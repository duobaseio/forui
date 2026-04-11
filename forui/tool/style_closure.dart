// ignore_for_file: avoid_print

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;

final _stylePattern = RegExp(r'^F.*Styles?$');
final _library = p.join(Directory.current.path, 'lib');

// Disclaimer: This script is vibe-coded. Use at your own risk.
//
// Generates a transitive closure of styles as well the the CLI option to generate said style.
Future<void> main() async {
  final collection = AnalysisContextCollection(
    includedPaths: [_library],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  final files = Directory(_library)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && !f.path.endsWith('.design.dart') && !f.path.endsWith('.control.dart'))
      .map((f) => f.path)
      .toList();

  // Phase 1: Collect all style classes/extension types and their fields.
  final visitor = _StyleCollector();
  for (final file in files) {
    if (await collection.contextFor(file).currentSession.getResolvedUnit(file) case final ResolvedUnitResult result) {
      result.unit.accept(visitor);
    }
  }

  // Phase 2: Resolve superclass fields by walking the inheritance chain.
  // styleFields currently has direct fields only; we need to add transitive superclass style deps.
  final resolved = <String, Set<String>>{};
  for (final entry in visitor.styleFields.entries) {
    final all = <String>{};

    void collectSuper(String type) {
      final deps = visitor.styleFields[type];
      if (deps == null) {
        return;
      }
      deps.forEach(all.add);
      // Follow the extends chain.
      if (visitor.superclasses[type] case final superType? when _stylePattern.hasMatch(superType)) {
        all.add(superType);
        collectSuper(superType);
      }
    }

    collectSuper(entry.key);
    resolved[entry.key] = all;
  }

  // Phase 3: Collect FThemeData fields as roots.
  final themeFile = p.join(_library, 'src', 'theme', 'theme_data.dart');
  final rootVisitor = _ThemeDataVisitor();
  if (await collection.contextFor(themeFile).currentSession.getResolvedUnit(themeFile)
      case final ResolvedUnitResult result) {
    result.unit.accept(rootVisitor);
  }

  // Phase 4: Compute transitive closure for each root via DFS.
  final closures = <String, List<String>>{};
  for (final MapEntry(key: fieldName, value: typeName) in rootVisitor.roots.entries) {
    final closure = <String>{};

    void dfs(String type) {
      if (!closure.add(type)) {
        return;
      }
      (resolved[type] ?? <String>{}).forEach(dfs);
    }

    dfs(typeName);
    closures[fieldName] = closure.toList();
  }

  // Phase 5: Run `dart run forui style ls` and write output to markdown.
  final styleLs = await Process.run('dart', [
    'run',
    'forui',
    'style',
    'ls',
  ], workingDirectory: p.join(_library, '..', 'example'));
  final buffer = StringBuffer()
    ..writeln('# Style Closure')
    ..writeln()
    ..writeln('## `dart run forui style ls`')
    ..writeln()
    ..writeln('```')
    ..writeln((styleLs.stdout as String).trimRight())
    ..writeln('```')
    ..writeln()
    ..writeln('## Field-based transitive closure')
    ..writeln()
    ..writeln('```');

  for (final MapEntry(key: fieldName, value: closure) in closures.entries) {
    buffer.writeln('$fieldName (${rootVisitor.roots[fieldName]}) -> $closure');
  }

  buffer.writeln('```');

  final output = File(p.join(_library, '..', 'build', 'style_closure.md'))..writeAsStringSync(buffer.toString());
  print('Written to ${output.path}');
}

/// Collects all style classes/extension types and maps each to the set of F*Style(s) types found in its fields.
class _StyleCollector extends RecursiveAstVisitor<void> {
  /// Maps style type name -> set of style type names found in its direct fields.
  final Map<String, Set<String>> styleFields = {};

  /// Maps style type name -> its superclass name (if it matches the style pattern).
  final Map<String, String> superclasses = {};

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.namePart.typeName.lexeme;
    if (!_stylePattern.hasMatch(name)) {
      return;
    }

    final fields = <String>{};

    // Collect fields from this class.
    if (declaration.body case BlockClassBody(:final members)) {
      for (final member in members) {
        if (member is FieldDeclaration) {
          _addFieldType(member, fields);
        }
      }
    }

    // Track superclass.
    if (declaration.extendsClause?.superclass case final NamedType superType) {
      final superName = superType.name.lexeme;
      if (_stylePattern.hasMatch(superName)) {
        superclasses[name] = superName;
      }
    }

    styleFields[name] = fields;
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration declaration) {
    final name = declaration.primaryConstructor.typeName.lexeme;
    if (!_stylePattern.hasMatch(name)) {
      return;
    }

    final fields = <String>{};

    // For extension types wrapping FVariants<C, V, StyleType, D>, extract StyleType.
    final representationType =
        (declaration.primaryConstructor.formalParameters.parameters.single as SimpleFormalParameter).type!;
    _extractVariantsStyleType(representationType, fields);

    // Also collect any declared fields in the extension type body.
    if (declaration.body case BlockClassBody(:final members)) {
      for (final member in members) {
        if (member is FieldDeclaration) {
          _addFieldType(member, fields);
        }
      }
    }

    styleFields[name] = fields;
  }

  void _addFieldType(FieldDeclaration declaration, Set<String> fields) {
    if (declaration.isStatic) {
      return;
    }

    final typeAnnotation = declaration.fields.type;
    if (typeAnnotation == null) {
      return;
    }

    _extractStyleTypes(typeAnnotation, fields);
  }

  void _extractStyleTypes(TypeAnnotation typeAnnotation, Set<String> fields) {
    if (typeAnnotation case final NamedType namedType) {
      final name = namedType.name.lexeme;
      if (_stylePattern.hasMatch(name)) {
        fields.add(name);
      }
      // Check type arguments for nested style types.
      if (namedType.typeArguments != null) {
        for (final arg in namedType.typeArguments!.arguments) {
          _extractStyleTypes(arg, fields);
        }
      }
    }
  }

  void _extractVariantsStyleType(TypeAnnotation typeAnnotation, Set<String> fields) {
    if (typeAnnotation case final NamedType namedType) {
      final name = namedType.name.lexeme;
      if (name == 'FVariants' && namedType.typeArguments != null) {
        final args = namedType.typeArguments!.arguments;
        if (args.length >= 3) {
          // 3rd type arg is the style type.
          final styleArg = args[2];
          if (styleArg case final NamedType styleNamedType) {
            final styleTypeName = styleNamedType.name.lexeme;
            if (_stylePattern.hasMatch(styleTypeName)) {
              fields.add(styleTypeName);
            }
          }
        }
      }
    }
  }
}

/// Collects the style fields from FThemeData.
class _ThemeDataVisitor extends RecursiveAstVisitor<void> {
  /// Maps field name -> type name for style fields in FThemeData.
  final Map<String, String> roots = {};

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    if (declaration.namePart.typeName.lexeme == 'FThemeData') {
      super.visitClassDeclaration(declaration);
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration declaration) {
    if (declaration.isStatic) {
      return;
    }

    final typeAnnotation = declaration.fields.type;
    if (typeAnnotation == null) {
      return;
    }

    if (typeAnnotation case final NamedType namedType) {
      final typeName = namedType.name.lexeme;
      if (_stylePattern.hasMatch(typeName)) {
        final fieldName = declaration.fields.variables.first.name.lexeme;
        roots[fieldName] = typeName;
      }
    }
  }
}

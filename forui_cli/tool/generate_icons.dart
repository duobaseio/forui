import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;

import 'main.dart';

final _icons = p.join(library, 'src', 'theme', 'icons.dart');

/// Traverses forui's icons.dart and returns FIcons's instance field names in declaration order.
Future<List<String>> traverseIcons(AnalysisContextCollection collection) async {
  if (await collection.contextFor(_icons).currentSession.getResolvedUnit(_icons) case final ResolvedUnitResult result) {
    final visitor = _IconsVisitor();
    result.unit.accept(visitor);
    return visitor.slots;
  }

  throw Exception('Failed to parse $_icons');
}

/// Generates the `IconMapping` enum from FIcons's [slots].
String generateIconMapping(List<String> slots) {
  final library = LibraryBuilder()
    ..comments.addAll([header])
    ..body.add(
      (EnumBuilder()
            ..docs.addAll([
              "/// The icons used by Forui widgets. Generated from FIcons's fields.",
              '///',
              '/// Each icon library maps every value to its equivalent icon in `Icons.mapping(...)`.',
            ])
            ..name = 'IconMapping'
            ..values.addAll([for (final slot in slots) (EnumValueBuilder()..name = slot).build()]))
          .build(),
    );

  return metaFormatter.format(library.build().accept(emitter).toString());
}

/// Collects FIcons's instance final field names in declaration order.
class _IconsVisitor extends RecursiveAstVisitor<void> {
  final List<String> slots = [];
  bool _inside = false;

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    if (declaration.namePart.typeName.lexeme == 'FIcons') {
      _inside = true;
      super.visitClassDeclaration(declaration);
      _inside = false;
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration declaration) {
    if (_inside && !declaration.isStatic) {
      for (final variable in declaration.fields.variables) {
        slots.add(variable.name.lexeme);
      }
    }
    super.visitFieldDeclaration(declaration);
  }
}

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

final _comment = RegExp('(/// ?)');

/// Summarizes the multi-line documentation comment by extracting the first sentence.
///
/// Returns null if no summary could be found.
@visibleForTesting
String? summarizeDocs(String? documentation) {
  var lines = documentation?.split('\n').map((l) => l.replaceFirst(_comment, '')) ?? <String>[];
  if (lines.isEmpty) {
    return null;
  }

  if (lines.first case final comment when comment.startsWith('{@macro')) {
    // The macro needs to be on a new line for dart doc to properly parse it.
    return '\n /// $comment';
  }

  if (lines.first case final comment when comment.startsWith('{@template')) {
    // Skip if template is malformed. We assume that a template is multi-lined.
    if (lines.length <= 2) {
      return null;
    }

    lines = lines.skip(1).toList();
  }

  final full = lines.join('\n');
  var bracketDepth = 0;
  var parenDepth = 0;
  var backticked = false;

  String summary = '';
  parse:
  for (var i = 0; i < full.length; i++) {
    final char = full[i];

    switch (char) {
      case '[' when !backticked:
        bracketDepth++;
      case ']' when !backticked:
        bracketDepth--;
      case '(' when !backticked:
        parenDepth++;
      case ')' when !backticked:
        parenDepth--;
      case '`':
        backticked = !backticked;
      case '.' when bracketDepth == 0 && parenDepth == 0 && !backticked:
        // Skip common abbreviations (i.e., e.g.)
        // Both dots in "i.e." and "e.g." need to be skipped

        // Check if this is the first dot: "i." or "e." part of "i.e." or "e.g."
        if (i >= 1 && i + 2 < full.length) {
          if ((full[i - 1] == 'i' && full[i + 1] == 'e' && full[i + 2] == '.') ||
              (full[i - 1] == 'e' && full[i + 1] == 'g' && full[i + 2] == '.')) {
            continue;
          }
        }

        // Check if this is the second dot: final '.' in "i.e." or "e.g."
        if (i >= 3) {
          if ((full[i - 3] == 'i' && full[i - 2] == '.' && full[i - 1] == 'e') ||
              (full[i - 3] == 'e' && full[i - 2] == '.' && full[i - 1] == 'g')) {
            continue;
          }
        }

        // Check if followed by whitespace, EOL, or EOS (to avoid matching decimals like 1.5).
        if (i + 1 >= full.length || full[i + 1] == ' ' || full[i + 1] == '\n') {
          summary = full.substring(0, i + 1).trim();
          break parse;
        }
    }
  }

  summary = summary.replaceAll('\n', ' ');
  return summary.isEmpty ? null : summary;
}

/// Generates an extension.
///
/// The copyWith function is generated in an extension rather than on a mixin/augmentation to make the function
/// non-virtual. This prevents conflicts between base and subclasses.
@internal
class TransformationsExtension {
  /// The build step.
  @protected
  final BuildStep step;

  /// The type.
  @protected
  final ClassElement element;

  /// The fields.
  @protected
  final List<FieldElement> fields;

  /// The copyWith documentation comments.
  @protected
  final List<String> copyWithDocsHeader;

  /// Creates a [TransformationsExtension].
  TransformationsExtension(this.step, this.element, {required this.copyWithDocsHeader})
    : fields = transitiveInstanceFields(element);

  /// Generates an extension that provides non virtual transforming methods.
  Future<Extension> generate() async =>
      (ExtensionBuilder()
            ..docs.addAll(['/// Provides a [copyWith] method.'])
            ..name = '\$${element.name!}Transformations'
            ..on = refer(element.name!)
            ..methods.addAll([await copyWith]))
          .build();

  /// Generates a copyWith method that allows for creating a new instance of the style with modified properties.
  @protected
  Future<Method> get copyWith async {
    // Copy the documentation comments from the fields.
    final docs = ['/// ## Parameters'];

    for (final field in fields) {
      final prefix = '/// * [${element.name}.${field.name}]';
      final summary = summarizeDocs(field.documentationComment);

      docs.add('$prefix${summary == null ? '' : ' - $summary'}');
    }

    // Generate assignments for the copyWith method body
    final assignments = fields.map((f) {
      if (nestedMotion(f.type) || nestedStyle(f.type)) {
        return '${f.name}: ${f.name} != null ? ${f.name}(this.${f.name}) : this.${f.name},';
      } else {
        return '${f.name}: ${f.name} ?? this.${f.name},';
      }
    }).join();

    final parameters = <Parameter>[];
    for (final field in fields) {
      final type = await fieldType(step, field);
      if (nestedMotion(field.type)) {
        parameters.add(
          Parameter(
            (p) => p
              ..name = field.name!
              ..type = refer('$type Function($type motion)?')
              ..named = true,
          ),
        );
      } else if (nestedStyle(field.type)) {
        parameters.add(
          Parameter(
            (p) => p
              ..name = field.name!
              ..type = refer('$type Function($type style)?')
              ..named = true,
          ),
        );
      } else {
        final nullableType = await _nullableType(field);
        parameters.add(
          Parameter(
            (p) => p
              ..name = field.name!
              ..type = refer(nullableType)
              ..named = true,
          ),
        );
      }
    }

    return Method(
      (m) => m
        ..returns = refer(element.name!)
        ..docs.addAll([...copyWithDocsHeader, ...docs])
        ..annotations.add(refer('useResult'))
        ..name = 'copyWith'
        ..optionalParameters.addAll(parameters)
        ..lambda = true
        ..body = Code('.new($assignments)\n'),
    );
  }

  Future<String> _nullableType(FieldElement field) async {
    final type = await fieldType(step, field);
    return field.type.nullabilitySuffix == .question ? type : '$type?';
  }

  /// Checks if the type is a nested motion.
  @protected
  bool nestedMotion(DartType type) {
    final typeName = type.getDisplayString();
    return typeName.startsWith('F') && typeName.endsWith('Motion');
  }

  /// Checks if the type is a nested style.
  @protected
  bool nestedStyle(DartType type) {
    final typeName = type.getDisplayString();
    return (typeName.startsWith('F') && !typeName.startsWith('FInherited')) &&
        (typeName.endsWith('Style') || typeName.endsWith('Styles'));
  }
}

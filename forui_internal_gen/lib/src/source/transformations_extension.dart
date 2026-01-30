import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/docs.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

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

  /// The sentinel values for nullable fields.
  @protected
  final Map<String, String> sentinels;

  /// The copyWith documentation comments.
  @protected
  final List<String> copyWithDocsHeader;

  /// Creates a [TransformationsExtension].
  TransformationsExtension(this.step, this.element, this.sentinels, {required this.copyWithDocsHeader})
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

    // Generate assignments and parameters for the copyWith method
    final assignments = <String>[];
    final parameters = <Parameter>[];

    for (final field in fields) {
      final (type, assignment, sentinel) = await deltaField(step, field, sentinels);
      assignments.add('${field.name}: $assignment,');
      parameters.add(
        Parameter(
          (p) => p
            ..name = field.name!
            ..type = refer(type)
            ..named = true
            ..defaultTo = sentinel == null ? null : Code(sentinel),
        ),
      );
    }

    return Method(
      (m) => m
        ..returns = refer(element.name!)
        ..docs.addAll([...copyWithDocsHeader, ...docs])
        ..annotations.add(refer('useResult'))
        ..name = 'copyWith'
        ..optionalParameters.addAll(parameters)
        ..lambda = true
        ..body = Code('.new(${assignments.join()})\n'),
    );
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

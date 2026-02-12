import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/transformations_extension.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates a [TransformationsExtension] that provides `copyWith` and `lerp` methods.
class DesignTransformationsExtension extends TransformationsExtension {
  /// Creates a [DesignTransformationsExtension].
  DesignTransformationsExtension(super.step, super.element, super.sentinels, {required super.copyWithDocsHeader});

  /// Generates an extension that provides non virtual transforming methods.
  @override
  Future<Extension> generate() async =>
      (ExtensionBuilder()
            ..docs.addAll(['/// Provides [copyWith] and [lerp] methods.'])
            ..name = '\$${element.name!}Transformations'
            ..on = refer(element.name!)
            ..methods.addAll([await copyWith, await _lerp]))
          .build();

  Future<Method> get _lerp async {
    Future<String> invocation(FieldElement field) async {
      final type = field.type;
      final typeName = type.getDisplayString();
      final name = field.name!;

      // DO NOT REORDER, we need the subclass (Alignment) to dominate the superclass (AlignmentGeometry) pattern.
      return switch (type) {
        _
            when alignmentGeometry.isAssignableFromType(type) ||
                borderRadiusGeometry.isAssignableFromType(type) ||
                boxConstraints.isAssignableFromType(type) ||
                decoration.isAssignableFromType(type) ||
                edgeInsetsGeometry.isAssignableFromType(type) ||
                textStyle.isAssignableFromType(type) =>
          '.lerp($name, other.$name, t) ?? $name',
        //
        _ when color.isAssignableFromType(type) => 'FColors.lerpColor($name, other.$name, t) ?? $name',
        //
        _ when iconThemeData.isAssignableFromType(type) => '.lerp($name, other.$name, t)',
        //
        _ when doubleType.isAssignableFromType(type) => 'lerpDouble($name, other.$name, t) ?? $name',
        // List<BoxShadow>/List<Shadow>
        _ when list.isAssignableFromType(type) && type is ParameterizedType => switch (type.typeArguments.single) {
          final t when boxShadow.isAssignableFromType(t) => 'BoxShadow.lerpList($name, other.$name, t) ?? $name',
          final t when shadow.isAssignableFromType(t) => 'Shadow.lerpList($name, other.$name, t) ?? $name',
          _ => 't < 0.5 ? $name : other.$name',
        },
        // FVariants<K, V, D> - use AST to get type due to circular dependency
        InterfaceType(:final element) when element.name == 'FVariants' => await () async {
          final node = await step.resolver.astNodeFor(field.firstFragment);
          if (node?.parent case VariableDeclarationList(type: NamedType(:final typeArguments?))) {
            return switch (typeArguments.arguments[2].toSource()) {
              'BoxDecoration' => '.lerpBoxDecoration($name, other.$name, t)',
              'BoxDecoration?' => '.lerpWhere($name, other.$name, t, BoxDecoration.lerp)',
              'Decoration' => '.lerpDecoration($name, other.$name, t)',
              'Decoration?' => '.lerpWhere($name, other.$name, t, Decoration.lerp)',
              'Color' => '.lerpColor($name, other.$name, t)',
              'Color?' => '.lerpWhere($name, other.$name, t, Color.lerp)',
              'IconThemeData' => '.lerpIconThemeData($name, other.$name, t)',
              'IconThemeData?' => '.lerpWhere($name, other.$name, t, IconThemeData.lerp)',
              'TextStyle' => '.lerpTextStyle($name, other.$name, t)',
              'TextStyle?' => '.lerpWhere($name, other.$name, t, TextStyle.lerp)',
              final nested when nestedMotion(nested) || nestedStyle(nested) =>
                '.lerpWhere($name, other.$name, t, (a, b, t) => a!.lerp(b!, t))',
              _ => 't < 0.5 ? $name : other.$name',
            };
          }
          return 't < 0.5 ? $name : other.$name';
        }(),
        // Nested motion/style
        _ when nestedMotion(typeName) || nestedStyle(typeName) => '$name.lerp(other.$name, t)',
        //
        _ => 't < 0.5 ? $name : other.$name',
      };
    }

    // Generate field assignments for the lerp method body.
    final assignments = [for (final field in fields) '${field.name}: ${await invocation(field)},'].join();

    return Method(
      (m) => m
        ..returns = refer(element.name!)
        ..docs.addAll([
          '/// Linearly interpolate between this and another [${element.name!}] using the given factor [t].',
        ])
        ..annotations.add(refer('useResult'))
        ..name = 'lerp'
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'other'
              ..type = refer(element.name!),
          ),
          Parameter(
            (p) => p
              ..name = 't'
              ..type = refer('double'),
          ),
        ])
        ..lambda = true
        ..body = Code('.new($assignments)\n'),
    );
  }

  /// Checks if the type is a nested motion.
  @protected
  bool nestedMotion(String type) => type.startsWith('F') && type.endsWith('Motion');

  /// Checks if the type is a nested style.
  @protected
  bool nestedStyle(String type) =>
      (type.startsWith('F') && !type.startsWith('FInherited')) && (type.endsWith('Style') || type.endsWith('Styles'));
}

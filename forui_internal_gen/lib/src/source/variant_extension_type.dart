import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

/// Matches F at the start only if followed by an uppercase letter.
final _f = RegExp('^F(?=[A-Z])');

/// Generates widget-specific variant and variant constraint extension types.
@internal
class VariantExtensionType {
  static const _platforms = {
    'touch': '/// Matches all touch-based platforms, [android], [iOS] and [fuchsia].',
    'android':
        '/// The Android platform variant.\n'
        '///\n'
        '/// More specific than [touch] in variant resolution.',
    'iOS':
        '/// The iOS platform variant.\n'
        '///\n'
        '/// More specific than [touch] in variant resolution.',
    'fuchsia':
        '/// The Fuchsia platform variant.\n'
        '///\n'
        '/// More specific than [touch] in variant resolution.',
    'desktop': '/// Matches all desktop-based platforms, [windows], [macOS] and [linux].',
    'windows':
        '/// The Windows platform variant.\n'
        '///\n'
        '/// More specific than [desktop] in variant resolution.',
    'macOS':
        '/// The macOS platform variant.\n'
        '///\n'
        '/// More specific than [desktop] in variant resolution.',
    'linux':
        '/// The Linux platform variant.\n'
        '///\n'
        '/// More specific than [desktop] in variant resolution.',
    'web':
        '/// The web platform variant.\n'
        '///\n'
        '/// Standalone platform that is neither [touch] nor [desktop].',
  };

  /// The widget name.
  final String widget;

  /// The variant constraint name.
  final String constraint;

  /// The variant name.
  final String variant;

  /// The variants and their documentation.
  final Map<String, String> variants;

  /// Creates a new [VariantExtensionType].
  VariantExtensionType(InterfaceType widget, this.variants)
    : widget = widget.element.name!,
      constraint = 'F${widget.element.name!.replaceFirst(_f, '')}VariantConstraint',
      variant = 'F${widget.element.name!.replaceFirst(_f, '')}Variant';

  /// Generates the variant constraint extension type.
  ExtensionType generateVariantConstraint() => ExtensionType(
    (b) => b
      ..docs.addAll([
        '/// Represents a combination of variants which a [$widget] can be styled.',
        '///',
        '/// See also:',
        '/// * [$variant], which represents individual variants for [$widget].',
      ])
      ..constant = true
      ..name = constraint
      ..primaryConstructorName = '_'
      ..representationDeclaration = RepresentationDeclaration(
        (r) => r
          ..name = '_'
          ..declaredRepresentationType = refer('FVariantConstraint'),
      )
      ..implements.add(refer('FVariantConstraint'))
      ..fields.addAll(_constraintVariants)
      ..fields.addAll(_constraintPlatformVariants)
      ..constructors.add(_not)
      ..methods.add(_and),
  );

  /// Generates variant fields for the constraint extension type that alias the variant fields.
  List<Field> get _constraintVariants => [
    for (final MapEntry(key: name, value: documentation) in variants.entries)
      Field(
        (f) => f
          ..docs.add('/// $documentation')
          ..static = true
          ..modifier = FieldModifier.constant
          ..name = name
          ..assignment = Code('$variant.$name'),
      ),
  ];

  /// Generates platform variant fields for the constraint extension type that alias the variant platform fields.
  List<Field> get _constraintPlatformVariants => [
    for (final MapEntry(key: name, value: documentation) in _platforms.entries)
      Field(
        (f) => f
          ..docs.addAll(documentation.split('\n'))
          ..static = true
          ..modifier = FieldModifier.constant
          ..name = name
          ..assignment = Code('$variant.$name'),
      ),
  ];

  /// Generates a factory constructor for negating a constraint.
  Constructor get _not => Constructor(
    (c) => c
      ..factory = true
      ..docs.addAll(['/// Creates a [$constraint] that negates [constraint].'])
      ..name = 'not'
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..type = refer(constraint)
            ..name = 'constraint',
        ),
      )
      ..lambda = true
      ..body = Code('$constraint._(Not(constraint))'),
  );

  /// Generates a method for combining two constraints with a logical AND.
  Method get _and => Method(
    (m) => m
      ..returns = refer(constraint)
      ..docs.addAll(['/// Combines this with [other] using a logical AND operation.'])
      ..name = 'and'
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..type = refer(constraint)
            ..name = 'other',
        ),
      )
      ..lambda = true
      ..body = Code('$constraint._(And(this, other))'),
  );

  /// Generates the variant extension type.
  ExtensionType generateVariant() => ExtensionType(
    (b) => b
      ..docs.addAll([
        '/// Represents a condition under which a [$widget] can be styled differently.',
        '///',
        '/// See also:',
        '/// * [$constraint], which represents combinations of variants for [$widget].',
      ])
      ..constant = true
      ..name = variant
      ..primaryConstructorName = '_'
      ..representationDeclaration = RepresentationDeclaration(
        (r) => r
          ..name = '_'
          ..declaredRepresentationType = refer('FVariant'),
      )
      ..implements.addAll([refer(constraint), refer('FVariant')])
      ..fields.addAll(_variantVariants)
      ..fields.addAll(_variantPlatformVariants),
  );

  /// Generates variant fields for the variant extension type.
  List<Field> get _variantVariants => [
    for (final MapEntry(key: name, value: documentation) in variants.entries)
      Field(
        (f) => f
          ..docs.add('/// $documentation')
          ..static = true
          ..modifier = FieldModifier.constant
          ..name = name
          ..assignment = Code("$variant._(.new('$name'))"),
      ),
  ];

  /// Generates platform variant fields for the variant extension type.
  List<Field> get _variantPlatformVariants => [
    for (final MapEntry(key: name, value: documentation) in _platforms.entries)
      Field(
        (f) => f
          ..docs.addAll(documentation.split('\n'))
          ..static = true
          ..modifier = FieldModifier.constant
          ..name = name
          ..assignment = Code('$variant._(FPlatformVariant.$name)'),
      ),
  ];
}

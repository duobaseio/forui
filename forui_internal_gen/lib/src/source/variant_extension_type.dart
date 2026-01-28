import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

/// Matches the suffixing Style or Styles.
final _style = RegExp(r'Styles?$');

/// Generates widget-specific variant and variant constraint extension types.
@internal
class VariantExtensionType {
  static const _platformCategories = {
    'touch': (
      'Touch()',
      '/// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].',
    ),
    'desktop': (
      'Desktop()',
      '/// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].',
    ),
  };

  static const _platformVariants = {
    'android': '/// The Android platform variant.',
    'iOS': '/// The iOS platform variant.',
    'fuchsia': '/// The Fuchsia platform variant.',

    'windows': '/// The Windows platform variant.',
    'macOS': '/// The macOS platform variant.',
    'linux': '/// The Linux platform variant.',
    'web': '/// The web platform variant.',
  };

  /// The style name.
  final String style;

  /// The variant constraint name.
  final String constraint;

  /// The variant name.
  final String variant;

  /// The variants and their tier and documentation.
  final Map<String, (int, String)> variants;

  /// Creates a new [VariantExtensionType].
  VariantExtensionType(InterfaceType widget, this.variants)
    : style = widget.element.name!,
      constraint = '${widget.element.name!.replaceFirst(_style, '')}VariantConstraint',
      variant = '${widget.element.name!.replaceFirst(_style, '')}Variant';

  /// Generates the variant constraint extension type.
  ExtensionType generateVariantConstraint() => ExtensionType(
    (b) => b
      ..docs.addAll([
        '/// Represents a combination of variants for a [$style]',
        '///',
        '/// See also:',
        '/// * [$variant], which represents individual variants for [$style].',
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
      ..fields.addAll(_constraintPlatformCategories)
      ..fields.addAll(_constraintPlatformVariants)
      ..constructors.add(_not)
      ..methods.add(_and),
  );

  /// Generates variant fields for the constraint extension type that alias the variant fields.
  List<Field> get _constraintVariants => [
    for (final MapEntry(key: name, value: (_, documentation)) in variants.entries)
      Field(
        (f) => f
          ..docs.add('/// $documentation')
          ..static = true
          ..modifier = .constant
          ..name = name
          ..assignment = Code('$variant.$name'),
      ),
  ];

  /// Generates platform category fields for the constraint extension type that alias the variant platform category fields.
  List<Field> get _constraintPlatformCategories => [
    for (final MapEntry(key: name, value: (constructor, documentation)) in _platformCategories.entries)
      Field(
        (f) => f
          ..docs.addAll(documentation.split('\n'))
          ..static = true
          ..modifier = .constant
          ..name = name
          ..assignment = Code(constructor),
      ),
  ];

  /// Generates platform variant fields for the constraint extension type that alias the variant platform fields.
  List<Field> get _constraintPlatformVariants => [
    for (final MapEntry(key: name, value: documentation) in _platformVariants.entries)
      Field(
        (f) => f
          ..docs.addAll(documentation.split('\n'))
          ..static = true
          ..modifier = .constant
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
        '/// Represents a variant in [$style].',
        '///',
        '/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.',
        '///',
        '/// See also:',
        '/// * [$constraint], which represents combinations of variants for [$style].',
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
    for (final MapEntry(key: name, value: (tier, documentation)) in variants.entries)
      Field(
        (f) => f
          ..docs.add('/// $documentation')
          ..static = true
          ..modifier = .constant
          ..name = name
          ..assignment = Code("$variant._(.new($tier, '$name'))"),
      ),
  ];

  /// Generates platform variant fields for the variant extension type.
  List<Field> get _variantPlatformVariants => [
    for (final MapEntry(key: name, value: documentation) in _platformVariants.entries)
      Field(
        (f) => f
          ..docs.addAll(documentation.split('\n'))
          ..static = true
          ..modifier = .constant
          ..name = name
          ..assignment = Code('$variant._(FPlatformVariant.$name)'),
      ),
  ];
}

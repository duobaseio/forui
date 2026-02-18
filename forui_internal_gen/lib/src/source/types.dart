import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

// ignore_for_file: public_member_api_docs

const boolType = TypeChecker.typeNamed(bool, inSdk: true);
const intType = TypeChecker.typeNamed(int, inSdk: true);
const doubleType = TypeChecker.typeNamed(double, inSdk: true);
const string = TypeChecker.typeNamed(String, inSdk: true);
const enumeration = TypeChecker.typeNamed(Enum, inSdk: true);

const iterable = TypeChecker.typeNamed(Iterable, inSdk: true);
const list = TypeChecker.typeNamed(List, inSdk: true);
const set = TypeChecker.typeNamed(Set, inSdk: true);
const map = TypeChecker.typeNamed(Map, inSdk: true);

const color = TypeChecker.fromUrl('dart:ui#Color');

const alignmentGeometry = TypeChecker.fromUrl('package:flutter/src/painting/alignment.dart#AlignmentGeometry');
const borderRadiusGeometry = TypeChecker.fromUrl(
  'package:flutter/src/painting/border_radius.dart#BorderRadiusGeometry',
);
const boxConstraints = TypeChecker.fromUrl('package:flutter/src/rendering/box.dart#BoxConstraints');
const boxDecoration = TypeChecker.fromUrl('package:flutter/src/painting/box_decoration.dart#BoxDecoration');
const decoration = TypeChecker.fromUrl('package:flutter/src/painting/decoration.dart#Decoration');
const edgeInsetsGeometry = TypeChecker.fromUrl('package:flutter/src/painting/edge_insets.dart#EdgeInsetsGeometry');
const iconData = TypeChecker.fromUrl('package:flutter/src/widgets/icon_theme.dart#IconData');
const iconThemeData = TypeChecker.fromUrl('package:flutter/src/widgets/icon_theme_data.dart#IconThemeData');
const textStyle = TypeChecker.fromUrl('package:flutter/src/painting/text_style.dart#TextStyle');
const boxShadow = TypeChecker.fromUrl('package:flutter/src/painting/box_shadow.dart#BoxShadow');
const shadow = TypeChecker.fromUrl('dart:ui#Shadow');

const fWidgetStateMap = TypeChecker.fromUrl('package:forui/src/theme/widget_state_map.dart#FWidgetStateMap');
const fVariants = TypeChecker.fromUrl('package:forui/src/theme/variants.dart#FVariants');

// Annotations
const variants = TypeChecker.fromUrl('package:forui/src/foundation/annotations.dart#Variants');
const sentinels = TypeChecker.fromUrl('package:forui/src/foundation/annotations.dart#Sentinels');

/// Returns the instance fields for the given [element] and its supertypes.
List<FieldElement> transitiveInstanceFields(ClassElement element) {
  final fields = <FieldElement>[];

  void addFieldsFromType(ClassElement element) {
    fields.addAll(
      element.fields.where(
        (f) =>
            !(f.getter?.isAbstract ?? false) &&
            !f.isStatic &&
            f.isPublic &&
            f.name != 'runtimeType' &&
            f.name != 'hashCode',
      ),
    );

    if (element.supertype?.element case final ClassElement supertype) {
      addFieldsFromType(supertype);
    }
  }

  addFieldsFromType(element);

  // Remove duplicates (in case a field is overridden)
  return fields.toSet().toList();
}

/// Returns the instance fields for the given [element].
List<FieldElement> instanceFields(ClassElement element) => [
  for (final field in element.fields)
    if (!(field.getter?.isAbstract ?? false) &&
        !field.isStatic &&
        field.isPublic &&
        field.name != 'runtimeType' &&
        field.name != 'hashCode')
      field,
];

String aliasAwareType(DartType type) {
  if (type.alias case final alias?) {
    final name = alias.element.displayName;
    final typeParameters = alias.typeArguments.isEmpty ? '' : '<${alias.typeArguments.map(aliasAwareType).join(', ')}>';
    final suffix = switch (type.nullabilitySuffix) {
      .question => '?',
      .star => '*',
      .none => '',
    };
    return '$name$typeParameters$suffix';
  }

  return type.getDisplayString();
}

/// Returns the the `Variants` annotation's fields.
(String prefix, Map<String, (int, String)> variants) variantsAnnotation(DartObject annotation) => (
  annotation.getField('prefix')!.toStringValue()!,
  annotation.getField('variants')!.toMapValue()!.map((key, value) {
    final record = value!.toRecordValue()!.positional;
    return MapEntry(key!.toStringValue()!, (record[0].toIntValue()!, record[1].toStringValue()!));
  }),
);

/// Returns the the `Sentinels` annotation's fields.
(InterfaceType style, Map<String, String> values) sentinelsAnnotation(DartObject annotation) => (
  annotation.getField('style')!.toTypeValue()! as InterfaceType,
  annotation
      .getField('values')!
      .toMapValue()!
      .map((key, value) => MapEntry(key!.toStringValue()!, value!.toStringValue()!)),
);

/// Returns the delta type, assignment expression, and optional sentinel for a [field].
Future<(String type, String assignment, String? sentinel)> deltaField(
  BuildStep step,
  FieldElement field,
  Map<String, String> sentinels, {
  String prefix = 'this',
  bool cast = false,
}) async {
  final name = field.name!;
  final typeName = field.type.getDisplayString();

  // Nested styles
  if ((typeName.startsWith('F') && !typeName.startsWith('FInherited')) &&
      (typeName.endsWith('Style') || typeName.endsWith('Styles'))) {
    return ('${typeName}Delta?', '$name?.call($prefix.$name) ?? $prefix.$name', null);
  }

  // Nested motions
  if (typeName.startsWith('F') && typeName.endsWith('Motion')) {
    return ('${typeName}Delta?', '$name?.call($prefix.$name) ?? $prefix.$name', null);
  }

  // Supported Flutter in-built types
  if (const {
    'BoxDecoration',
    'Decoration',
    'EdgeInsets',
    'EdgeInsetsDirectional',
    'EdgeInsetsGeometry',
    'IconThemeData',
    'ShapeDecoration',
    'TextStyle',
  }.contains(typeName)) {
    return ('${typeName}Delta?', '$name?.call($prefix.$name) ?? $prefix.$name', null);
  }

  // FVariants<K extends FVariantConstraint, V, D extends Delta<V>>
  if (field.type case InterfaceType(:final element) when element.name == 'FVariants') {
    final type = ((await step.resolver.astNodeFor(field.firstFragment))!.parent! as VariableDeclarationList).type!;
    final [kAst, eAst, vAst, dAst] = (type as NamedType).typeArguments!.arguments;

    final k = kAst.toSource();
    final e = eAst.toSource();
    final v = vAst.toSource();
    final d = dAst.toSource();

    final deltaType = (dAst as NamedType).name.lexeme == 'Delta'
        ? 'FVariantsValueDelta<$k, $e, $v, $d>'
        : 'FVariantsDelta<$k, $e, $v, $d>';

    return ('$deltaType?', '$name?.call($prefix.$name) ?? $prefix.$name', null);
  }

  // Nullable types with explicit sentinel values
  if (sentinels[field.name] case final sentinel?) {
    return (typeName, '$name == $sentinel ? $prefix.$name : $name', sentinel);
  }

  // Enums and nullable types without explicit sentinel values
  if (field.type.nullabilitySuffix == NullabilitySuffix.question &&
      (enumeration.isAssignableFromType(field.type) || !sentinels.containsKey(field.name))) {
    return ('$typeName Function()?', '$name == null ? $prefix.$name : $name${cast ? '!' : ''}()', null);
  }

  return ('$typeName?', '$name ?? $prefix.$name', null);
}

/// Returns the type string for a field, handling FVariants circular dependency.
///
/// `FVariants<K, V, D>` has a circular dependency where K (the constraint type) is generated by the same generator.
/// We resolve this by traversing the AST to get the type parameters instead of using the element's resolved types.
///
/// For inherited fields from other libraries, the AST may not be available, but the types are already resolved
/// so we fall back to [aliasAwareType].
Future<String> fieldType(BuildStep step, FieldElement field) async {
  if (field.type case InterfaceType(:final element) when element.name == 'FVariants') {
    if (await step.resolver.astNodeFor(field.firstFragment) case final node?) {
      return (node.parent! as VariableDeclarationList).type!.toSource();
    }
  }

  return aliasAwareType(field.type);
}

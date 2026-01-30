import 'package:build_test/build_test.dart';
import 'package:forui_internal_gen/forui_internal_gen.dart';
import 'package:test/test.dart';

const _source = r'''
import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/delta.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:meta/meta.dart';

@Variants(FGolden, {'hovered': (1, 'The hovered state'), 'pressed': (1, 'The pressed state')})
@Sentinels(FGoldenStyle, {'someDouble': 'double.infinity', 'color': 'colorSentinel'})
part 'example.design.dart';

class FGolden {}

class FGoldenStyle with Diagnosticable, _$FGoldenStyleFunctions {
  /// This is a field's summary.
  ///
  /// This is more information about a field.
  final double someDouble;
  final Alignment alignment;
  final AlignmentGeometry alignmentGeometry;
  final BorderRadius borderRadius;
  final BorderRadiusGeometry borderRadiusGeometry;
  final BoxConstraints boxConstraints;
  final BoxDecoration boxDecoration;
  final Decoration decoration;
  final Color color;
  final EdgeInsets edgeInsets;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final IconThemeData iconThemeData;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadows;
  final List<Shadow> shadows;
  final FVariants<FGoldenVariantConstraint, BoxDecoration, Delta<BoxDecoration>> boxDecorationVariants;
  final FVariants<FGoldenVariantConstraint, BoxDecoration?, Delta<BoxDecoration?>> nullableBoxDecorationVariants;
  final FVariants<FGoldenVariantConstraint, Color, Delta<Color>> colorVariants;
  final FVariants<FGoldenVariantConstraint, Color?, Delta<Color?>> nullableColorVariants;
  final FVariants<FGoldenVariantConstraint, IconThemeData, Delta<IconThemeData>> iconThemeDataVariants;
  final FVariants<FGoldenVariantConstraint, IconThemeData?, Delta<IconThemeData?>> nullableIconThemeDataVariants;
  final FVariants<FGoldenVariantConstraint, TextStyle, Delta<TextStyle>> textStyleVariants;
  final FVariants<FGoldenVariantConstraint, TextStyle?, Delta<TextStyle?>> nullableTextStyleVariants;
  final FGoldenNestedMotion nestedMotion;
  final FGoldenNestedStyle nestedStyle;
  final List<String> list;
  final Set<String> set;
  final Map<String, int> map;

  /// Variants with generic delta.
  /// * [FGoldenVariantConstraint]
  final FVariants<FGoldenVariantConstraint, Color, Delta<Color>> variantsWithGenericDelta;

  /// Variants with specific delta.
  /// * [FGoldenVariantConstraint]
  final FVariants<FGoldenVariantConstraint, TextStyle, TextStyleDelta> variantsWithSpecificDelta;

  FGoldenStyle({
    required this.someDouble,
    required this.alignment,
    required this.alignmentGeometry,
    required this.borderRadius,
    required this.borderRadiusGeometry,
    required this.boxConstraints,
    required this.boxDecoration,
    required this.decoration,
    required this.color,
    required this.edgeInsets,
    required this.edgeInsetsDirectional,
    required this.edgeInsetsGeometry,
    required this.iconThemeData,
    required this.textStyle,
    required this.boxShadows,
    required this.shadows,
    required this.boxDecorationVariants,
    required this.nullableBoxDecorationVariants,
    required this.colorVariants,
    required this.nullableColorVariants,
    required this.iconThemeDataVariants,
    required this.nullableIconThemeDataVariants,
    required this.textStyleVariants,
    required this.nullableTextStyleVariants,
    required this.nestedMotion,
    required this.nestedStyle,
    required this.list,
    required this.set,
    required this.map,
    required this.variantsWithGenericDelta,
    required this.variantsWithSpecificDelta,
  });
}

class FGoldenNestedMotion with Diagnosticable, _$FGoldenNestedMotionFunctions {
  /// This is a field's summary.
  ///
  /// This is more information about a field.
  final double someDouble;
  final Duration duration;
  final Curve curve;

  FGoldenNestedMotion({required this.someDouble, required this.duration, required this.curve});
}

class FGoldenNestedStyle with Diagnosticable, _$FGoldenNestedStyleFunctions {}

''';

const _golden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'example.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants for a [FGolden]
///
/// See also:
/// * [FGoldenVariant], which represents individual variants for [FGolden].
extension type const FGoldenVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FGoldenVariantConstraint] that negates [variant].
  factory FGoldenVariantConstraint.not(FGoldenVariant variant) => FGoldenVariantConstraint._(Not(variant));

  /// The hovered state
  static const hovered = FGoldenVariant.hovered;

  /// The pressed state
  static const pressed = FGoldenVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = Touch();

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = Desktop();

  /// The Android platform variant.
  static const android = FGoldenVariant.android;

  /// The iOS platform variant.
  static const iOS = FGoldenVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FGoldenVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FGoldenVariant.windows;

  /// The macOS platform variant.
  static const macOS = FGoldenVariant.macOS;

  /// The Linux platform variant.
  static const linux = FGoldenVariant.linux;

  /// The web platform variant.
  static const web = FGoldenVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FGoldenVariantConstraint and(FGoldenVariantConstraint other) => FGoldenVariantConstraint._(And(this, other));
}

/// Represents a variant in [FGolden].
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FGoldenVariantConstraint], which represents combinations of variants for [FGolden].
extension type const FGoldenVariant._(FVariant _) implements FGoldenVariantConstraint, FVariant {
  /// The hovered state
  static const hovered = FGoldenVariant._(.new(1, 'hovered'));

  /// The pressed state
  static const pressed = FGoldenVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FGoldenVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FGoldenVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FGoldenVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FGoldenVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FGoldenVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FGoldenVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FGoldenVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FGoldenStyleTransformations on FGoldenStyle {
  /// Returns a copy of this [FGoldenStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FGoldenStyle.someDouble] - This is a field's summary.
  /// * [FGoldenStyle.alignment]
  /// * [FGoldenStyle.alignmentGeometry]
  /// * [FGoldenStyle.borderRadius]
  /// * [FGoldenStyle.borderRadiusGeometry]
  /// * [FGoldenStyle.boxConstraints]
  /// * [FGoldenStyle.boxDecoration]
  /// * [FGoldenStyle.decoration]
  /// * [FGoldenStyle.color]
  /// * [FGoldenStyle.edgeInsets]
  /// * [FGoldenStyle.edgeInsetsDirectional]
  /// * [FGoldenStyle.edgeInsetsGeometry]
  /// * [FGoldenStyle.iconThemeData]
  /// * [FGoldenStyle.textStyle]
  /// * [FGoldenStyle.boxShadows]
  /// * [FGoldenStyle.shadows]
  /// * [FGoldenStyle.boxDecorationVariants]
  /// * [FGoldenStyle.nullableBoxDecorationVariants]
  /// * [FGoldenStyle.colorVariants]
  /// * [FGoldenStyle.nullableColorVariants]
  /// * [FGoldenStyle.iconThemeDataVariants]
  /// * [FGoldenStyle.nullableIconThemeDataVariants]
  /// * [FGoldenStyle.textStyleVariants]
  /// * [FGoldenStyle.nullableTextStyleVariants]
  /// * [FGoldenStyle.nestedMotion]
  /// * [FGoldenStyle.nestedStyle]
  /// * [FGoldenStyle.list]
  /// * [FGoldenStyle.set]
  /// * [FGoldenStyle.map]
  /// * [FGoldenStyle.variantsWithGenericDelta] - Variants with generic delta.
  /// * [FGoldenStyle.variantsWithSpecificDelta] - Variants with specific delta.
  @useResult
  FGoldenStyle copyWith({
    double? someDouble,
    Alignment? alignment,
    AlignmentGeometry? alignmentGeometry,
    BorderRadius? borderRadius,
    BorderRadiusGeometry? borderRadiusGeometry,
    BoxConstraints? boxConstraints,
    BoxDecoration? boxDecoration,
    Decoration? decoration,
    Color? color,
    EdgeInsets? edgeInsets,
    EdgeInsetsDirectional? edgeInsetsDirectional,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    IconThemeData? iconThemeData,
    TextStyle? textStyle,
    List<BoxShadow>? boxShadows,
    List<Shadow>? shadows,
    FVariants<FGoldenVariantConstraint, BoxDecoration, Delta<BoxDecoration>>? boxDecorationVariants,
    FVariants<FGoldenVariantConstraint, BoxDecoration?, Delta<BoxDecoration?>>? nullableBoxDecorationVariants,
    FVariants<FGoldenVariantConstraint, Color, Delta<Color>>? colorVariants,
    FVariants<FGoldenVariantConstraint, Color?, Delta<Color?>>? nullableColorVariants,
    FVariants<FGoldenVariantConstraint, IconThemeData, Delta<IconThemeData>>? iconThemeDataVariants,
    FVariants<FGoldenVariantConstraint, IconThemeData?, Delta<IconThemeData?>>? nullableIconThemeDataVariants,
    FVariants<FGoldenVariantConstraint, TextStyle, Delta<TextStyle>>? textStyleVariants,
    FVariants<FGoldenVariantConstraint, TextStyle?, Delta<TextStyle?>>? nullableTextStyleVariants,
    FGoldenNestedMotion Function(FGoldenNestedMotion motion)? nestedMotion,
    FGoldenNestedStyle Function(FGoldenNestedStyle style)? nestedStyle,
    List<String>? list,
    Set<String>? set,
    Map<String, int>? map,
    FVariants<FGoldenVariantConstraint, Color, Delta<Color>>? variantsWithGenericDelta,
    FVariants<FGoldenVariantConstraint, TextStyle, TextStyleDelta>? variantsWithSpecificDelta,
  }) => .new(
    someDouble: someDouble ?? this.someDouble,
    alignment: alignment ?? this.alignment,
    alignmentGeometry: alignmentGeometry ?? this.alignmentGeometry,
    borderRadius: borderRadius ?? this.borderRadius,
    borderRadiusGeometry: borderRadiusGeometry ?? this.borderRadiusGeometry,
    boxConstraints: boxConstraints ?? this.boxConstraints,
    boxDecoration: boxDecoration ?? this.boxDecoration,
    decoration: decoration ?? this.decoration,
    color: color ?? this.color,
    edgeInsets: edgeInsets ?? this.edgeInsets,
    edgeInsetsDirectional: edgeInsetsDirectional ?? this.edgeInsetsDirectional,
    edgeInsetsGeometry: edgeInsetsGeometry ?? this.edgeInsetsGeometry,
    iconThemeData: iconThemeData ?? this.iconThemeData,
    textStyle: textStyle ?? this.textStyle,
    boxShadows: boxShadows ?? this.boxShadows,
    shadows: shadows ?? this.shadows,
    boxDecorationVariants: boxDecorationVariants ?? this.boxDecorationVariants,
    nullableBoxDecorationVariants: nullableBoxDecorationVariants ?? this.nullableBoxDecorationVariants,
    colorVariants: colorVariants ?? this.colorVariants,
    nullableColorVariants: nullableColorVariants ?? this.nullableColorVariants,
    iconThemeDataVariants: iconThemeDataVariants ?? this.iconThemeDataVariants,
    nullableIconThemeDataVariants: nullableIconThemeDataVariants ?? this.nullableIconThemeDataVariants,
    textStyleVariants: textStyleVariants ?? this.textStyleVariants,
    nullableTextStyleVariants: nullableTextStyleVariants ?? this.nullableTextStyleVariants,
    nestedMotion: nestedMotion != null ? nestedMotion(this.nestedMotion) : this.nestedMotion,
    nestedStyle: nestedStyle != null ? nestedStyle(this.nestedStyle) : this.nestedStyle,
    list: list ?? this.list,
    set: set ?? this.set,
    map: map ?? this.map,
    variantsWithGenericDelta: variantsWithGenericDelta ?? this.variantsWithGenericDelta,
    variantsWithSpecificDelta: variantsWithSpecificDelta ?? this.variantsWithSpecificDelta,
  );

  /// Linearly interpolate between this and another [FGoldenStyle] using the given factor [t].
  @useResult
  FGoldenStyle lerp(FGoldenStyle other, double t) => .new(
    someDouble: lerpDouble(someDouble, other.someDouble, t) ?? someDouble,
    alignment: .lerp(alignment, other.alignment, t) ?? alignment,
    alignmentGeometry: .lerp(alignmentGeometry, other.alignmentGeometry, t) ?? alignmentGeometry,
    borderRadius: .lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    borderRadiusGeometry: .lerp(borderRadiusGeometry, other.borderRadiusGeometry, t) ?? borderRadiusGeometry,
    boxConstraints: .lerp(boxConstraints, other.boxConstraints, t) ?? boxConstraints,
    boxDecoration: .lerp(boxDecoration, other.boxDecoration, t) ?? boxDecoration,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    color: .lerp(color, other.color, t) ?? color,
    edgeInsets: .lerp(edgeInsets, other.edgeInsets, t) ?? edgeInsets,
    edgeInsetsDirectional: .lerp(edgeInsetsDirectional, other.edgeInsetsDirectional, t) ?? edgeInsetsDirectional,
    edgeInsetsGeometry: .lerp(edgeInsetsGeometry, other.edgeInsetsGeometry, t) ?? edgeInsetsGeometry,
    iconThemeData: .lerp(iconThemeData, other.iconThemeData, t),
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    boxShadows: BoxShadow.lerpList(boxShadows, other.boxShadows, t) ?? boxShadows,
    shadows: Shadow.lerpList(shadows, other.shadows, t) ?? shadows,
    boxDecorationVariants: .lerpBoxDecoration(boxDecorationVariants, other.boxDecorationVariants, t),
    nullableBoxDecorationVariants: .lerpWhere(
      nullableBoxDecorationVariants,
      other.nullableBoxDecorationVariants,
      t,
      BoxDecoration.lerp,
    ),
    colorVariants: .lerpColor(colorVariants, other.colorVariants, t),
    nullableColorVariants: .lerpWhere(nullableColorVariants, other.nullableColorVariants, t, Color.lerp),
    iconThemeDataVariants: .lerpIconThemeData(iconThemeDataVariants, other.iconThemeDataVariants, t),
    nullableIconThemeDataVariants: .lerpWhere(
      nullableIconThemeDataVariants,
      other.nullableIconThemeDataVariants,
      t,
      IconThemeData.lerp,
    ),
    textStyleVariants: .lerpTextStyle(textStyleVariants, other.textStyleVariants, t),
    nullableTextStyleVariants: .lerpWhere(
      nullableTextStyleVariants,
      other.nullableTextStyleVariants,
      t,
      TextStyle.lerp,
    ),
    nestedMotion: nestedMotion.lerp(other.nestedMotion, t),
    nestedStyle: nestedStyle.lerp(other.nestedStyle, t),
    list: t < 0.5 ? list : other.list,
    set: t < 0.5 ? set : other.set,
    map: t < 0.5 ? map : other.map,
    variantsWithGenericDelta: .lerpColor(variantsWithGenericDelta, other.variantsWithGenericDelta, t),
    variantsWithSpecificDelta: .lerpTextStyle(variantsWithSpecificDelta, other.variantsWithSpecificDelta, t),
  );
}

mixin _$FGoldenStyleFunctions on Diagnosticable {
  double get someDouble;
  Alignment get alignment;
  AlignmentGeometry get alignmentGeometry;
  BorderRadius get borderRadius;
  BorderRadiusGeometry get borderRadiusGeometry;
  BoxConstraints get boxConstraints;
  BoxDecoration get boxDecoration;
  Decoration get decoration;
  Color get color;
  EdgeInsets get edgeInsets;
  EdgeInsetsDirectional get edgeInsetsDirectional;
  EdgeInsetsGeometry get edgeInsetsGeometry;
  IconThemeData get iconThemeData;
  TextStyle get textStyle;
  List<BoxShadow> get boxShadows;
  List<Shadow> get shadows;
  FVariants<FGoldenVariantConstraint, BoxDecoration, Delta<BoxDecoration>> get boxDecorationVariants;
  FVariants<FGoldenVariantConstraint, BoxDecoration?, Delta<BoxDecoration?>> get nullableBoxDecorationVariants;
  FVariants<FGoldenVariantConstraint, Color, Delta<Color>> get colorVariants;
  FVariants<FGoldenVariantConstraint, Color?, Delta<Color?>> get nullableColorVariants;
  FVariants<FGoldenVariantConstraint, IconThemeData, Delta<IconThemeData>> get iconThemeDataVariants;
  FVariants<FGoldenVariantConstraint, IconThemeData?, Delta<IconThemeData?>> get nullableIconThemeDataVariants;
  FVariants<FGoldenVariantConstraint, TextStyle, Delta<TextStyle>> get textStyleVariants;
  FVariants<FGoldenVariantConstraint, TextStyle?, Delta<TextStyle?>> get nullableTextStyleVariants;
  FGoldenNestedMotion get nestedMotion;
  FGoldenNestedStyle get nestedStyle;
  List<String> get list;
  Set<String> get set;
  Map<String, int> get map;
  FVariants<FGoldenVariantConstraint, Color, Delta<Color>> get variantsWithGenericDelta;
  FVariants<FGoldenVariantConstraint, TextStyle, TextStyleDelta> get variantsWithSpecificDelta;

  /// Returns itself.
  ///
  /// Allows [FGoldenStyle] to replace functions that accept and return a [FGoldenStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FGoldenStyle Function(FGoldenStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FGoldenStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FGoldenStyle(...));
  /// ```
  @useResult
  FGoldenStyle call(Object? _) => this as FGoldenStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('someDouble', someDouble, level: .debug))
      ..add(DiagnosticsProperty('alignment', alignment, level: .debug))
      ..add(DiagnosticsProperty('alignmentGeometry', alignmentGeometry, level: .debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: .debug))
      ..add(DiagnosticsProperty('borderRadiusGeometry', borderRadiusGeometry, level: .debug))
      ..add(DiagnosticsProperty('boxConstraints', boxConstraints, level: .debug))
      ..add(DiagnosticsProperty('boxDecoration', boxDecoration, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(ColorProperty('color', color, level: .debug))
      ..add(DiagnosticsProperty('edgeInsets', edgeInsets, level: .debug))
      ..add(DiagnosticsProperty('edgeInsetsDirectional', edgeInsetsDirectional, level: .debug))
      ..add(DiagnosticsProperty('edgeInsetsGeometry', edgeInsetsGeometry, level: .debug))
      ..add(DiagnosticsProperty('iconThemeData', iconThemeData, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(IterableProperty('boxShadows', boxShadows, level: .debug))
      ..add(IterableProperty('shadows', shadows, level: .debug))
      ..add(DiagnosticsProperty('boxDecorationVariants', boxDecorationVariants, level: .debug))
      ..add(DiagnosticsProperty('nullableBoxDecorationVariants', nullableBoxDecorationVariants, level: .debug))
      ..add(DiagnosticsProperty('colorVariants', colorVariants, level: .debug))
      ..add(DiagnosticsProperty('nullableColorVariants', nullableColorVariants, level: .debug))
      ..add(DiagnosticsProperty('iconThemeDataVariants', iconThemeDataVariants, level: .debug))
      ..add(DiagnosticsProperty('nullableIconThemeDataVariants', nullableIconThemeDataVariants, level: .debug))
      ..add(DiagnosticsProperty('textStyleVariants', textStyleVariants, level: .debug))
      ..add(DiagnosticsProperty('nullableTextStyleVariants', nullableTextStyleVariants, level: .debug))
      ..add(DiagnosticsProperty('nestedMotion', nestedMotion, level: .debug))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle, level: .debug))
      ..add(IterableProperty('list', list, level: .debug))
      ..add(IterableProperty('set', set, level: .debug))
      ..add(DiagnosticsProperty('map', map, level: .debug))
      ..add(DiagnosticsProperty('variantsWithGenericDelta', variantsWithGenericDelta, level: .debug))
      ..add(DiagnosticsProperty('variantsWithSpecificDelta', variantsWithSpecificDelta, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FGoldenStyle &&
          runtimeType == other.runtimeType &&
          someDouble == other.someDouble &&
          alignment == other.alignment &&
          alignmentGeometry == other.alignmentGeometry &&
          borderRadius == other.borderRadius &&
          borderRadiusGeometry == other.borderRadiusGeometry &&
          boxConstraints == other.boxConstraints &&
          boxDecoration == other.boxDecoration &&
          decoration == other.decoration &&
          color == other.color &&
          edgeInsets == other.edgeInsets &&
          edgeInsetsDirectional == other.edgeInsetsDirectional &&
          edgeInsetsGeometry == other.edgeInsetsGeometry &&
          iconThemeData == other.iconThemeData &&
          textStyle == other.textStyle &&
          listEquals(boxShadows, other.boxShadows) &&
          listEquals(shadows, other.shadows) &&
          boxDecorationVariants == other.boxDecorationVariants &&
          nullableBoxDecorationVariants == other.nullableBoxDecorationVariants &&
          colorVariants == other.colorVariants &&
          nullableColorVariants == other.nullableColorVariants &&
          iconThemeDataVariants == other.iconThemeDataVariants &&
          nullableIconThemeDataVariants == other.nullableIconThemeDataVariants &&
          textStyleVariants == other.textStyleVariants &&
          nullableTextStyleVariants == other.nullableTextStyleVariants &&
          nestedMotion == other.nestedMotion &&
          nestedStyle == other.nestedStyle &&
          listEquals(list, other.list) &&
          setEquals(set, other.set) &&
          mapEquals(map, other.map) &&
          variantsWithGenericDelta == other.variantsWithGenericDelta &&
          variantsWithSpecificDelta == other.variantsWithSpecificDelta);

  @override
  int get hashCode =>
      someDouble.hashCode ^
      alignment.hashCode ^
      alignmentGeometry.hashCode ^
      borderRadius.hashCode ^
      borderRadiusGeometry.hashCode ^
      boxConstraints.hashCode ^
      boxDecoration.hashCode ^
      decoration.hashCode ^
      color.hashCode ^
      edgeInsets.hashCode ^
      edgeInsetsDirectional.hashCode ^
      edgeInsetsGeometry.hashCode ^
      iconThemeData.hashCode ^
      textStyle.hashCode ^
      const ListEquality().hash(boxShadows) ^
      const ListEquality().hash(shadows) ^
      boxDecorationVariants.hashCode ^
      nullableBoxDecorationVariants.hashCode ^
      colorVariants.hashCode ^
      nullableColorVariants.hashCode ^
      iconThemeDataVariants.hashCode ^
      nullableIconThemeDataVariants.hashCode ^
      textStyleVariants.hashCode ^
      nullableTextStyleVariants.hashCode ^
      nestedMotion.hashCode ^
      nestedStyle.hashCode ^
      const ListEquality().hash(list) ^
      const SetEquality().hash(set) ^
      const MapEquality().hash(map) ^
      variantsWithGenericDelta.hashCode ^
      variantsWithSpecificDelta.hashCode;
}

/// A delta that applies modifications to a [FGoldenStyle].
sealed class FGoldenStyleDelta with Delta<FGoldenStyle> {
  /// Creates a complete replacement for a [FGoldenStyle].
  const factory FGoldenStyleDelta.value(FGoldenStyle value) = _FGoldenStyleValue;

  /// Creates a delta that returns the [FGoldenStyle] in the current context.
  const factory FGoldenStyleDelta.inherit() = _FGoldenStyleInherit;

  /// Creates a partial modification of a [FGoldenStyle].
  const factory FGoldenStyleDelta.delta({
    double someDouble,
    Alignment? alignment,
    AlignmentGeometry? alignmentGeometry,
    BorderRadius? borderRadius,
    BorderRadiusGeometry? borderRadiusGeometry,
    BoxConstraints? boxConstraints,
    BoxDecorationDelta? boxDecoration,
    Decoration? decoration,
    Color color,
    EdgeInsets? edgeInsets,
    EdgeInsetsDirectional? edgeInsetsDirectional,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    IconThemeDataDelta? iconThemeData,
    TextStyleDelta? textStyle,
    List<BoxShadow>? boxShadows,
    List<Shadow>? shadows,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration>? boxDecorationVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration?>? nullableBoxDecorationVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? colorVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color?>? nullableColorVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData>? iconThemeDataVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData?>? nullableIconThemeDataVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle>? textStyleVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle?>? nullableTextStyleVariants,
    FGoldenNestedMotionDelta? nestedMotion,
    FGoldenNestedStyleDelta? nestedStyle,
    List<String>? list,
    Set<String>? set,
    Map<String, int>? map,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? variantsWithGenericDelta,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? variantsWithSpecificDelta,
  }) = _FGoldenStyleDelta;
}

class _FGoldenStyleValue implements FGoldenStyleDelta {
  const _FGoldenStyleValue(this._value);

  final FGoldenStyle _value;

  @override
  FGoldenStyle call(FGoldenStyle _) => _value;
}

class _FGoldenStyleInherit implements FGoldenStyleDelta {
  const _FGoldenStyleInherit();

  @override
  FGoldenStyle call(FGoldenStyle original) => original;
}

class _FGoldenStyleDelta implements FGoldenStyleDelta {
  const _FGoldenStyleDelta({
    this.someDouble = double.infinity,
    this.alignment,
    this.alignmentGeometry,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.boxConstraints,
    this.boxDecoration,
    this.decoration,
    this.color = colorSentinel,
    this.edgeInsets,
    this.edgeInsetsDirectional,
    this.edgeInsetsGeometry,
    this.iconThemeData,
    this.textStyle,
    this.boxShadows,
    this.shadows,
    this.boxDecorationVariants,
    this.nullableBoxDecorationVariants,
    this.colorVariants,
    this.nullableColorVariants,
    this.iconThemeDataVariants,
    this.nullableIconThemeDataVariants,
    this.textStyleVariants,
    this.nullableTextStyleVariants,
    this.nestedMotion,
    this.nestedStyle,
    this.list,
    this.set,
    this.map,
    this.variantsWithGenericDelta,
    this.variantsWithSpecificDelta,
  });

  final double someDouble;

  final Alignment? alignment;

  final AlignmentGeometry? alignmentGeometry;

  final BorderRadius? borderRadius;

  final BorderRadiusGeometry? borderRadiusGeometry;

  final BoxConstraints? boxConstraints;

  final BoxDecorationDelta? boxDecoration;

  final Decoration? decoration;

  final Color color;

  final EdgeInsets? edgeInsets;

  final EdgeInsetsDirectional? edgeInsetsDirectional;

  final EdgeInsetsGeometry? edgeInsetsGeometry;

  final IconThemeDataDelta? iconThemeData;

  final TextStyleDelta? textStyle;

  final List<BoxShadow>? boxShadows;

  final List<Shadow>? shadows;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration>? boxDecorationVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration?>? nullableBoxDecorationVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? colorVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color?>? nullableColorVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData>? iconThemeDataVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData?>? nullableIconThemeDataVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle>? textStyleVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle?>? nullableTextStyleVariants;

  final FGoldenNestedMotionDelta? nestedMotion;

  final FGoldenNestedStyleDelta? nestedStyle;

  final List<String>? list;

  final Set<String>? set;

  final Map<String, int>? map;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? variantsWithGenericDelta;

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? variantsWithSpecificDelta;

  @override
  FGoldenStyle call(FGoldenStyle original) => FGoldenStyle(
    someDouble: someDouble == double.infinity ? original.someDouble : someDouble,
    alignment: alignment ?? original.alignment,
    alignmentGeometry: alignmentGeometry ?? original.alignmentGeometry,
    borderRadius: borderRadius ?? original.borderRadius,
    borderRadiusGeometry: borderRadiusGeometry ?? original.borderRadiusGeometry,
    boxConstraints: boxConstraints ?? original.boxConstraints,
    boxDecoration: boxDecoration?.call(original.boxDecoration) ?? original.boxDecoration,
    decoration: decoration ?? original.decoration,
    color: color == colorSentinel ? original.color : color,
    edgeInsets: edgeInsets ?? original.edgeInsets,
    edgeInsetsDirectional: edgeInsetsDirectional ?? original.edgeInsetsDirectional,
    edgeInsetsGeometry: edgeInsetsGeometry ?? original.edgeInsetsGeometry,
    iconThemeData: iconThemeData?.call(original.iconThemeData) ?? original.iconThemeData,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    boxShadows: boxShadows ?? original.boxShadows,
    shadows: shadows ?? original.shadows,
    boxDecorationVariants:
        boxDecorationVariants?.call(original.boxDecorationVariants) ?? original.boxDecorationVariants,
    nullableBoxDecorationVariants:
        nullableBoxDecorationVariants?.call(original.nullableBoxDecorationVariants) ??
        original.nullableBoxDecorationVariants,
    colorVariants: colorVariants?.call(original.colorVariants) ?? original.colorVariants,
    nullableColorVariants:
        nullableColorVariants?.call(original.nullableColorVariants) ?? original.nullableColorVariants,
    iconThemeDataVariants:
        iconThemeDataVariants?.call(original.iconThemeDataVariants) ?? original.iconThemeDataVariants,
    nullableIconThemeDataVariants:
        nullableIconThemeDataVariants?.call(original.nullableIconThemeDataVariants) ??
        original.nullableIconThemeDataVariants,
    textStyleVariants: textStyleVariants?.call(original.textStyleVariants) ?? original.textStyleVariants,
    nullableTextStyleVariants:
        nullableTextStyleVariants?.call(original.nullableTextStyleVariants) ?? original.nullableTextStyleVariants,
    nestedMotion: nestedMotion?.call(original.nestedMotion) ?? original.nestedMotion,
    nestedStyle: nestedStyle?.call(original.nestedStyle) ?? original.nestedStyle,
    list: list ?? original.list,
    set: set ?? original.set,
    map: map ?? original.map,
    variantsWithGenericDelta:
        variantsWithGenericDelta?.call(original.variantsWithGenericDelta) ?? original.variantsWithGenericDelta,
    variantsWithSpecificDelta:
        variantsWithSpecificDelta?.call(original.variantsWithSpecificDelta) ?? original.variantsWithSpecificDelta,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FGoldenNestedMotionTransformations on FGoldenNestedMotion {
  /// Returns a copy of this [FGoldenNestedMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FGoldenNestedMotion.someDouble] - This is a field's summary.
  /// * [FGoldenNestedMotion.duration]
  /// * [FGoldenNestedMotion.curve]
  @useResult
  FGoldenNestedMotion copyWith({double? someDouble, Duration? duration, Curve? curve}) =>
      .new(someDouble: someDouble ?? this.someDouble, duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FGoldenNestedMotion] using the given factor [t].
  @useResult
  FGoldenNestedMotion lerp(FGoldenNestedMotion other, double t) => .new(
    someDouble: lerpDouble(someDouble, other.someDouble, t) ?? someDouble,
    duration: t < 0.5 ? duration : other.duration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FGoldenNestedMotionFunctions on Diagnosticable {
  double get someDouble;
  Duration get duration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FGoldenNestedMotion call(Object? _) => this as FGoldenNestedMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('someDouble', someDouble, level: .debug))
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FGoldenNestedMotion &&
          runtimeType == other.runtimeType &&
          someDouble == other.someDouble &&
          duration == other.duration &&
          curve == other.curve);

  @override
  int get hashCode => someDouble.hashCode ^ duration.hashCode ^ curve.hashCode;
}

/// A delta that applies modifications to a [FGoldenNestedMotion].
sealed class FGoldenNestedMotionDelta with Delta<FGoldenNestedMotion> {
  /// Creates a complete replacement for a [FGoldenNestedMotion].
  const factory FGoldenNestedMotionDelta.value(FGoldenNestedMotion value) = _FGoldenNestedMotionValue;

  /// Creates a delta that returns the [FGoldenNestedMotion] in the current context.
  const factory FGoldenNestedMotionDelta.inherit() = _FGoldenNestedMotionInherit;

  /// Creates a partial modification of a [FGoldenNestedMotion].
  const factory FGoldenNestedMotionDelta.delta({double? someDouble, Duration? duration, Curve? curve}) =
      _FGoldenNestedMotionDelta;
}

class _FGoldenNestedMotionValue implements FGoldenNestedMotionDelta {
  const _FGoldenNestedMotionValue(this._value);

  final FGoldenNestedMotion _value;

  @override
  FGoldenNestedMotion call(FGoldenNestedMotion _) => _value;
}

class _FGoldenNestedMotionInherit implements FGoldenNestedMotionDelta {
  const _FGoldenNestedMotionInherit();

  @override
  FGoldenNestedMotion call(FGoldenNestedMotion original) => original;
}

class _FGoldenNestedMotionDelta implements FGoldenNestedMotionDelta {
  const _FGoldenNestedMotionDelta({this.someDouble, this.duration, this.curve});

  final double? someDouble;

  final Duration? duration;

  final Curve? curve;

  @override
  FGoldenNestedMotion call(FGoldenNestedMotion original) => FGoldenNestedMotion(
    someDouble: someDouble ?? original.someDouble,
    duration: duration ?? original.duration,
    curve: curve ?? original.curve,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FGoldenNestedStyleTransformations on FGoldenNestedStyle {
  /// Returns a copy of this [FGoldenNestedStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  @useResult
  FGoldenNestedStyle copyWith() => .new();

  /// Linearly interpolate between this and another [FGoldenNestedStyle] using the given factor [t].
  @useResult
  FGoldenNestedStyle lerp(FGoldenNestedStyle other, double t) => .new();
}

mixin _$FGoldenNestedStyleFunctions on Diagnosticable {
  /// Returns itself.
  ///
  /// Allows [FGoldenNestedStyle] to replace functions that accept and return a [FGoldenNestedStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FGoldenNestedStyle Function(FGoldenNestedStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FGoldenNestedStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FGoldenNestedStyle(...));
  /// ```
  @useResult
  FGoldenNestedStyle call(Object? _) => this as FGoldenNestedStyle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FGoldenNestedStyle && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

/// A delta that applies modifications to a [FGoldenNestedStyle].
sealed class FGoldenNestedStyleDelta with Delta<FGoldenNestedStyle> {
  /// Creates a complete replacement for a [FGoldenNestedStyle].
  const factory FGoldenNestedStyleDelta.value(FGoldenNestedStyle value) = _FGoldenNestedStyleValue;

  /// Creates a delta that returns the [FGoldenNestedStyle] in the current context.
  const factory FGoldenNestedStyleDelta.inherit() = _FGoldenNestedStyleInherit;

  /// Creates a partial modification of a [FGoldenNestedStyle].
  const factory FGoldenNestedStyleDelta.delta() = _FGoldenNestedStyleDelta;
}

class _FGoldenNestedStyleValue implements FGoldenNestedStyleDelta {
  const _FGoldenNestedStyleValue(this._value);

  final FGoldenNestedStyle _value;

  @override
  FGoldenNestedStyle call(FGoldenNestedStyle _) => _value;
}

class _FGoldenNestedStyleInherit implements FGoldenNestedStyleDelta {
  const _FGoldenNestedStyleInherit();

  @override
  FGoldenNestedStyle call(FGoldenNestedStyle original) => original;
}

class _FGoldenNestedStyleDelta implements FGoldenNestedStyleDelta {
  const _FGoldenNestedStyleDelta();

  @override
  FGoldenNestedStyle call(FGoldenNestedStyle original) => FGoldenNestedStyle();
}
''';

void main() {
  test('design', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      designBuilder(.empty),
      {'forui_internal_gen|test/src/example.dart': _source},
      outputs: {'forui_internal_gen|test/src/example.design.dart': _golden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
}

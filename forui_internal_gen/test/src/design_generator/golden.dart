const golden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'example.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FGoldenVariant], which represents individual variants.
extension type const FGoldenVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FGoldenVariantConstraint] that negates [variant].
  factory FGoldenVariantConstraint.not(FGoldenVariant variant) => FGoldenVariantConstraint._(Not(variant));

  /// The hovered state
  static const hovered = FGoldenVariant.hovered;

  /// The pressed state
  static const pressed = FGoldenVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FGoldenVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FGoldenVariant._(Desktop());

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

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FGoldenVariantConstraint], which represents combinations of variants.
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
    double someDouble = double.infinity,
    Alignment? alignment,
    AlignmentGeometry? alignmentGeometry,
    BorderRadius? borderRadius,
    BorderRadiusGeometry? borderRadiusGeometry,
    BoxConstraints? boxConstraints,
    BoxDecorationDelta? boxDecoration,
    Decoration? decoration,
    Color color = colorSentinel,
    EdgeInsets? edgeInsets,
    EdgeInsetsDirectional? edgeInsetsDirectional,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    IconThemeDataDelta? iconThemeData,
    TextStyleDelta? textStyle,
    List<BoxShadow>? boxShadows,
    List<Shadow>? shadows,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration, BoxDecorationDelta>? boxDecorationVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration?, BoxDecorationDelta>?
    nullableBoxDecorationVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? colorVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color?>? nullableColorVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData, IconThemeDataDelta>? iconThemeDataVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData?, IconThemeDataDelta>?
    nullableIconThemeDataVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? textStyleVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle?, TextStyleDelta>? nullableTextStyleVariants,
    FGoldenNestedMotionDelta? nestedMotion,
    FGoldenNestedStyleDelta? nestedStyle,
    List<String>? list,
    Set<String>? set,
    Map<String, int>? map,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? variantsWithGenericDelta,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? variantsWithSpecificDelta,
  }) => .new(
    someDouble: someDouble == double.infinity ? this.someDouble : someDouble,
    alignment: alignment ?? this.alignment,
    alignmentGeometry: alignmentGeometry ?? this.alignmentGeometry,
    borderRadius: borderRadius ?? this.borderRadius,
    borderRadiusGeometry: borderRadiusGeometry ?? this.borderRadiusGeometry,
    boxConstraints: boxConstraints ?? this.boxConstraints,
    boxDecoration: boxDecoration?.call(this.boxDecoration) ?? this.boxDecoration,
    decoration: decoration ?? this.decoration,
    color: color == colorSentinel ? this.color : color,
    edgeInsets: edgeInsets ?? this.edgeInsets,
    edgeInsetsDirectional: edgeInsetsDirectional ?? this.edgeInsetsDirectional,
    edgeInsetsGeometry: edgeInsetsGeometry ?? this.edgeInsetsGeometry,
    iconThemeData: iconThemeData?.call(this.iconThemeData) ?? this.iconThemeData,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    boxShadows: boxShadows ?? this.boxShadows,
    shadows: shadows ?? this.shadows,
    boxDecorationVariants: boxDecorationVariants?.call(this.boxDecorationVariants) ?? this.boxDecorationVariants,
    nullableBoxDecorationVariants:
        nullableBoxDecorationVariants?.call(this.nullableBoxDecorationVariants) ?? this.nullableBoxDecorationVariants,
    colorVariants: colorVariants?.call(this.colorVariants) ?? this.colorVariants,
    nullableColorVariants: nullableColorVariants?.call(this.nullableColorVariants) ?? this.nullableColorVariants,
    iconThemeDataVariants: iconThemeDataVariants?.call(this.iconThemeDataVariants) ?? this.iconThemeDataVariants,
    nullableIconThemeDataVariants:
        nullableIconThemeDataVariants?.call(this.nullableIconThemeDataVariants) ?? this.nullableIconThemeDataVariants,
    textStyleVariants: textStyleVariants?.call(this.textStyleVariants) ?? this.textStyleVariants,
    nullableTextStyleVariants:
        nullableTextStyleVariants?.call(this.nullableTextStyleVariants) ?? this.nullableTextStyleVariants,
    nestedMotion: nestedMotion?.call(this.nestedMotion) ?? this.nestedMotion,
    nestedStyle: nestedStyle?.call(this.nestedStyle) ?? this.nestedStyle,
    list: list ?? this.list,
    set: set ?? this.set,
    map: map ?? this.map,
    variantsWithGenericDelta:
        variantsWithGenericDelta?.call(this.variantsWithGenericDelta) ?? this.variantsWithGenericDelta,
    variantsWithSpecificDelta:
        variantsWithSpecificDelta?.call(this.variantsWithSpecificDelta) ?? this.variantsWithSpecificDelta,
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
    color: FColors.lerpColor(color, other.color, t) ?? color,
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

mixin _$FGoldenStyleFunctions on Diagnosticable implements FGoldenStyleDelta {
  /// Returns itself.
  @override
  FGoldenStyle call(Object _) => this as FGoldenStyle;

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
  FVariants<FGoldenVariantConstraint, BoxDecoration, BoxDecorationDelta> get boxDecorationVariants;
  FVariants<FGoldenVariantConstraint, BoxDecoration?, BoxDecorationDelta> get nullableBoxDecorationVariants;
  FVariants<FGoldenVariantConstraint, Color, Delta> get colorVariants;
  FVariants<FGoldenVariantConstraint, Color?, Delta> get nullableColorVariants;
  FVariants<FGoldenVariantConstraint, IconThemeData, IconThemeDataDelta> get iconThemeDataVariants;
  FVariants<FGoldenVariantConstraint, IconThemeData?, IconThemeDataDelta> get nullableIconThemeDataVariants;
  FVariants<FGoldenVariantConstraint, TextStyle, TextStyleDelta> get textStyleVariants;
  FVariants<FGoldenVariantConstraint, TextStyle?, TextStyleDelta> get nullableTextStyleVariants;
  FGoldenNestedMotion get nestedMotion;
  FGoldenNestedStyle get nestedStyle;
  List<String> get list;
  Set<String> get set;
  Map<String, int> get map;
  FVariants<FGoldenVariantConstraint, Color, Delta> get variantsWithGenericDelta;
  FVariants<FGoldenVariantConstraint, TextStyle, TextStyleDelta> get variantsWithSpecificDelta;
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
///
/// A [FGoldenStyle] is itself a [FGoldenStyleDelta].
sealed class FGoldenStyleDelta with Delta {
  /// Creates a delta that returns the [FGoldenStyle] in the current context.
  const factory FGoldenStyleDelta.inherit() = _FGoldenStyleInherit;

  /// Creates a partial modification of a [FGoldenStyle].
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
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration, BoxDecorationDelta>? boxDecorationVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration?, BoxDecorationDelta>?
    nullableBoxDecorationVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? colorVariants,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color?>? nullableColorVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData, IconThemeDataDelta>? iconThemeDataVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData?, IconThemeDataDelta>?
    nullableIconThemeDataVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? textStyleVariants,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle?, TextStyleDelta>? nullableTextStyleVariants,
    FGoldenNestedMotionDelta? nestedMotion,
    FGoldenNestedStyleDelta? nestedStyle,
    List<String>? list,
    Set<String>? set,
    Map<String, int>? map,
    FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? variantsWithGenericDelta,
    FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? variantsWithSpecificDelta,
  }) = _FGoldenStyleDelta;

  @override
  FGoldenStyle call(covariant FGoldenStyle value);
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

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration, BoxDecorationDelta>?
  boxDecorationVariants;

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, BoxDecoration?, BoxDecorationDelta>?
  nullableBoxDecorationVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color>? colorVariants;

  final FVariantsValueDelta<FGoldenVariantConstraint, FGoldenVariant, Color?>? nullableColorVariants;

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData, IconThemeDataDelta>?
  iconThemeDataVariants;

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, IconThemeData?, IconThemeDataDelta>?
  nullableIconThemeDataVariants;

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle, TextStyleDelta>? textStyleVariants;

  final FVariantsDelta<FGoldenVariantConstraint, FGoldenVariant, TextStyle?, TextStyleDelta>? nullableTextStyleVariants;

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

mixin _$FGoldenNestedMotionFunctions on Diagnosticable implements FGoldenNestedMotionDelta {
  /// Returns itself.
  @override
  FGoldenNestedMotion call(Object _) => this as FGoldenNestedMotion;

  double get someDouble;
  Duration get duration;
  Curve get curve;
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
///
/// A [FGoldenNestedMotion] is itself a [FGoldenNestedMotionDelta].
sealed class FGoldenNestedMotionDelta with Delta {
  /// Creates a delta that returns the [FGoldenNestedMotion] in the current context.
  const factory FGoldenNestedMotionDelta.inherit() = _FGoldenNestedMotionInherit;

  /// Creates a partial modification of a [FGoldenNestedMotion].
  ///
  /// ## Parameters
  /// * [FGoldenNestedMotion.someDouble] - This is a field's summary.
  /// * [FGoldenNestedMotion.duration]
  /// * [FGoldenNestedMotion.curve]
  const factory FGoldenNestedMotionDelta.delta({double? someDouble, Duration? duration, Curve? curve}) =
      _FGoldenNestedMotionDelta;

  @override
  FGoldenNestedMotion call(covariant FGoldenNestedMotion value);
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

mixin _$FGoldenNestedStyleFunctions on Diagnosticable implements FGoldenNestedStyleDelta {
  /// Returns itself.
  @override
  FGoldenNestedStyle call(Object _) => this as FGoldenNestedStyle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FGoldenNestedStyle && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

/// A delta that applies modifications to a [FGoldenNestedStyle].
///
/// A [FGoldenNestedStyle] is itself a [FGoldenNestedStyleDelta].
sealed class FGoldenNestedStyleDelta with Delta {
  /// Creates a delta that returns the [FGoldenNestedStyle] in the current context.
  const factory FGoldenNestedStyleDelta.inherit() = _FGoldenNestedStyleInherit;

  /// Creates a partial modification of a [FGoldenNestedStyle].
  ///
  /// ## Parameters
  const factory FGoldenNestedStyleDelta.delta() = _FGoldenNestedStyleDelta;

  @override
  FGoldenNestedStyle call(covariant FGoldenNestedStyle value);
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

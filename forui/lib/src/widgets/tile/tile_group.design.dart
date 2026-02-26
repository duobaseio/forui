// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTileGroupStyleTransformations on FTileGroupStyle {
  /// Returns a copy of this [FTileGroupStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTileGroupStyle.decoration] - The group's decoration.
  /// * [FTileGroupStyle.dividerColor] - The divider's style.
  /// * [FTileGroupStyle.dividerWidth] - The divider's width.
  /// * [FTileGroupStyle.tileStyles] - The tile's styles.
  /// * [FTileGroupStyle.slideableTiles] - Whether the tiles support pressing a tile and sliding to another.
  /// * [FTileGroupStyle.labelPadding] - The label's padding.
  /// * [FTileGroupStyle.descriptionPadding] - The description's padding.
  /// * [FTileGroupStyle.errorPadding] - The error's padding.
  /// * [FTileGroupStyle.childPadding] - The child's padding.
  /// * [FTileGroupStyle.labelMotion] - The motion properties for error animations.
  /// * [FTileGroupStyle.labelTextStyle] - The label's text style.
  /// * [FTileGroupStyle.descriptionTextStyle] - The description's text style.
  /// * [FTileGroupStyle.errorTextStyle] - The error's text style.
  @useResult
  FTileGroupStyle copyWith({
    DecorationDelta? decoration,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FVariantsDelta<FItemVariantConstraint, FItemVariant, FTileStyle, FTileStyleDelta>? tileStyles,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta>? slideableTiles,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    dividerColor: dividerColor?.call(this.dividerColor) ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    tileStyles: tileStyles?.call(this.tileStyles) ?? this.tileStyles,
    slideableTiles: slideableTiles?.call(this.slideableTiles) ?? this.slideableTiles,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FTileGroupStyle] using the given factor [t].
  @useResult
  FTileGroupStyle lerp(FTileGroupStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    tileStyles: .lerpWhere(tileStyles, other.tileStyles, t, (a, b, t) => a!.lerp(b!, t)),
    slideableTiles: t < 0.5 ? slideableTiles : other.slideableTiles,
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelMotion: labelMotion.lerp(other.labelMotion, t),
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerpTextStyle(errorTextStyle, other.errorTextStyle, t),
  );
}

mixin _$FTileGroupStyleFunctions on Diagnosticable implements FTileGroupStyleDelta {
  /// Returns itself.
  @override
  FTileGroupStyle call(Object _) => this as FTileGroupStyle;

  Decoration get decoration;
  FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta> get dividerColor;
  double get dividerWidth;
  FVariants<FItemVariantConstraint, FItemVariant, FTileStyle, FTileStyleDelta> get tileStyles;
  FVariants<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta> get slideableTiles;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FLabelMotion get labelMotion;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get descriptionTextStyle;
  FVariants<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta> get errorTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: .debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: .debug))
      ..add(DiagnosticsProperty('tileStyles', tileStyles, level: .debug))
      ..add(DiagnosticsProperty('slideableTiles', slideableTiles, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileGroupStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          tileStyles == other.tileStyles &&
          slideableTiles == other.slideableTiles &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelMotion == other.labelMotion &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      tileStyles.hashCode ^
      slideableTiles.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FTileGroupStyle].
///
/// A [FTileGroupStyle] is itself a [FTileGroupStyleDelta].
abstract class FTileGroupStyleDelta with Delta {
  /// Creates a partial modification of a [FTileGroupStyle].
  ///
  /// ## Parameters
  /// * [FTileGroupStyle.decoration] - The group's decoration.
  /// * [FTileGroupStyle.dividerColor] - The divider's style.
  /// * [FTileGroupStyle.dividerWidth] - The divider's width.
  /// * [FTileGroupStyle.tileStyles] - The tile's styles.
  /// * [FTileGroupStyle.slideableTiles] - Whether the tiles support pressing a tile and sliding to another.
  /// * [FTileGroupStyle.labelPadding] - The label's padding.
  /// * [FTileGroupStyle.descriptionPadding] - The description's padding.
  /// * [FTileGroupStyle.errorPadding] - The error's padding.
  /// * [FTileGroupStyle.childPadding] - The child's padding.
  /// * [FTileGroupStyle.labelMotion] - The motion properties for error animations.
  /// * [FTileGroupStyle.labelTextStyle] - The label's text style.
  /// * [FTileGroupStyle.descriptionTextStyle] - The description's text style.
  /// * [FTileGroupStyle.errorTextStyle] - The error's text style.
  const factory FTileGroupStyleDelta.delta({
    DecorationDelta? decoration,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FVariantsDelta<FItemVariantConstraint, FItemVariant, FTileStyle, FTileStyleDelta>? tileStyles,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta>? slideableTiles,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FTileGroupStyleDelta;

  /// Creates a delta that returns the [FTileGroupStyle] in the current context.
  const factory FTileGroupStyleDelta.context() = _FTileGroupStyleContext;

  @override
  FTileGroupStyle call(covariant FTileGroupStyle value);
}

class _FTileGroupStyleDelta implements FTileGroupStyleDelta {
  const _FTileGroupStyleDelta({
    this.decoration,
    this.dividerColor,
    this.dividerWidth,
    this.tileStyles,
    this.slideableTiles,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final DecorationDelta? decoration;

  final FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor;

  final double? dividerWidth;

  final FVariantsDelta<FItemVariantConstraint, FItemVariant, FTileStyle, FTileStyleDelta>? tileStyles;

  final FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta>? slideableTiles;

  final EdgeInsetsGeometryDelta? labelPadding;

  final EdgeInsetsGeometryDelta? descriptionPadding;

  final EdgeInsetsGeometryDelta? errorPadding;

  final EdgeInsetsGeometryDelta? childPadding;

  final FLabelMotionDelta? labelMotion;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle;

  final FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>?
  errorTextStyle;

  @override
  FTileGroupStyle call(FTileGroupStyle original) => FTileGroupStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    dividerWidth: dividerWidth ?? original.dividerWidth,
    tileStyles: tileStyles?.call(original.tileStyles) ?? original.tileStyles,
    slideableTiles: slideableTiles?.call(original.slideableTiles) ?? original.slideableTiles,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    descriptionPadding: descriptionPadding?.call(original.descriptionPadding) ?? original.descriptionPadding,
    errorPadding: errorPadding?.call(original.errorPadding) ?? original.errorPadding,
    childPadding: childPadding?.call(original.childPadding) ?? original.childPadding,
    labelMotion: labelMotion?.call(original.labelMotion) ?? original.labelMotion,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(original.descriptionTextStyle) ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

class _FTileGroupStyleContext implements FTileGroupStyleDelta {
  const _FTileGroupStyleContext();

  @override
  FTileGroupStyle call(FTileGroupStyle original) => original;
}

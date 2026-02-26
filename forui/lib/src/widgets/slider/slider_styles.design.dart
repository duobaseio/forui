// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_styles.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FSliderAxisVariant], which represents individual variants.
extension type const FSliderAxisVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FSliderAxisVariantConstraint] that negates [variant].
  factory FSliderAxisVariantConstraint.not(FSliderAxisVariant variant) => FSliderAxisVariantConstraint._(Not(variant));

  /// The horizontal slider variant.
  static const horizontal = FSliderAxisVariant.horizontal;

  /// The vertical slider variant.
  static const vertical = FSliderAxisVariant.vertical;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FSliderAxisVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FSliderAxisVariant._(Desktop());

  /// The Android platform variant.
  static const android = FSliderAxisVariant.android;

  /// The iOS platform variant.
  static const iOS = FSliderAxisVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FSliderAxisVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FSliderAxisVariant.windows;

  /// The macOS platform variant.
  static const macOS = FSliderAxisVariant.macOS;

  /// The Linux platform variant.
  static const linux = FSliderAxisVariant.linux;

  /// The web platform variant.
  static const web = FSliderAxisVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FSliderAxisVariantConstraint and(FSliderAxisVariantConstraint other) =>
      FSliderAxisVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FSliderAxisVariantConstraint], which represents combinations of variants.
extension type const FSliderAxisVariant._(FVariant _) implements FSliderAxisVariantConstraint, FVariant {
  /// The horizontal slider variant.
  static const horizontal = FSliderAxisVariant._(.new(1, 'horizontal'));

  /// The vertical slider variant.
  static const vertical = FSliderAxisVariant._(.new(1, 'vertical'));

  /// The Android platform variant.
  static const android = FSliderAxisVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FSliderAxisVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FSliderAxisVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FSliderAxisVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FSliderAxisVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FSliderAxisVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FSliderAxisVariant._(FPlatformVariant.web);
}

/// Represents a combination of variants.
///
/// See also:
/// * [FSliderVariant], which represents individual variants.
extension type const FSliderVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FSliderVariantConstraint] that negates [variant].
  factory FSliderVariantConstraint.not(FSliderVariant variant) => FSliderVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FSliderVariant.disabled;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FSliderVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FSliderVariant._(Desktop());

  /// The Android platform variant.
  static const android = FSliderVariant.android;

  /// The iOS platform variant.
  static const iOS = FSliderVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FSliderVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FSliderVariant.windows;

  /// The macOS platform variant.
  static const macOS = FSliderVariant.macOS;

  /// The Linux platform variant.
  static const linux = FSliderVariant.linux;

  /// The web platform variant.
  static const web = FSliderVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FSliderVariantConstraint and(FSliderVariantConstraint other) => FSliderVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FSliderVariantConstraint], which represents combinations of variants.
extension type const FSliderVariant._(FVariant _) implements FSliderVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FSliderVariant._(.new(2, 'disabled'));

  /// The Android platform variant.
  static const android = FSliderVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FSliderVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FSliderVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FSliderVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FSliderVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FSliderVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FSliderVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FSliderStyleTransformations on FSliderStyle {
  /// Returns a copy of this [FSliderStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderStyle.activeColor] - The slider's active track colors.
  /// * [FSliderStyle.inactiveColor] - The slider's inactive track colors.
  /// * [FSliderStyle.borderRadius] - The slider's border radius.
  /// * [FSliderStyle.crossAxisExtent] - The slider's cross-axis extent.
  /// * [FSliderStyle.thumbSize] - The thumb's size.
  /// * [FSliderStyle.thumbStyle] - The slider thumb's style.
  /// * [FSliderStyle.markStyle] - The slider marks' style.
  /// * [FSliderStyle.tooltipStyle] - The tooltip's style.
  /// * [FSliderStyle.tooltipMotion] - The tooltip's motion-related properties.
  /// * [FSliderStyle.tooltipTipAnchor] - The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned.
  /// * [FSliderStyle.tooltipThumbAnchor] - The anchor of the thumb to which the [tooltipTipAnchor] is aligned.
  /// * [FSliderStyle.labelPadding] - The label's padding.
  /// * [FSliderStyle.descriptionPadding] - The description's padding.
  /// * [FSliderStyle.errorPadding] - The error's padding.
  /// * [FSliderStyle.childPadding] - The child's padding.
  /// * [FSliderStyle.labelMotion] - The motion properties for error animations.
  /// * [FSliderStyle.labelTextStyle] - The label's text style.
  /// * [FSliderStyle.descriptionTextStyle] - The description's text style.
  /// * [FSliderStyle.errorTextStyle] - The error's text style.
  @useResult
  FSliderStyle copyWith({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? activeColor,
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? inactiveColor,
    BorderRadius? borderRadius,
    double? crossAxisExtent,
    double? thumbSize,
    FSliderThumbStyleDelta? thumbStyle,
    FSliderMarkStyleDelta? markStyle,
    FTooltipStyleDelta? tooltipStyle,
    FTooltipMotionDelta? tooltipMotion,
    AlignmentGeometry? tooltipTipAnchor,
    AlignmentGeometry? tooltipThumbAnchor,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    activeColor: activeColor?.call(this.activeColor) ?? this.activeColor,
    inactiveColor: inactiveColor?.call(this.inactiveColor) ?? this.inactiveColor,
    borderRadius: borderRadius ?? this.borderRadius,
    crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
    thumbSize: thumbSize ?? this.thumbSize,
    thumbStyle: thumbStyle?.call(this.thumbStyle) ?? this.thumbStyle,
    markStyle: markStyle?.call(this.markStyle) ?? this.markStyle,
    tooltipStyle: tooltipStyle?.call(this.tooltipStyle) ?? this.tooltipStyle,
    tooltipMotion: tooltipMotion?.call(this.tooltipMotion) ?? this.tooltipMotion,
    tooltipTipAnchor: tooltipTipAnchor ?? this.tooltipTipAnchor,
    tooltipThumbAnchor: tooltipThumbAnchor ?? this.tooltipThumbAnchor,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSliderStyle] using the given factor [t].
  @useResult
  FSliderStyle lerp(FSliderStyle other, double t) => .new(
    activeColor: .lerpColor(activeColor, other.activeColor, t),
    inactiveColor: .lerpColor(inactiveColor, other.inactiveColor, t),
    borderRadius: .lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    crossAxisExtent: lerpDouble(crossAxisExtent, other.crossAxisExtent, t) ?? crossAxisExtent,
    thumbSize: lerpDouble(thumbSize, other.thumbSize, t) ?? thumbSize,
    thumbStyle: thumbStyle.lerp(other.thumbStyle, t),
    markStyle: markStyle.lerp(other.markStyle, t),
    tooltipStyle: tooltipStyle.lerp(other.tooltipStyle, t),
    tooltipMotion: tooltipMotion.lerp(other.tooltipMotion, t),
    tooltipTipAnchor: .lerp(tooltipTipAnchor, other.tooltipTipAnchor, t) ?? tooltipTipAnchor,
    tooltipThumbAnchor: .lerp(tooltipThumbAnchor, other.tooltipThumbAnchor, t) ?? tooltipThumbAnchor,
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

mixin _$FSliderStyleFunctions on Diagnosticable implements FSliderStyleDelta {
  /// Returns itself.
  @override
  FSliderStyle call(Object _) => this as FSliderStyle;

  FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> get activeColor;
  FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> get inactiveColor;
  BorderRadius get borderRadius;
  double get crossAxisExtent;
  double get thumbSize;
  FSliderThumbStyle get thumbStyle;
  FSliderMarkStyle get markStyle;
  FTooltipStyle get tooltipStyle;
  FTooltipMotion get tooltipMotion;
  AlignmentGeometry get tooltipTipAnchor;
  AlignmentGeometry get tooltipThumbAnchor;
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
      ..add(DiagnosticsProperty('activeColor', activeColor, level: .debug))
      ..add(DiagnosticsProperty('inactiveColor', inactiveColor, level: .debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: .debug))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent, level: .debug))
      ..add(DoubleProperty('thumbSize', thumbSize, level: .debug))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle, level: .debug))
      ..add(DiagnosticsProperty('markStyle', markStyle, level: .debug))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle, level: .debug))
      ..add(DiagnosticsProperty('tooltipMotion', tooltipMotion, level: .debug))
      ..add(DiagnosticsProperty('tooltipTipAnchor', tooltipTipAnchor, level: .debug))
      ..add(DiagnosticsProperty('tooltipThumbAnchor', tooltipThumbAnchor, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderStyle &&
          runtimeType == other.runtimeType &&
          activeColor == other.activeColor &&
          inactiveColor == other.inactiveColor &&
          borderRadius == other.borderRadius &&
          crossAxisExtent == other.crossAxisExtent &&
          thumbSize == other.thumbSize &&
          thumbStyle == other.thumbStyle &&
          markStyle == other.markStyle &&
          tooltipStyle == other.tooltipStyle &&
          tooltipMotion == other.tooltipMotion &&
          tooltipTipAnchor == other.tooltipTipAnchor &&
          tooltipThumbAnchor == other.tooltipThumbAnchor &&
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
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      borderRadius.hashCode ^
      crossAxisExtent.hashCode ^
      thumbSize.hashCode ^
      thumbStyle.hashCode ^
      markStyle.hashCode ^
      tooltipStyle.hashCode ^
      tooltipMotion.hashCode ^
      tooltipTipAnchor.hashCode ^
      tooltipThumbAnchor.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FSliderStyle].
///
/// A [FSliderStyle] is itself a [FSliderStyleDelta].
abstract class FSliderStyleDelta with Delta {
  /// Creates a partial modification of a [FSliderStyle].
  ///
  /// ## Parameters
  /// * [FSliderStyle.activeColor] - The slider's active track colors.
  /// * [FSliderStyle.inactiveColor] - The slider's inactive track colors.
  /// * [FSliderStyle.borderRadius] - The slider's border radius.
  /// * [FSliderStyle.crossAxisExtent] - The slider's cross-axis extent.
  /// * [FSliderStyle.thumbSize] - The thumb's size.
  /// * [FSliderStyle.thumbStyle] - The slider thumb's style.
  /// * [FSliderStyle.markStyle] - The slider marks' style.
  /// * [FSliderStyle.tooltipStyle] - The tooltip's style.
  /// * [FSliderStyle.tooltipMotion] - The tooltip's motion-related properties.
  /// * [FSliderStyle.tooltipTipAnchor] - The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned.
  /// * [FSliderStyle.tooltipThumbAnchor] - The anchor of the thumb to which the [tooltipTipAnchor] is aligned.
  /// * [FSliderStyle.labelPadding] - The label's padding.
  /// * [FSliderStyle.descriptionPadding] - The description's padding.
  /// * [FSliderStyle.errorPadding] - The error's padding.
  /// * [FSliderStyle.childPadding] - The child's padding.
  /// * [FSliderStyle.labelMotion] - The motion properties for error animations.
  /// * [FSliderStyle.labelTextStyle] - The label's text style.
  /// * [FSliderStyle.descriptionTextStyle] - The description's text style.
  /// * [FSliderStyle.errorTextStyle] - The error's text style.
  const factory FSliderStyleDelta.delta({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? activeColor,
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? inactiveColor,
    BorderRadius? borderRadius,
    double? crossAxisExtent,
    double? thumbSize,
    FSliderThumbStyleDelta? thumbStyle,
    FSliderMarkStyleDelta? markStyle,
    FTooltipStyleDelta? tooltipStyle,
    FTooltipMotionDelta? tooltipMotion,
    AlignmentGeometry? tooltipTipAnchor,
    AlignmentGeometry? tooltipThumbAnchor,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FSliderStyleDelta;

  /// Creates a delta that returns the [FSliderStyle] in the current context.
  const factory FSliderStyleDelta.context() = _FSliderStyleContext;

  @override
  FSliderStyle call(covariant FSliderStyle value);
}

class _FSliderStyleDelta implements FSliderStyleDelta {
  const _FSliderStyleDelta({
    this.activeColor,
    this.inactiveColor,
    this.borderRadius,
    this.crossAxisExtent,
    this.thumbSize,
    this.thumbStyle,
    this.markStyle,
    this.tooltipStyle,
    this.tooltipMotion,
    this.tooltipTipAnchor,
    this.tooltipThumbAnchor,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? activeColor;

  final FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? inactiveColor;

  final BorderRadius? borderRadius;

  final double? crossAxisExtent;

  final double? thumbSize;

  final FSliderThumbStyleDelta? thumbStyle;

  final FSliderMarkStyleDelta? markStyle;

  final FTooltipStyleDelta? tooltipStyle;

  final FTooltipMotionDelta? tooltipMotion;

  final AlignmentGeometry? tooltipTipAnchor;

  final AlignmentGeometry? tooltipThumbAnchor;

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
  FSliderStyle call(FSliderStyle original) => FSliderStyle(
    activeColor: activeColor?.call(original.activeColor) ?? original.activeColor,
    inactiveColor: inactiveColor?.call(original.inactiveColor) ?? original.inactiveColor,
    borderRadius: borderRadius ?? original.borderRadius,
    crossAxisExtent: crossAxisExtent ?? original.crossAxisExtent,
    thumbSize: thumbSize ?? original.thumbSize,
    thumbStyle: thumbStyle?.call(original.thumbStyle) ?? original.thumbStyle,
    markStyle: markStyle?.call(original.markStyle) ?? original.markStyle,
    tooltipStyle: tooltipStyle?.call(original.tooltipStyle) ?? original.tooltipStyle,
    tooltipMotion: tooltipMotion?.call(original.tooltipMotion) ?? original.tooltipMotion,
    tooltipTipAnchor: tooltipTipAnchor ?? original.tooltipTipAnchor,
    tooltipThumbAnchor: tooltipThumbAnchor ?? original.tooltipThumbAnchor,
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

class _FSliderStyleContext implements FSliderStyleDelta {
  const _FSliderStyleContext();

  @override
  FSliderStyle call(FSliderStyle original) => original;
}

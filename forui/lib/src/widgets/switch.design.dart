// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'switch.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FSwitchVariant], which represents individual variants.
extension type const FSwitchVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FSwitchVariantConstraint] that negates [variant].
  factory FSwitchVariantConstraint.not(FSwitchVariant variant) => FSwitchVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FSwitchVariant.disabled;

  /// The semantic variant when this widget is in an error state.
  static const error = FSwitchVariant.error;

  /// The semantic variant when this widget is selected/on.
  static const selected = FSwitchVariant.selected;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FSwitchVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FSwitchVariant._(Desktop());

  /// The Android platform variant.
  static const android = FSwitchVariant.android;

  /// The iOS platform variant.
  static const iOS = FSwitchVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FSwitchVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FSwitchVariant.windows;

  /// The macOS platform variant.
  static const macOS = FSwitchVariant.macOS;

  /// The Linux platform variant.
  static const linux = FSwitchVariant.linux;

  /// The web platform variant.
  static const web = FSwitchVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FSwitchVariantConstraint and(FSwitchVariantConstraint other) => FSwitchVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FSwitchVariantConstraint], which represents combinations of variants.
extension type const FSwitchVariant._(FVariant _) implements FSwitchVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FSwitchVariant._(.new(2, 'disabled'));

  /// The semantic variant when this widget is in an error state.
  static const error = FSwitchVariant._(.new(2, 'error'));

  /// The semantic variant when this widget is selected/on.
  static const selected = FSwitchVariant._(.new(2, 'selected'));

  /// The Android platform variant.
  static const android = FSwitchVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FSwitchVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FSwitchVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FSwitchVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FSwitchVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FSwitchVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FSwitchVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FSwitchStyleTransformations on FSwitchStyle {
  /// Returns a copy of this [FSwitchStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSwitchStyle.focusColor] - This [FSwitch]'s color when focused.
  /// * [FSwitchStyle.trackColor] - The track's color.
  /// * [FSwitchStyle.thumbColor] - The thumb's color.
  /// * [FSwitchStyle.labelPadding] - The label's padding.
  /// * [FSwitchStyle.descriptionPadding] - The description's padding.
  /// * [FSwitchStyle.errorPadding] - The error's padding.
  /// * [FSwitchStyle.childPadding] - The child's padding.
  /// * [FSwitchStyle.labelMotion] - The motion properties for error animations.
  /// * [FSwitchStyle.labelTextStyle] - The label's text style.
  /// * [FSwitchStyle.descriptionTextStyle] - The description's text style.
  /// * [FSwitchStyle.errorTextStyle] - The error's text style.
  @useResult
  FSwitchStyle copyWith({
    Color? focusColor,
    FVariantsValueDelta<FSwitchVariantConstraint, FSwitchVariant, Color, Delta>? trackColor,
    FVariantsValueDelta<FSwitchVariantConstraint, FSwitchVariant, Color, Delta>? thumbColor,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    focusColor: focusColor ?? this.focusColor,
    trackColor: trackColor?.call(this.trackColor) ?? this.trackColor,
    thumbColor: thumbColor?.call(this.thumbColor) ?? this.thumbColor,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSwitchStyle] using the given factor [t].
  @useResult
  FSwitchStyle lerp(FSwitchStyle other, double t) => .new(
    focusColor: FColors.lerpColor(focusColor, other.focusColor, t) ?? focusColor,
    trackColor: .lerpColor(trackColor, other.trackColor, t),
    thumbColor: .lerpColor(thumbColor, other.thumbColor, t),
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

mixin _$FSwitchStyleFunctions on Diagnosticable implements FSwitchStyleDelta {
  /// Returns itself.
  @override
  FSwitchStyle call(Object _) => this as FSwitchStyle;

  Color get focusColor;
  FVariants<FSwitchVariantConstraint, FSwitchVariant, Color, Delta> get trackColor;
  FVariants<FSwitchVariantConstraint, FSwitchVariant, Color, Delta> get thumbColor;
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
      ..add(ColorProperty('focusColor', focusColor, level: .debug))
      ..add(DiagnosticsProperty('trackColor', trackColor, level: .debug))
      ..add(DiagnosticsProperty('thumbColor', thumbColor, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSwitchStyle &&
          runtimeType == other.runtimeType &&
          focusColor == other.focusColor &&
          trackColor == other.trackColor &&
          thumbColor == other.thumbColor &&
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
      focusColor.hashCode ^
      trackColor.hashCode ^
      thumbColor.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FSwitchStyle].
///
/// A [FSwitchStyle] is itself a [FSwitchStyleDelta].
abstract class FSwitchStyleDelta with Delta {
  /// Creates a partial modification of a [FSwitchStyle].
  ///
  /// ## Parameters
  /// * [FSwitchStyle.focusColor] - This [FSwitch]'s color when focused.
  /// * [FSwitchStyle.trackColor] - The track's color.
  /// * [FSwitchStyle.thumbColor] - The thumb's color.
  /// * [FSwitchStyle.labelPadding] - The label's padding.
  /// * [FSwitchStyle.descriptionPadding] - The description's padding.
  /// * [FSwitchStyle.errorPadding] - The error's padding.
  /// * [FSwitchStyle.childPadding] - The child's padding.
  /// * [FSwitchStyle.labelMotion] - The motion properties for error animations.
  /// * [FSwitchStyle.labelTextStyle] - The label's text style.
  /// * [FSwitchStyle.descriptionTextStyle] - The description's text style.
  /// * [FSwitchStyle.errorTextStyle] - The error's text style.
  const factory FSwitchStyleDelta.delta({
    Color? focusColor,
    FVariantsValueDelta<FSwitchVariantConstraint, FSwitchVariant, Color, Delta>? trackColor,
    FVariantsValueDelta<FSwitchVariantConstraint, FSwitchVariant, Color, Delta>? thumbColor,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FSwitchStyleDelta;

  /// Creates a delta that returns the [FSwitchStyle] in the current context.
  const factory FSwitchStyleDelta.context() = _FSwitchStyleContext;

  @override
  FSwitchStyle call(covariant FSwitchStyle value);
}

class _FSwitchStyleDelta implements FSwitchStyleDelta {
  const _FSwitchStyleDelta({
    this.focusColor,
    this.trackColor,
    this.thumbColor,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final Color? focusColor;

  final FVariantsValueDelta<FSwitchVariantConstraint, FSwitchVariant, Color, Delta>? trackColor;

  final FVariantsValueDelta<FSwitchVariantConstraint, FSwitchVariant, Color, Delta>? thumbColor;

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
  FSwitchStyle call(FSwitchStyle original) => FSwitchStyle(
    focusColor: focusColor ?? original.focusColor,
    trackColor: trackColor?.call(original.trackColor) ?? original.trackColor,
    thumbColor: thumbColor?.call(original.thumbColor) ?? original.thumbColor,
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

class _FSwitchStyleContext implements FSwitchStyleDelta {
  const _FSwitchStyleContext();

  @override
  FSwitchStyle call(FSwitchStyle original) => original;
}

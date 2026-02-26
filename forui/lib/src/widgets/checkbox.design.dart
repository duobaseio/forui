// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'checkbox.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FCheckboxVariant], which represents individual variants.
extension type const FCheckboxVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FCheckboxVariantConstraint] that negates [variant].
  factory FCheckboxVariantConstraint.not(FCheckboxVariant variant) => FCheckboxVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCheckboxVariant.disabled;

  /// The semantic variant when this widget is in an error state.
  static const error = FCheckboxVariant.error;

  /// The semantic variant when this widget is selected/checked.
  static const selected = FCheckboxVariant.selected;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCheckboxVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCheckboxVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCheckboxVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FCheckboxVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FCheckboxVariant._(Desktop());

  /// The Android platform variant.
  static const android = FCheckboxVariant.android;

  /// The iOS platform variant.
  static const iOS = FCheckboxVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FCheckboxVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FCheckboxVariant.windows;

  /// The macOS platform variant.
  static const macOS = FCheckboxVariant.macOS;

  /// The Linux platform variant.
  static const linux = FCheckboxVariant.linux;

  /// The web platform variant.
  static const web = FCheckboxVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FCheckboxVariantConstraint and(FCheckboxVariantConstraint other) => FCheckboxVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FCheckboxVariantConstraint], which represents combinations of variants.
extension type const FCheckboxVariant._(FVariant _) implements FCheckboxVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCheckboxVariant._(.new(2, 'disabled'));

  /// The semantic variant when this widget is in an error state.
  static const error = FCheckboxVariant._(.new(2, 'error'));

  /// The semantic variant when this widget is selected/checked.
  static const selected = FCheckboxVariant._(.new(2, 'selected'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCheckboxVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCheckboxVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCheckboxVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FCheckboxVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FCheckboxVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FCheckboxVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FCheckboxVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FCheckboxVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FCheckboxVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FCheckboxVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FCheckboxStyleTransformations on FCheckboxStyle {
  /// Returns a copy of this [FCheckboxStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCheckboxStyle.tappableStyle] - The tappable style.
  /// * [FCheckboxStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FCheckboxStyle.size] - The checkboxes size.
  /// * [FCheckboxStyle.iconStyle] - The icon style.
  /// * [FCheckboxStyle.decoration] - The box decoration.
  /// * [FCheckboxStyle.motion] - The motion-related properties.
  /// * [FCheckboxStyle.labelPadding] - The label's padding.
  /// * [FCheckboxStyle.descriptionPadding] - The description's padding.
  /// * [FCheckboxStyle.errorPadding] - The error's padding.
  /// * [FCheckboxStyle.childPadding] - The child's padding.
  /// * [FCheckboxStyle.labelMotion] - The motion properties for error animations.
  /// * [FCheckboxStyle.labelTextStyle] - The label's text style.
  /// * [FCheckboxStyle.descriptionTextStyle] - The description's text style.
  /// * [FCheckboxStyle.errorTextStyle] - The error's text style.
  @useResult
  FCheckboxStyle copyWith({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    double? size,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta>? decoration,
    FCheckboxMotionDelta? motion,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    size: size ?? this.size,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    motion: motion?.call(this.motion) ?? this.motion,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FCheckboxStyle] using the given factor [t].
  @useResult
  FCheckboxStyle lerp(FCheckboxStyle other, double t) => .new(
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    size: lerpDouble(size, other.size, t) ?? size,
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    decoration: .lerpDecoration(decoration, other.decoration, t),
    motion: motion.lerp(other.motion, t),
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

mixin _$FCheckboxStyleFunctions on Diagnosticable implements FCheckboxStyleDelta {
  /// Returns itself.
  @override
  FCheckboxStyle call(Object _) => this as FCheckboxStyle;

  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  double get size;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FVariants<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta> get decoration;
  FCheckboxMotion get motion;
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
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DoubleProperty('size', size, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCheckboxStyle &&
          runtimeType == other.runtimeType &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          size == other.size &&
          iconStyle == other.iconStyle &&
          decoration == other.decoration &&
          motion == other.motion &&
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
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      size.hashCode ^
      iconStyle.hashCode ^
      decoration.hashCode ^
      motion.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FCheckboxStyle].
///
/// A [FCheckboxStyle] is itself a [FCheckboxStyleDelta].
abstract class FCheckboxStyleDelta with Delta {
  /// Creates a partial modification of a [FCheckboxStyle].
  ///
  /// ## Parameters
  /// * [FCheckboxStyle.tappableStyle] - The tappable style.
  /// * [FCheckboxStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FCheckboxStyle.size] - The checkboxes size.
  /// * [FCheckboxStyle.iconStyle] - The icon style.
  /// * [FCheckboxStyle.decoration] - The box decoration.
  /// * [FCheckboxStyle.motion] - The motion-related properties.
  /// * [FCheckboxStyle.labelPadding] - The label's padding.
  /// * [FCheckboxStyle.descriptionPadding] - The description's padding.
  /// * [FCheckboxStyle.errorPadding] - The error's padding.
  /// * [FCheckboxStyle.childPadding] - The child's padding.
  /// * [FCheckboxStyle.labelMotion] - The motion properties for error animations.
  /// * [FCheckboxStyle.labelTextStyle] - The label's text style.
  /// * [FCheckboxStyle.descriptionTextStyle] - The description's text style.
  /// * [FCheckboxStyle.errorTextStyle] - The error's text style.
  const factory FCheckboxStyleDelta.delta({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    double? size,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta>? decoration,
    FCheckboxMotionDelta? motion,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FCheckboxStyleDelta;

  /// Creates a delta that returns the [FCheckboxStyle] in the current context.
  const factory FCheckboxStyleDelta.context() = _FCheckboxStyleContext;

  @override
  FCheckboxStyle call(covariant FCheckboxStyle value);
}

class _FCheckboxStyleDelta implements FCheckboxStyleDelta {
  const _FCheckboxStyleDelta({
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.size,
    this.iconStyle,
    this.decoration,
    this.motion,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final double? size;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FVariantsDelta<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta>? decoration;

  final FCheckboxMotionDelta? motion;

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
  FCheckboxStyle call(FCheckboxStyle original) => FCheckboxStyle(
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    size: size ?? original.size,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    motion: motion?.call(original.motion) ?? original.motion,
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

class _FCheckboxStyleContext implements FCheckboxStyleDelta {
  const _FCheckboxStyleContext();

  @override
  FCheckboxStyle call(FCheckboxStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FCheckboxMotionTransformations on FCheckboxMotion {
  /// Returns a copy of this [FCheckboxMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FCheckboxMotion.fadeInDuration] - The duration of the fade in animation.
  /// * [FCheckboxMotion.fadeOutDuration] - The duration of the fade out animation.
  /// * [FCheckboxMotion.fadeInCurve] - The curve of the fade in animation.
  /// * [FCheckboxMotion.fadeOutCurve] - The curve of the fade out animation.
  @useResult
  FCheckboxMotion copyWith({
    Duration? fadeInDuration,
    Duration? fadeOutDuration,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
  }) => .new(
    fadeInDuration: fadeInDuration ?? this.fadeInDuration,
    fadeOutDuration: fadeOutDuration ?? this.fadeOutDuration,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
  );

  /// Linearly interpolate between this and another [FCheckboxMotion] using the given factor [t].
  @useResult
  FCheckboxMotion lerp(FCheckboxMotion other, double t) => .new(
    fadeInDuration: t < 0.5 ? fadeInDuration : other.fadeInDuration,
    fadeOutDuration: t < 0.5 ? fadeOutDuration : other.fadeOutDuration,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
  );
}

mixin _$FCheckboxMotionFunctions on Diagnosticable implements FCheckboxMotionDelta {
  /// Returns itself.
  @override
  FCheckboxMotion call(Object _) => this as FCheckboxMotion;

  Duration get fadeInDuration;
  Duration get fadeOutDuration;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration, level: .debug))
      ..add(DiagnosticsProperty('fadeOutDuration', fadeOutDuration, level: .debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCheckboxMotion &&
          runtimeType == other.runtimeType &&
          fadeInDuration == other.fadeInDuration &&
          fadeOutDuration == other.fadeOutDuration &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve);

  @override
  int get hashCode => fadeInDuration.hashCode ^ fadeOutDuration.hashCode ^ fadeInCurve.hashCode ^ fadeOutCurve.hashCode;
}

/// A delta that applies modifications to a [FCheckboxMotion].
///
/// A [FCheckboxMotion] is itself a [FCheckboxMotionDelta].
abstract class FCheckboxMotionDelta with Delta {
  /// Creates a partial modification of a [FCheckboxMotion].
  ///
  /// ## Parameters
  /// * [FCheckboxMotion.fadeInDuration] - The duration of the fade in animation.
  /// * [FCheckboxMotion.fadeOutDuration] - The duration of the fade out animation.
  /// * [FCheckboxMotion.fadeInCurve] - The curve of the fade in animation.
  /// * [FCheckboxMotion.fadeOutCurve] - The curve of the fade out animation.
  const factory FCheckboxMotionDelta.delta({
    Duration? fadeInDuration,
    Duration? fadeOutDuration,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
  }) = _FCheckboxMotionDelta;

  /// Creates a delta that returns the [FCheckboxMotion] in the current context.
  const factory FCheckboxMotionDelta.context() = _FCheckboxMotionContext;

  @override
  FCheckboxMotion call(covariant FCheckboxMotion value);
}

class _FCheckboxMotionDelta implements FCheckboxMotionDelta {
  const _FCheckboxMotionDelta({this.fadeInDuration, this.fadeOutDuration, this.fadeInCurve, this.fadeOutCurve});

  final Duration? fadeInDuration;

  final Duration? fadeOutDuration;

  final Curve? fadeInCurve;

  final Curve? fadeOutCurve;

  @override
  FCheckboxMotion call(FCheckboxMotion original) => FCheckboxMotion(
    fadeInDuration: fadeInDuration ?? original.fadeInDuration,
    fadeOutDuration: fadeOutDuration ?? original.fadeOutDuration,
    fadeInCurve: fadeInCurve ?? original.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? original.fadeOutCurve,
  );
}

class _FCheckboxMotionContext implements FCheckboxMotionDelta {
  const _FCheckboxMotionContext();

  @override
  FCheckboxMotion call(FCheckboxMotion original) => original;
}

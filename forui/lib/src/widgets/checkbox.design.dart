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
  /// * [FCheckboxStyle.leadingLabelStyle] - The label style when [FCheckbox.leadingLabel] is true.
  /// * [FCheckboxStyle.trailingLabelStyle] - The label style when [FCheckbox.leadingLabel] is false (the default).
  @useResult
  FCheckboxStyle copyWith({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    double? size,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta>? decoration,
    FCheckboxMotionDelta? motion,
    FLabelStyleDelta? leadingLabelStyle,
    FLabelStyleDelta? trailingLabelStyle,
  }) => .new(
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    size: size ?? this.size,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    motion: motion?.call(this.motion) ?? this.motion,
    leadingLabelStyle: leadingLabelStyle?.call(this.leadingLabelStyle) ?? this.leadingLabelStyle,
    trailingLabelStyle: trailingLabelStyle?.call(this.trailingLabelStyle) ?? this.trailingLabelStyle,
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
    leadingLabelStyle: leadingLabelStyle.lerp(other.leadingLabelStyle, t),
    trailingLabelStyle: trailingLabelStyle.lerp(other.trailingLabelStyle, t),
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
  FLabelStyle get leadingLabelStyle;
  FLabelStyle get trailingLabelStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DoubleProperty('size', size, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug))
      ..add(DiagnosticsProperty('leadingLabelStyle', leadingLabelStyle, level: .debug))
      ..add(DiagnosticsProperty('trailingLabelStyle', trailingLabelStyle, level: .debug));
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
          leadingLabelStyle == other.leadingLabelStyle &&
          trailingLabelStyle == other.trailingLabelStyle);

  @override
  int get hashCode =>
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      size.hashCode ^
      iconStyle.hashCode ^
      decoration.hashCode ^
      motion.hashCode ^
      leadingLabelStyle.hashCode ^
      trailingLabelStyle.hashCode;
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
  /// * [FCheckboxStyle.leadingLabelStyle] - The label style when [FCheckbox.leadingLabel] is true.
  /// * [FCheckboxStyle.trailingLabelStyle] - The label style when [FCheckbox.leadingLabel] is false (the default).
  const factory FCheckboxStyleDelta.delta({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    double? size,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta>? decoration,
    FCheckboxMotionDelta? motion,
    FLabelStyleDelta? leadingLabelStyle,
    FLabelStyleDelta? trailingLabelStyle,
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
    this.leadingLabelStyle,
    this.trailingLabelStyle,
  });

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final double? size;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FVariantsDelta<FCheckboxVariantConstraint, FCheckboxVariant, Decoration, DecorationDelta>? decoration;

  final FCheckboxMotionDelta? motion;

  final FLabelStyleDelta? leadingLabelStyle;

  final FLabelStyleDelta? trailingLabelStyle;

  @override
  FCheckboxStyle call(FCheckboxStyle original) => FCheckboxStyle(
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    size: size ?? original.size,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    motion: motion?.call(original.motion) ?? original.motion,
    leadingLabelStyle: leadingLabelStyle?.call(original.leadingLabelStyle) ?? original.leadingLabelStyle,
    trailingLabelStyle: trailingLabelStyle?.call(original.trailingLabelStyle) ?? original.trailingLabelStyle,
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

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'form_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FFormFieldVariant], which represents individual variants.
extension type const FFormFieldVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FFormFieldVariantConstraint] that negates [variant].
  factory FFormFieldVariantConstraint.not(FFormFieldVariant variant) => FFormFieldVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FFormFieldVariant.disabled;

  /// The semantic variant when this widget is in an error state.
  static const error = FFormFieldVariant.error;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FFormFieldVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FFormFieldVariant._(Desktop());

  /// The Android platform variant.
  static const android = FFormFieldVariant.android;

  /// The iOS platform variant.
  static const iOS = FFormFieldVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FFormFieldVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FFormFieldVariant.windows;

  /// The macOS platform variant.
  static const macOS = FFormFieldVariant.macOS;

  /// The Linux platform variant.
  static const linux = FFormFieldVariant.linux;

  /// The web platform variant.
  static const web = FFormFieldVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FFormFieldVariantConstraint and(FFormFieldVariantConstraint other) => FFormFieldVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FFormFieldVariantConstraint], which represents combinations of variants.
extension type const FFormFieldVariant._(FVariant _) implements FFormFieldVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FFormFieldVariant._(.new(2, 'disabled'));

  /// The semantic variant when this widget is in an error state.
  static const error = FFormFieldVariant._(.new(2, 'error'));

  /// The Android platform variant.
  static const android = FFormFieldVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FFormFieldVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FFormFieldVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FFormFieldVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FFormFieldVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FFormFieldVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FFormFieldVariant._(FPlatformVariant.web);
}

/// Represents a combination of variants.
///
/// See also:
/// * [FFormFieldErrorVariant], which represents individual variants.
extension type const FFormFieldErrorVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FFormFieldErrorVariantConstraint] that negates [variant].
  factory FFormFieldErrorVariantConstraint.not(FFormFieldErrorVariant variant) =>
      FFormFieldErrorVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FFormFieldErrorVariant.disabled;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FFormFieldErrorVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FFormFieldErrorVariant._(Desktop());

  /// The Android platform variant.
  static const android = FFormFieldErrorVariant.android;

  /// The iOS platform variant.
  static const iOS = FFormFieldErrorVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FFormFieldErrorVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FFormFieldErrorVariant.windows;

  /// The macOS platform variant.
  static const macOS = FFormFieldErrorVariant.macOS;

  /// The Linux platform variant.
  static const linux = FFormFieldErrorVariant.linux;

  /// The web platform variant.
  static const web = FFormFieldErrorVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FFormFieldErrorVariantConstraint and(FFormFieldErrorVariantConstraint other) =>
      FFormFieldErrorVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FFormFieldErrorVariantConstraint], which represents combinations of variants.
extension type const FFormFieldErrorVariant._(FVariant _) implements FFormFieldErrorVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FFormFieldErrorVariant._(.new(2, 'disabled'));

  /// The Android platform variant.
  static const android = FFormFieldErrorVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FFormFieldErrorVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FFormFieldErrorVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FFormFieldErrorVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FFormFieldErrorVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FFormFieldErrorVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FFormFieldErrorVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FFormFieldStyleTransformations on FFormFieldStyle {
  /// Returns a copy of this [FFormFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FFormFieldStyle.labelTextStyle] - The label's text style.
  /// * [FFormFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FFormFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FFormFieldStyle copyWith({
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FFormFieldStyle] using the given factor [t].
  @useResult
  FFormFieldStyle lerp(FFormFieldStyle other, double t) => .new(
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerpTextStyle(errorTextStyle, other.errorTextStyle, t),
  );
}

mixin _$FFormFieldStyleFunctions on Diagnosticable implements FFormFieldStyleDelta {
  /// Returns itself.
  @override
  FFormFieldStyle call(Object _) => this as FFormFieldStyle;

  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get descriptionTextStyle;
  FVariants<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta> get errorTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: .debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FFormFieldStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FFormFieldStyle].
///
/// A [FFormFieldStyle] is itself a [FFormFieldStyleDelta].
abstract class FFormFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FFormFieldStyle].
  ///
  /// ## Parameters
  /// * [FFormFieldStyle.labelTextStyle] - The label's text style.
  /// * [FFormFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FFormFieldStyle.errorTextStyle] - The error's text style.
  const factory FFormFieldStyleDelta.delta({
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FFormFieldStyleDelta;

  /// Creates a delta that returns the [FFormFieldStyle] in the current context.
  const factory FFormFieldStyleDelta.context() = _FFormFieldStyleContext;

  @override
  FFormFieldStyle call(covariant FFormFieldStyle value);
}

class _FFormFieldStyleDelta implements FFormFieldStyleDelta {
  const _FFormFieldStyleDelta({this.labelTextStyle, this.descriptionTextStyle, this.errorTextStyle});

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle;

  final FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>?
  errorTextStyle;

  @override
  FFormFieldStyle call(FFormFieldStyle original) => FFormFieldStyle(
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(original.descriptionTextStyle) ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

class _FFormFieldStyleContext implements FFormFieldStyleDelta {
  const _FFormFieldStyleContext();

  @override
  FFormFieldStyle call(FFormFieldStyle original) => original;
}

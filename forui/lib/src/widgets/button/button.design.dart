// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FButtonVariant], which represents individual variants.
extension type const FButtonVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FButtonVariantConstraint] that negates [variant].
  factory FButtonVariantConstraint.not(FButtonVariant variant) => FButtonVariantConstraint._(Not(variant));

  /// The primary button style.
  static const primary = FButtonVariant.primary;

  /// The secondary button style.
  static const secondary = FButtonVariant.secondary;

  /// The destructive button style.
  static const destructive = FButtonVariant.destructive;

  /// The outline button style.
  static const outline = FButtonVariant.outline;

  /// The ghost button style.
  static const ghost = FButtonVariant.ghost;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FButtonVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FButtonVariant._(Desktop());

  /// The Android platform variant.
  static const android = FButtonVariant.android;

  /// The iOS platform variant.
  static const iOS = FButtonVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FButtonVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FButtonVariant.windows;

  /// The macOS platform variant.
  static const macOS = FButtonVariant.macOS;

  /// The Linux platform variant.
  static const linux = FButtonVariant.linux;

  /// The web platform variant.
  static const web = FButtonVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FButtonVariantConstraint and(FButtonVariantConstraint other) => FButtonVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FButtonVariantConstraint], which represents combinations of variants.
extension type const FButtonVariant._(FVariant _) implements FButtonVariantConstraint, FVariant {
  /// The primary button style.
  static const primary = FButtonVariant._(.new(2, 'primary'));

  /// The secondary button style.
  static const secondary = FButtonVariant._(.new(2, 'secondary'));

  /// The destructive button style.
  static const destructive = FButtonVariant._(.new(2, 'destructive'));

  /// The outline button style.
  static const outline = FButtonVariant._(.new(2, 'outline'));

  /// The ghost button style.
  static const ghost = FButtonVariant._(.new(2, 'ghost'));

  /// The Android platform variant.
  static const android = FButtonVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FButtonVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FButtonVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FButtonVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FButtonVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FButtonVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FButtonVariant._(FPlatformVariant.web);
}

/// Represents a combination of variants.
///
/// See also:
/// * [FButtonSizeVariant], which represents individual variants.
extension type const FButtonSizeVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FButtonSizeVariantConstraint] that negates [variant].
  factory FButtonSizeVariantConstraint.not(FButtonSizeVariant variant) => FButtonSizeVariantConstraint._(Not(variant));

  /// The extra small button size.
  static const xs = FButtonSizeVariant.xs;

  /// The small button size.
  static const sm = FButtonSizeVariant.sm;

  /// The medium (default) button size.
  static const md = FButtonSizeVariant.md;

  /// The large button size.
  static const lg = FButtonSizeVariant.lg;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FButtonSizeVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FButtonSizeVariant._(Desktop());

  /// The Android platform variant.
  static const android = FButtonSizeVariant.android;

  /// The iOS platform variant.
  static const iOS = FButtonSizeVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FButtonSizeVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FButtonSizeVariant.windows;

  /// The macOS platform variant.
  static const macOS = FButtonSizeVariant.macOS;

  /// The Linux platform variant.
  static const linux = FButtonSizeVariant.linux;

  /// The web platform variant.
  static const web = FButtonSizeVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FButtonSizeVariantConstraint and(FButtonSizeVariantConstraint other) =>
      FButtonSizeVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FButtonSizeVariantConstraint], which represents combinations of variants.
extension type const FButtonSizeVariant._(FVariant _) implements FButtonSizeVariantConstraint, FVariant {
  /// The extra small button size.
  static const xs = FButtonSizeVariant._(.new(1, 'xs'));

  /// The small button size.
  static const sm = FButtonSizeVariant._(.new(1, 'sm'));

  /// The medium (default) button size.
  static const md = FButtonSizeVariant._(.new(1, 'md'));

  /// The large button size.
  static const lg = FButtonSizeVariant._(.new(1, 'lg'));

  /// The Android platform variant.
  static const android = FButtonSizeVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FButtonSizeVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FButtonSizeVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FButtonSizeVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FButtonSizeVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FButtonSizeVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FButtonSizeVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FButtonStyleTransformations on FButtonStyle {
  /// Returns a copy of this [FButtonStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonStyle.decoration] - The box decoration.
  /// * [FButtonStyle.contentStyle] - The content's style.
  /// * [FButtonStyle.iconContentStyle] - The icon content's style.
  /// * [FButtonStyle.tappableStyle] - The tappable's style.
  /// * [FButtonStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FButtonStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration,
    FButtonContentStyleDelta? contentStyle,
    FButtonIconContentStyleDelta? iconContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    iconContentStyle: iconContentStyle?.call(this.iconContentStyle) ?? this.iconContentStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FButtonStyle] using the given factor [t].
  @useResult
  FButtonStyle lerp(FButtonStyle other, double t) => .new(
    decoration: .lerpDecoration(decoration, other.decoration, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    iconContentStyle: iconContentStyle.lerp(other.iconContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FButtonStyleFunctions on Diagnosticable implements FButtonStyleDelta {
  /// Returns itself.
  @override
  FButtonStyle call(Object _) => this as FButtonStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get decoration;
  FButtonContentStyle get contentStyle;
  FButtonIconContentStyle get iconContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('iconContentStyle', iconContentStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          iconContentStyle == other.iconContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      contentStyle.hashCode ^
      iconContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FButtonStyle].
///
/// A [FButtonStyle] is itself a [FButtonStyleDelta].
abstract class FButtonStyleDelta with Delta {
  /// Creates a partial modification of a [FButtonStyle].
  ///
  /// ## Parameters
  /// * [FButtonStyle.decoration] - The box decoration.
  /// * [FButtonStyle.contentStyle] - The content's style.
  /// * [FButtonStyle.iconContentStyle] - The icon content's style.
  /// * [FButtonStyle.tappableStyle] - The tappable's style.
  /// * [FButtonStyle.focusedOutlineStyle] - The focused outline style.
  const factory FButtonStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration,
    FButtonContentStyleDelta? contentStyle,
    FButtonIconContentStyleDelta? iconContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FButtonStyleDelta;

  /// Creates a delta that returns the [FButtonStyle] in the current context.
  const factory FButtonStyleDelta.context() = _FButtonStyleContext;

  @override
  FButtonStyle call(covariant FButtonStyle value);
}

class _FButtonStyleDelta implements FButtonStyleDelta {
  const _FButtonStyleDelta({
    this.decoration,
    this.contentStyle,
    this.iconContentStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration;

  final FButtonContentStyleDelta? contentStyle;

  final FButtonIconContentStyleDelta? iconContentStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FButtonStyle call(FButtonStyle original) => FButtonStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    iconContentStyle: iconContentStyle?.call(original.iconContentStyle) ?? original.iconContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FButtonStyleContext implements FButtonStyleDelta {
  const _FButtonStyleContext();

  @override
  FButtonStyle call(FButtonStyle original) => original;
}

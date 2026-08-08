// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FDividerAxisVariant], which represents individual variants.
extension type const FDividerAxisVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FDividerAxisVariantConstraint] that negates [variant].
  factory FDividerAxisVariantConstraint.not(FDividerAxisVariant variant) =>
      FDividerAxisVariantConstraint._(Not(variant));

  /// The vertical divider variant.
  static const vertical = FDividerAxisVariant.vertical;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FDividerAxisVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FDividerAxisVariant._(Desktop());

  /// The Android platform variant.
  static const android = FDividerAxisVariant.android;

  /// The iOS platform variant.
  static const iOS = FDividerAxisVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FDividerAxisVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FDividerAxisVariant.windows;

  /// The macOS platform variant.
  static const macOS = FDividerAxisVariant.macOS;

  /// The Linux platform variant.
  static const linux = FDividerAxisVariant.linux;

  /// The web platform variant.
  static const web = FDividerAxisVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FDividerAxisVariantConstraint and(FDividerAxisVariantConstraint other) =>
      FDividerAxisVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FDividerAxisVariantConstraint], which represents combinations of variants.
extension type const FDividerAxisVariant._(FVariant _) implements FDividerAxisVariantConstraint, FVariant {
  /// The vertical divider variant.
  static const vertical = FDividerAxisVariant._(.new(1, 'vertical'));

  /// The Android platform variant.
  static const android = FDividerAxisVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FDividerAxisVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FDividerAxisVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FDividerAxisVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FDividerAxisVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FDividerAxisVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FDividerAxisVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FDividerStyleTransformations on FDividerStyle {
  /// Returns a copy of this [FDividerStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FDividerStyle.color] - The color of the separating line.
  /// * [FDividerStyle.padding] - The padding surrounding the separating line.
  /// * [FDividerStyle.width] - The width (thickness) of the separating line.
  @useResult
  FDividerStyle copyWith({Color? color, EdgeInsetsGeometryDelta? padding, double? width}) => .new(
    color: color ?? this.color,
    padding: padding?.call(this.padding) ?? this.padding,
    width: width ?? this.width,
  );

  /// Linearly interpolate between this and another [FDividerStyle] using the given factor [t].
  @useResult
  FDividerStyle lerp(FDividerStyle other, double t) => .new(
    color: FColors.lerpColor(color, other.color, t) ?? color,
    padding: .lerp(padding, other.padding, t) ?? padding,
    width: lerpDouble(width, other.width, t) ?? width,
  );
}

mixin _$FDividerStyleFunctions on Diagnosticable implements FDividerStyleDelta {
  /// Returns itself.
  @override
  FDividerStyle call(Object _) => this as FDividerStyle;

  Color get color;
  EdgeInsetsGeometry get padding;
  double get width;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('width', width, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDividerStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          padding == other.padding &&
          width == other.width);

  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ width.hashCode;
}

/// A delta that applies modifications to a [FDividerStyle].
///
/// A [FDividerStyle] is itself a [FDividerStyleDelta].
abstract class FDividerStyleDelta with Delta {
  /// Creates a partial modification of a [FDividerStyle].
  ///
  /// ## Parameters
  /// * [FDividerStyle.color] - The color of the separating line.
  /// * [FDividerStyle.padding] - The padding surrounding the separating line.
  /// * [FDividerStyle.width] - The width (thickness) of the separating line.
  const factory FDividerStyleDelta.delta({Color? color, EdgeInsetsGeometryDelta? padding, double? width}) =
      _FDividerStyleDelta;

  /// Creates a delta that returns the [FDividerStyle] in the current context.
  const factory FDividerStyleDelta.context() = _FDividerStyleContext;

  @override
  FDividerStyle call(covariant FDividerStyle value);
}

class _FDividerStyleDelta implements FDividerStyleDelta {
  const _FDividerStyleDelta({this.color, this.padding, this.width});

  final Color? color;

  final EdgeInsetsGeometryDelta? padding;

  final double? width;

  @override
  FDividerStyle call(FDividerStyle original) => FDividerStyle(
    color: color ?? original.color,
    padding: padding?.call(original.padding) ?? original.padding,
    width: width ?? original.width,
  );
}

class _FDividerStyleContext implements FDividerStyleDelta {
  const _FDividerStyleContext();

  @override
  FDividerStyle call(FDividerStyle original) => original;
}

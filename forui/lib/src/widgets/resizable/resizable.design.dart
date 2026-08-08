// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'resizable.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FResizableAxisVariant], which represents individual variants.
extension type const FResizableAxisVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FResizableAxisVariantConstraint] that negates [variant].
  factory FResizableAxisVariantConstraint.not(FResizableAxisVariant variant) =>
      FResizableAxisVariantConstraint._(Not(variant));

  /// The horizontal resizable variant.
  static const horizontal = FResizableAxisVariant.horizontal;

  /// The vertical resizable variant.
  static const vertical = FResizableAxisVariant.vertical;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FResizableAxisVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FResizableAxisVariant._(Desktop());

  /// The Android platform variant.
  static const android = FResizableAxisVariant.android;

  /// The iOS platform variant.
  static const iOS = FResizableAxisVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FResizableAxisVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FResizableAxisVariant.windows;

  /// The macOS platform variant.
  static const macOS = FResizableAxisVariant.macOS;

  /// The Linux platform variant.
  static const linux = FResizableAxisVariant.linux;

  /// The web platform variant.
  static const web = FResizableAxisVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FResizableAxisVariantConstraint and(FResizableAxisVariantConstraint other) =>
      FResizableAxisVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FResizableAxisVariantConstraint], which represents combinations of variants.
extension type const FResizableAxisVariant._(FVariant _) implements FResizableAxisVariantConstraint, FVariant {
  /// The horizontal resizable variant.
  static const horizontal = FResizableAxisVariant._(.new(1, 'horizontal'));

  /// The vertical resizable variant.
  static const vertical = FResizableAxisVariant._(.new(1, 'vertical'));

  /// The Android platform variant.
  static const android = FResizableAxisVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FResizableAxisVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FResizableAxisVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FResizableAxisVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FResizableAxisVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FResizableAxisVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FResizableAxisVariant._(FPlatformVariant.web);
}

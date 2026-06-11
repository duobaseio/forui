// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'alert.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FAlertVariant], which represents individual variants.
extension type const FAlertVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FAlertVariantConstraint] that negates [variant].
  factory FAlertVariantConstraint.not(FAlertVariant variant) => FAlertVariantConstraint._(Not(variant));

  /// The primary alert style.
  static const primary = FAlertVariant.primary;

  /// The destructive alert style.
  static const destructive = FAlertVariant.destructive;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FAlertVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FAlertVariant._(Desktop());

  /// The Android platform variant.
  static const android = FAlertVariant.android;

  /// The iOS platform variant.
  static const iOS = FAlertVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FAlertVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FAlertVariant.windows;

  /// The macOS platform variant.
  static const macOS = FAlertVariant.macOS;

  /// The Linux platform variant.
  static const linux = FAlertVariant.linux;

  /// The web platform variant.
  static const web = FAlertVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FAlertVariantConstraint and(FAlertVariantConstraint other) => FAlertVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FAlertVariantConstraint], which represents combinations of variants.
extension type const FAlertVariant._(FVariant _) implements FAlertVariantConstraint, FVariant {
  /// The primary alert style.
  static const primary = FAlertVariant._(.new(1, 'primary'));

  /// The destructive alert style.
  static const destructive = FAlertVariant._(.new(2, 'destructive'));

  /// The Android platform variant.
  static const android = FAlertVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FAlertVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FAlertVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FAlertVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FAlertVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FAlertVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FAlertVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FAlertStyleTransformations on FAlertStyle {
  /// Returns a copy of this [FAlertStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAlertStyle.decoration] - The decoration.
  /// * [FAlertStyle.padding] - The padding.
  /// * [FAlertStyle.iconStyle] - The icon's style.
  /// * [FAlertStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FAlertStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  @useResult
  FAlertStyle copyWith({
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
    IconThemeDataDelta? iconStyle,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    padding: padding?.call(this.padding) ?? this.padding,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(this.subtitleTextStyle) ?? this.subtitleTextStyle,
  );

  /// Linearly interpolate between this and another [FAlertStyle] using the given factor [t].
  @useResult
  FAlertStyle lerp(FAlertStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    subtitleTextStyle: .lerp(subtitleTextStyle, other.subtitleTextStyle, t) ?? subtitleTextStyle,
  );
}

mixin _$FAlertStyleFunctions on Diagnosticable implements FAlertStyleDelta {
  /// Returns itself.
  @override
  FAlertStyle call(Object _) => this as FAlertStyle;

  Decoration get decoration;
  EdgeInsetsGeometry get padding;
  IconThemeData get iconStyle;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAlertStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          iconStyle == other.iconStyle &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode;
}

/// A delta that applies modifications to a [FAlertStyle].
///
/// A [FAlertStyle] is itself a [FAlertStyleDelta].
abstract class FAlertStyleDelta with Delta {
  /// Creates a partial modification of a [FAlertStyle].
  ///
  /// ## Parameters
  /// * [FAlertStyle.decoration] - The decoration.
  /// * [FAlertStyle.padding] - The padding.
  /// * [FAlertStyle.iconStyle] - The icon's style.
  /// * [FAlertStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FAlertStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  const factory FAlertStyleDelta.delta({
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
    IconThemeDataDelta? iconStyle,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
  }) = _FAlertStyleDelta;

  /// Creates a delta that returns the [FAlertStyle] in the current context.
  const factory FAlertStyleDelta.context() = _FAlertStyleContext;

  @override
  FAlertStyle call(covariant FAlertStyle value);
}

class _FAlertStyleDelta implements FAlertStyleDelta {
  const _FAlertStyleDelta({this.decoration, this.padding, this.iconStyle, this.titleTextStyle, this.subtitleTextStyle});

  final DecorationDelta? decoration;

  final EdgeInsetsGeometryDelta? padding;

  final IconThemeDataDelta? iconStyle;

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? subtitleTextStyle;

  @override
  FAlertStyle call(FAlertStyle original) => FAlertStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    padding: padding?.call(original.padding) ?? original.padding,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(original.subtitleTextStyle) ?? original.subtitleTextStyle,
  );
}

class _FAlertStyleContext implements FAlertStyleDelta {
  const _FAlertStyleContext();

  @override
  FAlertStyle call(FAlertStyle original) => original;
}

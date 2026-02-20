// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FSelectSectionVariant], which represents individual variants.
extension type const FSelectSectionVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FSelectSectionVariantConstraint] that negates [variant].
  factory FSelectSectionVariantConstraint.not(FSelectSectionVariant variant) =>
      FSelectSectionVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FSelectSectionVariant.disabled;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FSelectSectionVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FSelectSectionVariant._(Desktop());

  /// The Android platform variant.
  static const android = FSelectSectionVariant.android;

  /// The iOS platform variant.
  static const iOS = FSelectSectionVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FSelectSectionVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FSelectSectionVariant.windows;

  /// The macOS platform variant.
  static const macOS = FSelectSectionVariant.macOS;

  /// The Linux platform variant.
  static const linux = FSelectSectionVariant.linux;

  /// The web platform variant.
  static const web = FSelectSectionVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FSelectSectionVariantConstraint and(FSelectSectionVariantConstraint other) =>
      FSelectSectionVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FSelectSectionVariantConstraint], which represents combinations of variants.
extension type const FSelectSectionVariant._(FVariant _) implements FSelectSectionVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FSelectSectionVariant._(.new(2, 'disabled'));

  /// The Android platform variant.
  static const android = FSelectSectionVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FSelectSectionVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FSelectSectionVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FSelectSectionVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FSelectSectionVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FSelectSectionVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FSelectSectionVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FSelectSectionStyleTransformations on FSelectSectionStyle {
  /// Returns a copy of this [FSelectSectionStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectSectionStyle.labelTextStyle] - The label's text style.
  /// * [FSelectSectionStyle.labelPadding] - The padding around the label.
  /// * [FSelectSectionStyle.dividerColor] - The divider's style.
  /// * [FSelectSectionStyle.dividerWidth] - The divider's width.
  /// * [FSelectSectionStyle.itemStyle] - The section's items' style.
  @useResult
  FSelectSectionStyle copyWith({
    FVariantsDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    FVariantsValueDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
  }) => .new(
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    dividerColor: dividerColor?.call(this.dividerColor) ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle?.call(this.itemStyle) ?? this.itemStyle,
  );

  /// Linearly interpolate between this and another [FSelectSectionStyle] using the given factor [t].
  @useResult
  FSelectSectionStyle lerp(FSelectSectionStyle other, double t) => .new(
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FSelectSectionStyleFunctions on Diagnosticable implements FSelectSectionStyleDelta {
  /// Returns itself.
  @override
  FSelectSectionStyle call(Object _) => this as FSelectSectionStyle;

  FVariants<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FVariants<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta> get dividerColor;
  double get dividerWidth;
  FItemStyle get itemStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: .debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: .debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: .debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSectionStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          labelPadding == other.labelPadding &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          itemStyle == other.itemStyle);

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      labelPadding.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      itemStyle.hashCode;
}

/// A delta that applies modifications to a [FSelectSectionStyle].
///
/// A [FSelectSectionStyle] is itself a [FSelectSectionStyleDelta].
abstract class FSelectSectionStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectSectionStyle].
  ///
  /// ## Parameters
  /// * [FSelectSectionStyle.labelTextStyle] - The label's text style.
  /// * [FSelectSectionStyle.labelPadding] - The padding around the label.
  /// * [FSelectSectionStyle.dividerColor] - The divider's style.
  /// * [FSelectSectionStyle.dividerWidth] - The divider's width.
  /// * [FSelectSectionStyle.itemStyle] - The section's items' style.
  const factory FSelectSectionStyleDelta.delta({
    FVariantsDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    FVariantsValueDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
  }) = _FSelectSectionStyleDelta;

  /// Creates a delta that returns the [FSelectSectionStyle] in the current context.
  const factory FSelectSectionStyleDelta.context() = _FSelectSectionStyleContext;

  @override
  FSelectSectionStyle call(covariant FSelectSectionStyle value);
}

class _FSelectSectionStyleDelta implements FSelectSectionStyleDelta {
  const _FSelectSectionStyleDelta({
    this.labelTextStyle,
    this.labelPadding,
    this.dividerColor,
    this.dividerWidth,
    this.itemStyle,
  });

  final FVariantsDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta>?
  labelTextStyle;

  final EdgeInsetsGeometryDelta? labelPadding;

  final FVariantsValueDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta>? dividerColor;

  final double? dividerWidth;

  final FItemStyleDelta? itemStyle;

  @override
  FSelectSectionStyle call(FSelectSectionStyle original) => FSelectSectionStyle(
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    dividerWidth: dividerWidth ?? original.dividerWidth,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
  );
}

class _FSelectSectionStyleContext implements FSelectSectionStyleDelta {
  const _FSelectSectionStyleContext();

  @override
  FSelectSectionStyle call(FSelectSectionStyle original) => original;
}

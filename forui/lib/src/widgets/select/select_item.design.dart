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
  factory not(FSelectSectionVariant variant) => FSelectSectionVariantConstraint._(Not(variant));

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
  /// * [FSelectSectionStyle.dividerColor] - The color of the divider between items in this section.
  /// * [FSelectSectionStyle.dividerWidth] - The width of the divider between items in this section.
  /// * [FSelectSectionStyle.itemStyle] - The section's items' style.
  /// * [FSelectSectionStyle.labelPadding] - The padding around the label.
  /// * [FSelectSectionStyle.spacing] - The spacing below the section.
  @useResult
  FSelectSectionStyle copyWith({
    FVariantsDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsValueDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    double? spacing,
  }) => .new(
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    dividerColor: dividerColor?.call(this.dividerColor) ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle?.call(this.itemStyle) ?? this.itemStyle,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    spacing: spacing ?? this.spacing,
  );

  /// Linearly interpolate between this and another [FSelectSectionStyle] using the given factor [t].
  @useResult
  FSelectSectionStyle lerp(FSelectSectionStyle other, double t) => .new(
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FSelectSectionStyleFunctions on Diagnosticable implements FSelectSectionStyleDelta {
  /// Returns itself.
  @override
  FSelectSectionStyle call(Object _) => this as FSelectSectionStyle;

  FVariants<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta> get dividerColor;
  double get dividerWidth;
  FItemStyle get itemStyle;
  EdgeInsetsGeometry get labelPadding;
  double get spacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: .debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: .debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: .debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSectionStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          itemStyle == other.itemStyle &&
          labelPadding == other.labelPadding &&
          spacing == other.spacing);

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      itemStyle.hashCode ^
      labelPadding.hashCode ^
      spacing.hashCode;
}

/// A delta that applies modifications to a [FSelectSectionStyle].
///
/// A [FSelectSectionStyle] is itself a [FSelectSectionStyleDelta].
abstract class FSelectSectionStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectSectionStyle].
  ///
  /// ## Parameters
  /// * [FSelectSectionStyle.labelTextStyle] - The label's text style.
  /// * [FSelectSectionStyle.dividerColor] - The color of the divider between items in this section.
  /// * [FSelectSectionStyle.dividerWidth] - The width of the divider between items in this section.
  /// * [FSelectSectionStyle.itemStyle] - The section's items' style.
  /// * [FSelectSectionStyle.labelPadding] - The padding around the label.
  /// * [FSelectSectionStyle.spacing] - The spacing below the section.
  const factory delta({
    FVariantsDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsValueDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    double? spacing,
  }) = _FSelectSectionStyleDelta;

  /// Creates a delta that returns the [FSelectSectionStyle] in the current context.
  const factory context() = _FSelectSectionStyleContext;

  @override
  FSelectSectionStyle call(covariant FSelectSectionStyle value);
}

class _FSelectSectionStyleDelta implements FSelectSectionStyleDelta {
  const new({
    this.labelTextStyle,
    this.dividerColor,
    this.dividerWidth,
    this.itemStyle,
    this.labelPadding,
    this.spacing,
  });

  final FVariantsDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, TextStyle, TextStyleDelta>?
  labelTextStyle;

  final FVariantsValueDelta<FSelectSectionVariantConstraint, FSelectSectionVariant, Color, Delta>? dividerColor;

  final double? dividerWidth;

  final FItemStyleDelta? itemStyle;

  final EdgeInsetsGeometryDelta? labelPadding;

  final double? spacing;

  @override
  FSelectSectionStyle call(FSelectSectionStyle original) => FSelectSectionStyle(
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    dividerWidth: dividerWidth ?? original.dividerWidth,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    spacing: spacing ?? original.spacing,
  );
}

class _FSelectSectionStyleContext implements FSelectSectionStyleDelta {
  const new();

  @override
  FSelectSectionStyle call(FSelectSectionStyle original) => original;
}

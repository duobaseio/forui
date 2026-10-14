// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FAutocompleteSectionVariant], which represents individual variants.
extension type const FAutocompleteSectionVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FAutocompleteSectionVariantConstraint] that negates [variant].
  factory not(FAutocompleteSectionVariant variant) => FAutocompleteSectionVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FAutocompleteSectionVariant.disabled;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FAutocompleteSectionVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FAutocompleteSectionVariant._(Desktop());

  /// The Android platform variant.
  static const android = FAutocompleteSectionVariant.android;

  /// The iOS platform variant.
  static const iOS = FAutocompleteSectionVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FAutocompleteSectionVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FAutocompleteSectionVariant.windows;

  /// The macOS platform variant.
  static const macOS = FAutocompleteSectionVariant.macOS;

  /// The Linux platform variant.
  static const linux = FAutocompleteSectionVariant.linux;

  /// The web platform variant.
  static const web = FAutocompleteSectionVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FAutocompleteSectionVariantConstraint and(FAutocompleteSectionVariantConstraint other) =>
      FAutocompleteSectionVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FAutocompleteSectionVariantConstraint], which represents combinations of variants.
extension type const FAutocompleteSectionVariant._(FVariant _)
    implements FAutocompleteSectionVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FAutocompleteSectionVariant._(.new(2, 'disabled'));

  /// The Android platform variant.
  static const android = FAutocompleteSectionVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FAutocompleteSectionVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FAutocompleteSectionVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FAutocompleteSectionVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FAutocompleteSectionVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FAutocompleteSectionVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FAutocompleteSectionVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteSectionStyleTransformations on FAutocompleteSectionStyle {
  /// Returns a copy of this [FAutocompleteSectionStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteSectionStyle.labelTextStyle] - The enabled label's text style.
  /// * [FAutocompleteSectionStyle.dividerColor] - The color of the divider between items in this section.
  /// * [FAutocompleteSectionStyle.dividerWidth] - The width of the divider between items in this section.
  /// * [FAutocompleteSectionStyle.itemStyle] - The section's items' style.
  /// * [FAutocompleteSectionStyle.labelPadding] - The padding around the label.
  /// * [FAutocompleteSectionStyle.spacing] - The spacing below the section.
  @useResult
  FAutocompleteSectionStyle copyWith({
    FVariantsDelta<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>?
    labelTextStyle,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
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

  /// Linearly interpolate between this and another [FAutocompleteSectionStyle] using the given factor [t].
  @useResult
  FAutocompleteSectionStyle lerp(FAutocompleteSectionStyle other, double t) => .new(
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FAutocompleteSectionStyleFunctions on Diagnosticable implements FAutocompleteSectionStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteSectionStyle call(Object _) => this as FAutocompleteSectionStyle;

  FVariants<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>
  get labelTextStyle;
  FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta> get dividerColor;
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
      (other is FAutocompleteSectionStyle &&
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

/// A delta that applies modifications to a [FAutocompleteSectionStyle].
///
/// A [FAutocompleteSectionStyle] is itself a [FAutocompleteSectionStyleDelta].
abstract class FAutocompleteSectionStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteSectionStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteSectionStyle.labelTextStyle] - The enabled label's text style.
  /// * [FAutocompleteSectionStyle.dividerColor] - The color of the divider between items in this section.
  /// * [FAutocompleteSectionStyle.dividerWidth] - The width of the divider between items in this section.
  /// * [FAutocompleteSectionStyle.itemStyle] - The section's items' style.
  /// * [FAutocompleteSectionStyle.labelPadding] - The padding around the label.
  /// * [FAutocompleteSectionStyle.spacing] - The spacing below the section.
  const factory delta({
    FVariantsDelta<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>?
    labelTextStyle,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    double? spacing,
  }) = _FAutocompleteSectionStyleDelta;

  /// Creates a delta that returns the [FAutocompleteSectionStyle] in the current context.
  const factory context() = _FAutocompleteSectionStyleContext;

  @override
  FAutocompleteSectionStyle call(covariant FAutocompleteSectionStyle value);
}

class _FAutocompleteSectionStyleDelta implements FAutocompleteSectionStyleDelta {
  const new({
    this.labelTextStyle,
    this.dividerColor,
    this.dividerWidth,
    this.itemStyle,
    this.labelPadding,
    this.spacing,
  });

  final FVariantsDelta<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>?
  labelTextStyle;

  final FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor;

  final double? dividerWidth;

  final FItemStyleDelta? itemStyle;

  final EdgeInsetsGeometryDelta? labelPadding;

  final double? spacing;

  @override
  FAutocompleteSectionStyle call(FAutocompleteSectionStyle original) => FAutocompleteSectionStyle(
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    dividerWidth: dividerWidth ?? original.dividerWidth,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    spacing: spacing ?? original.spacing,
  );
}

class _FAutocompleteSectionStyleContext implements FAutocompleteSectionStyleDelta {
  const new();

  @override
  FAutocompleteSectionStyle call(FAutocompleteSectionStyle original) => original;
}

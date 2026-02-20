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
  factory FAutocompleteSectionVariantConstraint.not(FAutocompleteSectionVariant variant) =>
      FAutocompleteSectionVariantConstraint._(Not(variant));

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
  /// * [FAutocompleteSectionStyle.labelPadding] - The padding around the label.
  /// * [FAutocompleteSectionStyle.dividerColor] - The divider's style.
  /// * [FAutocompleteSectionStyle.dividerWidth] - The divider's width.
  /// * [FAutocompleteSectionStyle.itemStyle] - The section's items' style.
  @useResult
  FAutocompleteSectionStyle copyWith({
    FVariantsDelta<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>?
    labelTextStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
  }) => .new(
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    dividerColor: dividerColor?.call(this.dividerColor) ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle?.call(this.itemStyle) ?? this.itemStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteSectionStyle] using the given factor [t].
  @useResult
  FAutocompleteSectionStyle lerp(FAutocompleteSectionStyle other, double t) => .new(
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FAutocompleteSectionStyleFunctions on Diagnosticable implements FAutocompleteSectionStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteSectionStyle call(Object _) => this as FAutocompleteSectionStyle;

  FVariants<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>
  get labelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta> get dividerColor;
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
      (other is FAutocompleteSectionStyle &&
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

/// A delta that applies modifications to a [FAutocompleteSectionStyle].
///
/// A [FAutocompleteSectionStyle] is itself a [FAutocompleteSectionStyleDelta].
abstract class FAutocompleteSectionStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteSectionStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteSectionStyle.labelTextStyle] - The enabled label's text style.
  /// * [FAutocompleteSectionStyle.labelPadding] - The padding around the label.
  /// * [FAutocompleteSectionStyle.dividerColor] - The divider's style.
  /// * [FAutocompleteSectionStyle.dividerWidth] - The divider's width.
  /// * [FAutocompleteSectionStyle.itemStyle] - The section's items' style.
  const factory FAutocompleteSectionStyleDelta.delta({
    FVariantsDelta<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>?
    labelTextStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FItemStyleDelta? itemStyle,
  }) = _FAutocompleteSectionStyleDelta;

  /// Creates a delta that returns the [FAutocompleteSectionStyle] in the current context.
  const factory FAutocompleteSectionStyleDelta.context() = _FAutocompleteSectionStyleContext;

  @override
  FAutocompleteSectionStyle call(covariant FAutocompleteSectionStyle value);
}

class _FAutocompleteSectionStyleDelta implements FAutocompleteSectionStyleDelta {
  const _FAutocompleteSectionStyleDelta({
    this.labelTextStyle,
    this.labelPadding,
    this.dividerColor,
    this.dividerWidth,
    this.itemStyle,
  });

  final FVariantsDelta<FAutocompleteSectionVariantConstraint, FAutocompleteSectionVariant, TextStyle, TextStyleDelta>?
  labelTextStyle;

  final EdgeInsetsGeometryDelta? labelPadding;

  final FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor;

  final double? dividerWidth;

  final FItemStyleDelta? itemStyle;

  @override
  FAutocompleteSectionStyle call(FAutocompleteSectionStyle original) => FAutocompleteSectionStyle(
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    dividerWidth: dividerWidth ?? original.dividerWidth,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
  );
}

class _FAutocompleteSectionStyleContext implements FAutocompleteSectionStyleDelta {
  const _FAutocompleteSectionStyleContext();

  @override
  FAutocompleteSectionStyle call(FAutocompleteSectionStyle original) => original;
}

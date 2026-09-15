// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FItemVariant], which represents individual variants.
extension type const FItemVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FItemVariantConstraint] that negates [variant].
  factory not(FItemVariant variant) => FItemVariantConstraint._(Not(variant));

  /// The primary item style.
  static const primary = FItemVariant.primary;

  /// The destructive item style.
  static const destructive = FItemVariant.destructive;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FItemVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FItemVariant._(Desktop());

  /// The Android platform variant.
  static const android = FItemVariant.android;

  /// The iOS platform variant.
  static const iOS = FItemVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FItemVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FItemVariant.windows;

  /// The macOS platform variant.
  static const macOS = FItemVariant.macOS;

  /// The Linux platform variant.
  static const linux = FItemVariant.linux;

  /// The web platform variant.
  static const web = FItemVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FItemVariantConstraint and(FItemVariantConstraint other) => FItemVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FItemVariantConstraint], which represents combinations of variants.
extension type const FItemVariant._(FVariant _) implements FItemVariantConstraint, FVariant {
  /// The primary item style.
  static const primary = FItemVariant._(.new(1, 'primary'));

  /// The destructive item style.
  static const destructive = FItemVariant._(.new(2, 'destructive'));

  /// The Android platform variant.
  static const android = FItemVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FItemVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FItemVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FItemVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FItemVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FItemVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FItemVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FItemStyleTransformations on FItemStyle {
  /// Returns a copy of this [FItemStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemStyle.backgroundColor] - The item's background color, enclosing the [padding] and content, and below [contentDecoration].
  /// * [FItemStyle.contentDecoration] - The content's decoration, enclosed within [padding] and [shape], and above [backgroundColor].
  /// * [FItemStyle.contentStyle] - The content's style.
  /// * [FItemStyle.rawContentStyle] - The raw content's style.
  /// * [FItemStyle.tappableStyle] - The tappable style.
  /// * [FItemStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FItemStyle.padding] - The padding around the [contentDecoration].
  /// * [FItemStyle.shape] - The item's shape, only applied when outside an [FItemGroup] or other similar groups.
  @useResult
  FItemStyle copyWith({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle = Sentinels.focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    ShapeBorder? shape = Sentinels.shapeBorder,
  }) => .new(
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    contentDecoration: contentDecoration?.call(this.contentDecoration) ?? this.contentDecoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    rawContentStyle: rawContentStyle?.call(this.rawContentStyle) ?? this.rawContentStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == Sentinels.focusedOutlineStyle
        ? this.focusedOutlineStyle
        : focusedOutlineStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    shape: shape == Sentinels.shapeBorder ? this.shape : shape,
  );

  /// Linearly interpolate between this and another [FItemStyle] using the given factor [t].
  @useResult
  FItemStyle lerp(FItemStyle other, double t) => .new(
    backgroundColor: .lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    contentDecoration: .lerpDecoration(contentDecoration, other.contentDecoration, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawContentStyle: rawContentStyle.lerp(other.rawContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    shape: t < 0.5 ? shape : other.shape,
  );
}

mixin _$FItemStyleFunctions on Diagnosticable implements FItemStyleDelta {
  /// Returns itself.
  @override
  FItemStyle call(Object _) => this as FItemStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Color?, Delta> get backgroundColor;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get contentDecoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;
  EdgeInsetsGeometry get padding;
  ShapeBorder? get shape;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('contentDecoration', contentDecoration, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('rawContentStyle', rawContentStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('shape', shape, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          contentDecoration == other.contentDecoration &&
          contentStyle == other.contentStyle &&
          rawContentStyle == other.rawContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          padding == other.padding &&
          shape == other.shape);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      contentDecoration.hashCode ^
      contentStyle.hashCode ^
      rawContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      padding.hashCode ^
      shape.hashCode;
}

/// A delta that applies modifications to a [FItemStyle].
///
/// A [FItemStyle] is itself a [FItemStyleDelta].
abstract class FItemStyleDelta with Delta {
  /// Creates a partial modification of a [FItemStyle].
  ///
  /// ## Parameters
  /// * [FItemStyle.backgroundColor] - The item's background color, enclosing the [padding] and content, and below [contentDecoration].
  /// * [FItemStyle.contentDecoration] - The content's decoration, enclosed within [padding] and [shape], and above [backgroundColor].
  /// * [FItemStyle.contentStyle] - The content's style.
  /// * [FItemStyle.rawContentStyle] - The raw content's style.
  /// * [FItemStyle.tappableStyle] - The tappable style.
  /// * [FItemStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FItemStyle.padding] - The padding around the [contentDecoration].
  /// * [FItemStyle.shape] - The item's shape, only applied when outside an [FItemGroup] or other similar groups.
  const factory delta({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    ShapeBorder? shape,
  }) = _FItemStyleDelta;

  /// Creates a delta that returns the [FItemStyle] in the current context.
  const factory context() = _FItemStyleContext;

  @override
  FItemStyle call(covariant FItemStyle value);
}

class _FItemStyleDelta implements FItemStyleDelta {
  const new({
    this.backgroundColor,
    this.contentDecoration,
    this.contentStyle,
    this.rawContentStyle,
    this.tappableStyle,
    this.focusedOutlineStyle = Sentinels.focusedOutlineStyle,
    this.padding,
    this.shape = Sentinels.shapeBorder,
  });

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration;

  final FItemContentStyleDelta? contentStyle;

  final FRawItemContentStyleDelta? rawContentStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyle? focusedOutlineStyle;

  final EdgeInsetsGeometryDelta? padding;

  final ShapeBorder? shape;

  @override
  FItemStyle call(FItemStyle original) => FItemStyle(
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    contentDecoration: contentDecoration?.call(original.contentDecoration) ?? original.contentDecoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    rawContentStyle: rawContentStyle?.call(original.rawContentStyle) ?? original.rawContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == Sentinels.focusedOutlineStyle
        ? original.focusedOutlineStyle
        : focusedOutlineStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    shape: shape == Sentinels.shapeBorder ? original.shape : shape,
  );
}

class _FItemStyleContext implements FItemStyleDelta {
  const new();

  @override
  FItemStyle call(FItemStyle original) => original;
}

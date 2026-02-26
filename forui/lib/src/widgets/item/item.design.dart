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
  factory FItemVariantConstraint.not(FItemVariant variant) => FItemVariantConstraint._(Not(variant));

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
  /// * [FItemStyle.backgroundColor] - The item's background color.
  /// * [FItemStyle.margin] - The margin around the item, including the [decoration].
  /// * [FItemStyle.decoration] - The item's decoration.
  /// * [FItemStyle.contentStyle] - The default item content's style.
  /// * [FItemStyle.rawItemContentStyle] - THe default raw item content's style.
  /// * [FItemStyle.tappableStyle] - The tappable style.
  /// * [FItemStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FItemStyle copyWith({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    EdgeInsetsGeometryDelta? margin,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawItemContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle = focusedOutlineStyleSentinel,
  }) => .new(
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    margin: margin?.call(this.margin) ?? this.margin,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    rawItemContentStyle: rawItemContentStyle?.call(this.rawItemContentStyle) ?? this.rawItemContentStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == focusedOutlineStyleSentinel
        ? this.focusedOutlineStyle
        : focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FItemStyle] using the given factor [t].
  @useResult
  FItemStyle lerp(FItemStyle other, double t) => .new(
    backgroundColor: .lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    margin: .lerp(margin, other.margin, t) ?? margin,
    decoration: .lerpDecoration(decoration, other.decoration, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawItemContentStyle: rawItemContentStyle.lerp(other.rawItemContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
  );
}

mixin _$FItemStyleFunctions on Diagnosticable implements FItemStyleDelta {
  /// Returns itself.
  @override
  FItemStyle call(Object _) => this as FItemStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Color?, Delta> get backgroundColor;
  EdgeInsetsGeometry get margin;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get decoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawItemContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('margin', margin, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('rawItemContentStyle', rawItemContentStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          margin == other.margin &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          rawItemContentStyle == other.rawItemContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      margin.hashCode ^
      decoration.hashCode ^
      contentStyle.hashCode ^
      rawItemContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FItemStyle].
///
/// A [FItemStyle] is itself a [FItemStyleDelta].
abstract class FItemStyleDelta with Delta {
  /// Creates a partial modification of a [FItemStyle].
  ///
  /// ## Parameters
  /// * [FItemStyle.backgroundColor] - The item's background color.
  /// * [FItemStyle.margin] - The margin around the item, including the [decoration].
  /// * [FItemStyle.decoration] - The item's decoration.
  /// * [FItemStyle.contentStyle] - The default item content's style.
  /// * [FItemStyle.rawItemContentStyle] - THe default raw item content's style.
  /// * [FItemStyle.tappableStyle] - The tappable style.
  /// * [FItemStyle.focusedOutlineStyle] - The focused outline style.
  const factory FItemStyleDelta.delta({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    EdgeInsetsGeometryDelta? margin,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawItemContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) = _FItemStyleDelta;

  /// Creates a delta that returns the [FItemStyle] in the current context.
  const factory FItemStyleDelta.context() = _FItemStyleContext;

  @override
  FItemStyle call(covariant FItemStyle value);
}

class _FItemStyleDelta implements FItemStyleDelta {
  const _FItemStyleDelta({
    this.backgroundColor,
    this.margin,
    this.decoration,
    this.contentStyle,
    this.rawItemContentStyle,
    this.tappableStyle,
    this.focusedOutlineStyle = focusedOutlineStyleSentinel,
  });

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor;

  final EdgeInsetsGeometryDelta? margin;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration;

  final FItemContentStyleDelta? contentStyle;

  final FRawItemContentStyleDelta? rawItemContentStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyle? focusedOutlineStyle;

  @override
  FItemStyle call(FItemStyle original) => FItemStyle(
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    margin: margin?.call(original.margin) ?? original.margin,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    rawItemContentStyle: rawItemContentStyle?.call(original.rawItemContentStyle) ?? original.rawItemContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == focusedOutlineStyleSentinel
        ? original.focusedOutlineStyle
        : focusedOutlineStyle,
  );
}

class _FItemStyleContext implements FItemStyleDelta {
  const _FItemStyleContext();

  @override
  FItemStyle call(FItemStyle original) => original;
}

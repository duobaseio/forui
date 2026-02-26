// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tag.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FMultiSelectTagVariant], which represents individual variants.
extension type const FMultiSelectTagVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FMultiSelectTagVariantConstraint] that negates [variant].
  factory FMultiSelectTagVariantConstraint.not(FMultiSelectTagVariant variant) =>
      FMultiSelectTagVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FMultiSelectTagVariant.disabled;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FMultiSelectTagVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FMultiSelectTagVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FMultiSelectTagVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FMultiSelectTagVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FMultiSelectTagVariant._(Desktop());

  /// The Android platform variant.
  static const android = FMultiSelectTagVariant.android;

  /// The iOS platform variant.
  static const iOS = FMultiSelectTagVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FMultiSelectTagVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FMultiSelectTagVariant.windows;

  /// The macOS platform variant.
  static const macOS = FMultiSelectTagVariant.macOS;

  /// The Linux platform variant.
  static const linux = FMultiSelectTagVariant.linux;

  /// The web platform variant.
  static const web = FMultiSelectTagVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FMultiSelectTagVariantConstraint and(FMultiSelectTagVariantConstraint other) =>
      FMultiSelectTagVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FMultiSelectTagVariantConstraint], which represents combinations of variants.
extension type const FMultiSelectTagVariant._(FVariant _) implements FMultiSelectTagVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FMultiSelectTagVariant._(.new(2, 'disabled'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FMultiSelectTagVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FMultiSelectTagVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FMultiSelectTagVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FMultiSelectTagVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FMultiSelectTagVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FMultiSelectTagVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FMultiSelectTagVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FMultiSelectTagVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FMultiSelectTagVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FMultiSelectTagVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectTagStyleTransformations on FMultiSelectTagStyle {
  /// Returns a copy of this [FMultiSelectTagStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectTagStyle.decoration] - The decoration.
  /// * [FMultiSelectTagStyle.padding] - The padding.
  /// * [FMultiSelectTagStyle.spacing] - The spacing between the label and the icon.
  /// * [FMultiSelectTagStyle.labelTextStyle] - The label's text style.
  /// * [FMultiSelectTagStyle.iconStyle] - The icon's style.
  /// * [FMultiSelectTagStyle.tappableStyle] - The tappable style.
  /// * [FMultiSelectTagStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FMultiSelectTagStyle copyWith({
    FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, Decoration, DecorationDelta>? decoration,
    EdgeInsetsDelta? padding,
    double? spacing,
    FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, IconThemeData, IconThemeDataDelta>?
    iconStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    padding: padding?.call(this.padding) ?? this.padding,
    spacing: spacing ?? this.spacing,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectTagStyle] using the given factor [t].
  @useResult
  FMultiSelectTagStyle lerp(FMultiSelectTagStyle other, double t) => .new(
    decoration: .lerpDecoration(decoration, other.decoration, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FMultiSelectTagStyleFunctions on Diagnosticable implements FMultiSelectTagStyleDelta {
  /// Returns itself.
  @override
  FMultiSelectTagStyle call(Object _) => this as FMultiSelectTagStyle;

  FVariants<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, Decoration, DecorationDelta> get decoration;
  EdgeInsets get padding;
  double get spacing;
  FVariants<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectTagStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          spacing == other.spacing &&
          labelTextStyle == other.labelTextStyle &&
          iconStyle == other.iconStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      labelTextStyle.hashCode ^
      iconStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FMultiSelectTagStyle].
///
/// A [FMultiSelectTagStyle] is itself a [FMultiSelectTagStyleDelta].
abstract class FMultiSelectTagStyleDelta with Delta {
  /// Creates a partial modification of a [FMultiSelectTagStyle].
  ///
  /// ## Parameters
  /// * [FMultiSelectTagStyle.decoration] - The decoration.
  /// * [FMultiSelectTagStyle.padding] - The padding.
  /// * [FMultiSelectTagStyle.spacing] - The spacing between the label and the icon.
  /// * [FMultiSelectTagStyle.labelTextStyle] - The label's text style.
  /// * [FMultiSelectTagStyle.iconStyle] - The icon's style.
  /// * [FMultiSelectTagStyle.tappableStyle] - The tappable style.
  /// * [FMultiSelectTagStyle.focusedOutlineStyle] - The focused outline style.
  const factory FMultiSelectTagStyleDelta.delta({
    FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, Decoration, DecorationDelta>? decoration,
    EdgeInsetsDelta? padding,
    double? spacing,
    FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, IconThemeData, IconThemeDataDelta>?
    iconStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FMultiSelectTagStyleDelta;

  /// Creates a delta that returns the [FMultiSelectTagStyle] in the current context.
  const factory FMultiSelectTagStyleDelta.context() = _FMultiSelectTagStyleContext;

  @override
  FMultiSelectTagStyle call(covariant FMultiSelectTagStyle value);
}

class _FMultiSelectTagStyleDelta implements FMultiSelectTagStyleDelta {
  const _FMultiSelectTagStyleDelta({
    this.decoration,
    this.padding,
    this.spacing,
    this.labelTextStyle,
    this.iconStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, Decoration, DecorationDelta>?
  decoration;

  final EdgeInsetsDelta? padding;

  final double? spacing;

  final FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, TextStyle, TextStyleDelta>?
  labelTextStyle;

  final FVariantsDelta<FMultiSelectTagVariantConstraint, FMultiSelectTagVariant, IconThemeData, IconThemeDataDelta>?
  iconStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FMultiSelectTagStyle call(FMultiSelectTagStyle original) => FMultiSelectTagStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    padding: padding?.call(original.padding) ?? original.padding,
    spacing: spacing ?? original.spacing,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FMultiSelectTagStyleContext implements FMultiSelectTagStyleDelta {
  const _FMultiSelectTagStyleContext();

  @override
  FMultiSelectTagStyle call(FMultiSelectTagStyle original) => original;
}

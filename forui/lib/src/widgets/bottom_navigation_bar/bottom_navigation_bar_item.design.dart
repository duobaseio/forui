// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBottomNavigationBarItemStyleTransformations on FBottomNavigationBarItemStyle {
  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FBottomNavigationBarItemStyle.iconStyle] - The icon's style.
  /// * [FBottomNavigationBarItemStyle.textStyle] - The text style.
  /// * [FBottomNavigationBarItemStyle.tappableStyle] - The item's tappable's style.
  /// * [FBottomNavigationBarItemStyle.focusedOutlineStyle] - The item's focused outline style.
  /// * [FBottomNavigationBarItemStyle.padding] - The padding.
  /// * [FBottomNavigationBarItemStyle.spacing] - The spacing between the icon and the label.
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    double? spacing,
  }) => .new(
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    spacing: spacing ?? this.spacing,
  );

  /// Linearly interpolate between this and another [FBottomNavigationBarItemStyle] using the given factor [t].
  @useResult
  FBottomNavigationBarItemStyle lerp(FBottomNavigationBarItemStyle other, double t) => .new(
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FBottomNavigationBarItemStyleFunctions on Diagnosticable implements FBottomNavigationBarItemStyleDelta {
  /// Returns itself.
  @override
  FBottomNavigationBarItemStyle call(Object _) => this as FBottomNavigationBarItemStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarItemStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          textStyle == other.textStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          padding == other.padding &&
          spacing == other.spacing);

  @override
  int get hashCode =>
      iconStyle.hashCode ^
      textStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      padding.hashCode ^
      spacing.hashCode;
}

/// A delta that applies modifications to a [FBottomNavigationBarItemStyle].
///
/// A [FBottomNavigationBarItemStyle] is itself a [FBottomNavigationBarItemStyleDelta].
abstract class FBottomNavigationBarItemStyleDelta with Delta {
  /// Creates a partial modification of a [FBottomNavigationBarItemStyle].
  ///
  /// ## Parameters
  /// * [FBottomNavigationBarItemStyle.iconStyle] - The icon's style.
  /// * [FBottomNavigationBarItemStyle.textStyle] - The text style.
  /// * [FBottomNavigationBarItemStyle.tappableStyle] - The item's tappable's style.
  /// * [FBottomNavigationBarItemStyle.focusedOutlineStyle] - The item's focused outline style.
  /// * [FBottomNavigationBarItemStyle.padding] - The padding.
  /// * [FBottomNavigationBarItemStyle.spacing] - The spacing between the icon and the label.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    double? spacing,
  }) = _FBottomNavigationBarItemStyleDelta;

  /// Creates a delta that returns the [FBottomNavigationBarItemStyle] in the current context.
  const factory context() = _FBottomNavigationBarItemStyleContext;

  @override
  FBottomNavigationBarItemStyle call(covariant FBottomNavigationBarItemStyle value);
}

class _FBottomNavigationBarItemStyleDelta implements FBottomNavigationBarItemStyleDelta {
  const new({this.iconStyle, this.textStyle, this.tappableStyle, this.focusedOutlineStyle, this.padding, this.spacing});

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final EdgeInsetsGeometryDelta? padding;

  final double? spacing;

  @override
  FBottomNavigationBarItemStyle call(FBottomNavigationBarItemStyle original) => FBottomNavigationBarItemStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    spacing: spacing ?? original.spacing,
  );
}

class _FBottomNavigationBarItemStyleContext implements FBottomNavigationBarItemStyleDelta {
  const new();

  @override
  FBottomNavigationBarItemStyle call(FBottomNavigationBarItemStyle original) => original;
}

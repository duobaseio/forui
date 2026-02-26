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
  /// * [FBottomNavigationBarItemStyle.padding] - The padding.
  /// * [FBottomNavigationBarItemStyle.spacing] - The spacing between the icon and the label.
  /// * [FBottomNavigationBarItemStyle.tappableStyle] - The item's tappable's style.
  /// * [FBottomNavigationBarItemStyle.focusedOutlineStyle] - The item's focused outline style.
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    EdgeInsetsGeometryDelta? padding,
    double? spacing,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    spacing: spacing ?? this.spacing,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FBottomNavigationBarItemStyle] using the given factor [t].
  @useResult
  FBottomNavigationBarItemStyle lerp(FBottomNavigationBarItemStyle other, double t) => .new(
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FBottomNavigationBarItemStyleFunctions on Diagnosticable implements FBottomNavigationBarItemStyleDelta {
  /// Returns itself.
  @override
  FBottomNavigationBarItemStyle call(Object _) => this as FBottomNavigationBarItemStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarItemStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          textStyle == other.textStyle &&
          padding == other.padding &&
          spacing == other.spacing &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      iconStyle.hashCode ^
      textStyle.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
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
  /// * [FBottomNavigationBarItemStyle.padding] - The padding.
  /// * [FBottomNavigationBarItemStyle.spacing] - The spacing between the icon and the label.
  /// * [FBottomNavigationBarItemStyle.tappableStyle] - The item's tappable's style.
  /// * [FBottomNavigationBarItemStyle.focusedOutlineStyle] - The item's focused outline style.
  const factory FBottomNavigationBarItemStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    EdgeInsetsGeometryDelta? padding,
    double? spacing,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FBottomNavigationBarItemStyleDelta;

  /// Creates a delta that returns the [FBottomNavigationBarItemStyle] in the current context.
  const factory FBottomNavigationBarItemStyleDelta.context() = _FBottomNavigationBarItemStyleContext;

  @override
  FBottomNavigationBarItemStyle call(covariant FBottomNavigationBarItemStyle value);
}

class _FBottomNavigationBarItemStyleDelta implements FBottomNavigationBarItemStyleDelta {
  const _FBottomNavigationBarItemStyleDelta({
    this.iconStyle,
    this.textStyle,
    this.padding,
    this.spacing,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final EdgeInsetsGeometryDelta? padding;

  final double? spacing;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FBottomNavigationBarItemStyle call(FBottomNavigationBarItemStyle original) => FBottomNavigationBarItemStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    spacing: spacing ?? original.spacing,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FBottomNavigationBarItemStyleContext implements FBottomNavigationBarItemStyleDelta {
  const _FBottomNavigationBarItemStyleContext();

  @override
  FBottomNavigationBarItemStyle call(FBottomNavigationBarItemStyle original) => original;
}

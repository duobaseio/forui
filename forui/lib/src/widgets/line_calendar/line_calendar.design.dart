// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'line_calendar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FLineCalendarItemVariant], which represents individual variants.
extension type const FLineCalendarItemVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FLineCalendarItemVariantConstraint] that negates [variant].
  factory FLineCalendarItemVariantConstraint.not(FLineCalendarItemVariant variant) =>
      FLineCalendarItemVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled.
  static const disabled = FLineCalendarItemVariant.disabled;

  /// The semantic variant when this item has been selected.
  static const selected = FLineCalendarItemVariant.selected;

  /// The semantic variant when the item represents today.
  static const today = FLineCalendarItemVariant.today;

  /// The interaction variant when this widget has focus.
  static const primaryFocused = FLineCalendarItemVariant.primaryFocused;

  /// The interaction variant when the widget or descendants have focus.
  static const focused = FLineCalendarItemVariant.focused;

  /// The interaction variant when hovered.
  static const hovered = FLineCalendarItemVariant.hovered;

  /// The interaction variant when pressed.
  static const pressed = FLineCalendarItemVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FLineCalendarItemVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FLineCalendarItemVariant._(Desktop());

  /// The Android platform variant.
  static const android = FLineCalendarItemVariant.android;

  /// The iOS platform variant.
  static const iOS = FLineCalendarItemVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FLineCalendarItemVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FLineCalendarItemVariant.windows;

  /// The macOS platform variant.
  static const macOS = FLineCalendarItemVariant.macOS;

  /// The Linux platform variant.
  static const linux = FLineCalendarItemVariant.linux;

  /// The web platform variant.
  static const web = FLineCalendarItemVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FLineCalendarItemVariantConstraint and(FLineCalendarItemVariantConstraint other) =>
      FLineCalendarItemVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FLineCalendarItemVariantConstraint], which represents combinations of variants.
extension type const FLineCalendarItemVariant._(FVariant _) implements FLineCalendarItemVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled.
  static const disabled = FLineCalendarItemVariant._(.new(2, 'disabled'));

  /// The semantic variant when this item has been selected.
  static const selected = FLineCalendarItemVariant._(.new(2, 'selected'));

  /// The semantic variant when the item represents today.
  static const today = FLineCalendarItemVariant._(.new(2, 'today'));

  /// The interaction variant when this widget has focus.
  static const primaryFocused = FLineCalendarItemVariant._(.new(1, 'primaryFocused'));

  /// The interaction variant when the widget or descendants have focus.
  static const focused = FLineCalendarItemVariant._(.new(1, 'focused'));

  /// The interaction variant when hovered.
  static const hovered = FLineCalendarItemVariant._(.new(1, 'hovered'));

  /// The interaction variant when pressed.
  static const pressed = FLineCalendarItemVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FLineCalendarItemVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FLineCalendarItemVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FLineCalendarItemVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FLineCalendarItemVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FLineCalendarItemVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FLineCalendarItemVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FLineCalendarItemVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FLineCalendarStyleTransformations on FLineCalendarStyle {
  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FLineCalendarStyle.itemSpacing] - The horizontal spacing between each calendar item.
  /// * [FLineCalendarStyle.contentEdgeSpacing] - The vertical height between the content and the edges.
  /// * [FLineCalendarStyle.contentSpacing] - The vertical height between the date and weekday.
  /// * [FLineCalendarStyle.decoration] - The decoration.
  /// * [FLineCalendarStyle.todayIndicatorColor] - The color of the today indicator.
  /// * [FLineCalendarStyle.dateTextStyle] - The text style for the date.
  /// * [FLineCalendarStyle.weekdayTextStyle] - The text style for the day of the week.
  /// * [FLineCalendarStyle.tappableStyle] - The tappable style.
  @useResult
  FLineCalendarStyle copyWith({
    double? itemSpacing,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Decoration, DecorationDelta>?
    decoration,
    FVariantsValueDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Color, Delta>?
    todayIndicatorColor,
    FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>?
    dateTextStyle,
    FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>?
    weekdayTextStyle,
    FTappableStyleDelta? tappableStyle,
  }) => .new(
    itemSpacing: itemSpacing ?? this.itemSpacing,
    contentEdgeSpacing: contentEdgeSpacing ?? this.contentEdgeSpacing,
    contentSpacing: contentSpacing ?? this.contentSpacing,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    todayIndicatorColor: todayIndicatorColor?.call(this.todayIndicatorColor) ?? this.todayIndicatorColor,
    dateTextStyle: dateTextStyle?.call(this.dateTextStyle) ?? this.dateTextStyle,
    weekdayTextStyle: weekdayTextStyle?.call(this.weekdayTextStyle) ?? this.weekdayTextStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FLineCalendarStyle] using the given factor [t].
  @useResult
  FLineCalendarStyle lerp(FLineCalendarStyle other, double t) => .new(
    itemSpacing: lerpDouble(itemSpacing, other.itemSpacing, t) ?? itemSpacing,
    contentEdgeSpacing: lerpDouble(contentEdgeSpacing, other.contentEdgeSpacing, t) ?? contentEdgeSpacing,
    contentSpacing: lerpDouble(contentSpacing, other.contentSpacing, t) ?? contentSpacing,
    decoration: .lerpDecoration(decoration, other.decoration, t),
    todayIndicatorColor: .lerpColor(todayIndicatorColor, other.todayIndicatorColor, t),
    dateTextStyle: .lerpTextStyle(dateTextStyle, other.dateTextStyle, t),
    weekdayTextStyle: .lerpTextStyle(weekdayTextStyle, other.weekdayTextStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FLineCalendarStyleFunctions on Diagnosticable implements FLineCalendarStyleDelta {
  /// Returns itself.
  @override
  FLineCalendarStyle call(Object _) => this as FLineCalendarStyle;

  double get itemSpacing;
  double get contentEdgeSpacing;
  double get contentSpacing;
  FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Decoration, DecorationDelta> get decoration;
  FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Color, Delta> get todayIndicatorColor;
  FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta> get dateTextStyle;
  FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>
  get weekdayTextStyle;
  FTappableStyle get tappableStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('itemSpacing', itemSpacing, level: .debug))
      ..add(DoubleProperty('contentEdgeSpacing', contentEdgeSpacing, level: .debug))
      ..add(DoubleProperty('contentSpacing', contentSpacing, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('todayIndicatorColor', todayIndicatorColor, level: .debug))
      ..add(DiagnosticsProperty('dateTextStyle', dateTextStyle, level: .debug))
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLineCalendarStyle &&
          runtimeType == other.runtimeType &&
          itemSpacing == other.itemSpacing &&
          contentEdgeSpacing == other.contentEdgeSpacing &&
          contentSpacing == other.contentSpacing &&
          decoration == other.decoration &&
          todayIndicatorColor == other.todayIndicatorColor &&
          dateTextStyle == other.dateTextStyle &&
          weekdayTextStyle == other.weekdayTextStyle &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode =>
      itemSpacing.hashCode ^
      contentEdgeSpacing.hashCode ^
      contentSpacing.hashCode ^
      decoration.hashCode ^
      todayIndicatorColor.hashCode ^
      dateTextStyle.hashCode ^
      weekdayTextStyle.hashCode ^
      tappableStyle.hashCode;
}

/// A delta that applies modifications to a [FLineCalendarStyle].
///
/// A [FLineCalendarStyle] is itself a [FLineCalendarStyleDelta].
abstract class FLineCalendarStyleDelta with Delta {
  /// Creates a partial modification of a [FLineCalendarStyle].
  ///
  /// ## Parameters
  /// * [FLineCalendarStyle.itemSpacing] - The horizontal spacing between each calendar item.
  /// * [FLineCalendarStyle.contentEdgeSpacing] - The vertical height between the content and the edges.
  /// * [FLineCalendarStyle.contentSpacing] - The vertical height between the date and weekday.
  /// * [FLineCalendarStyle.decoration] - The decoration.
  /// * [FLineCalendarStyle.todayIndicatorColor] - The color of the today indicator.
  /// * [FLineCalendarStyle.dateTextStyle] - The text style for the date.
  /// * [FLineCalendarStyle.weekdayTextStyle] - The text style for the day of the week.
  /// * [FLineCalendarStyle.tappableStyle] - The tappable style.
  const factory FLineCalendarStyleDelta.delta({
    double? itemSpacing,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Decoration, DecorationDelta>?
    decoration,
    FVariantsValueDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Color, Delta>?
    todayIndicatorColor,
    FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>?
    dateTextStyle,
    FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>?
    weekdayTextStyle,
    FTappableStyleDelta? tappableStyle,
  }) = _FLineCalendarStyleDelta;

  /// Creates a delta that returns the [FLineCalendarStyle] in the current context.
  const factory FLineCalendarStyleDelta.context() = _FLineCalendarStyleContext;

  @override
  FLineCalendarStyle call(covariant FLineCalendarStyle value);
}

class _FLineCalendarStyleDelta implements FLineCalendarStyleDelta {
  const _FLineCalendarStyleDelta({
    this.itemSpacing,
    this.contentEdgeSpacing,
    this.contentSpacing,
    this.decoration,
    this.todayIndicatorColor,
    this.dateTextStyle,
    this.weekdayTextStyle,
    this.tappableStyle,
  });

  final double? itemSpacing;

  final double? contentEdgeSpacing;

  final double? contentSpacing;

  final FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Decoration, DecorationDelta>?
  decoration;

  final FVariantsValueDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Color, Delta>?
  todayIndicatorColor;

  final FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>?
  dateTextStyle;

  final FVariantsDelta<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>?
  weekdayTextStyle;

  final FTappableStyleDelta? tappableStyle;

  @override
  FLineCalendarStyle call(FLineCalendarStyle original) => FLineCalendarStyle(
    itemSpacing: itemSpacing ?? original.itemSpacing,
    contentEdgeSpacing: contentEdgeSpacing ?? original.contentEdgeSpacing,
    contentSpacing: contentSpacing ?? original.contentSpacing,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    todayIndicatorColor: todayIndicatorColor?.call(original.todayIndicatorColor) ?? original.todayIndicatorColor,
    dateTextStyle: dateTextStyle?.call(original.dateTextStyle) ?? original.dateTextStyle,
    weekdayTextStyle: weekdayTextStyle?.call(original.weekdayTextStyle) ?? original.weekdayTextStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
  );
}

class _FLineCalendarStyleContext implements FLineCalendarStyleDelta {
  const _FLineCalendarStyleContext();

  @override
  FLineCalendarStyle call(FLineCalendarStyle original) => original;
}

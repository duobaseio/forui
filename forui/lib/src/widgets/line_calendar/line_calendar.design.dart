// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'line_calendar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FLineCalendarStyleTransformations on FLineCalendarStyle {
  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FLineCalendarStyle.padding] - The horizontal padding around each calendar item.
  /// * [FLineCalendarStyle.contentEdgeSpacing] - The vertical height between the content and the edges.
  /// * [FLineCalendarStyle.contentSpacing] - The vertical height between the date and weekday.
  /// * [FLineCalendarStyle.decoration] - The decoration.
  /// * [FLineCalendarStyle.todayIndicatorColor] - The color of the today indicator.
  /// * [FLineCalendarStyle.dateTextStyle] - The text style for the date.
  /// * [FLineCalendarStyle.weekdayTextStyle] - The text style for the day of the week.
  /// * [FLineCalendarStyle.tappableStyle] - The tappable style.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsetsGeometryDelta? padding,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? todayIndicatorColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? dateTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? weekdayTextStyle,
    FTappableStyleDelta? tappableStyle,
  }) => .new(
    padding: padding?.call(this.padding) ?? this.padding,
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
    padding: .lerp(padding, other.padding, t) ?? padding,
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

  EdgeInsetsGeometry get padding;
  double get contentEdgeSpacing;
  double get contentSpacing;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get decoration;
  FVariants<FTappableVariantConstraint, FTappableVariant, Color, Delta> get todayIndicatorColor;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get dateTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get weekdayTextStyle;
  FTappableStyle get tappableStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
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
          padding == other.padding &&
          contentEdgeSpacing == other.contentEdgeSpacing &&
          contentSpacing == other.contentSpacing &&
          decoration == other.decoration &&
          todayIndicatorColor == other.todayIndicatorColor &&
          dateTextStyle == other.dateTextStyle &&
          weekdayTextStyle == other.weekdayTextStyle &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode =>
      padding.hashCode ^
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
  /// * [FLineCalendarStyle.padding] - The horizontal padding around each calendar item.
  /// * [FLineCalendarStyle.contentEdgeSpacing] - The vertical height between the content and the edges.
  /// * [FLineCalendarStyle.contentSpacing] - The vertical height between the date and weekday.
  /// * [FLineCalendarStyle.decoration] - The decoration.
  /// * [FLineCalendarStyle.todayIndicatorColor] - The color of the today indicator.
  /// * [FLineCalendarStyle.dateTextStyle] - The text style for the date.
  /// * [FLineCalendarStyle.weekdayTextStyle] - The text style for the day of the week.
  /// * [FLineCalendarStyle.tappableStyle] - The tappable style.
  const factory FLineCalendarStyleDelta.delta({
    EdgeInsetsGeometryDelta? padding,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? todayIndicatorColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? dateTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? weekdayTextStyle,
    FTappableStyleDelta? tappableStyle,
  }) = _FLineCalendarStyleDelta;

  /// Creates a delta that returns the [FLineCalendarStyle] in the current context.
  const factory FLineCalendarStyleDelta.context() = _FLineCalendarStyleContext;

  @override
  FLineCalendarStyle call(covariant FLineCalendarStyle value);
}

class _FLineCalendarStyleDelta implements FLineCalendarStyleDelta {
  const _FLineCalendarStyleDelta({
    this.padding,
    this.contentEdgeSpacing,
    this.contentSpacing,
    this.decoration,
    this.todayIndicatorColor,
    this.dateTextStyle,
    this.weekdayTextStyle,
    this.tappableStyle,
  });

  final EdgeInsetsGeometryDelta? padding;

  final double? contentEdgeSpacing;

  final double? contentSpacing;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? decoration;

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? todayIndicatorColor;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? dateTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? weekdayTextStyle;

  final FTappableStyleDelta? tappableStyle;

  @override
  FLineCalendarStyle call(FLineCalendarStyle original) => FLineCalendarStyle(
    padding: padding?.call(original.padding) ?? original.padding,
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

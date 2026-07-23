// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'calendar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarStyleTransformations on FCalendarStyle {
  /// Returns a copy of this [FCalendarStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarStyle.headerStyle] - The header's style.
  /// * [FCalendarStyle.dayPickerStyle] - The day picker's style.
  /// * [FCalendarStyle.monthPickerStyle] - The month picker's style.
  /// * [FCalendarStyle.yearPickerStyle] - The year picker's style.
  /// * [FCalendarStyle.wheelPickerStyle] - The wheel picker's style.
  /// * [FCalendarStyle.decoration] - The decoration surrounding the header & picker.
  /// * [FCalendarStyle.padding] - The padding surrounding the header & picker.
  @useResult
  FCalendarStyle copyWith({
    FCalendarHeaderStyleDelta? headerStyle,
    FCalendarDayPickerStyleDelta? dayPickerStyle,
    FCalendarMonthPickerStyleDelta? monthPickerStyle,
    FCalendarYearPickerStyleDelta? yearPickerStyle,
    FPickerStyleDelta? wheelPickerStyle,
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
  }) => .new(
    headerStyle: headerStyle?.call(this.headerStyle) ?? this.headerStyle,
    dayPickerStyle: dayPickerStyle?.call(this.dayPickerStyle) ?? this.dayPickerStyle,
    monthPickerStyle: monthPickerStyle?.call(this.monthPickerStyle) ?? this.monthPickerStyle,
    yearPickerStyle: yearPickerStyle?.call(this.yearPickerStyle) ?? this.yearPickerStyle,
    wheelPickerStyle: wheelPickerStyle?.call(this.wheelPickerStyle) ?? this.wheelPickerStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    padding: padding?.call(this.padding) ?? this.padding,
  );

  /// Linearly interpolate between this and another [FCalendarStyle] using the given factor [t].
  @useResult
  FCalendarStyle lerp(FCalendarStyle other, double t) => .new(
    headerStyle: headerStyle.lerp(other.headerStyle, t),
    dayPickerStyle: dayPickerStyle.lerp(other.dayPickerStyle, t),
    monthPickerStyle: monthPickerStyle.lerp(other.monthPickerStyle, t),
    yearPickerStyle: yearPickerStyle.lerp(other.yearPickerStyle, t),
    wheelPickerStyle: wheelPickerStyle.lerp(other.wheelPickerStyle, t),
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FCalendarStyleFunctions on Diagnosticable implements FCalendarStyleDelta {
  /// Returns itself.
  @override
  FCalendarStyle call(Object _) => this as FCalendarStyle;

  FCalendarHeaderStyle get headerStyle;
  FCalendarDayPickerStyle get dayPickerStyle;
  FCalendarMonthPickerStyle get monthPickerStyle;
  FCalendarYearPickerStyle get yearPickerStyle;
  FPickerStyle get wheelPickerStyle;
  Decoration get decoration;
  EdgeInsetsGeometry get padding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerStyle', headerStyle, level: .debug))
      ..add(DiagnosticsProperty('dayPickerStyle', dayPickerStyle, level: .debug))
      ..add(DiagnosticsProperty('monthPickerStyle', monthPickerStyle, level: .debug))
      ..add(DiagnosticsProperty('yearPickerStyle', yearPickerStyle, level: .debug))
      ..add(DiagnosticsProperty('wheelPickerStyle', wheelPickerStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarStyle &&
          runtimeType == other.runtimeType &&
          headerStyle == other.headerStyle &&
          dayPickerStyle == other.dayPickerStyle &&
          monthPickerStyle == other.monthPickerStyle &&
          yearPickerStyle == other.yearPickerStyle &&
          wheelPickerStyle == other.wheelPickerStyle &&
          decoration == other.decoration &&
          padding == other.padding);

  @override
  int get hashCode =>
      headerStyle.hashCode ^
      dayPickerStyle.hashCode ^
      monthPickerStyle.hashCode ^
      yearPickerStyle.hashCode ^
      wheelPickerStyle.hashCode ^
      decoration.hashCode ^
      padding.hashCode;
}

/// A delta that applies modifications to a [FCalendarStyle].
///
/// A [FCalendarStyle] is itself a [FCalendarStyleDelta].
abstract class FCalendarStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarStyle].
  ///
  /// ## Parameters
  /// * [FCalendarStyle.headerStyle] - The header's style.
  /// * [FCalendarStyle.dayPickerStyle] - The day picker's style.
  /// * [FCalendarStyle.monthPickerStyle] - The month picker's style.
  /// * [FCalendarStyle.yearPickerStyle] - The year picker's style.
  /// * [FCalendarStyle.wheelPickerStyle] - The wheel picker's style.
  /// * [FCalendarStyle.decoration] - The decoration surrounding the header & picker.
  /// * [FCalendarStyle.padding] - The padding surrounding the header & picker.
  const factory FCalendarStyleDelta.delta({
    FCalendarHeaderStyleDelta? headerStyle,
    FCalendarDayPickerStyleDelta? dayPickerStyle,
    FCalendarMonthPickerStyleDelta? monthPickerStyle,
    FCalendarYearPickerStyleDelta? yearPickerStyle,
    FPickerStyleDelta? wheelPickerStyle,
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
  }) = _FCalendarStyleDelta;

  /// Creates a delta that returns the [FCalendarStyle] in the current context.
  const factory FCalendarStyleDelta.context() = _FCalendarStyleContext;

  @override
  FCalendarStyle call(covariant FCalendarStyle value);
}

class _FCalendarStyleDelta implements FCalendarStyleDelta {
  const _FCalendarStyleDelta({
    this.headerStyle,
    this.dayPickerStyle,
    this.monthPickerStyle,
    this.yearPickerStyle,
    this.wheelPickerStyle,
    this.decoration,
    this.padding,
  });

  final FCalendarHeaderStyleDelta? headerStyle;

  final FCalendarDayPickerStyleDelta? dayPickerStyle;

  final FCalendarMonthPickerStyleDelta? monthPickerStyle;

  final FCalendarYearPickerStyleDelta? yearPickerStyle;

  final FPickerStyleDelta? wheelPickerStyle;

  final DecorationDelta? decoration;

  final EdgeInsetsGeometryDelta? padding;

  @override
  FCalendarStyle call(FCalendarStyle original) => FCalendarStyle(
    headerStyle: headerStyle?.call(original.headerStyle) ?? original.headerStyle,
    dayPickerStyle: dayPickerStyle?.call(original.dayPickerStyle) ?? original.dayPickerStyle,
    monthPickerStyle: monthPickerStyle?.call(original.monthPickerStyle) ?? original.monthPickerStyle,
    yearPickerStyle: yearPickerStyle?.call(original.yearPickerStyle) ?? original.yearPickerStyle,
    wheelPickerStyle: wheelPickerStyle?.call(original.wheelPickerStyle) ?? original.wheelPickerStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    padding: padding?.call(original.padding) ?? original.padding,
  );
}

class _FCalendarStyleContext implements FCalendarStyleDelta {
  const _FCalendarStyleContext();

  @override
  FCalendarStyle call(FCalendarStyle original) => original;
}

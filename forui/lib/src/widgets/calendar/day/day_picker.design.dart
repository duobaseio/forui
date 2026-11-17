// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'day_picker.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarDayPickerStyleTransformations on FCalendarDayPickerStyle {
  /// Returns a copy of this [FCalendarDayPickerStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarDayPickerStyle.weekdayTextStyle] - The text style for the days of the weekday headers.
  /// * [FCalendarDayPickerStyle.dayStyles] - The styles of the day tiles.
  /// * [FCalendarDayPickerStyle.daySize] - The size of each day.
  /// * [FCalendarDayPickerStyle.headerSpacing] - The spacing between the header and the day picker.
  /// * [FCalendarDayPickerStyle.firstDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.daySpacing] - The vertical spacing between days in the day picker.
  @useResult
  FCalendarDayPickerStyle copyWith({
    TextStyleDelta? weekdayTextStyle,
    FVariantsDelta<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta>?
    dayStyles,
    Size? daySize,
    double? headerSpacing,
    int? Function()? firstDayOfWeek,
    double? daySpacing,
  }) => .new(
    weekdayTextStyle: weekdayTextStyle?.call(this.weekdayTextStyle) ?? this.weekdayTextStyle,
    dayStyles: FCalendarDayStyles(dayStyles?.call(this.dayStyles) ?? this.dayStyles),
    daySize: daySize ?? this.daySize,
    headerSpacing: headerSpacing ?? this.headerSpacing,
    firstDayOfWeek: firstDayOfWeek == null ? this.firstDayOfWeek : firstDayOfWeek(),
    daySpacing: daySpacing ?? this.daySpacing,
  );

  /// Linearly interpolate between this and another [FCalendarDayPickerStyle] using the given factor [t].
  @useResult
  FCalendarDayPickerStyle lerp(FCalendarDayPickerStyle other, double t) => .new(
    weekdayTextStyle: .lerp(weekdayTextStyle, other.weekdayTextStyle, t) ?? weekdayTextStyle,
    dayStyles: FCalendarDayStyles(.lerpWhere(dayStyles, other.dayStyles, t, (a, b, t) => a!.lerp(b!, t))),
    daySize: t < 0.5 ? daySize : other.daySize,
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    firstDayOfWeek: t < 0.5 ? firstDayOfWeek : other.firstDayOfWeek,
    daySpacing: lerpDouble(daySpacing, other.daySpacing, t) ?? daySpacing,
  );
}

mixin _$FCalendarDayPickerStyleFunctions on Diagnosticable implements FCalendarDayPickerStyleDelta {
  /// Returns itself.
  @override
  FCalendarDayPickerStyle call(Object _) => this as FCalendarDayPickerStyle;

  TextStyle get weekdayTextStyle;
  FCalendarDayStyles get dayStyles;
  Size get daySize;
  double get headerSpacing;
  int? get firstDayOfWeek;
  double get daySpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle, level: .debug))
      ..add(DiagnosticsProperty('dayStyles', dayStyles, level: .debug))
      ..add(DiagnosticsProperty('daySize', daySize, level: .debug))
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(IntProperty('firstDayOfWeek', firstDayOfWeek, level: .debug))
      ..add(DoubleProperty('daySpacing', daySpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarDayPickerStyle &&
          runtimeType == other.runtimeType &&
          weekdayTextStyle == other.weekdayTextStyle &&
          dayStyles == other.dayStyles &&
          daySize == other.daySize &&
          headerSpacing == other.headerSpacing &&
          firstDayOfWeek == other.firstDayOfWeek &&
          daySpacing == other.daySpacing);

  @override
  int get hashCode =>
      weekdayTextStyle.hashCode ^
      dayStyles.hashCode ^
      daySize.hashCode ^
      headerSpacing.hashCode ^
      firstDayOfWeek.hashCode ^
      daySpacing.hashCode;
}

/// A delta that applies modifications to a [FCalendarDayPickerStyle].
///
/// A [FCalendarDayPickerStyle] is itself a [FCalendarDayPickerStyleDelta].
abstract class FCalendarDayPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarDayPickerStyle].
  ///
  /// ## Parameters
  /// * [FCalendarDayPickerStyle.weekdayTextStyle] - The text style for the days of the weekday headers.
  /// * [FCalendarDayPickerStyle.dayStyles] - The styles of the day tiles.
  /// * [FCalendarDayPickerStyle.daySize] - The size of each day.
  /// * [FCalendarDayPickerStyle.headerSpacing] - The spacing between the header and the day picker.
  /// * [FCalendarDayPickerStyle.firstDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.daySpacing] - The vertical spacing between days in the day picker.
  const factory delta({
    TextStyleDelta? weekdayTextStyle,
    FVariantsDelta<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta>?
    dayStyles,
    Size? daySize,
    double? headerSpacing,
    int? Function()? firstDayOfWeek,
    double? daySpacing,
  }) = _FCalendarDayPickerStyleDelta;

  /// Creates a delta that returns the [FCalendarDayPickerStyle] in the current context.
  const factory context() = _FCalendarDayPickerStyleContext;

  @override
  FCalendarDayPickerStyle call(covariant FCalendarDayPickerStyle value);
}

class _FCalendarDayPickerStyleDelta implements FCalendarDayPickerStyleDelta {
  const new({
    this.weekdayTextStyle,
    this.dayStyles,
    this.daySize,
    this.headerSpacing,
    this.firstDayOfWeek,
    this.daySpacing,
  });

  final TextStyleDelta? weekdayTextStyle;

  final FVariantsDelta<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta>?
  dayStyles;

  final Size? daySize;

  final double? headerSpacing;

  final int? Function()? firstDayOfWeek;

  final double? daySpacing;

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => FCalendarDayPickerStyle(
    weekdayTextStyle: weekdayTextStyle?.call(original.weekdayTextStyle) ?? original.weekdayTextStyle,
    dayStyles: FCalendarDayStyles(dayStyles?.call(original.dayStyles) ?? original.dayStyles),
    daySize: daySize ?? original.daySize,
    headerSpacing: headerSpacing ?? original.headerSpacing,
    firstDayOfWeek: firstDayOfWeek == null ? original.firstDayOfWeek : firstDayOfWeek!(),
    daySpacing: daySpacing ?? original.daySpacing,
  );
}

class _FCalendarDayPickerStyleContext implements FCalendarDayPickerStyleDelta {
  const new();

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => original;
}

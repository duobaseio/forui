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
  /// * [FCalendarDayPickerStyle.headerSpacing] - The spacing between the header and the day picker.
  /// * [FCalendarDayPickerStyle.weekdayTextStyle] - The text style for the days of the weekday headers.
  /// * [FCalendarDayPickerStyle.firstDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.dayStyles] - The styles of the day tiles.
  /// * [FCalendarDayPickerStyle.daySize] - The size of each day.
  /// * [FCalendarDayPickerStyle.daySpacing] - The vertical spacing between days in the day picker.
  @useResult
  FCalendarDayPickerStyle copyWith({
    double? headerSpacing,
    TextStyleDelta? weekdayTextStyle,
    int? Function()? firstDayOfWeek,
    FVariantsDelta<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta>?
    dayStyles,
    Size? daySize,
    double? daySpacing,
  }) => .new(
    headerSpacing: headerSpacing ?? this.headerSpacing,
    weekdayTextStyle: weekdayTextStyle?.call(this.weekdayTextStyle) ?? this.weekdayTextStyle,
    firstDayOfWeek: firstDayOfWeek == null ? this.firstDayOfWeek : firstDayOfWeek(),
    dayStyles: FCalendarDayStyles(dayStyles?.call(this.dayStyles) ?? this.dayStyles),
    daySize: daySize ?? this.daySize,
    daySpacing: daySpacing ?? this.daySpacing,
  );

  /// Linearly interpolate between this and another [FCalendarDayPickerStyle] using the given factor [t].
  @useResult
  FCalendarDayPickerStyle lerp(FCalendarDayPickerStyle other, double t) => .new(
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    weekdayTextStyle: .lerp(weekdayTextStyle, other.weekdayTextStyle, t) ?? weekdayTextStyle,
    firstDayOfWeek: t < 0.5 ? firstDayOfWeek : other.firstDayOfWeek,
    dayStyles: FCalendarDayStyles(.lerpWhere(dayStyles, other.dayStyles, t, (a, b, t) => a!.lerp(b!, t))),
    daySize: t < 0.5 ? daySize : other.daySize,
    daySpacing: lerpDouble(daySpacing, other.daySpacing, t) ?? daySpacing,
  );
}

mixin _$FCalendarDayPickerStyleFunctions on Diagnosticable implements FCalendarDayPickerStyleDelta {
  /// Returns itself.
  @override
  FCalendarDayPickerStyle call(Object _) => this as FCalendarDayPickerStyle;

  double get headerSpacing;
  TextStyle get weekdayTextStyle;
  int? get firstDayOfWeek;
  FCalendarDayStyles get dayStyles;
  Size get daySize;
  double get daySpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle, level: .debug))
      ..add(IntProperty('firstDayOfWeek', firstDayOfWeek, level: .debug))
      ..add(DiagnosticsProperty('dayStyles', dayStyles, level: .debug))
      ..add(DiagnosticsProperty('daySize', daySize, level: .debug))
      ..add(DoubleProperty('daySpacing', daySpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarDayPickerStyle &&
          runtimeType == other.runtimeType &&
          headerSpacing == other.headerSpacing &&
          weekdayTextStyle == other.weekdayTextStyle &&
          firstDayOfWeek == other.firstDayOfWeek &&
          dayStyles == other.dayStyles &&
          daySize == other.daySize &&
          daySpacing == other.daySpacing);

  @override
  int get hashCode =>
      headerSpacing.hashCode ^
      weekdayTextStyle.hashCode ^
      firstDayOfWeek.hashCode ^
      dayStyles.hashCode ^
      daySize.hashCode ^
      daySpacing.hashCode;
}

/// A delta that applies modifications to a [FCalendarDayPickerStyle].
///
/// A [FCalendarDayPickerStyle] is itself a [FCalendarDayPickerStyleDelta].
abstract class FCalendarDayPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarDayPickerStyle].
  ///
  /// ## Parameters
  /// * [FCalendarDayPickerStyle.headerSpacing] - The spacing between the header and the day picker.
  /// * [FCalendarDayPickerStyle.weekdayTextStyle] - The text style for the days of the weekday headers.
  /// * [FCalendarDayPickerStyle.firstDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.dayStyles] - The styles of the day tiles.
  /// * [FCalendarDayPickerStyle.daySize] - The size of each day.
  /// * [FCalendarDayPickerStyle.daySpacing] - The vertical spacing between days in the day picker.
  const factory FCalendarDayPickerStyleDelta.delta({
    double? headerSpacing,
    TextStyleDelta? weekdayTextStyle,
    int? Function()? firstDayOfWeek,
    FVariantsDelta<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta>?
    dayStyles,
    Size? daySize,
    double? daySpacing,
  }) = _FCalendarDayPickerStyleDelta;

  /// Creates a delta that returns the [FCalendarDayPickerStyle] in the current context.
  const factory FCalendarDayPickerStyleDelta.context() = _FCalendarDayPickerStyleContext;

  @override
  FCalendarDayPickerStyle call(covariant FCalendarDayPickerStyle value);
}

class _FCalendarDayPickerStyleDelta implements FCalendarDayPickerStyleDelta {
  const _FCalendarDayPickerStyleDelta({
    this.headerSpacing,
    this.weekdayTextStyle,
    this.firstDayOfWeek,
    this.dayStyles,
    this.daySize,
    this.daySpacing,
  });

  final double? headerSpacing;

  final TextStyleDelta? weekdayTextStyle;

  final int? Function()? firstDayOfWeek;

  final FVariantsDelta<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta>?
  dayStyles;

  final Size? daySize;

  final double? daySpacing;

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => FCalendarDayPickerStyle(
    headerSpacing: headerSpacing ?? original.headerSpacing,
    weekdayTextStyle: weekdayTextStyle?.call(original.weekdayTextStyle) ?? original.weekdayTextStyle,
    firstDayOfWeek: firstDayOfWeek == null ? original.firstDayOfWeek : firstDayOfWeek!(),
    dayStyles: FCalendarDayStyles(dayStyles?.call(original.dayStyles) ?? original.dayStyles),
    daySize: daySize ?? original.daySize,
    daySpacing: daySpacing ?? original.daySpacing,
  );
}

class _FCalendarDayPickerStyleContext implements FCalendarDayPickerStyleDelta {
  const _FCalendarDayPickerStyleContext();

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => original;
}

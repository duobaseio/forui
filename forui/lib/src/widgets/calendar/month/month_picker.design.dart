// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'month_picker.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarMonthPickerStyleTransformations on FCalendarMonthPickerStyle {
  /// Returns a copy of this [FCalendarMonthPickerStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarMonthPickerStyle.monthStyles] - The styles of the month tiles.
  /// * [FCalendarMonthPickerStyle.monthSize] - The size of each month.
  /// * [FCalendarMonthPickerStyle.headerSpacing] - The spacing between the header and the month picker.
  /// * [FCalendarMonthPickerStyle.monthSpacing] - The vertical spacing between rows of months in the month picker.
  @useResult
  FCalendarMonthPickerStyle copyWith({
    FVariantsDelta<
      FCalendarMonthVariantConstraint,
      FCalendarMonthVariant,
      FCalendarMonthStyle,
      FCalendarMonthStyleDelta
    >?
    monthStyles,
    Size? monthSize,
    double? headerSpacing,
    double? monthSpacing,
  }) => .new(
    monthStyles: FCalendarMonthStyles(monthStyles?.call(this.monthStyles) ?? this.monthStyles),
    monthSize: monthSize ?? this.monthSize,
    headerSpacing: headerSpacing ?? this.headerSpacing,
    monthSpacing: monthSpacing ?? this.monthSpacing,
  );

  /// Linearly interpolate between this and another [FCalendarMonthPickerStyle] using the given factor [t].
  @useResult
  FCalendarMonthPickerStyle lerp(FCalendarMonthPickerStyle other, double t) => .new(
    monthStyles: FCalendarMonthStyles(.lerpWhere(monthStyles, other.monthStyles, t, (a, b, t) => a!.lerp(b!, t))),
    monthSize: t < 0.5 ? monthSize : other.monthSize,
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    monthSpacing: lerpDouble(monthSpacing, other.monthSpacing, t) ?? monthSpacing,
  );
}

mixin _$FCalendarMonthPickerStyleFunctions on Diagnosticable implements FCalendarMonthPickerStyleDelta {
  /// Returns itself.
  @override
  FCalendarMonthPickerStyle call(Object _) => this as FCalendarMonthPickerStyle;

  FCalendarMonthStyles get monthStyles;
  Size get monthSize;
  double get headerSpacing;
  double get monthSpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('monthStyles', monthStyles, level: .debug))
      ..add(DiagnosticsProperty('monthSize', monthSize, level: .debug))
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(DoubleProperty('monthSpacing', monthSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarMonthPickerStyle &&
          runtimeType == other.runtimeType &&
          monthStyles == other.monthStyles &&
          monthSize == other.monthSize &&
          headerSpacing == other.headerSpacing &&
          monthSpacing == other.monthSpacing);

  @override
  int get hashCode => monthStyles.hashCode ^ monthSize.hashCode ^ headerSpacing.hashCode ^ monthSpacing.hashCode;
}

/// A delta that applies modifications to a [FCalendarMonthPickerStyle].
///
/// A [FCalendarMonthPickerStyle] is itself a [FCalendarMonthPickerStyleDelta].
abstract class FCalendarMonthPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarMonthPickerStyle].
  ///
  /// ## Parameters
  /// * [FCalendarMonthPickerStyle.monthStyles] - The styles of the month tiles.
  /// * [FCalendarMonthPickerStyle.monthSize] - The size of each month.
  /// * [FCalendarMonthPickerStyle.headerSpacing] - The spacing between the header and the month picker.
  /// * [FCalendarMonthPickerStyle.monthSpacing] - The vertical spacing between rows of months in the month picker.
  const factory delta({
    FVariantsDelta<
      FCalendarMonthVariantConstraint,
      FCalendarMonthVariant,
      FCalendarMonthStyle,
      FCalendarMonthStyleDelta
    >?
    monthStyles,
    Size? monthSize,
    double? headerSpacing,
    double? monthSpacing,
  }) = _FCalendarMonthPickerStyleDelta;

  /// Creates a delta that returns the [FCalendarMonthPickerStyle] in the current context.
  const factory context() = _FCalendarMonthPickerStyleContext;

  @override
  FCalendarMonthPickerStyle call(covariant FCalendarMonthPickerStyle value);
}

class _FCalendarMonthPickerStyleDelta implements FCalendarMonthPickerStyleDelta {
  const new({this.monthStyles, this.monthSize, this.headerSpacing, this.monthSpacing});

  final FVariantsDelta<
    FCalendarMonthVariantConstraint,
    FCalendarMonthVariant,
    FCalendarMonthStyle,
    FCalendarMonthStyleDelta
  >?
  monthStyles;

  final Size? monthSize;

  final double? headerSpacing;

  final double? monthSpacing;

  @override
  FCalendarMonthPickerStyle call(FCalendarMonthPickerStyle original) => FCalendarMonthPickerStyle(
    monthStyles: FCalendarMonthStyles(monthStyles?.call(original.monthStyles) ?? original.monthStyles),
    monthSize: monthSize ?? original.monthSize,
    headerSpacing: headerSpacing ?? original.headerSpacing,
    monthSpacing: monthSpacing ?? original.monthSpacing,
  );
}

class _FCalendarMonthPickerStyleContext implements FCalendarMonthPickerStyleDelta {
  const new();

  @override
  FCalendarMonthPickerStyle call(FCalendarMonthPickerStyle original) => original;
}

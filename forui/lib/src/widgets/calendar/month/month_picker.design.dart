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
  /// * [FCalendarMonthPickerStyle.headerSpacing] - The spacing between the header and the month picker.
  /// * [FCalendarMonthPickerStyle.monthStyles] - The styles of the month tiles.
  /// * [FCalendarMonthPickerStyle.monthSize] - The size of each month.
  /// * [FCalendarMonthPickerStyle.monthSpacing] - The vertical spacing between rows of months in the month picker.
  @useResult
  FCalendarMonthPickerStyle copyWith({
    double? headerSpacing,
    FVariantsDelta<
      FCalendarMonthVariantConstraint,
      FCalendarMonthVariant,
      FCalendarMonthStyle,
      FCalendarMonthStyleDelta
    >?
    monthStyles,
    Size? monthSize,
    double? monthSpacing,
  }) => .new(
    headerSpacing: headerSpacing ?? this.headerSpacing,
    monthStyles: FCalendarMonthStyles(monthStyles?.call(this.monthStyles) ?? this.monthStyles),
    monthSize: monthSize ?? this.monthSize,
    monthSpacing: monthSpacing ?? this.monthSpacing,
  );

  /// Linearly interpolate between this and another [FCalendarMonthPickerStyle] using the given factor [t].
  @useResult
  FCalendarMonthPickerStyle lerp(FCalendarMonthPickerStyle other, double t) => .new(
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    monthStyles: FCalendarMonthStyles(.lerpWhere(monthStyles, other.monthStyles, t, (a, b, t) => a!.lerp(b!, t))),
    monthSize: t < 0.5 ? monthSize : other.monthSize,
    monthSpacing: lerpDouble(monthSpacing, other.monthSpacing, t) ?? monthSpacing,
  );
}

mixin _$FCalendarMonthPickerStyleFunctions on Diagnosticable implements FCalendarMonthPickerStyleDelta {
  /// Returns itself.
  @override
  FCalendarMonthPickerStyle call(Object _) => this as FCalendarMonthPickerStyle;

  double get headerSpacing;
  FCalendarMonthStyles get monthStyles;
  Size get monthSize;
  double get monthSpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(DiagnosticsProperty('monthStyles', monthStyles, level: .debug))
      ..add(DiagnosticsProperty('monthSize', monthSize, level: .debug))
      ..add(DoubleProperty('monthSpacing', monthSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarMonthPickerStyle &&
          runtimeType == other.runtimeType &&
          headerSpacing == other.headerSpacing &&
          monthStyles == other.monthStyles &&
          monthSize == other.monthSize &&
          monthSpacing == other.monthSpacing);

  @override
  int get hashCode => headerSpacing.hashCode ^ monthStyles.hashCode ^ monthSize.hashCode ^ monthSpacing.hashCode;
}

/// A delta that applies modifications to a [FCalendarMonthPickerStyle].
///
/// A [FCalendarMonthPickerStyle] is itself a [FCalendarMonthPickerStyleDelta].
abstract class FCalendarMonthPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarMonthPickerStyle].
  ///
  /// ## Parameters
  /// * [FCalendarMonthPickerStyle.headerSpacing] - The spacing between the header and the month picker.
  /// * [FCalendarMonthPickerStyle.monthStyles] - The styles of the month tiles.
  /// * [FCalendarMonthPickerStyle.monthSize] - The size of each month.
  /// * [FCalendarMonthPickerStyle.monthSpacing] - The vertical spacing between rows of months in the month picker.
  const factory FCalendarMonthPickerStyleDelta.delta({
    double? headerSpacing,
    FVariantsDelta<
      FCalendarMonthVariantConstraint,
      FCalendarMonthVariant,
      FCalendarMonthStyle,
      FCalendarMonthStyleDelta
    >?
    monthStyles,
    Size? monthSize,
    double? monthSpacing,
  }) = _FCalendarMonthPickerStyleDelta;

  /// Creates a delta that returns the [FCalendarMonthPickerStyle] in the current context.
  const factory FCalendarMonthPickerStyleDelta.context() = _FCalendarMonthPickerStyleContext;

  @override
  FCalendarMonthPickerStyle call(covariant FCalendarMonthPickerStyle value);
}

class _FCalendarMonthPickerStyleDelta implements FCalendarMonthPickerStyleDelta {
  const _FCalendarMonthPickerStyleDelta({this.headerSpacing, this.monthStyles, this.monthSize, this.monthSpacing});

  final double? headerSpacing;

  final FVariantsDelta<
    FCalendarMonthVariantConstraint,
    FCalendarMonthVariant,
    FCalendarMonthStyle,
    FCalendarMonthStyleDelta
  >?
  monthStyles;

  final Size? monthSize;

  final double? monthSpacing;

  @override
  FCalendarMonthPickerStyle call(FCalendarMonthPickerStyle original) => FCalendarMonthPickerStyle(
    headerSpacing: headerSpacing ?? original.headerSpacing,
    monthStyles: FCalendarMonthStyles(monthStyles?.call(original.monthStyles) ?? original.monthStyles),
    monthSize: monthSize ?? original.monthSize,
    monthSpacing: monthSpacing ?? original.monthSpacing,
  );
}

class _FCalendarMonthPickerStyleContext implements FCalendarMonthPickerStyleDelta {
  const _FCalendarMonthPickerStyleContext();

  @override
  FCalendarMonthPickerStyle call(FCalendarMonthPickerStyle original) => original;
}

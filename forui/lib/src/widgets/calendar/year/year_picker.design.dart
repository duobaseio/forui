// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'year_picker.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarYearPickerStyleTransformations on FCalendarYearPickerStyle {
  /// Returns a copy of this [FCalendarYearPickerStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarYearPickerStyle.headerSpacing] - The spacing between the header and the year picker.
  /// * [FCalendarYearPickerStyle.yearStyles] - The styles of the year tiles.
  /// * [FCalendarYearPickerStyle.yearSize] - The size of each year.
  /// * [FCalendarYearPickerStyle.yearSpacing] - The vertical spacing between rows of years in the year picker.
  @useResult
  FCalendarYearPickerStyle copyWith({
    double? headerSpacing,
    FVariantsDelta<FCalendarYearVariantConstraint, FCalendarYearVariant, FCalendarYearStyle, FCalendarYearStyleDelta>?
    yearStyles,
    Size? yearSize,
    double? yearSpacing,
  }) => .new(
    headerSpacing: headerSpacing ?? this.headerSpacing,
    yearStyles: FCalendarYearStyles(yearStyles?.call(this.yearStyles) ?? this.yearStyles),
    yearSize: yearSize ?? this.yearSize,
    yearSpacing: yearSpacing ?? this.yearSpacing,
  );

  /// Linearly interpolate between this and another [FCalendarYearPickerStyle] using the given factor [t].
  @useResult
  FCalendarYearPickerStyle lerp(FCalendarYearPickerStyle other, double t) => .new(
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    yearStyles: FCalendarYearStyles(.lerpWhere(yearStyles, other.yearStyles, t, (a, b, t) => a!.lerp(b!, t))),
    yearSize: t < 0.5 ? yearSize : other.yearSize,
    yearSpacing: lerpDouble(yearSpacing, other.yearSpacing, t) ?? yearSpacing,
  );
}

mixin _$FCalendarYearPickerStyleFunctions on Diagnosticable implements FCalendarYearPickerStyleDelta {
  /// Returns itself.
  @override
  FCalendarYearPickerStyle call(Object _) => this as FCalendarYearPickerStyle;

  double get headerSpacing;
  FCalendarYearStyles get yearStyles;
  Size get yearSize;
  double get yearSpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(DiagnosticsProperty('yearStyles', yearStyles, level: .debug))
      ..add(DiagnosticsProperty('yearSize', yearSize, level: .debug))
      ..add(DoubleProperty('yearSpacing', yearSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarYearPickerStyle &&
          runtimeType == other.runtimeType &&
          headerSpacing == other.headerSpacing &&
          yearStyles == other.yearStyles &&
          yearSize == other.yearSize &&
          yearSpacing == other.yearSpacing);

  @override
  int get hashCode => headerSpacing.hashCode ^ yearStyles.hashCode ^ yearSize.hashCode ^ yearSpacing.hashCode;
}

/// A delta that applies modifications to a [FCalendarYearPickerStyle].
///
/// A [FCalendarYearPickerStyle] is itself a [FCalendarYearPickerStyleDelta].
abstract class FCalendarYearPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarYearPickerStyle].
  ///
  /// ## Parameters
  /// * [FCalendarYearPickerStyle.headerSpacing] - The spacing between the header and the year picker.
  /// * [FCalendarYearPickerStyle.yearStyles] - The styles of the year tiles.
  /// * [FCalendarYearPickerStyle.yearSize] - The size of each year.
  /// * [FCalendarYearPickerStyle.yearSpacing] - The vertical spacing between rows of years in the year picker.
  const factory FCalendarYearPickerStyleDelta.delta({
    double? headerSpacing,
    FVariantsDelta<FCalendarYearVariantConstraint, FCalendarYearVariant, FCalendarYearStyle, FCalendarYearStyleDelta>?
    yearStyles,
    Size? yearSize,
    double? yearSpacing,
  }) = _FCalendarYearPickerStyleDelta;

  /// Creates a delta that returns the [FCalendarYearPickerStyle] in the current context.
  const factory FCalendarYearPickerStyleDelta.context() = _FCalendarYearPickerStyleContext;

  @override
  FCalendarYearPickerStyle call(covariant FCalendarYearPickerStyle value);
}

class _FCalendarYearPickerStyleDelta implements FCalendarYearPickerStyleDelta {
  const _FCalendarYearPickerStyleDelta({this.headerSpacing, this.yearStyles, this.yearSize, this.yearSpacing});

  final double? headerSpacing;

  final FVariantsDelta<
    FCalendarYearVariantConstraint,
    FCalendarYearVariant,
    FCalendarYearStyle,
    FCalendarYearStyleDelta
  >?
  yearStyles;

  final Size? yearSize;

  final double? yearSpacing;

  @override
  FCalendarYearPickerStyle call(FCalendarYearPickerStyle original) => FCalendarYearPickerStyle(
    headerSpacing: headerSpacing ?? original.headerSpacing,
    yearStyles: FCalendarYearStyles(yearStyles?.call(original.yearStyles) ?? original.yearStyles),
    yearSize: yearSize ?? original.yearSize,
    yearSpacing: yearSpacing ?? original.yearSpacing,
  );
}

class _FCalendarYearPickerStyleContext implements FCalendarYearPickerStyleDelta {
  const _FCalendarYearPickerStyleContext();

  @override
  FCalendarYearPickerStyle call(FCalendarYearPickerStyle original) => original;
}

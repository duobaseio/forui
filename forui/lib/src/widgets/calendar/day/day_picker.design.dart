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
  /// * [FCalendarDayPickerStyle.headerTextStyle] - The text style for the day of th week headers.
  /// * [FCalendarDayPickerStyle.current] - The styles of dates in the current month.
  /// * [FCalendarDayPickerStyle.enclosing] - The styles of dates in the enclosing months.
  /// * [FCalendarDayPickerStyle.startDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.tileSize] - The tile's size.
  @useResult
  FCalendarDayPickerStyle copyWith({
    TextStyleDelta? headerTextStyle,
    FCalendarEntryStyleDelta? current,
    FCalendarEntryStyleDelta? enclosing,
    int? startDayOfWeek = -1,
    double? tileSize,
  }) => .new(
    headerTextStyle: headerTextStyle?.call(this.headerTextStyle) ?? this.headerTextStyle,
    current: current?.call(this.current) ?? this.current,
    enclosing: enclosing?.call(this.enclosing) ?? this.enclosing,
    startDayOfWeek: startDayOfWeek == -1 ? this.startDayOfWeek : startDayOfWeek,
    tileSize: tileSize ?? this.tileSize,
  );

  /// Linearly interpolate between this and another [FCalendarDayPickerStyle] using the given factor [t].
  @useResult
  FCalendarDayPickerStyle lerp(FCalendarDayPickerStyle other, double t) => .new(
    headerTextStyle: .lerp(headerTextStyle, other.headerTextStyle, t) ?? headerTextStyle,
    current: current.lerp(other.current, t),
    enclosing: enclosing.lerp(other.enclosing, t),
    startDayOfWeek: t < 0.5 ? startDayOfWeek : other.startDayOfWeek,
    tileSize: lerpDouble(tileSize, other.tileSize, t) ?? tileSize,
  );
}

mixin _$FCalendarDayPickerStyleFunctions on Diagnosticable implements FCalendarDayPickerStyleDelta {
  /// Returns itself.
  @override
  FCalendarDayPickerStyle call(Object _) => this as FCalendarDayPickerStyle;

  TextStyle get headerTextStyle;
  FCalendarEntryStyle get current;
  FCalendarEntryStyle get enclosing;
  int? get startDayOfWeek;
  double get tileSize;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle, level: .debug))
      ..add(DiagnosticsProperty('current', current, level: .debug))
      ..add(DiagnosticsProperty('enclosing', enclosing, level: .debug))
      ..add(IntProperty('startDayOfWeek', startDayOfWeek, level: .debug))
      ..add(DoubleProperty('tileSize', tileSize, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarDayPickerStyle &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          current == other.current &&
          enclosing == other.enclosing &&
          startDayOfWeek == other.startDayOfWeek &&
          tileSize == other.tileSize);

  @override
  int get hashCode =>
      headerTextStyle.hashCode ^ current.hashCode ^ enclosing.hashCode ^ startDayOfWeek.hashCode ^ tileSize.hashCode;
}

/// A delta that applies modifications to a [FCalendarDayPickerStyle].
///
/// A [FCalendarDayPickerStyle] is itself a [FCalendarDayPickerStyleDelta].
abstract class FCalendarDayPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarDayPickerStyle].
  ///
  /// ## Parameters
  /// * [FCalendarDayPickerStyle.headerTextStyle] - The text style for the day of th week headers.
  /// * [FCalendarDayPickerStyle.current] - The styles of dates in the current month.
  /// * [FCalendarDayPickerStyle.enclosing] - The styles of dates in the enclosing months.
  /// * [FCalendarDayPickerStyle.startDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.tileSize] - The tile's size.
  const factory FCalendarDayPickerStyleDelta.delta({
    TextStyleDelta? headerTextStyle,
    FCalendarEntryStyleDelta? current,
    FCalendarEntryStyleDelta? enclosing,
    int? startDayOfWeek,
    double? tileSize,
  }) = _FCalendarDayPickerStyleDelta;

  /// Creates a delta that returns the [FCalendarDayPickerStyle] in the current context.
  const factory FCalendarDayPickerStyleDelta.context() = _FCalendarDayPickerStyleContext;

  @override
  FCalendarDayPickerStyle call(covariant FCalendarDayPickerStyle value);
}

class _FCalendarDayPickerStyleDelta implements FCalendarDayPickerStyleDelta {
  const _FCalendarDayPickerStyleDelta({
    this.headerTextStyle,
    this.current,
    this.enclosing,
    this.startDayOfWeek = -1,
    this.tileSize,
  });

  final TextStyleDelta? headerTextStyle;

  final FCalendarEntryStyleDelta? current;

  final FCalendarEntryStyleDelta? enclosing;

  final int? startDayOfWeek;

  final double? tileSize;

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => FCalendarDayPickerStyle(
    headerTextStyle: headerTextStyle?.call(original.headerTextStyle) ?? original.headerTextStyle,
    current: current?.call(original.current) ?? original.current,
    enclosing: enclosing?.call(original.enclosing) ?? original.enclosing,
    startDayOfWeek: startDayOfWeek == -1 ? original.startDayOfWeek : startDayOfWeek,
    tileSize: tileSize ?? original.tileSize,
  );
}

class _FCalendarDayPickerStyleContext implements FCalendarDayPickerStyleDelta {
  const _FCalendarDayPickerStyleContext();

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => original;
}

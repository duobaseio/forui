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
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarDayPickerStyle.headerTextStyle] - The text style for the day of th week headers.
  /// * [FCalendarDayPickerStyle.current] - The styles of dates in the current month.
  /// * [FCalendarDayPickerStyle.enclosing] - The styles of dates in the enclosing months.
  /// * [FCalendarDayPickerStyle.startDayOfWeek] - The starting day of the week.
  /// * [FCalendarDayPickerStyle.tileSize] - The tile's size.
  @useResult
  FCalendarDayPickerStyle copyWith({
    TextStyle? headerTextStyle,
    FCalendarEntryStyle Function(FCalendarEntryStyle style)? current,
    FCalendarEntryStyle Function(FCalendarEntryStyle style)? enclosing,
    int? startDayOfWeek,
    double? tileSize,
  }) => .new(
    headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    current: current != null ? current(this.current) : this.current,
    enclosing: enclosing != null ? enclosing(this.enclosing) : this.enclosing,
    startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
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

mixin _$FCalendarDayPickerStyleFunctions on Diagnosticable {
  TextStyle get headerTextStyle;
  FCalendarEntryStyle get current;
  FCalendarEntryStyle get enclosing;
  int? get startDayOfWeek;
  double get tileSize;

  /// Returns itself.
  ///
  /// Allows [FCalendarDayPickerStyle] to replace functions that accept and return a [FCalendarDayPickerStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarDayPickerStyle Function(FCalendarDayPickerStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarDayPickerStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarDayPickerStyle(...));
  /// ```
  @useResult
  FCalendarDayPickerStyle call(Object? _) => this as FCalendarDayPickerStyle;

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
sealed class FCalendarDayPickerStyleDelta with Delta<FCalendarDayPickerStyle> {
  /// Creates a complete replacement for a [FCalendarDayPickerStyle].
  const factory FCalendarDayPickerStyleDelta.replace(FCalendarDayPickerStyle replacement) =
      _FCalendarDayPickerStyleReplace;

  /// Creates a partial modification of a [FCalendarDayPickerStyle].
  const factory FCalendarDayPickerStyleDelta.merge({
    TextStyleDelta? headerTextStyle,
    FCalendarEntryStyleDelta? current,
    FCalendarEntryStyleDelta? enclosing,
    int? Function()? startDayOfWeek,
    double? tileSize,
  }) = _FCalendarDayPickerStyleMerge;
}

class _FCalendarDayPickerStyleReplace implements FCalendarDayPickerStyleDelta {
  const _FCalendarDayPickerStyleReplace(this._replacement);

  final FCalendarDayPickerStyle _replacement;

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle _) => _replacement;
}

class _FCalendarDayPickerStyleMerge implements FCalendarDayPickerStyleDelta {
  const _FCalendarDayPickerStyleMerge({
    this.headerTextStyle,
    this.current,
    this.enclosing,
    this.startDayOfWeek,
    this.tileSize,
  });

  final TextStyleDelta? headerTextStyle;

  final FCalendarEntryStyleDelta? current;

  final FCalendarEntryStyleDelta? enclosing;

  final int? Function()? startDayOfWeek;

  final double? tileSize;

  @override
  FCalendarDayPickerStyle call(FCalendarDayPickerStyle original) => FCalendarDayPickerStyle(
    headerTextStyle: headerTextStyle?.call(original.headerTextStyle) ?? original.headerTextStyle,
    current: current?.call(original.current) ?? original.current,
    enclosing: enclosing?.call(original.enclosing) ?? original.enclosing,
    startDayOfWeek: startDayOfWeek == null ? original.startDayOfWeek : startDayOfWeek!(),
    tileSize: tileSize ?? original.tileSize,
  );
}

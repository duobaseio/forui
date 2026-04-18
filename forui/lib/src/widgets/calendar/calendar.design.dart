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
  /// * [FCalendarStyle.yearMonthPickerStyle] - The year/month picker's style.
  /// * [FCalendarStyle.decoration] - The decoration surrounding the header & picker.
  /// * [FCalendarStyle.padding] - The padding surrounding the header & picker.
  /// * [FCalendarStyle.pageAnimationDuration] - The duration of the page switch animation.
  @useResult
  FCalendarStyle copyWith({
    FCalendarHeaderStyleDelta? headerStyle,
    FCalendarDayPickerStyleDelta? dayPickerStyle,
    FCalendarEntryStyleDelta? yearMonthPickerStyle,
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
    Duration? pageAnimationDuration,
  }) => .new(
    headerStyle: headerStyle?.call(this.headerStyle) ?? this.headerStyle,
    dayPickerStyle: dayPickerStyle?.call(this.dayPickerStyle) ?? this.dayPickerStyle,
    yearMonthPickerStyle: yearMonthPickerStyle?.call(this.yearMonthPickerStyle) ?? this.yearMonthPickerStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    padding: padding?.call(this.padding) ?? this.padding,
    pageAnimationDuration: pageAnimationDuration ?? this.pageAnimationDuration,
  );

  /// Linearly interpolate between this and another [FCalendarStyle] using the given factor [t].
  @useResult
  FCalendarStyle lerp(FCalendarStyle other, double t) => .new(
    headerStyle: headerStyle.lerp(other.headerStyle, t),
    dayPickerStyle: dayPickerStyle.lerp(other.dayPickerStyle, t),
    yearMonthPickerStyle: yearMonthPickerStyle.lerp(other.yearMonthPickerStyle, t),
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
    pageAnimationDuration: t < 0.5 ? pageAnimationDuration : other.pageAnimationDuration,
  );
}

mixin _$FCalendarStyleFunctions on Diagnosticable implements FCalendarStyleDelta {
  /// Returns itself.
  @override
  FCalendarStyle call(Object _) => this as FCalendarStyle;

  FCalendarHeaderStyle get headerStyle;
  FCalendarDayPickerStyle get dayPickerStyle;
  FCalendarEntryStyle get yearMonthPickerStyle;
  Decoration get decoration;
  EdgeInsetsGeometry get padding;
  Duration get pageAnimationDuration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerStyle', headerStyle, level: .debug))
      ..add(DiagnosticsProperty('dayPickerStyle', dayPickerStyle, level: .debug))
      ..add(DiagnosticsProperty('yearMonthPickerStyle', yearMonthPickerStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('pageAnimationDuration', pageAnimationDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarStyle &&
          runtimeType == other.runtimeType &&
          headerStyle == other.headerStyle &&
          dayPickerStyle == other.dayPickerStyle &&
          yearMonthPickerStyle == other.yearMonthPickerStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          pageAnimationDuration == other.pageAnimationDuration);

  @override
  int get hashCode =>
      headerStyle.hashCode ^
      dayPickerStyle.hashCode ^
      yearMonthPickerStyle.hashCode ^
      decoration.hashCode ^
      padding.hashCode ^
      pageAnimationDuration.hashCode;
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
  /// * [FCalendarStyle.yearMonthPickerStyle] - The year/month picker's style.
  /// * [FCalendarStyle.decoration] - The decoration surrounding the header & picker.
  /// * [FCalendarStyle.padding] - The padding surrounding the header & picker.
  /// * [FCalendarStyle.pageAnimationDuration] - The duration of the page switch animation.
  const factory FCalendarStyleDelta.delta({
    FCalendarHeaderStyleDelta? headerStyle,
    FCalendarDayPickerStyleDelta? dayPickerStyle,
    FCalendarEntryStyleDelta? yearMonthPickerStyle,
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
    Duration? pageAnimationDuration,
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
    this.yearMonthPickerStyle,
    this.decoration,
    this.padding,
    this.pageAnimationDuration,
  });

  final FCalendarHeaderStyleDelta? headerStyle;

  final FCalendarDayPickerStyleDelta? dayPickerStyle;

  final FCalendarEntryStyleDelta? yearMonthPickerStyle;

  final DecorationDelta? decoration;

  final EdgeInsetsGeometryDelta? padding;

  final Duration? pageAnimationDuration;

  @override
  FCalendarStyle call(FCalendarStyle original) => FCalendarStyle(
    headerStyle: headerStyle?.call(original.headerStyle) ?? original.headerStyle,
    dayPickerStyle: dayPickerStyle?.call(original.dayPickerStyle) ?? original.dayPickerStyle,
    yearMonthPickerStyle: yearMonthPickerStyle?.call(original.yearMonthPickerStyle) ?? original.yearMonthPickerStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    padding: padding?.call(original.padding) ?? original.padding,
    pageAnimationDuration: pageAnimationDuration ?? original.pageAnimationDuration,
  );
}

class _FCalendarStyleContext implements FCalendarStyleDelta {
  const _FCalendarStyleContext();

  @override
  FCalendarStyle call(FCalendarStyle original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'entry.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarEntryStyleTransformations on FCalendarEntryStyle {
  /// Returns a copy of this [FCalendarEntryStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarEntryStyle.backgroundColor] - The day's background color.
  /// * [FCalendarEntryStyle.borderColor] - The border.
  /// * [FCalendarEntryStyle.textStyle] - The day's text style.
  /// * [FCalendarEntryStyle.radius] - The entry border's radius.
  @useResult
  FCalendarEntryStyle copyWith({
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color?>? borderColor,
    FWidgetStateMap<TextStyle>? textStyle,
    Radius? radius,
  }) => .new(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    borderColor: borderColor ?? this.borderColor,
    textStyle: textStyle ?? this.textStyle,
    radius: radius ?? this.radius,
  );

  /// Linearly interpolate between this and another [FCalendarEntryStyle] using the given factor [t].
  @useResult
  FCalendarEntryStyle lerp(FCalendarEntryStyle other, double t) => .new(
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    borderColor: .lerpWhere(borderColor, other.borderColor, t, Color.lerp),
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    radius: t < 0.5 ? radius : other.radius,
  );
}

mixin _$FCalendarEntryStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color?> get borderColor;
  FWidgetStateMap<TextStyle> get textStyle;
  Radius get radius;

  /// Returns itself.
  ///
  /// Allows [FCalendarEntryStyle] to replace functions that accept and return a [FCalendarEntryStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarEntryStyle Function(FCalendarEntryStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarEntryStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarEntryStyle(...));
  /// ```
  @useResult
  FCalendarEntryStyle call(Object? _) => this as FCalendarEntryStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('radius', radius, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarEntryStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          textStyle == other.textStyle &&
          radius == other.radius);

  @override
  int get hashCode => backgroundColor.hashCode ^ borderColor.hashCode ^ textStyle.hashCode ^ radius.hashCode;
}

/// A delta that applies modifications to a [FCalendarEntryStyle].
sealed class FCalendarEntryStyleDelta with Delta<FCalendarEntryStyle> {
  /// Creates a complete replacement for a [FCalendarEntryStyle].
  const factory FCalendarEntryStyleDelta.replace(FCalendarEntryStyle replacement) = _FCalendarEntryStyleReplace;

  /// Creates a partial modification of a [FCalendarEntryStyle].
  const factory FCalendarEntryStyleDelta.merge({
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color?>? borderColor,
    FWidgetStateMap<TextStyle>? textStyle,
    Radius? radius,
  }) = _FCalendarEntryStyleMerge;
}

class _FCalendarEntryStyleReplace implements FCalendarEntryStyleDelta {
  const _FCalendarEntryStyleReplace(this._replacement);

  final FCalendarEntryStyle _replacement;

  @override
  FCalendarEntryStyle call(FCalendarEntryStyle _) => _replacement;
}

class _FCalendarEntryStyleMerge implements FCalendarEntryStyleDelta {
  const _FCalendarEntryStyleMerge({this.backgroundColor, this.borderColor, this.textStyle, this.radius});

  final FWidgetStateMap<Color>? backgroundColor;

  final FWidgetStateMap<Color?>? borderColor;

  final FWidgetStateMap<TextStyle>? textStyle;

  final Radius? radius;

  @override
  FCalendarEntryStyle call(FCalendarEntryStyle original) => FCalendarEntryStyle(
    backgroundColor: backgroundColor ?? original.backgroundColor,
    borderColor: borderColor ?? original.borderColor,
    textStyle: textStyle ?? original.textStyle,
    radius: radius ?? original.radius,
  );
}

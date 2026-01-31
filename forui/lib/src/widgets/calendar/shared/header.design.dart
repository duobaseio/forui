// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarHeaderStyleTransformations on FCalendarHeaderStyle {
  /// Returns a copy of this [FCalendarHeaderStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarHeaderStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FCalendarHeaderStyle.buttonStyle] - The button style.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The header's text style.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  @useResult
  FCalendarHeaderStyle copyWith({
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FButtonStyle Function(FButtonStyle style)? buttonStyle,
    TextStyle? headerTextStyle,
    Duration? animationDuration,
  }) => .new(
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    buttonStyle: buttonStyle != null ? buttonStyle(this.buttonStyle) : this.buttonStyle,
    headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    animationDuration: animationDuration ?? this.animationDuration,
  );

  /// Linearly interpolate between this and another [FCalendarHeaderStyle] using the given factor [t].
  @useResult
  FCalendarHeaderStyle lerp(FCalendarHeaderStyle other, double t) => .new(
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    buttonStyle: buttonStyle.lerp(other.buttonStyle, t),
    headerTextStyle: .lerp(headerTextStyle, other.headerTextStyle, t) ?? headerTextStyle,
    animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
  );
}

mixin _$FCalendarHeaderStyleFunctions on Diagnosticable {
  FFocusedOutlineStyle get focusedOutlineStyle;
  FButtonStyle get buttonStyle;
  TextStyle get headerTextStyle;
  Duration get animationDuration;

  /// Returns itself.
  ///
  /// Allows [FCalendarHeaderStyle] to replace functions that accept and return a [FCalendarHeaderStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarHeaderStyle Function(FCalendarHeaderStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarHeaderStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarHeaderStyle(...));
  /// ```
  @useResult
  FCalendarHeaderStyle call(Object? _) => this as FCalendarHeaderStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('buttonStyle', buttonStyle, level: .debug))
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle, level: .debug))
      ..add(DiagnosticsProperty('animationDuration', animationDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarHeaderStyle &&
          runtimeType == other.runtimeType &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          buttonStyle == other.buttonStyle &&
          headerTextStyle == other.headerTextStyle &&
          animationDuration == other.animationDuration);

  @override
  int get hashCode =>
      focusedOutlineStyle.hashCode ^ buttonStyle.hashCode ^ headerTextStyle.hashCode ^ animationDuration.hashCode;
}

/// A delta that applies modifications to a [FCalendarHeaderStyle].
sealed class FCalendarHeaderStyleDelta with Delta<FCalendarHeaderStyle> {
  /// Creates a complete replacement for a [FCalendarHeaderStyle].
  const factory FCalendarHeaderStyleDelta.replace(FCalendarHeaderStyle replacement) = _FCalendarHeaderStyleReplace;

  /// Creates a partial modification of a [FCalendarHeaderStyle].
  const factory FCalendarHeaderStyleDelta.merge({
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    TextStyleDelta? headerTextStyle,
    Duration? animationDuration,
  }) = _FCalendarHeaderStyleMerge;
}

class _FCalendarHeaderStyleReplace implements FCalendarHeaderStyleDelta {
  const _FCalendarHeaderStyleReplace(this._replacement);

  final FCalendarHeaderStyle _replacement;

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle _) => _replacement;
}

class _FCalendarHeaderStyleMerge implements FCalendarHeaderStyleDelta {
  const _FCalendarHeaderStyleMerge({
    this.focusedOutlineStyle,
    this.buttonStyle,
    this.headerTextStyle,
    this.animationDuration,
  });

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FButtonStyleDelta? buttonStyle;

  final TextStyleDelta? headerTextStyle;

  final Duration? animationDuration;

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle original) => FCalendarHeaderStyle(
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    buttonStyle: buttonStyle?.call(original.buttonStyle) ?? original.buttonStyle,
    headerTextStyle: headerTextStyle?.call(original.headerTextStyle) ?? original.headerTextStyle,
    animationDuration: animationDuration ?? original.animationDuration,
  );
}

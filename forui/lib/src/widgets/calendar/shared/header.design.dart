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
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarHeaderStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FCalendarHeaderStyle.buttonStyle] - The button style.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The header's text style.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  @useResult
  FCalendarHeaderStyle copyWith({
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    TextStyleDelta? headerTextStyle,
    Duration? animationDuration,
  }) => .new(
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    buttonStyle: buttonStyle?.call(this.buttonStyle) ?? this.buttonStyle,
    headerTextStyle: headerTextStyle?.call(this.headerTextStyle) ?? this.headerTextStyle,
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

mixin _$FCalendarHeaderStyleFunctions on Diagnosticable implements FCalendarHeaderStyleDelta {
  /// Returns itself.
  @override
  FCalendarHeaderStyle call(Object _) => this as FCalendarHeaderStyle;

  FFocusedOutlineStyle get focusedOutlineStyle;
  FButtonStyle get buttonStyle;
  TextStyle get headerTextStyle;
  Duration get animationDuration;
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
///
/// A [FCalendarHeaderStyle] is itself a [FCalendarHeaderStyleDelta].
abstract class FCalendarHeaderStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarHeaderStyle].
  ///
  /// ## Parameters
  /// * [FCalendarHeaderStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FCalendarHeaderStyle.buttonStyle] - The button style.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The header's text style.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  const factory FCalendarHeaderStyleDelta.delta({
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    TextStyleDelta? headerTextStyle,
    Duration? animationDuration,
  }) = _FCalendarHeaderStyleDelta;

  /// Creates a delta that returns the [FCalendarHeaderStyle] in the current context.
  const factory FCalendarHeaderStyleDelta.context() = _FCalendarHeaderStyleContext;

  @override
  FCalendarHeaderStyle call(covariant FCalendarHeaderStyle value);
}

class _FCalendarHeaderStyleDelta implements FCalendarHeaderStyleDelta {
  const _FCalendarHeaderStyleDelta({
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

class _FCalendarHeaderStyleContext implements FCalendarHeaderStyleDelta {
  const _FCalendarHeaderStyleContext();

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle original) => original;
}

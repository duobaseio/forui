// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'avatar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAvatarStyleTransformations on FAvatarStyle {
  /// Returns a copy of this [FAvatarStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAvatarStyle.backgroundColor] - The fallback's background color.
  /// * [FAvatarStyle.foregroundColor] - The fallback's color.
  /// * [FAvatarStyle.textStyle] - The text style for the fallback text.
  /// * [FAvatarStyle.fadeInDuration] - Duration for the transition animation.
  @useResult
  FAvatarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyleDelta? textStyle,
    Duration? fadeInDuration,
  }) => .new(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    fadeInDuration: fadeInDuration ?? this.fadeInDuration,
  );

  /// Linearly interpolate between this and another [FAvatarStyle] using the given factor [t].
  @useResult
  FAvatarStyle lerp(FAvatarStyle other, double t) => .new(
    backgroundColor: FColors.lerpColor(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
    foregroundColor: FColors.lerpColor(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    fadeInDuration: t < 0.5 ? fadeInDuration : other.fadeInDuration,
  );
}

mixin _$FAvatarStyleFunctions on Diagnosticable implements FAvatarStyleDelta {
  /// Returns itself.
  @override
  FAvatarStyle call(Object _) => this as FAvatarStyle;

  Color get backgroundColor;
  Color get foregroundColor;
  TextStyle get textStyle;
  Duration get fadeInDuration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(ColorProperty('foregroundColor', foregroundColor, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAvatarStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          textStyle == other.textStyle &&
          fadeInDuration == other.fadeInDuration);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^ foregroundColor.hashCode ^ textStyle.hashCode ^ fadeInDuration.hashCode;
}

/// A delta that applies modifications to a [FAvatarStyle].
///
/// A [FAvatarStyle] is itself a [FAvatarStyleDelta].
abstract class FAvatarStyleDelta with Delta {
  /// Creates a partial modification of a [FAvatarStyle].
  ///
  /// ## Parameters
  /// * [FAvatarStyle.backgroundColor] - The fallback's background color.
  /// * [FAvatarStyle.foregroundColor] - The fallback's color.
  /// * [FAvatarStyle.textStyle] - The text style for the fallback text.
  /// * [FAvatarStyle.fadeInDuration] - Duration for the transition animation.
  const factory FAvatarStyleDelta.delta({
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyleDelta? textStyle,
    Duration? fadeInDuration,
  }) = _FAvatarStyleDelta;

  /// Creates a delta that returns the [FAvatarStyle] in the current context.
  const factory FAvatarStyleDelta.context() = _FAvatarStyleContext;

  @override
  FAvatarStyle call(covariant FAvatarStyle value);
}

class _FAvatarStyleDelta implements FAvatarStyleDelta {
  const _FAvatarStyleDelta({this.backgroundColor, this.foregroundColor, this.textStyle, this.fadeInDuration});

  final Color? backgroundColor;

  final Color? foregroundColor;

  final TextStyleDelta? textStyle;

  final Duration? fadeInDuration;

  @override
  FAvatarStyle call(FAvatarStyle original) => FAvatarStyle(
    backgroundColor: backgroundColor ?? original.backgroundColor,
    foregroundColor: foregroundColor ?? original.foregroundColor,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    fadeInDuration: fadeInDuration ?? original.fadeInDuration,
  );
}

class _FAvatarStyleContext implements FAvatarStyleDelta {
  const _FAvatarStyleContext();

  @override
  FAvatarStyle call(FAvatarStyle original) => original;
}

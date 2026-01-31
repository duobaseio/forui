// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'radio.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FRadioStyleTransformations on FRadioStyle {
  /// Returns a copy of this [FRadioStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FRadioStyle.tappableStyle] - The tappable style.
  /// * [FRadioStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FRadioStyle.borderColor] - The [FRadio]'s border color.
  /// * [FRadioStyle.backgroundColor] - The [FRadio]'s background color.
  /// * [FRadioStyle.indicatorColor] - The [FRadio]'s indicator color.
  /// * [FRadioStyle.motion] - The motion-related properties.
  /// * [FRadioStyle.labelPadding] - The label's padding.
  /// * [FRadioStyle.descriptionPadding] - The description's padding.
  /// * [FRadioStyle.errorPadding] - The error's padding.
  /// * [FRadioStyle.childPadding] - The child's padding.
  /// * [FRadioStyle.labelTextStyle] - The label's text style.
  /// * [FRadioStyle.descriptionTextStyle] - The description's text style.
  /// * [FRadioStyle.errorTextStyle] - The error's text style.
  @useResult
  FRadioStyle copyWith({
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FWidgetStateMap<Color>? borderColor,
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color>? indicatorColor,
    FRadioMotion Function(FRadioMotion motion)? motion,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => .new(
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    borderColor: borderColor ?? this.borderColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    indicatorColor: indicatorColor ?? this.indicatorColor,
    motion: motion != null ? motion(this.motion) : this.motion,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FRadioStyle] using the given factor [t].
  @useResult
  FRadioStyle lerp(FRadioStyle other, double t) => .new(
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    borderColor: .lerpColor(borderColor, other.borderColor, t),
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    indicatorColor: .lerpColor(indicatorColor, other.indicatorColor, t),
    motion: motion.lerp(other.motion, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FRadioStyleFunctions on Diagnosticable {
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FWidgetStateMap<Color> get borderColor;
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color> get indicatorColor;
  FRadioMotion get motion;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FRadioStyle] to replace functions that accept and return a [FRadioStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FRadioStyle Function(FRadioStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FRadioStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FRadioStyle(...));
  /// ```
  @useResult
  FRadioStyle call(Object? _) => this as FRadioStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('indicatorColor', indicatorColor, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioStyle &&
          runtimeType == other.runtimeType &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          borderColor == other.borderColor &&
          backgroundColor == other.backgroundColor &&
          indicatorColor == other.indicatorColor &&
          motion == other.motion &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      borderColor.hashCode ^
      backgroundColor.hashCode ^
      indicatorColor.hashCode ^
      motion.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FRadioStyle].
sealed class FRadioStyleDelta with Delta<FRadioStyle> {
  /// Creates a complete replacement for a [FRadioStyle].
  const factory FRadioStyleDelta.replace(FRadioStyle replacement) = _FRadioStyleReplace;

  /// Creates a partial modification of a [FRadioStyle].
  const factory FRadioStyleDelta.merge({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FWidgetStateMap<Color>? borderColor,
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color>? indicatorColor,
    FRadioMotionDelta? motion,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyleDelta? errorTextStyle,
  }) = _FRadioStyleMerge;
}

class _FRadioStyleReplace implements FRadioStyleDelta {
  const _FRadioStyleReplace(this._replacement);

  final FRadioStyle _replacement;

  @override
  FRadioStyle call(FRadioStyle _) => _replacement;
}

class _FRadioStyleMerge implements FRadioStyleDelta {
  const _FRadioStyleMerge({
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.borderColor,
    this.backgroundColor,
    this.indicatorColor,
    this.motion,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FWidgetStateMap<Color>? borderColor;

  final FWidgetStateMap<Color>? backgroundColor;

  final FWidgetStateMap<Color>? indicatorColor;

  final FRadioMotionDelta? motion;

  final EdgeInsetsGeometry? labelPadding;

  final EdgeInsetsGeometry? descriptionPadding;

  final EdgeInsetsGeometry? errorPadding;

  final EdgeInsetsGeometry? childPadding;

  final FWidgetStateMap<TextStyle>? labelTextStyle;

  final FWidgetStateMap<TextStyle>? descriptionTextStyle;

  final TextStyleDelta? errorTextStyle;

  @override
  FRadioStyle call(FRadioStyle original) => FRadioStyle(
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    borderColor: borderColor ?? original.borderColor,
    backgroundColor: backgroundColor ?? original.backgroundColor,
    indicatorColor: indicatorColor ?? original.indicatorColor,
    motion: motion?.call(original.motion) ?? original.motion,
    labelPadding: labelPadding ?? original.labelPadding,
    descriptionPadding: descriptionPadding ?? original.descriptionPadding,
    errorPadding: errorPadding ?? original.errorPadding,
    childPadding: childPadding ?? original.childPadding,
    labelTextStyle: labelTextStyle ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FRadioMotionTransformations on FRadioMotion {
  /// Returns a copy of this [FRadioMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FRadioMotion.duration] - The duration of the animation when selected.
  /// * [FRadioMotion.reverseDuration] - The duration of the reverse animation when unselected.
  /// * [FRadioMotion.curve] - The curve of the animation.
  @useResult
  FRadioMotion copyWith({Duration? duration, Duration? reverseDuration, Curve? curve}) => .new(
    duration: duration ?? this.duration,
    reverseDuration: reverseDuration ?? this.reverseDuration,
    curve: curve ?? this.curve,
  );

  /// Linearly interpolate between this and another [FRadioMotion] using the given factor [t].
  @useResult
  FRadioMotion lerp(FRadioMotion other, double t) => .new(
    duration: t < 0.5 ? duration : other.duration,
    reverseDuration: t < 0.5 ? reverseDuration : other.reverseDuration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FRadioMotionFunctions on Diagnosticable {
  Duration get duration;
  Duration get reverseDuration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FRadioMotion call(Object? _) => this as FRadioMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('reverseDuration', reverseDuration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioMotion &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          reverseDuration == other.reverseDuration &&
          curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ reverseDuration.hashCode ^ curve.hashCode;
}

/// A delta that applies modifications to a [FRadioMotion].
sealed class FRadioMotionDelta with Delta<FRadioMotion> {
  /// Creates a complete replacement for a [FRadioMotion].
  const factory FRadioMotionDelta.replace(FRadioMotion replacement) = _FRadioMotionReplace;

  /// Creates a partial modification of a [FRadioMotion].
  const factory FRadioMotionDelta.merge({Duration? duration, Duration? reverseDuration, Curve? curve}) =
      _FRadioMotionMerge;
}

class _FRadioMotionReplace implements FRadioMotionDelta {
  const _FRadioMotionReplace(this._replacement);

  final FRadioMotion _replacement;

  @override
  FRadioMotion call(FRadioMotion _) => _replacement;
}

class _FRadioMotionMerge implements FRadioMotionDelta {
  const _FRadioMotionMerge({this.duration, this.reverseDuration, this.curve});

  final Duration? duration;

  final Duration? reverseDuration;

  final Curve? curve;

  @override
  FRadioMotion call(FRadioMotion original) => FRadioMotion(
    duration: duration ?? original.duration,
    reverseDuration: reverseDuration ?? original.reverseDuration,
    curve: curve ?? original.curve,
  );
}

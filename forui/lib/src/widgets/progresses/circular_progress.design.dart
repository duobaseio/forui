// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'circular_progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCircularProgressStyleTransformations on FCircularProgressStyle {
  /// Returns a copy of this [FCircularProgressStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCircularProgressStyle.iconStyle] - The circular progress's style.
  /// * [FCircularProgressStyle.motion] - The motion-related properties.
  @useResult
  FCircularProgressStyle copyWith({
    IconThemeData? iconStyle,
    FCircularProgressMotion Function(FCircularProgressMotion motion)? motion,
  }) => .new(iconStyle: iconStyle ?? this.iconStyle, motion: motion != null ? motion(this.motion) : this.motion);

  /// Linearly interpolate between this and another [FCircularProgressStyle] using the given factor [t].
  @useResult
  FCircularProgressStyle lerp(FCircularProgressStyle other, double t) =>
      .new(iconStyle: .lerp(iconStyle, other.iconStyle, t), motion: motion.lerp(other.motion, t));
}

mixin _$FCircularProgressStyleFunctions on Diagnosticable {
  IconThemeData get iconStyle;
  FCircularProgressMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FCircularProgressStyle] to replace functions that accept and return a [FCircularProgressStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCircularProgressStyle Function(FCircularProgressStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCircularProgressStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCircularProgressStyle(...));
  /// ```
  @useResult
  FCircularProgressStyle call(Object? _) => this as FCircularProgressStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCircularProgressStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          motion == other.motion);

  @override
  int get hashCode => iconStyle.hashCode ^ motion.hashCode;
}

/// A delta that applies modifications to a [FCircularProgressStyle].
sealed class FCircularProgressStyleDelta with Delta<FCircularProgressStyle> {
  /// Creates a complete replacement for a [FCircularProgressStyle].
  const factory FCircularProgressStyleDelta.replace(FCircularProgressStyle replacement) =
      _FCircularProgressStyleReplace;

  /// Creates a partial modification of a [FCircularProgressStyle].
  const factory FCircularProgressStyleDelta.merge({
    IconThemeDataDelta? iconStyle,
    FCircularProgressMotionDelta? motion,
  }) = _FCircularProgressStyleMerge;
}

class _FCircularProgressStyleReplace implements FCircularProgressStyleDelta {
  const _FCircularProgressStyleReplace(this._replacement);

  final FCircularProgressStyle _replacement;

  @override
  FCircularProgressStyle call(FCircularProgressStyle _) => _replacement;
}

class _FCircularProgressStyleMerge implements FCircularProgressStyleDelta {
  const _FCircularProgressStyleMerge({this.iconStyle, this.motion});

  final IconThemeDataDelta? iconStyle;

  final FCircularProgressMotionDelta? motion;

  @override
  FCircularProgressStyle call(FCircularProgressStyle original) => FCircularProgressStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FCircularProgressMotionTransformations on FCircularProgressMotion {
  /// Returns a copy of this [FCircularProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FCircularProgressMotion.duration] - The duration of one full rotation.
  /// * [FCircularProgressMotion.curve] - The animation curve.
  /// * [FCircularProgressMotion.tween] - The rotation's tween.
  @useResult
  FCircularProgressMotion copyWith({Duration? duration, Curve? curve, Animatable<double>? tween}) =>
      .new(duration: duration ?? this.duration, curve: curve ?? this.curve, tween: tween ?? this.tween);

  /// Linearly interpolate between this and another [FCircularProgressMotion] using the given factor [t].
  @useResult
  FCircularProgressMotion lerp(FCircularProgressMotion other, double t) => .new(
    duration: t < 0.5 ? duration : other.duration,
    curve: t < 0.5 ? curve : other.curve,
    tween: t < 0.5 ? tween : other.tween,
  );
}

mixin _$FCircularProgressMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;
  Animatable<double> get tween;

  /// Returns itself.
  @useResult
  FCircularProgressMotion call(Object? _) => this as FCircularProgressMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug))
      ..add(DiagnosticsProperty('tween', tween, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCircularProgressMotion &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve &&
          tween == other.tween);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode ^ tween.hashCode;
}

/// A delta that applies modifications to a [FCircularProgressMotion].
sealed class FCircularProgressMotionDelta with Delta<FCircularProgressMotion> {
  /// Creates a complete replacement for a [FCircularProgressMotion].
  const factory FCircularProgressMotionDelta.replace(FCircularProgressMotion replacement) =
      _FCircularProgressMotionReplace;

  /// Creates a partial modification of a [FCircularProgressMotion].
  const factory FCircularProgressMotionDelta.merge({Duration? duration, Curve? curve, Animatable<double>? tween}) =
      _FCircularProgressMotionMerge;
}

class _FCircularProgressMotionReplace implements FCircularProgressMotionDelta {
  const _FCircularProgressMotionReplace(this._replacement);

  final FCircularProgressMotion _replacement;

  @override
  FCircularProgressMotion call(FCircularProgressMotion _) => _replacement;
}

class _FCircularProgressMotionMerge implements FCircularProgressMotionDelta {
  const _FCircularProgressMotionMerge({this.duration, this.curve, this.tween});

  final Duration? duration;

  final Curve? curve;

  final Animatable<double>? tween;

  @override
  FCircularProgressMotion call(FCircularProgressMotion original) => FCircularProgressMotion(
    duration: duration ?? original.duration,
    curve: curve ?? original.curve,
    tween: tween ?? original.tween,
  );
}

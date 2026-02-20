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
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCircularProgressStyle.iconStyle] - The circular progress's style.
  /// * [FCircularProgressStyle.motion] - The motion-related properties.
  @useResult
  FCircularProgressStyle copyWith({IconThemeDataDelta? iconStyle, FCircularProgressMotionDelta? motion}) => .new(
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FCircularProgressStyle] using the given factor [t].
  @useResult
  FCircularProgressStyle lerp(FCircularProgressStyle other, double t) =>
      .new(iconStyle: .lerp(iconStyle, other.iconStyle, t), motion: motion.lerp(other.motion, t));
}

mixin _$FCircularProgressStyleFunctions on Diagnosticable implements FCircularProgressStyleDelta {
  /// Returns itself.
  @override
  FCircularProgressStyle call(Object _) => this as FCircularProgressStyle;

  IconThemeData get iconStyle;
  FCircularProgressMotion get motion;
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
///
/// A [FCircularProgressStyle] is itself a [FCircularProgressStyleDelta].
abstract class FCircularProgressStyleDelta with Delta {
  /// Creates a partial modification of a [FCircularProgressStyle].
  ///
  /// ## Parameters
  /// * [FCircularProgressStyle.iconStyle] - The circular progress's style.
  /// * [FCircularProgressStyle.motion] - The motion-related properties.
  const factory FCircularProgressStyleDelta.delta({
    IconThemeDataDelta? iconStyle,
    FCircularProgressMotionDelta? motion,
  }) = _FCircularProgressStyleDelta;

  /// Creates a delta that returns the [FCircularProgressStyle] in the current context.
  const factory FCircularProgressStyleDelta.context() = _FCircularProgressStyleContext;

  @override
  FCircularProgressStyle call(covariant FCircularProgressStyle value);
}

class _FCircularProgressStyleDelta implements FCircularProgressStyleDelta {
  const _FCircularProgressStyleDelta({this.iconStyle, this.motion});

  final IconThemeDataDelta? iconStyle;

  final FCircularProgressMotionDelta? motion;

  @override
  FCircularProgressStyle call(FCircularProgressStyle original) => FCircularProgressStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FCircularProgressStyleContext implements FCircularProgressStyleDelta {
  const _FCircularProgressStyleContext();

  @override
  FCircularProgressStyle call(FCircularProgressStyle original) => original;
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

mixin _$FCircularProgressMotionFunctions on Diagnosticable implements FCircularProgressMotionDelta {
  /// Returns itself.
  @override
  FCircularProgressMotion call(Object _) => this as FCircularProgressMotion;

  Duration get duration;
  Curve get curve;
  Animatable<double> get tween;
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
///
/// A [FCircularProgressMotion] is itself a [FCircularProgressMotionDelta].
abstract class FCircularProgressMotionDelta with Delta {
  /// Creates a partial modification of a [FCircularProgressMotion].
  ///
  /// ## Parameters
  /// * [FCircularProgressMotion.duration] - The duration of one full rotation.
  /// * [FCircularProgressMotion.curve] - The animation curve.
  /// * [FCircularProgressMotion.tween] - The rotation's tween.
  const factory FCircularProgressMotionDelta.delta({Duration? duration, Curve? curve, Animatable<double>? tween}) =
      _FCircularProgressMotionDelta;

  /// Creates a delta that returns the [FCircularProgressMotion] in the current context.
  const factory FCircularProgressMotionDelta.context() = _FCircularProgressMotionContext;

  @override
  FCircularProgressMotion call(covariant FCircularProgressMotion value);
}

class _FCircularProgressMotionDelta implements FCircularProgressMotionDelta {
  const _FCircularProgressMotionDelta({this.duration, this.curve, this.tween});

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

class _FCircularProgressMotionContext implements FCircularProgressMotionDelta {
  const _FCircularProgressMotionContext();

  @override
  FCircularProgressMotion call(FCircularProgressMotion original) => original;
}

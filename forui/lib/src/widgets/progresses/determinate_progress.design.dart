// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'determinate_progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDeterminateProgressStyleTransformations on FDeterminateProgressStyle {
  /// Returns a copy of this [FDeterminateProgressStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FDeterminateProgressStyle.trackDecoration] - The track's decoration.
  /// * [FDeterminateProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FDeterminateProgressStyle.constraints] - The linear progress's constraints.
  /// * [FDeterminateProgressStyle.motion] - The motion-related properties for an indeterminate [FDeterminateProgress].
  @useResult
  FDeterminateProgressStyle copyWith({
    DecorationDelta? trackDecoration,
    DecorationDelta? fillDecoration,
    BoxConstraints? constraints,
    FDeterminateProgressMotionDelta? motion,
  }) => .new(
    trackDecoration: trackDecoration?.call(this.trackDecoration) ?? this.trackDecoration,
    fillDecoration: fillDecoration?.call(this.fillDecoration) ?? this.fillDecoration,
    constraints: constraints ?? this.constraints,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FDeterminateProgressStyle] using the given factor [t].
  @useResult
  FDeterminateProgressStyle lerp(FDeterminateProgressStyle other, double t) => .new(
    trackDecoration: .lerp(trackDecoration, other.trackDecoration, t) ?? trackDecoration,
    fillDecoration: .lerp(fillDecoration, other.fillDecoration, t) ?? fillDecoration,
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FDeterminateProgressStyleFunctions on Diagnosticable implements FDeterminateProgressStyleDelta {
  /// Returns itself.
  @override
  FDeterminateProgressStyle call(Object _) => this as FDeterminateProgressStyle;

  Decoration get trackDecoration;
  Decoration get fillDecoration;
  BoxConstraints get constraints;
  FDeterminateProgressMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('trackDecoration', trackDecoration, level: .debug))
      ..add(DiagnosticsProperty('fillDecoration', fillDecoration, level: .debug))
      ..add(DiagnosticsProperty('constraints', constraints, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDeterminateProgressStyle &&
          runtimeType == other.runtimeType &&
          trackDecoration == other.trackDecoration &&
          fillDecoration == other.fillDecoration &&
          constraints == other.constraints &&
          motion == other.motion);

  @override
  int get hashCode => trackDecoration.hashCode ^ fillDecoration.hashCode ^ constraints.hashCode ^ motion.hashCode;
}

/// A delta that applies modifications to a [FDeterminateProgressStyle].
///
/// A [FDeterminateProgressStyle] is itself a [FDeterminateProgressStyleDelta].
abstract class FDeterminateProgressStyleDelta with Delta {
  /// Creates a partial modification of a [FDeterminateProgressStyle].
  ///
  /// ## Parameters
  /// * [FDeterminateProgressStyle.trackDecoration] - The track's decoration.
  /// * [FDeterminateProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FDeterminateProgressStyle.constraints] - The linear progress's constraints.
  /// * [FDeterminateProgressStyle.motion] - The motion-related properties for an indeterminate [FDeterminateProgress].
  const factory delta({
    DecorationDelta? trackDecoration,
    DecorationDelta? fillDecoration,
    BoxConstraints? constraints,
    FDeterminateProgressMotionDelta? motion,
  }) = _FDeterminateProgressStyleDelta;

  /// Creates a delta that returns the [FDeterminateProgressStyle] in the current context.
  const factory context() = _FDeterminateProgressStyleContext;

  @override
  FDeterminateProgressStyle call(covariant FDeterminateProgressStyle value);
}

class _FDeterminateProgressStyleDelta implements FDeterminateProgressStyleDelta {
  const new({this.trackDecoration, this.fillDecoration, this.constraints, this.motion});

  final DecorationDelta? trackDecoration;

  final DecorationDelta? fillDecoration;

  final BoxConstraints? constraints;

  final FDeterminateProgressMotionDelta? motion;

  @override
  FDeterminateProgressStyle call(FDeterminateProgressStyle original) => FDeterminateProgressStyle(
    trackDecoration: trackDecoration?.call(original.trackDecoration) ?? original.trackDecoration,
    fillDecoration: fillDecoration?.call(original.fillDecoration) ?? original.fillDecoration,
    constraints: constraints ?? original.constraints,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FDeterminateProgressStyleContext implements FDeterminateProgressStyleDelta {
  const new();

  @override
  FDeterminateProgressStyle call(FDeterminateProgressStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDeterminateProgressMotionTransformations on FDeterminateProgressMotion {
  /// Returns a copy of this [FDeterminateProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDeterminateProgressMotion.duration] - The animation's duration.
  /// * [FDeterminateProgressMotion.curve] - The animation curve.
  @useResult
  FDeterminateProgressMotion copyWith({Duration? duration, Curve? curve}) =>
      .new(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FDeterminateProgressMotion] using the given factor [t].
  @useResult
  FDeterminateProgressMotion lerp(FDeterminateProgressMotion other, double t) =>
      .new(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FDeterminateProgressMotionFunctions on Diagnosticable implements FDeterminateProgressMotionDelta {
  /// Returns itself.
  @override
  FDeterminateProgressMotion call(Object _) => this as FDeterminateProgressMotion;

  Duration get duration;
  Curve get curve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDeterminateProgressMotion &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

/// A delta that applies modifications to a [FDeterminateProgressMotion].
///
/// A [FDeterminateProgressMotion] is itself a [FDeterminateProgressMotionDelta].
abstract class FDeterminateProgressMotionDelta with Delta {
  /// Creates a partial modification of a [FDeterminateProgressMotion].
  ///
  /// ## Parameters
  /// * [FDeterminateProgressMotion.duration] - The animation's duration.
  /// * [FDeterminateProgressMotion.curve] - The animation curve.
  const factory delta({Duration? duration, Curve? curve}) = _FDeterminateProgressMotionDelta;

  /// Creates a delta that returns the [FDeterminateProgressMotion] in the current context.
  const factory context() = _FDeterminateProgressMotionContext;

  @override
  FDeterminateProgressMotion call(covariant FDeterminateProgressMotion value);
}

class _FDeterminateProgressMotionDelta implements FDeterminateProgressMotionDelta {
  const new({this.duration, this.curve});

  final Duration? duration;

  final Curve? curve;

  @override
  FDeterminateProgressMotion call(FDeterminateProgressMotion original) =>
      FDeterminateProgressMotion(duration: duration ?? original.duration, curve: curve ?? original.curve);
}

class _FDeterminateProgressMotionContext implements FDeterminateProgressMotionDelta {
  const new();

  @override
  FDeterminateProgressMotion call(FDeterminateProgressMotion original) => original;
}

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
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDeterminateProgressStyle.constraints] - The linear progress's constraints.
  /// * [FDeterminateProgressStyle.trackDecoration] - The track's decoration.
  /// * [FDeterminateProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FDeterminateProgressStyle.motion] - The motion-related properties for an indeterminate [FDeterminateProgress].
  @useResult
  FDeterminateProgressStyle copyWith({
    BoxConstraints? constraints,
    BoxDecoration? trackDecoration,
    BoxDecoration? fillDecoration,
    FDeterminateProgressMotion Function(FDeterminateProgressMotion motion)? motion,
  }) => .new(
    constraints: constraints ?? this.constraints,
    trackDecoration: trackDecoration ?? this.trackDecoration,
    fillDecoration: fillDecoration ?? this.fillDecoration,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FDeterminateProgressStyle] using the given factor [t].
  @useResult
  FDeterminateProgressStyle lerp(FDeterminateProgressStyle other, double t) => .new(
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    trackDecoration: .lerp(trackDecoration, other.trackDecoration, t) ?? trackDecoration,
    fillDecoration: .lerp(fillDecoration, other.fillDecoration, t) ?? fillDecoration,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FDeterminateProgressStyleFunctions on Diagnosticable {
  BoxConstraints get constraints;
  BoxDecoration get trackDecoration;
  BoxDecoration get fillDecoration;
  FDeterminateProgressMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FDeterminateProgressStyle] to replace functions that accept and return a [FDeterminateProgressStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDeterminateProgressStyle Function(FDeterminateProgressStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDeterminateProgressStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDeterminateProgressStyle(...));
  /// ```
  @useResult
  FDeterminateProgressStyle call(Object? _) => this as FDeterminateProgressStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('constraints', constraints, level: .debug))
      ..add(DiagnosticsProperty('trackDecoration', trackDecoration, level: .debug))
      ..add(DiagnosticsProperty('fillDecoration', fillDecoration, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDeterminateProgressStyle &&
          runtimeType == other.runtimeType &&
          constraints == other.constraints &&
          trackDecoration == other.trackDecoration &&
          fillDecoration == other.fillDecoration &&
          motion == other.motion);

  @override
  int get hashCode => constraints.hashCode ^ trackDecoration.hashCode ^ fillDecoration.hashCode ^ motion.hashCode;
}

/// A delta that applies modifications to a [FDeterminateProgressStyle].
sealed class FDeterminateProgressStyleDelta with Delta<FDeterminateProgressStyle> {
  /// Creates a complete replacement for a [FDeterminateProgressStyle].
  const factory FDeterminateProgressStyleDelta.replace(FDeterminateProgressStyle replacement) =
      _FDeterminateProgressStyleReplace;

  /// Creates a partial modification of a [FDeterminateProgressStyle].
  const factory FDeterminateProgressStyleDelta.merge({
    BoxConstraints? constraints,
    BoxDecorationDelta? trackDecoration,
    BoxDecorationDelta? fillDecoration,
    FDeterminateProgressMotionDelta? motion,
  }) = _FDeterminateProgressStyleMerge;
}

class _FDeterminateProgressStyleReplace implements FDeterminateProgressStyleDelta {
  const _FDeterminateProgressStyleReplace(this._replacement);

  final FDeterminateProgressStyle _replacement;

  @override
  FDeterminateProgressStyle call(FDeterminateProgressStyle _) => _replacement;
}

class _FDeterminateProgressStyleMerge implements FDeterminateProgressStyleDelta {
  const _FDeterminateProgressStyleMerge({this.constraints, this.trackDecoration, this.fillDecoration, this.motion});

  final BoxConstraints? constraints;

  final BoxDecorationDelta? trackDecoration;

  final BoxDecorationDelta? fillDecoration;

  final FDeterminateProgressMotionDelta? motion;

  @override
  FDeterminateProgressStyle call(FDeterminateProgressStyle original) => FDeterminateProgressStyle(
    constraints: constraints ?? original.constraints,
    trackDecoration: trackDecoration?.call(original.trackDecoration) ?? original.trackDecoration,
    fillDecoration: fillDecoration?.call(original.fillDecoration) ?? original.fillDecoration,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FDeterminateProgressMotionTransformations on FDeterminateProgressMotion {
  /// Returns a copy of this [FDeterminateProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDeterminateProgressMotion.duration] - The animation's duration for a full progress from 0.0 to 1.0.
  /// * [FDeterminateProgressMotion.curve] - The animation curve.
  @useResult
  FDeterminateProgressMotion copyWith({Duration? duration, Curve? curve}) =>
      .new(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FDeterminateProgressMotion] using the given factor [t].
  @useResult
  FDeterminateProgressMotion lerp(FDeterminateProgressMotion other, double t) =>
      .new(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FDeterminateProgressMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FDeterminateProgressMotion call(Object? _) => this as FDeterminateProgressMotion;

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
sealed class FDeterminateProgressMotionDelta with Delta<FDeterminateProgressMotion> {
  /// Creates a complete replacement for a [FDeterminateProgressMotion].
  const factory FDeterminateProgressMotionDelta.replace(FDeterminateProgressMotion replacement) =
      _FDeterminateProgressMotionReplace;

  /// Creates a partial modification of a [FDeterminateProgressMotion].
  const factory FDeterminateProgressMotionDelta.merge({Duration? duration, Curve? curve}) =
      _FDeterminateProgressMotionMerge;
}

class _FDeterminateProgressMotionReplace implements FDeterminateProgressMotionDelta {
  const _FDeterminateProgressMotionReplace(this._replacement);

  final FDeterminateProgressMotion _replacement;

  @override
  FDeterminateProgressMotion call(FDeterminateProgressMotion _) => _replacement;
}

class _FDeterminateProgressMotionMerge implements FDeterminateProgressMotionDelta {
  const _FDeterminateProgressMotionMerge({this.duration, this.curve});

  final Duration? duration;

  final Curve? curve;

  @override
  FDeterminateProgressMotion call(FDeterminateProgressMotion original) =>
      FDeterminateProgressMotion(duration: duration ?? original.duration, curve: curve ?? original.curve);
}

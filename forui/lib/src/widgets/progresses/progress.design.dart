// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FProgressStyleTransformations on FProgressStyle {
  /// Returns a copy of this [FProgressStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FProgressStyle.constraints] - The linear progress's constraints.
  /// * [FProgressStyle.trackDecoration] - The track's decoration.
  /// * [FProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FProgressStyle.motion] - The motion-related properties for an indeterminate [FProgress].
  @useResult
  FProgressStyle copyWith({
    BoxConstraints? constraints,
    DecorationDelta? trackDecoration,
    DecorationDelta? fillDecoration,
    FProgressMotionDelta? motion,
  }) => .new(
    constraints: constraints ?? this.constraints,
    trackDecoration: trackDecoration?.call(this.trackDecoration) ?? this.trackDecoration,
    fillDecoration: fillDecoration?.call(this.fillDecoration) ?? this.fillDecoration,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FProgressStyle] using the given factor [t].
  @useResult
  FProgressStyle lerp(FProgressStyle other, double t) => .new(
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    trackDecoration: .lerp(trackDecoration, other.trackDecoration, t) ?? trackDecoration,
    fillDecoration: .lerp(fillDecoration, other.fillDecoration, t) ?? fillDecoration,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FProgressStyleFunctions on Diagnosticable implements FProgressStyleDelta {
  /// Returns itself.
  @override
  FProgressStyle call(Object _) => this as FProgressStyle;

  BoxConstraints get constraints;
  Decoration get trackDecoration;
  Decoration get fillDecoration;
  FProgressMotion get motion;
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
      (other is FProgressStyle &&
          runtimeType == other.runtimeType &&
          constraints == other.constraints &&
          trackDecoration == other.trackDecoration &&
          fillDecoration == other.fillDecoration &&
          motion == other.motion);

  @override
  int get hashCode => constraints.hashCode ^ trackDecoration.hashCode ^ fillDecoration.hashCode ^ motion.hashCode;
}

/// A delta that applies modifications to a [FProgressStyle].
///
/// A [FProgressStyle] is itself a [FProgressStyleDelta].
abstract class FProgressStyleDelta with Delta {
  /// Creates a partial modification of a [FProgressStyle].
  ///
  /// ## Parameters
  /// * [FProgressStyle.constraints] - The linear progress's constraints.
  /// * [FProgressStyle.trackDecoration] - The track's decoration.
  /// * [FProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FProgressStyle.motion] - The motion-related properties for an indeterminate [FProgress].
  const factory FProgressStyleDelta.delta({
    BoxConstraints? constraints,
    DecorationDelta? trackDecoration,
    DecorationDelta? fillDecoration,
    FProgressMotionDelta? motion,
  }) = _FProgressStyleDelta;

  /// Creates a delta that returns the [FProgressStyle] in the current context.
  const factory FProgressStyleDelta.context() = _FProgressStyleContext;

  @override
  FProgressStyle call(covariant FProgressStyle value);
}

class _FProgressStyleDelta implements FProgressStyleDelta {
  const _FProgressStyleDelta({this.constraints, this.trackDecoration, this.fillDecoration, this.motion});

  final BoxConstraints? constraints;

  final DecorationDelta? trackDecoration;

  final DecorationDelta? fillDecoration;

  final FProgressMotionDelta? motion;

  @override
  FProgressStyle call(FProgressStyle original) => FProgressStyle(
    constraints: constraints ?? original.constraints,
    trackDecoration: trackDecoration?.call(original.trackDecoration) ?? original.trackDecoration,
    fillDecoration: fillDecoration?.call(original.fillDecoration) ?? original.fillDecoration,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FProgressStyleContext implements FProgressStyleDelta {
  const _FProgressStyleContext();

  @override
  FProgressStyle call(FProgressStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FProgressMotionTransformations on FProgressMotion {
  /// Returns a copy of this [FProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FProgressMotion.period] - The animation's period.
  /// * [FProgressMotion.interval] - The interval between animations.
  /// * [FProgressMotion.curve] - The animation curve.
  /// * [FProgressMotion.value] - The percentage of the filled progress.
  @useResult
  FProgressMotion copyWith({Duration? period, Duration? interval, Curve? curve, double? value}) => .new(
    period: period ?? this.period,
    interval: interval ?? this.interval,
    curve: curve ?? this.curve,
    value: value ?? this.value,
  );

  /// Linearly interpolate between this and another [FProgressMotion] using the given factor [t].
  @useResult
  FProgressMotion lerp(FProgressMotion other, double t) => .new(
    period: t < 0.5 ? period : other.period,
    interval: t < 0.5 ? interval : other.interval,
    curve: t < 0.5 ? curve : other.curve,
    value: lerpDouble(value, other.value, t) ?? value,
  );
}

mixin _$FProgressMotionFunctions on Diagnosticable implements FProgressMotionDelta {
  /// Returns itself.
  @override
  FProgressMotion call(Object _) => this as FProgressMotion;

  Duration get period;
  Duration get interval;
  Curve get curve;
  double get value;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('period', period, level: .debug))
      ..add(DiagnosticsProperty('interval', interval, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug))
      ..add(DoubleProperty('value', value, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FProgressMotion &&
          runtimeType == other.runtimeType &&
          period == other.period &&
          interval == other.interval &&
          curve == other.curve &&
          value == other.value);

  @override
  int get hashCode => period.hashCode ^ interval.hashCode ^ curve.hashCode ^ value.hashCode;
}

/// A delta that applies modifications to a [FProgressMotion].
///
/// A [FProgressMotion] is itself a [FProgressMotionDelta].
abstract class FProgressMotionDelta with Delta {
  /// Creates a partial modification of a [FProgressMotion].
  ///
  /// ## Parameters
  /// * [FProgressMotion.period] - The animation's period.
  /// * [FProgressMotion.interval] - The interval between animations.
  /// * [FProgressMotion.curve] - The animation curve.
  /// * [FProgressMotion.value] - The percentage of the filled progress.
  const factory FProgressMotionDelta.delta({Duration? period, Duration? interval, Curve? curve, double? value}) =
      _FProgressMotionDelta;

  /// Creates a delta that returns the [FProgressMotion] in the current context.
  const factory FProgressMotionDelta.context() = _FProgressMotionContext;

  @override
  FProgressMotion call(covariant FProgressMotion value);
}

class _FProgressMotionDelta implements FProgressMotionDelta {
  const _FProgressMotionDelta({this.period, this.interval, this.curve, this.value});

  final Duration? period;

  final Duration? interval;

  final Curve? curve;

  final double? value;

  @override
  FProgressMotion call(FProgressMotion original) => FProgressMotion(
    period: period ?? original.period,
    interval: interval ?? original.interval,
    curve: curve ?? original.curve,
    value: value ?? original.value,
  );
}

class _FProgressMotionContext implements FProgressMotionDelta {
  const _FProgressMotionContext();

  @override
  FProgressMotion call(FProgressMotion original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'persistent_sheet.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPersistentSheetStyleTransformations on FPersistentSheetStyle {
  /// Returns a copy of this [FPersistentSheetStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FPersistentSheetStyle.motion] - The motion-related properties for a persistent sheet.
  /// * [FPersistentSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FPersistentSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  @useResult
  FPersistentSheetStyle copyWith({
    FPersistentSheetMotionDelta? motion,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) => .new(
    motion: motion?.call(this.motion) ?? this.motion,
    flingVelocity: flingVelocity ?? this.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? this.closeProgressThreshold,
  );

  /// Linearly interpolate between this and another [FPersistentSheetStyle] using the given factor [t].
  @useResult
  FPersistentSheetStyle lerp(FPersistentSheetStyle other, double t) => .new(
    motion: motion.lerp(other.motion, t),
    flingVelocity: lerpDouble(flingVelocity, other.flingVelocity, t) ?? flingVelocity,
    closeProgressThreshold:
        lerpDouble(closeProgressThreshold, other.closeProgressThreshold, t) ?? closeProgressThreshold,
  );
}

mixin _$FPersistentSheetStyleFunctions on Diagnosticable implements FPersistentSheetStyleDelta {
  /// Returns itself.
  @override
  FPersistentSheetStyle call(Object _) => this as FPersistentSheetStyle;

  FPersistentSheetMotion get motion;
  double get flingVelocity;
  double get closeProgressThreshold;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPersistentSheetStyle &&
          runtimeType == other.runtimeType &&
          motion == other.motion &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold);

  @override
  int get hashCode => motion.hashCode ^ flingVelocity.hashCode ^ closeProgressThreshold.hashCode;
}

/// A delta that applies modifications to a [FPersistentSheetStyle].
///
/// A [FPersistentSheetStyle] is itself a [FPersistentSheetStyleDelta].
abstract class FPersistentSheetStyleDelta with Delta {
  /// Creates a partial modification of a [FPersistentSheetStyle].
  ///
  /// ## Parameters
  /// * [FPersistentSheetStyle.motion] - The motion-related properties for a persistent sheet.
  /// * [FPersistentSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FPersistentSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  const factory FPersistentSheetStyleDelta.delta({
    FPersistentSheetMotionDelta? motion,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) = _FPersistentSheetStyleDelta;

  /// Creates a delta that returns the [FPersistentSheetStyle] in the current context.
  const factory FPersistentSheetStyleDelta.context() = _FPersistentSheetStyleContext;

  @override
  FPersistentSheetStyle call(covariant FPersistentSheetStyle value);
}

class _FPersistentSheetStyleDelta implements FPersistentSheetStyleDelta {
  const _FPersistentSheetStyleDelta({this.motion, this.flingVelocity, this.closeProgressThreshold});

  final FPersistentSheetMotionDelta? motion;

  final double? flingVelocity;

  final double? closeProgressThreshold;

  @override
  FPersistentSheetStyle call(FPersistentSheetStyle original) => FPersistentSheetStyle(
    motion: motion?.call(original.motion) ?? original.motion,
    flingVelocity: flingVelocity ?? original.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? original.closeProgressThreshold,
  );
}

class _FPersistentSheetStyleContext implements FPersistentSheetStyleDelta {
  const _FPersistentSheetStyleContext();

  @override
  FPersistentSheetStyle call(FPersistentSheetStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FPersistentSheetMotionTransformations on FPersistentSheetMotion {
  /// Returns a copy of this [FPersistentSheetMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FPersistentSheetMotion.expandDuration] - The duration of the sheet's expansion animation.
  /// * [FPersistentSheetMotion.collapseDuration] - The duration of the sheet's collapsing animation.
  /// * [FPersistentSheetMotion.curve] - The curve of the sheet's expansion and collapse.
  @useResult
  FPersistentSheetMotion copyWith({Duration? expandDuration, Duration? collapseDuration, Curve? curve}) => .new(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    curve: curve ?? this.curve,
  );

  /// Linearly interpolate between this and another [FPersistentSheetMotion] using the given factor [t].
  @useResult
  FPersistentSheetMotion lerp(FPersistentSheetMotion other, double t) => .new(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FPersistentSheetMotionFunctions on Diagnosticable implements FPersistentSheetMotionDelta {
  /// Returns itself.
  @override
  FPersistentSheetMotion call(Object _) => this as FPersistentSheetMotion;

  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get curve;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPersistentSheetMotion &&
          runtimeType == other.runtimeType &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          curve == other.curve);

  @override
  int get hashCode => expandDuration.hashCode ^ collapseDuration.hashCode ^ curve.hashCode;
}

/// A delta that applies modifications to a [FPersistentSheetMotion].
///
/// A [FPersistentSheetMotion] is itself a [FPersistentSheetMotionDelta].
abstract class FPersistentSheetMotionDelta with Delta {
  /// Creates a partial modification of a [FPersistentSheetMotion].
  ///
  /// ## Parameters
  /// * [FPersistentSheetMotion.expandDuration] - The duration of the sheet's expansion animation.
  /// * [FPersistentSheetMotion.collapseDuration] - The duration of the sheet's collapsing animation.
  /// * [FPersistentSheetMotion.curve] - The curve of the sheet's expansion and collapse.
  const factory FPersistentSheetMotionDelta.delta({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? curve,
  }) = _FPersistentSheetMotionDelta;

  /// Creates a delta that returns the [FPersistentSheetMotion] in the current context.
  const factory FPersistentSheetMotionDelta.context() = _FPersistentSheetMotionContext;

  @override
  FPersistentSheetMotion call(covariant FPersistentSheetMotion value);
}

class _FPersistentSheetMotionDelta implements FPersistentSheetMotionDelta {
  const _FPersistentSheetMotionDelta({this.expandDuration, this.collapseDuration, this.curve});

  final Duration? expandDuration;

  final Duration? collapseDuration;

  final Curve? curve;

  @override
  FPersistentSheetMotion call(FPersistentSheetMotion original) => FPersistentSheetMotion(
    expandDuration: expandDuration ?? original.expandDuration,
    collapseDuration: collapseDuration ?? original.collapseDuration,
    curve: curve ?? original.curve,
  );
}

class _FPersistentSheetMotionContext implements FPersistentSheetMotionDelta {
  const _FPersistentSheetMotionContext();

  @override
  FPersistentSheetMotion call(FPersistentSheetMotion original) => original;
}

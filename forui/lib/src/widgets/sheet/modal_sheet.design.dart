// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'modal_sheet.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FModalSheetStyleTransformations on FModalSheetStyle {
  /// Returns a copy of this [FModalSheetStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FModalSheetStyle.barrierFilter] -
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  /// * [FModalSheetStyle.motion] - The motion-related properties for a modal sheet.
  /// * [FModalSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FModalSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  @useResult
  FModalSheetStyle copyWith({
    ImageFilter Function(double)? barrierFilter = imageFilterFunctionSentinel,
    FModalSheetMotionDelta? motion,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) => .new(
    barrierFilter: barrierFilter == imageFilterFunctionSentinel ? this.barrierFilter : barrierFilter,
    motion: motion?.call(this.motion) ?? this.motion,
    flingVelocity: flingVelocity ?? this.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? this.closeProgressThreshold,
  );

  /// Linearly interpolate between this and another [FModalSheetStyle] using the given factor [t].
  @useResult
  FModalSheetStyle lerp(FModalSheetStyle other, double t) => .new(
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    motion: motion.lerp(other.motion, t),
    flingVelocity: lerpDouble(flingVelocity, other.flingVelocity, t) ?? flingVelocity,
    closeProgressThreshold:
        lerpDouble(closeProgressThreshold, other.closeProgressThreshold, t) ?? closeProgressThreshold,
  );
}

mixin _$FModalSheetStyleFunctions on Diagnosticable implements FModalSheetStyleDelta {
  /// Returns itself.
  @override
  FModalSheetStyle call(Object _) => this as FModalSheetStyle;

  ImageFilter Function(double)? get barrierFilter;
  FModalSheetMotion get motion;
  double get flingVelocity;
  double get closeProgressThreshold;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FModalSheetStyle &&
          runtimeType == other.runtimeType &&
          barrierFilter == other.barrierFilter &&
          motion == other.motion &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold);

  @override
  int get hashCode =>
      barrierFilter.hashCode ^ motion.hashCode ^ flingVelocity.hashCode ^ closeProgressThreshold.hashCode;
}

/// A delta that applies modifications to a [FModalSheetStyle].
///
/// A [FModalSheetStyle] is itself a [FModalSheetStyleDelta].
abstract class FModalSheetStyleDelta with Delta {
  /// Creates a partial modification of a [FModalSheetStyle].
  ///
  /// ## Parameters
  /// * [FModalSheetStyle.barrierFilter] -
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  /// * [FModalSheetStyle.motion] - The motion-related properties for a modal sheet.
  /// * [FModalSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FModalSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  const factory FModalSheetStyleDelta.delta({
    ImageFilter Function(double)? barrierFilter,
    FModalSheetMotionDelta? motion,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) = _FModalSheetStyleDelta;

  /// Creates a delta that returns the [FModalSheetStyle] in the current context.
  const factory FModalSheetStyleDelta.context() = _FModalSheetStyleContext;

  @override
  FModalSheetStyle call(covariant FModalSheetStyle value);
}

class _FModalSheetStyleDelta implements FModalSheetStyleDelta {
  const _FModalSheetStyleDelta({
    this.barrierFilter = imageFilterFunctionSentinel,
    this.motion,
    this.flingVelocity,
    this.closeProgressThreshold,
  });

  final ImageFilter Function(double)? barrierFilter;

  final FModalSheetMotionDelta? motion;

  final double? flingVelocity;

  final double? closeProgressThreshold;

  @override
  FModalSheetStyle call(FModalSheetStyle original) => FModalSheetStyle(
    barrierFilter: barrierFilter == imageFilterFunctionSentinel ? original.barrierFilter : barrierFilter,
    motion: motion?.call(original.motion) ?? original.motion,
    flingVelocity: flingVelocity ?? original.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? original.closeProgressThreshold,
  );
}

class _FModalSheetStyleContext implements FModalSheetStyleDelta {
  const _FModalSheetStyleContext();

  @override
  FModalSheetStyle call(FModalSheetStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FModalSheetMotionTransformations on FModalSheetMotion {
  /// Returns a copy of this [FModalSheetMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FModalSheetMotion.barrierCurve] - The barrier's curve.
  /// * [FModalSheetMotion.expandDuration] - The duration of the sheet's expansion animation.
  /// * [FModalSheetMotion.collapseDuration] - The duration of the sheet's collapsing animation.
  /// * [FModalSheetMotion.curve] - The curve of the sheet's expansion and collapse.
  @useResult
  FModalSheetMotion copyWith({
    Curve? barrierCurve,
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? curve,
  }) => .new(
    barrierCurve: barrierCurve ?? this.barrierCurve,
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    curve: curve ?? this.curve,
  );

  /// Linearly interpolate between this and another [FModalSheetMotion] using the given factor [t].
  @useResult
  FModalSheetMotion lerp(FModalSheetMotion other, double t) => .new(
    barrierCurve: t < 0.5 ? barrierCurve : other.barrierCurve,
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FModalSheetMotionFunctions on Diagnosticable implements FModalSheetMotionDelta {
  /// Returns itself.
  @override
  FModalSheetMotion call(Object _) => this as FModalSheetMotion;

  Curve get barrierCurve;
  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get curve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('barrierCurve', barrierCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FModalSheetMotion &&
          runtimeType == other.runtimeType &&
          barrierCurve == other.barrierCurve &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          curve == other.curve);

  @override
  int get hashCode => barrierCurve.hashCode ^ expandDuration.hashCode ^ collapseDuration.hashCode ^ curve.hashCode;
}

/// A delta that applies modifications to a [FModalSheetMotion].
///
/// A [FModalSheetMotion] is itself a [FModalSheetMotionDelta].
abstract class FModalSheetMotionDelta with Delta {
  /// Creates a partial modification of a [FModalSheetMotion].
  ///
  /// ## Parameters
  /// * [FModalSheetMotion.barrierCurve] - The barrier's curve.
  /// * [FModalSheetMotion.expandDuration] - The duration of the sheet's expansion animation.
  /// * [FModalSheetMotion.collapseDuration] - The duration of the sheet's collapsing animation.
  /// * [FModalSheetMotion.curve] - The curve of the sheet's expansion and collapse.
  const factory FModalSheetMotionDelta.delta({
    Curve? barrierCurve,
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? curve,
  }) = _FModalSheetMotionDelta;

  /// Creates a delta that returns the [FModalSheetMotion] in the current context.
  const factory FModalSheetMotionDelta.context() = _FModalSheetMotionContext;

  @override
  FModalSheetMotion call(covariant FModalSheetMotion value);
}

class _FModalSheetMotionDelta implements FModalSheetMotionDelta {
  const _FModalSheetMotionDelta({this.barrierCurve, this.expandDuration, this.collapseDuration, this.curve});

  final Curve? barrierCurve;

  final Duration? expandDuration;

  final Duration? collapseDuration;

  final Curve? curve;

  @override
  FModalSheetMotion call(FModalSheetMotion original) => FModalSheetMotion(
    barrierCurve: barrierCurve ?? original.barrierCurve,
    expandDuration: expandDuration ?? original.expandDuration,
    collapseDuration: collapseDuration ?? original.collapseDuration,
    curve: curve ?? original.curve,
  );
}

class _FModalSheetMotionContext implements FModalSheetMotionDelta {
  const _FModalSheetMotionContext();

  @override
  FModalSheetMotion call(FModalSheetMotion original) => original;
}

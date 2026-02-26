// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverMotionTransformations on FPopoverMotion {
  /// Returns a copy of this [FPopoverMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FPopoverMotion.entranceDuration] - The popover's entrance duration.
  /// * [FPopoverMotion.exitDuration] - The popover's exit duration.
  /// * [FPopoverMotion.expandCurve] - The curve used for the popover's expansion animation when entering.
  /// * [FPopoverMotion.collapseCurve] - The curve used for the popover's collapse animation when exiting.
  /// * [FPopoverMotion.fadeInCurve] - The curve used for the popover's fade-in animation when entering.
  /// * [FPopoverMotion.fadeOutCurve] - The curve used for the popover's fade-out animation when exiting.
  /// * [FPopoverMotion.scaleTween] - The popover's scale tween.
  /// * [FPopoverMotion.fadeTween] - The popover's fade tween.
  @useResult
  FPopoverMotion copyWith({
    Duration? entranceDuration,
    Duration? exitDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
  }) => .new(
    entranceDuration: entranceDuration ?? this.entranceDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    scaleTween: scaleTween ?? this.scaleTween,
    fadeTween: fadeTween ?? this.fadeTween,
  );

  /// Linearly interpolate between this and another [FPopoverMotion] using the given factor [t].
  @useResult
  FPopoverMotion lerp(FPopoverMotion other, double t) => .new(
    entranceDuration: t < 0.5 ? entranceDuration : other.entranceDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
    scaleTween: t < 0.5 ? scaleTween : other.scaleTween,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
  );
}

mixin _$FPopoverMotionFunctions on Diagnosticable implements FPopoverMotionDelta {
  /// Returns itself.
  @override
  FPopoverMotion call(Object _) => this as FPopoverMotion;

  Duration get entranceDuration;
  Duration get exitDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  Animatable<double> get scaleTween;
  Animatable<double> get fadeTween;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entranceDuration', entranceDuration, level: .debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: .debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: .debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: .debug))
      ..add(DiagnosticsProperty('scaleTween', scaleTween, level: .debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMotion &&
          runtimeType == other.runtimeType &&
          entranceDuration == other.entranceDuration &&
          exitDuration == other.exitDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve &&
          scaleTween == other.scaleTween &&
          fadeTween == other.fadeTween);

  @override
  int get hashCode =>
      entranceDuration.hashCode ^
      exitDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      fadeInCurve.hashCode ^
      fadeOutCurve.hashCode ^
      scaleTween.hashCode ^
      fadeTween.hashCode;
}

/// A delta that applies modifications to a [FPopoverMotion].
///
/// A [FPopoverMotion] is itself a [FPopoverMotionDelta].
abstract class FPopoverMotionDelta with Delta {
  /// Creates a partial modification of a [FPopoverMotion].
  ///
  /// ## Parameters
  /// * [FPopoverMotion.entranceDuration] - The popover's entrance duration.
  /// * [FPopoverMotion.exitDuration] - The popover's exit duration.
  /// * [FPopoverMotion.expandCurve] - The curve used for the popover's expansion animation when entering.
  /// * [FPopoverMotion.collapseCurve] - The curve used for the popover's collapse animation when exiting.
  /// * [FPopoverMotion.fadeInCurve] - The curve used for the popover's fade-in animation when entering.
  /// * [FPopoverMotion.fadeOutCurve] - The curve used for the popover's fade-out animation when exiting.
  /// * [FPopoverMotion.scaleTween] - The popover's scale tween.
  /// * [FPopoverMotion.fadeTween] - The popover's fade tween.
  const factory FPopoverMotionDelta.delta({
    Duration? entranceDuration,
    Duration? exitDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
  }) = _FPopoverMotionDelta;

  /// Creates a delta that returns the [FPopoverMotion] in the current context.
  const factory FPopoverMotionDelta.context() = _FPopoverMotionContext;

  @override
  FPopoverMotion call(covariant FPopoverMotion value);
}

class _FPopoverMotionDelta implements FPopoverMotionDelta {
  const _FPopoverMotionDelta({
    this.entranceDuration,
    this.exitDuration,
    this.expandCurve,
    this.collapseCurve,
    this.fadeInCurve,
    this.fadeOutCurve,
    this.scaleTween,
    this.fadeTween,
  });

  final Duration? entranceDuration;

  final Duration? exitDuration;

  final Curve? expandCurve;

  final Curve? collapseCurve;

  final Curve? fadeInCurve;

  final Curve? fadeOutCurve;

  final Animatable<double>? scaleTween;

  final Animatable<double>? fadeTween;

  @override
  FPopoverMotion call(FPopoverMotion original) => FPopoverMotion(
    entranceDuration: entranceDuration ?? original.entranceDuration,
    exitDuration: exitDuration ?? original.exitDuration,
    expandCurve: expandCurve ?? original.expandCurve,
    collapseCurve: collapseCurve ?? original.collapseCurve,
    fadeInCurve: fadeInCurve ?? original.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? original.fadeOutCurve,
    scaleTween: scaleTween ?? original.scaleTween,
    fadeTween: fadeTween ?? original.fadeTween,
  );
}

class _FPopoverMotionContext implements FPopoverMotionDelta {
  const _FPopoverMotionContext();

  @override
  FPopoverMotion call(FPopoverMotion original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverStyleTransformations on FPopoverStyle {
  /// Returns a copy of this [FPopoverStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FPopoverStyle.decoration] - The popover's decoration.
  /// * [FPopoverStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverStyle.viewInsets] - The additional insets of the view.
  @useResult
  FPopoverStyle copyWith({
    DecorationDelta? decoration,
    ImageFilter Function(double)? barrierFilter = imageFilterFunctionSentinel,
    ImageFilter Function(double)? backgroundFilter = imageFilterFunctionSentinel,
    EdgeInsetsGeometryDelta? viewInsets,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == imageFilterFunctionSentinel ? this.barrierFilter : barrierFilter,
    backgroundFilter: backgroundFilter == imageFilterFunctionSentinel ? this.backgroundFilter : backgroundFilter,
    viewInsets: viewInsets?.call(this.viewInsets) ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FPopoverStyle] using the given factor [t].
  @useResult
  FPopoverStyle lerp(FPopoverStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: .lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FPopoverStyleFunctions on Diagnosticable implements FPopoverStyleDelta {
  /// Returns itself.
  @override
  FPopoverStyle call(Object _) => this as FPopoverStyle;

  Decoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('viewInsets', viewInsets, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode => decoration.hashCode ^ barrierFilter.hashCode ^ backgroundFilter.hashCode ^ viewInsets.hashCode;
}

/// A delta that applies modifications to a [FPopoverStyle].
///
/// A [FPopoverStyle] is itself a [FPopoverStyleDelta].
abstract class FPopoverStyleDelta with Delta {
  /// Creates a partial modification of a [FPopoverStyle].
  ///
  /// ## Parameters
  /// * [FPopoverStyle.decoration] - The popover's decoration.
  /// * [FPopoverStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverStyle.viewInsets] - The additional insets of the view.
  const factory FPopoverStyleDelta.delta({
    DecorationDelta? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometryDelta? viewInsets,
  }) = _FPopoverStyleDelta;

  /// Creates a delta that returns the [FPopoverStyle] in the current context.
  const factory FPopoverStyleDelta.context() = _FPopoverStyleContext;

  @override
  FPopoverStyle call(covariant FPopoverStyle value);
}

class _FPopoverStyleDelta implements FPopoverStyleDelta {
  const _FPopoverStyleDelta({
    this.decoration,
    this.barrierFilter = imageFilterFunctionSentinel,
    this.backgroundFilter = imageFilterFunctionSentinel,
    this.viewInsets,
  });

  final DecorationDelta? decoration;

  final ImageFilter Function(double)? barrierFilter;

  final ImageFilter Function(double)? backgroundFilter;

  final EdgeInsetsGeometryDelta? viewInsets;

  @override
  FPopoverStyle call(FPopoverStyle original) => FPopoverStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == imageFilterFunctionSentinel ? original.barrierFilter : barrierFilter,
    backgroundFilter: backgroundFilter == imageFilterFunctionSentinel ? original.backgroundFilter : backgroundFilter,
    viewInsets: viewInsets?.call(original.viewInsets) ?? original.viewInsets,
  );
}

class _FPopoverStyleContext implements FPopoverStyleDelta {
  const _FPopoverStyleContext();

  @override
  FPopoverStyle call(FPopoverStyle original) => original;
}

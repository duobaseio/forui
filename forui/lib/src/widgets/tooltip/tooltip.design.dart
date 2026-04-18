// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tooltip.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTooltipStyleTransformations on FTooltipStyle {
  /// Returns a copy of this [FTooltipStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTooltipStyle.decoration] - The box decoration.
  /// * [FTooltipStyle.backgroundFilter] - An optional background filter applied to the tooltip.
  /// * [FTooltipStyle.padding] - The padding surrounding the tooltip's text.
  /// * [FTooltipStyle.textStyle] - The tooltip's default text style.
  /// * [FTooltipStyle.hapticFeedback] - The haptic feedback for when the tooltip is shown via long press.
  /// * [FTooltipStyle.motion] - The tooltip's motion configuration.
  /// * [FTooltipStyle.hoverEnterDuration] - The duration to wait before showing the tooltip after the user hovers over the target.
  /// * [FTooltipStyle.hoverExitDuration] - The duration to wait before hiding the tooltip after the user has stopped hovering over the target.
  /// * [FTooltipStyle.longPressExitDuration] - The duration to wait before hiding the tooltip after the user has stopped pressing the target.
  @useResult
  FTooltipStyle copyWith({
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter = Sentinels.imageFilter,
    EdgeInsetsDelta? padding,
    TextStyleDelta? textStyle,
    Future<void> Function()? hapticFeedback,
    FTooltipMotionDelta? motion,
    Duration? hoverEnterDuration,
    Duration? hoverExitDuration,
    Duration? longPressExitDuration,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    backgroundFilter: backgroundFilter == Sentinels.imageFilter ? this.backgroundFilter : backgroundFilter,
    padding: padding?.call(this.padding) ?? this.padding,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    hapticFeedback: hapticFeedback ?? this.hapticFeedback,
    motion: motion?.call(this.motion) ?? this.motion,
    hoverEnterDuration: hoverEnterDuration ?? this.hoverEnterDuration,
    hoverExitDuration: hoverExitDuration ?? this.hoverExitDuration,
    longPressExitDuration: longPressExitDuration ?? this.longPressExitDuration,
  );

  /// Linearly interpolate between this and another [FTooltipStyle] using the given factor [t].
  @useResult
  FTooltipStyle lerp(FTooltipStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: .lerp(padding, other.padding, t) ?? padding,
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    hapticFeedback: t < 0.5 ? hapticFeedback : other.hapticFeedback,
    motion: motion.lerp(other.motion, t),
    hoverEnterDuration: t < 0.5 ? hoverEnterDuration : other.hoverEnterDuration,
    hoverExitDuration: t < 0.5 ? hoverExitDuration : other.hoverExitDuration,
    longPressExitDuration: t < 0.5 ? longPressExitDuration : other.longPressExitDuration,
  );
}

mixin _$FTooltipStyleFunctions on Diagnosticable implements FTooltipStyleDelta {
  /// Returns itself.
  @override
  FTooltipStyle call(Object _) => this as FTooltipStyle;

  Decoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsets get padding;
  TextStyle get textStyle;
  Future<void> Function() get hapticFeedback;
  FTooltipMotion get motion;
  Duration get hoverEnterDuration;
  Duration get hoverExitDuration;
  Duration get longPressExitDuration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('hapticFeedback', hapticFeedback, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug))
      ..add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration, level: .debug))
      ..add(DiagnosticsProperty('hoverExitDuration', hoverExitDuration, level: .debug))
      ..add(DiagnosticsProperty('longPressExitDuration', longPressExitDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTooltipStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          textStyle == other.textStyle &&
          hapticFeedback == other.hapticFeedback &&
          motion == other.motion &&
          hoverEnterDuration == other.hoverEnterDuration &&
          hoverExitDuration == other.hoverExitDuration &&
          longPressExitDuration == other.longPressExitDuration);

  @override
  int get hashCode =>
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      textStyle.hashCode ^
      hapticFeedback.hashCode ^
      motion.hashCode ^
      hoverEnterDuration.hashCode ^
      hoverExitDuration.hashCode ^
      longPressExitDuration.hashCode;
}

/// A delta that applies modifications to a [FTooltipStyle].
///
/// A [FTooltipStyle] is itself a [FTooltipStyleDelta].
abstract class FTooltipStyleDelta with Delta {
  /// Creates a partial modification of a [FTooltipStyle].
  ///
  /// ## Parameters
  /// * [FTooltipStyle.decoration] - The box decoration.
  /// * [FTooltipStyle.backgroundFilter] - An optional background filter applied to the tooltip.
  /// * [FTooltipStyle.padding] - The padding surrounding the tooltip's text.
  /// * [FTooltipStyle.textStyle] - The tooltip's default text style.
  /// * [FTooltipStyle.hapticFeedback] - The haptic feedback for when the tooltip is shown via long press.
  /// * [FTooltipStyle.motion] - The tooltip's motion configuration.
  /// * [FTooltipStyle.hoverEnterDuration] - The duration to wait before showing the tooltip after the user hovers over the target.
  /// * [FTooltipStyle.hoverExitDuration] - The duration to wait before hiding the tooltip after the user has stopped hovering over the target.
  /// * [FTooltipStyle.longPressExitDuration] - The duration to wait before hiding the tooltip after the user has stopped pressing the target.
  const factory FTooltipStyleDelta.delta({
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsDelta? padding,
    TextStyleDelta? textStyle,
    Future<void> Function()? hapticFeedback,
    FTooltipMotionDelta? motion,
    Duration? hoverEnterDuration,
    Duration? hoverExitDuration,
    Duration? longPressExitDuration,
  }) = _FTooltipStyleDelta;

  /// Creates a delta that returns the [FTooltipStyle] in the current context.
  const factory FTooltipStyleDelta.context() = _FTooltipStyleContext;

  @override
  FTooltipStyle call(covariant FTooltipStyle value);
}

class _FTooltipStyleDelta implements FTooltipStyleDelta {
  const _FTooltipStyleDelta({
    this.decoration,
    this.backgroundFilter = Sentinels.imageFilter,
    this.padding,
    this.textStyle,
    this.hapticFeedback,
    this.motion,
    this.hoverEnterDuration,
    this.hoverExitDuration,
    this.longPressExitDuration,
  });

  final DecorationDelta? decoration;

  final ImageFilter? backgroundFilter;

  final EdgeInsetsDelta? padding;

  final TextStyleDelta? textStyle;

  final Future<void> Function()? hapticFeedback;

  final FTooltipMotionDelta? motion;

  final Duration? hoverEnterDuration;

  final Duration? hoverExitDuration;

  final Duration? longPressExitDuration;

  @override
  FTooltipStyle call(FTooltipStyle original) => FTooltipStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    backgroundFilter: backgroundFilter == Sentinels.imageFilter ? original.backgroundFilter : backgroundFilter,
    padding: padding?.call(original.padding) ?? original.padding,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    hapticFeedback: hapticFeedback ?? original.hapticFeedback,
    motion: motion?.call(original.motion) ?? original.motion,
    hoverEnterDuration: hoverEnterDuration ?? original.hoverEnterDuration,
    hoverExitDuration: hoverExitDuration ?? original.hoverExitDuration,
    longPressExitDuration: longPressExitDuration ?? original.longPressExitDuration,
  );
}

class _FTooltipStyleContext implements FTooltipStyleDelta {
  const _FTooltipStyleContext();

  @override
  FTooltipStyle call(FTooltipStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FTooltipMotionTransformations on FTooltipMotion {
  /// Returns a copy of this [FTooltipMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FTooltipMotion.entranceDuration] - The tooltip's entrance duration.
  /// * [FTooltipMotion.exitDuration] - The tooltip's exit duration.
  /// * [FTooltipMotion.expandCurve] - The curve used for the tooltip's expansion animation when entering.
  /// * [FTooltipMotion.collapseCurve] - The curve used for the tooltip's collapse animation when exiting.
  /// * [FTooltipMotion.fadeInCurve] - The curve used for the tooltip's fade-in animation when entering.
  /// * [FTooltipMotion.fadeOutCurve] - The curve used for the tooltip's fade-out animation when exiting.
  /// * [FTooltipMotion.scaleTween] - The tooltip's scale tween.
  /// * [FTooltipMotion.fadeTween] - The tooltip's fade tween.
  @useResult
  FTooltipMotion copyWith({
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

  /// Linearly interpolate between this and another [FTooltipMotion] using the given factor [t].
  @useResult
  FTooltipMotion lerp(FTooltipMotion other, double t) => .new(
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

mixin _$FTooltipMotionFunctions on Diagnosticable implements FTooltipMotionDelta {
  /// Returns itself.
  @override
  FTooltipMotion call(Object _) => this as FTooltipMotion;

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
      (other is FTooltipMotion &&
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

/// A delta that applies modifications to a [FTooltipMotion].
///
/// A [FTooltipMotion] is itself a [FTooltipMotionDelta].
abstract class FTooltipMotionDelta with Delta {
  /// Creates a partial modification of a [FTooltipMotion].
  ///
  /// ## Parameters
  /// * [FTooltipMotion.entranceDuration] - The tooltip's entrance duration.
  /// * [FTooltipMotion.exitDuration] - The tooltip's exit duration.
  /// * [FTooltipMotion.expandCurve] - The curve used for the tooltip's expansion animation when entering.
  /// * [FTooltipMotion.collapseCurve] - The curve used for the tooltip's collapse animation when exiting.
  /// * [FTooltipMotion.fadeInCurve] - The curve used for the tooltip's fade-in animation when entering.
  /// * [FTooltipMotion.fadeOutCurve] - The curve used for the tooltip's fade-out animation when exiting.
  /// * [FTooltipMotion.scaleTween] - The tooltip's scale tween.
  /// * [FTooltipMotion.fadeTween] - The tooltip's fade tween.
  const factory FTooltipMotionDelta.delta({
    Duration? entranceDuration,
    Duration? exitDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
  }) = _FTooltipMotionDelta;

  /// Creates a delta that returns the [FTooltipMotion] in the current context.
  const factory FTooltipMotionDelta.context() = _FTooltipMotionContext;

  @override
  FTooltipMotion call(covariant FTooltipMotion value);
}

class _FTooltipMotionDelta implements FTooltipMotionDelta {
  const _FTooltipMotionDelta({
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
  FTooltipMotion call(FTooltipMotion original) => FTooltipMotion(
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

class _FTooltipMotionContext implements FTooltipMotionDelta {
  const _FTooltipMotionContext();

  @override
  FTooltipMotion call(FTooltipMotion original) => original;
}

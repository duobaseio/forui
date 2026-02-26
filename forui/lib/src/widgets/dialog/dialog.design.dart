// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FDialogAxisVariant], which represents individual variants.
extension type const FDialogAxisVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FDialogAxisVariantConstraint] that negates [variant].
  factory FDialogAxisVariantConstraint.not(FDialogAxisVariant variant) => FDialogAxisVariantConstraint._(Not(variant));

  /// The vertical dialog variant.
  static const vertical = FDialogAxisVariant.vertical;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FDialogAxisVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FDialogAxisVariant._(Desktop());

  /// The Android platform variant.
  static const android = FDialogAxisVariant.android;

  /// The iOS platform variant.
  static const iOS = FDialogAxisVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FDialogAxisVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FDialogAxisVariant.windows;

  /// The macOS platform variant.
  static const macOS = FDialogAxisVariant.macOS;

  /// The Linux platform variant.
  static const linux = FDialogAxisVariant.linux;

  /// The web platform variant.
  static const web = FDialogAxisVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FDialogAxisVariantConstraint and(FDialogAxisVariantConstraint other) =>
      FDialogAxisVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FDialogAxisVariantConstraint], which represents combinations of variants.
extension type const FDialogAxisVariant._(FVariant _) implements FDialogAxisVariantConstraint, FVariant {
  /// The vertical dialog variant.
  static const vertical = FDialogAxisVariant._(.new(1, 'vertical'));

  /// The Android platform variant.
  static const android = FDialogAxisVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FDialogAxisVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FDialogAxisVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FDialogAxisVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FDialogAxisVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FDialogAxisVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FDialogAxisVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogRouteStyleTransformations on FDialogRouteStyle {
  /// Returns a copy of this [FDialogRouteStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogRouteStyle.barrierFilter] -
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  /// * [FDialogRouteStyle.motion] - Motion-related properties.
  @useResult
  FDialogRouteStyle copyWith({
    ImageFilter Function(double)? Function()? barrierFilter,
    FDialogRouteMotionDelta? motion,
  }) => .new(
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FDialogRouteStyle] using the given factor [t].
  @useResult
  FDialogRouteStyle lerp(FDialogRouteStyle other, double t) =>
      .new(barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter, motion: motion.lerp(other.motion, t));
}

mixin _$FDialogRouteStyleFunctions on Diagnosticable implements FDialogRouteStyleDelta {
  /// Returns itself.
  @override
  FDialogRouteStyle call(Object _) => this as FDialogRouteStyle;

  ImageFilter Function(double)? get barrierFilter;
  FDialogRouteMotion get motion;
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
      (other is FDialogRouteStyle &&
          runtimeType == other.runtimeType &&
          barrierFilter == other.barrierFilter &&
          motion == other.motion);

  @override
  int get hashCode => barrierFilter.hashCode ^ motion.hashCode;
}

/// A delta that applies modifications to a [FDialogRouteStyle].
///
/// A [FDialogRouteStyle] is itself a [FDialogRouteStyleDelta].
abstract class FDialogRouteStyleDelta with Delta {
  /// Creates a partial modification of a [FDialogRouteStyle].
  ///
  /// ## Parameters
  /// * [FDialogRouteStyle.barrierFilter] -
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  /// * [FDialogRouteStyle.motion] - Motion-related properties.
  const factory FDialogRouteStyleDelta.delta({
    ImageFilter Function(double)? Function()? barrierFilter,
    FDialogRouteMotionDelta? motion,
  }) = _FDialogRouteStyleDelta;

  /// Creates a delta that returns the [FDialogRouteStyle] in the current context.
  const factory FDialogRouteStyleDelta.context() = _FDialogRouteStyleContext;

  @override
  FDialogRouteStyle call(covariant FDialogRouteStyle value);
}

class _FDialogRouteStyleDelta implements FDialogRouteStyleDelta {
  const _FDialogRouteStyleDelta({this.barrierFilter, this.motion});

  final ImageFilter Function(double)? Function()? barrierFilter;

  final FDialogRouteMotionDelta? motion;

  @override
  FDialogRouteStyle call(FDialogRouteStyle original) => FDialogRouteStyle(
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FDialogRouteStyleContext implements FDialogRouteStyleDelta {
  const _FDialogRouteStyleContext();

  @override
  FDialogRouteStyle call(FDialogRouteStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogRouteMotionTransformations on FDialogRouteMotion {
  /// Returns a copy of this [FDialogRouteMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDialogRouteMotion.entranceDuration] - The amount of time the entrance animation takes.
  /// * [FDialogRouteMotion.exitDuration] - The amount of time the exit animation takes.
  /// * [FDialogRouteMotion.barrierCurve] - The curve used for the barrier's entrance and exit.
  @useResult
  FDialogRouteMotion copyWith({Duration? entranceDuration, Duration? exitDuration, Curve? barrierCurve}) => .new(
    entranceDuration: entranceDuration ?? this.entranceDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    barrierCurve: barrierCurve ?? this.barrierCurve,
  );

  /// Linearly interpolate between this and another [FDialogRouteMotion] using the given factor [t].
  @useResult
  FDialogRouteMotion lerp(FDialogRouteMotion other, double t) => .new(
    entranceDuration: t < 0.5 ? entranceDuration : other.entranceDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    barrierCurve: t < 0.5 ? barrierCurve : other.barrierCurve,
  );
}

mixin _$FDialogRouteMotionFunctions on Diagnosticable implements FDialogRouteMotionDelta {
  /// Returns itself.
  @override
  FDialogRouteMotion call(Object _) => this as FDialogRouteMotion;

  Duration get entranceDuration;
  Duration get exitDuration;
  Curve get barrierCurve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entranceDuration', entranceDuration, level: .debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: .debug))
      ..add(DiagnosticsProperty('barrierCurve', barrierCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogRouteMotion &&
          runtimeType == other.runtimeType &&
          entranceDuration == other.entranceDuration &&
          exitDuration == other.exitDuration &&
          barrierCurve == other.barrierCurve);

  @override
  int get hashCode => entranceDuration.hashCode ^ exitDuration.hashCode ^ barrierCurve.hashCode;
}

/// A delta that applies modifications to a [FDialogRouteMotion].
///
/// A [FDialogRouteMotion] is itself a [FDialogRouteMotionDelta].
abstract class FDialogRouteMotionDelta with Delta {
  /// Creates a partial modification of a [FDialogRouteMotion].
  ///
  /// ## Parameters
  /// * [FDialogRouteMotion.entranceDuration] - The amount of time the entrance animation takes.
  /// * [FDialogRouteMotion.exitDuration] - The amount of time the exit animation takes.
  /// * [FDialogRouteMotion.barrierCurve] - The curve used for the barrier's entrance and exit.
  const factory FDialogRouteMotionDelta.delta({
    Duration? entranceDuration,
    Duration? exitDuration,
    Curve? barrierCurve,
  }) = _FDialogRouteMotionDelta;

  /// Creates a delta that returns the [FDialogRouteMotion] in the current context.
  const factory FDialogRouteMotionDelta.context() = _FDialogRouteMotionContext;

  @override
  FDialogRouteMotion call(covariant FDialogRouteMotion value);
}

class _FDialogRouteMotionDelta implements FDialogRouteMotionDelta {
  const _FDialogRouteMotionDelta({this.entranceDuration, this.exitDuration, this.barrierCurve});

  final Duration? entranceDuration;

  final Duration? exitDuration;

  final Curve? barrierCurve;

  @override
  FDialogRouteMotion call(FDialogRouteMotion original) => FDialogRouteMotion(
    entranceDuration: entranceDuration ?? original.entranceDuration,
    exitDuration: exitDuration ?? original.exitDuration,
    barrierCurve: barrierCurve ?? original.barrierCurve,
  );
}

class _FDialogRouteMotionContext implements FDialogRouteMotionDelta {
  const _FDialogRouteMotionContext();

  @override
  FDialogRouteMotion call(FDialogRouteMotion original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogStyleTransformations on FDialogStyle {
  /// Returns a copy of this [FDialogStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogStyle.backgroundFilter] -
  /// {@macro forui.widgets.FPopoverStyle.backgroundFilter}
  /// * [FDialogStyle.decoration] - The decoration.
  /// * [FDialogStyle.insetPadding] - The inset padding.
  /// * [FDialogStyle.contentStyle] - The dialog content's style.
  /// * [FDialogStyle.slideableActions] - Whether the dialog's actions support pressing an action and sliding to another.
  /// * [FDialogStyle.motion] - Motion-related properties.
  @useResult
  FDialogStyle copyWith({
    ImageFilter Function(double)? backgroundFilter = imageFilterFunctionSentinel,
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? insetPadding,
    FVariantsDelta<FDialogAxisVariantConstraint, FDialogAxisVariant, FDialogContentStyle, FDialogContentStyleDelta>?
    contentStyle,
    FVariantsValueDelta<FDialogAxisVariantConstraint, FDialogAxisVariant, bool, Delta>? slideableActions,
    FDialogMotionDelta? motion,
  }) => .new(
    backgroundFilter: backgroundFilter == imageFilterFunctionSentinel ? this.backgroundFilter : backgroundFilter,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    insetPadding: insetPadding?.call(this.insetPadding) ?? this.insetPadding,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    slideableActions: slideableActions?.call(this.slideableActions) ?? this.slideableActions,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FDialogStyle] using the given factor [t].
  @useResult
  FDialogStyle lerp(FDialogStyle other, double t) => .new(
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    insetPadding: .lerp(insetPadding, other.insetPadding, t) ?? insetPadding,
    contentStyle: .lerpWhere(contentStyle, other.contentStyle, t, (a, b, t) => a!.lerp(b!, t)),
    slideableActions: t < 0.5 ? slideableActions : other.slideableActions,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FDialogStyleFunctions on Diagnosticable implements FDialogStyleDelta {
  /// Returns itself.
  @override
  FDialogStyle call(Object _) => this as FDialogStyle;

  ImageFilter Function(double)? get backgroundFilter;
  Decoration get decoration;
  EdgeInsetsGeometry get insetPadding;
  FVariants<FDialogAxisVariantConstraint, FDialogAxisVariant, FDialogContentStyle, FDialogContentStyleDelta>
  get contentStyle;
  FVariants<FDialogAxisVariantConstraint, FDialogAxisVariant, bool, Delta> get slideableActions;
  FDialogMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('insetPadding', insetPadding, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('slideableActions', slideableActions, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogStyle &&
          runtimeType == other.runtimeType &&
          backgroundFilter == other.backgroundFilter &&
          decoration == other.decoration &&
          insetPadding == other.insetPadding &&
          contentStyle == other.contentStyle &&
          slideableActions == other.slideableActions &&
          motion == other.motion);

  @override
  int get hashCode =>
      backgroundFilter.hashCode ^
      decoration.hashCode ^
      insetPadding.hashCode ^
      contentStyle.hashCode ^
      slideableActions.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FDialogStyle].
///
/// A [FDialogStyle] is itself a [FDialogStyleDelta].
abstract class FDialogStyleDelta with Delta {
  /// Creates a partial modification of a [FDialogStyle].
  ///
  /// ## Parameters
  /// * [FDialogStyle.backgroundFilter] -
  /// {@macro forui.widgets.FPopoverStyle.backgroundFilter}
  /// * [FDialogStyle.decoration] - The decoration.
  /// * [FDialogStyle.insetPadding] - The inset padding.
  /// * [FDialogStyle.contentStyle] - The dialog content's style.
  /// * [FDialogStyle.slideableActions] - Whether the dialog's actions support pressing an action and sliding to another.
  /// * [FDialogStyle.motion] - Motion-related properties.
  const factory FDialogStyleDelta.delta({
    ImageFilter Function(double)? backgroundFilter,
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? insetPadding,
    FVariantsDelta<FDialogAxisVariantConstraint, FDialogAxisVariant, FDialogContentStyle, FDialogContentStyleDelta>?
    contentStyle,
    FVariantsValueDelta<FDialogAxisVariantConstraint, FDialogAxisVariant, bool, Delta>? slideableActions,
    FDialogMotionDelta? motion,
  }) = _FDialogStyleDelta;

  /// Creates a delta that returns the [FDialogStyle] in the current context.
  const factory FDialogStyleDelta.context() = _FDialogStyleContext;

  @override
  FDialogStyle call(covariant FDialogStyle value);
}

class _FDialogStyleDelta implements FDialogStyleDelta {
  const _FDialogStyleDelta({
    this.backgroundFilter = imageFilterFunctionSentinel,
    this.decoration,
    this.insetPadding,
    this.contentStyle,
    this.slideableActions,
    this.motion,
  });

  final ImageFilter Function(double)? backgroundFilter;

  final DecorationDelta? decoration;

  final EdgeInsetsGeometryDelta? insetPadding;

  final FVariantsDelta<FDialogAxisVariantConstraint, FDialogAxisVariant, FDialogContentStyle, FDialogContentStyleDelta>?
  contentStyle;

  final FVariantsValueDelta<FDialogAxisVariantConstraint, FDialogAxisVariant, bool, Delta>? slideableActions;

  final FDialogMotionDelta? motion;

  @override
  FDialogStyle call(FDialogStyle original) => FDialogStyle(
    backgroundFilter: backgroundFilter == imageFilterFunctionSentinel ? original.backgroundFilter : backgroundFilter,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    insetPadding: insetPadding?.call(original.insetPadding) ?? original.insetPadding,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    slideableActions: slideableActions?.call(original.slideableActions) ?? original.slideableActions,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FDialogStyleContext implements FDialogStyleDelta {
  const _FDialogStyleContext();

  @override
  FDialogStyle call(FDialogStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogMotionTransformations on FDialogMotion {
  /// Returns a copy of this [FDialogMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDialogMotion.expandCurve] - The curve used for the dialog's expansion animation when entering.
  /// * [FDialogMotion.collapseCurve] - The curve used for the dialog's collapse animation when exiting.
  /// * [FDialogMotion.fadeInCurve] - The curve used for the dialog's fade-in animation when entering.
  /// * [FDialogMotion.fadeOutCurve] - The curve used for the dialog's fade-out animation when exiting.
  /// * [FDialogMotion.scaleTween] - The tween used to animate the dialog's scale in and out.
  /// * [FDialogMotion.fadeTween] - The tween used to animate the dialog's fade in and out.
  /// * [FDialogMotion.insetDuration] - The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  /// * [FDialogMotion.insetCurve] - The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is placed in.
  @useResult
  FDialogMotion copyWith({
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
    Duration? insetDuration,
    Curve? insetCurve,
  }) => .new(
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    scaleTween: scaleTween ?? this.scaleTween,
    fadeTween: fadeTween ?? this.fadeTween,
    insetDuration: insetDuration ?? this.insetDuration,
    insetCurve: insetCurve ?? this.insetCurve,
  );

  /// Linearly interpolate between this and another [FDialogMotion] using the given factor [t].
  @useResult
  FDialogMotion lerp(FDialogMotion other, double t) => .new(
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
    scaleTween: t < 0.5 ? scaleTween : other.scaleTween,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
    insetDuration: t < 0.5 ? insetDuration : other.insetDuration,
    insetCurve: t < 0.5 ? insetCurve : other.insetCurve,
  );
}

mixin _$FDialogMotionFunctions on Diagnosticable implements FDialogMotionDelta {
  /// Returns itself.
  @override
  FDialogMotion call(Object _) => this as FDialogMotion;

  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  Animatable<double> get scaleTween;
  Animatable<double> get fadeTween;
  Duration get insetDuration;
  Curve get insetCurve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: .debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: .debug))
      ..add(DiagnosticsProperty('scaleTween', scaleTween, level: .debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: .debug))
      ..add(DiagnosticsProperty('insetDuration', insetDuration, level: .debug))
      ..add(DiagnosticsProperty('insetCurve', insetCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogMotion &&
          runtimeType == other.runtimeType &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve &&
          scaleTween == other.scaleTween &&
          fadeTween == other.fadeTween &&
          insetDuration == other.insetDuration &&
          insetCurve == other.insetCurve);

  @override
  int get hashCode =>
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      fadeInCurve.hashCode ^
      fadeOutCurve.hashCode ^
      scaleTween.hashCode ^
      fadeTween.hashCode ^
      insetDuration.hashCode ^
      insetCurve.hashCode;
}

/// A delta that applies modifications to a [FDialogMotion].
///
/// A [FDialogMotion] is itself a [FDialogMotionDelta].
abstract class FDialogMotionDelta with Delta {
  /// Creates a partial modification of a [FDialogMotion].
  ///
  /// ## Parameters
  /// * [FDialogMotion.expandCurve] - The curve used for the dialog's expansion animation when entering.
  /// * [FDialogMotion.collapseCurve] - The curve used for the dialog's collapse animation when exiting.
  /// * [FDialogMotion.fadeInCurve] - The curve used for the dialog's fade-in animation when entering.
  /// * [FDialogMotion.fadeOutCurve] - The curve used for the dialog's fade-out animation when exiting.
  /// * [FDialogMotion.scaleTween] - The tween used to animate the dialog's scale in and out.
  /// * [FDialogMotion.fadeTween] - The tween used to animate the dialog's fade in and out.
  /// * [FDialogMotion.insetDuration] - The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  /// * [FDialogMotion.insetCurve] - The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is placed in.
  const factory FDialogMotionDelta.delta({
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
    Duration? insetDuration,
    Curve? insetCurve,
  }) = _FDialogMotionDelta;

  /// Creates a delta that returns the [FDialogMotion] in the current context.
  const factory FDialogMotionDelta.context() = _FDialogMotionContext;

  @override
  FDialogMotion call(covariant FDialogMotion value);
}

class _FDialogMotionDelta implements FDialogMotionDelta {
  const _FDialogMotionDelta({
    this.expandCurve,
    this.collapseCurve,
    this.fadeInCurve,
    this.fadeOutCurve,
    this.scaleTween,
    this.fadeTween,
    this.insetDuration,
    this.insetCurve,
  });

  final Curve? expandCurve;

  final Curve? collapseCurve;

  final Curve? fadeInCurve;

  final Curve? fadeOutCurve;

  final Animatable<double>? scaleTween;

  final Animatable<double>? fadeTween;

  final Duration? insetDuration;

  final Curve? insetCurve;

  @override
  FDialogMotion call(FDialogMotion original) => FDialogMotion(
    expandCurve: expandCurve ?? original.expandCurve,
    collapseCurve: collapseCurve ?? original.collapseCurve,
    fadeInCurve: fadeInCurve ?? original.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? original.fadeOutCurve,
    scaleTween: scaleTween ?? original.scaleTween,
    fadeTween: fadeTween ?? original.fadeTween,
    insetDuration: insetDuration ?? original.insetDuration,
    insetCurve: insetCurve ?? original.insetCurve,
  );
}

class _FDialogMotionContext implements FDialogMotionDelta {
  const _FDialogMotionContext();

  @override
  FDialogMotion call(FDialogMotion original) => original;
}

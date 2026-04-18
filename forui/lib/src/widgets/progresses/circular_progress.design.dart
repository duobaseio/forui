// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'circular_progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FCircularProgressSizeVariant], which represents individual variants.
extension type const FCircularProgressSizeVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FCircularProgressSizeVariantConstraint] that negates [variant].
  factory FCircularProgressSizeVariantConstraint.not(FCircularProgressSizeVariant variant) =>
      FCircularProgressSizeVariantConstraint._(Not(variant));

  /// The extra small circular progress size. Defaults to `typography.xs.fontSize`:
  /// * Desktop — 12.
  /// * Touch — 14.
  static const xs = FCircularProgressSizeVariant.xs;

  /// The small circular progress size. Defaults to `typography.sm.fontSize`:
  /// * Desktop — 14.
  /// * Touch — 16.
  static const sm = FCircularProgressSizeVariant.sm;

  /// The medium (default) circular progress size. Defaults to `typography.md.fontSize`:
  /// * Desktop — 16.
  /// * Touch — 18.
  static const md = FCircularProgressSizeVariant.md;

  /// The large circular progress size. Defaults to `typography.lg.fontSize`:
  /// * Desktop — 18.
  /// * Touch — 20.
  static const lg = FCircularProgressSizeVariant.lg;

  /// The extra large circular progress size. Defaults to `typography.xl.fontSize`:
  /// * Desktop — 20.
  /// * Touch — 22.
  static const xl = FCircularProgressSizeVariant.xl;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FCircularProgressSizeVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FCircularProgressSizeVariant._(Desktop());

  /// The Android platform variant.
  static const android = FCircularProgressSizeVariant.android;

  /// The iOS platform variant.
  static const iOS = FCircularProgressSizeVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FCircularProgressSizeVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FCircularProgressSizeVariant.windows;

  /// The macOS platform variant.
  static const macOS = FCircularProgressSizeVariant.macOS;

  /// The Linux platform variant.
  static const linux = FCircularProgressSizeVariant.linux;

  /// The web platform variant.
  static const web = FCircularProgressSizeVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FCircularProgressSizeVariantConstraint and(FCircularProgressSizeVariantConstraint other) =>
      FCircularProgressSizeVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FCircularProgressSizeVariantConstraint], which represents combinations of variants.
extension type const FCircularProgressSizeVariant._(FVariant _)
    implements FCircularProgressSizeVariantConstraint, FVariant {
  /// The extra small circular progress size. Defaults to `typography.xs.fontSize`:
  /// * Desktop — 12.
  /// * Touch — 14.
  static const xs = FCircularProgressSizeVariant._(.new(1, 'xs'));

  /// The small circular progress size. Defaults to `typography.sm.fontSize`:
  /// * Desktop — 14.
  /// * Touch — 16.
  static const sm = FCircularProgressSizeVariant._(.new(1, 'sm'));

  /// The medium (default) circular progress size. Defaults to `typography.md.fontSize`:
  /// * Desktop — 16.
  /// * Touch — 18.
  static const md = FCircularProgressSizeVariant._(.new(1, 'md'));

  /// The large circular progress size. Defaults to `typography.lg.fontSize`:
  /// * Desktop — 18.
  /// * Touch — 20.
  static const lg = FCircularProgressSizeVariant._(.new(1, 'lg'));

  /// The extra large circular progress size. Defaults to `typography.xl.fontSize`:
  /// * Desktop — 20.
  /// * Touch — 22.
  static const xl = FCircularProgressSizeVariant._(.new(1, 'xl'));

  /// The Android platform variant.
  static const android = FCircularProgressSizeVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FCircularProgressSizeVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FCircularProgressSizeVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FCircularProgressSizeVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FCircularProgressSizeVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FCircularProgressSizeVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FCircularProgressSizeVariant._(FPlatformVariant.web);
}

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

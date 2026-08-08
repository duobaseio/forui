// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tappable.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FTappableVariant], which represents individual variants.
extension type const FTappableVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FTappableVariantConstraint] that negates [variant].
  factory FTappableVariantConstraint.not(FTappableVariant variant) => FTappableVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FTappableVariant.disabled;

  /// The semantic variant when this item has been selected.
  static const selected = FTappableVariant.selected;

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FTappableVariant.primaryFocused;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FTappableVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FTappableVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FTappableVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FTappableVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FTappableVariant._(Desktop());

  /// The Android platform variant.
  static const android = FTappableVariant.android;

  /// The iOS platform variant.
  static const iOS = FTappableVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FTappableVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FTappableVariant.windows;

  /// The macOS platform variant.
  static const macOS = FTappableVariant.macOS;

  /// The Linux platform variant.
  static const linux = FTappableVariant.linux;

  /// The web platform variant.
  static const web = FTappableVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FTappableVariantConstraint and(FTappableVariantConstraint other) => FTappableVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FTappableVariantConstraint], which represents combinations of variants.
extension type const FTappableVariant._(FVariant _) implements FTappableVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FTappableVariant._(.new(2, 'disabled'));

  /// The semantic variant when this item has been selected.
  static const selected = FTappableVariant._(.new(2, 'selected'));

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FTappableVariant._(.new(1, 'primaryFocused'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FTappableVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FTappableVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FTappableVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FTappableVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FTappableVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FTappableVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FTappableVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FTappableVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FTappableVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FTappableVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FTappableStyleTransformations on FTappableStyle {
  /// Returns a copy of this [FTappableStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTappableStyle.cursor] - The mouse cursor for mouse pointers that are hovering over the region.
  /// * [FTappableStyle.pressedEnterDuration] - The duration to wait before applying the pressed effect after the user presses the tile.
  /// * [FTappableStyle.pressedExitDuration] - The duration to wait before removing the pressed effect after the user stops pressing the tile.
  /// * [FTappableStyle.motion] - Motion-related properties for the tappable.
  @useResult
  FTappableStyle copyWith({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, MouseCursor, Delta>? cursor,
    Duration? pressedEnterDuration,
    Duration? pressedExitDuration,
    FTappableMotionDelta? motion,
  }) => .new(
    cursor: cursor?.call(this.cursor) ?? this.cursor,
    pressedEnterDuration: pressedEnterDuration ?? this.pressedEnterDuration,
    pressedExitDuration: pressedExitDuration ?? this.pressedExitDuration,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FTappableStyle] using the given factor [t].
  @useResult
  FTappableStyle lerp(FTappableStyle other, double t) => .new(
    cursor: t < 0.5 ? cursor : other.cursor,
    pressedEnterDuration: t < 0.5 ? pressedEnterDuration : other.pressedEnterDuration,
    pressedExitDuration: t < 0.5 ? pressedExitDuration : other.pressedExitDuration,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FTappableStyleFunctions on Diagnosticable implements FTappableStyleDelta {
  /// Returns itself.
  @override
  FTappableStyle call(Object _) => this as FTappableStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, MouseCursor, Delta> get cursor;
  Duration get pressedEnterDuration;
  Duration get pressedExitDuration;
  FTappableMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('cursor', cursor, level: .debug))
      ..add(DiagnosticsProperty('pressedEnterDuration', pressedEnterDuration, level: .debug))
      ..add(DiagnosticsProperty('pressedExitDuration', pressedExitDuration, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTappableStyle &&
          runtimeType == other.runtimeType &&
          cursor == other.cursor &&
          pressedEnterDuration == other.pressedEnterDuration &&
          pressedExitDuration == other.pressedExitDuration &&
          motion == other.motion);

  @override
  int get hashCode => cursor.hashCode ^ pressedEnterDuration.hashCode ^ pressedExitDuration.hashCode ^ motion.hashCode;
}

/// A delta that applies modifications to a [FTappableStyle].
///
/// A [FTappableStyle] is itself a [FTappableStyleDelta].
abstract class FTappableStyleDelta with Delta {
  /// Creates a partial modification of a [FTappableStyle].
  ///
  /// ## Parameters
  /// * [FTappableStyle.cursor] - The mouse cursor for mouse pointers that are hovering over the region.
  /// * [FTappableStyle.pressedEnterDuration] - The duration to wait before applying the pressed effect after the user presses the tile.
  /// * [FTappableStyle.pressedExitDuration] - The duration to wait before removing the pressed effect after the user stops pressing the tile.
  /// * [FTappableStyle.motion] - Motion-related properties for the tappable.
  const factory FTappableStyleDelta.delta({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, MouseCursor, Delta>? cursor,
    Duration? pressedEnterDuration,
    Duration? pressedExitDuration,
    FTappableMotionDelta? motion,
  }) = _FTappableStyleDelta;

  /// Creates a delta that returns the [FTappableStyle] in the current context.
  const factory FTappableStyleDelta.context() = _FTappableStyleContext;

  @override
  FTappableStyle call(covariant FTappableStyle value);
}

class _FTappableStyleDelta implements FTappableStyleDelta {
  const _FTappableStyleDelta({this.cursor, this.pressedEnterDuration, this.pressedExitDuration, this.motion});

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, MouseCursor, Delta>? cursor;

  final Duration? pressedEnterDuration;

  final Duration? pressedExitDuration;

  final FTappableMotionDelta? motion;

  @override
  FTappableStyle call(FTappableStyle original) => FTappableStyle(
    cursor: cursor?.call(original.cursor) ?? original.cursor,
    pressedEnterDuration: pressedEnterDuration ?? original.pressedEnterDuration,
    pressedExitDuration: pressedExitDuration ?? original.pressedExitDuration,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FTappableStyleContext implements FTappableStyleDelta {
  const _FTappableStyleContext();

  @override
  FTappableStyle call(FTappableStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FTappableMotionTransformations on FTappableMotion {
  /// Returns a copy of this [FTappableMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FTappableMotion.bounceDownDuration] - The bounce animation's duration when the tappable is pressed down.
  /// * [FTappableMotion.bounceUpDuration] - The bounce animation's duration when the tappable is released (up).
  /// * [FTappableMotion.bounceDownCurve] - The curve used to animate the scale of the tappable when pressed (down).
  /// * [FTappableMotion.bounceUpCurve] - The curve used to animate the scale of the tappable when released (up).
  /// * [FTappableMotion.bounceTween] - The bounce's tween.
  /// * [FTappableMotion.bounceFloor] - The maximum number of pixels that the tappable can shrink during the bounce animation regardless of widget size.
  @useResult
  FTappableMotion copyWith({
    Duration? bounceDownDuration,
    Duration? bounceUpDuration,
    Curve? bounceDownCurve,
    Curve? bounceUpCurve,
    Animatable<double>? bounceTween,
    double? Function()? bounceFloor,
  }) => .new(
    bounceDownDuration: bounceDownDuration ?? this.bounceDownDuration,
    bounceUpDuration: bounceUpDuration ?? this.bounceUpDuration,
    bounceDownCurve: bounceDownCurve ?? this.bounceDownCurve,
    bounceUpCurve: bounceUpCurve ?? this.bounceUpCurve,
    bounceTween: bounceTween ?? this.bounceTween,
    bounceFloor: bounceFloor == null ? this.bounceFloor : bounceFloor(),
  );

  /// Linearly interpolate between this and another [FTappableMotion] using the given factor [t].
  @useResult
  FTappableMotion lerp(FTappableMotion other, double t) => .new(
    bounceDownDuration: t < 0.5 ? bounceDownDuration : other.bounceDownDuration,
    bounceUpDuration: t < 0.5 ? bounceUpDuration : other.bounceUpDuration,
    bounceDownCurve: t < 0.5 ? bounceDownCurve : other.bounceDownCurve,
    bounceUpCurve: t < 0.5 ? bounceUpCurve : other.bounceUpCurve,
    bounceTween: t < 0.5 ? bounceTween : other.bounceTween,
    bounceFloor: lerpDouble(bounceFloor, other.bounceFloor, t) ?? bounceFloor,
  );
}

mixin _$FTappableMotionFunctions on Diagnosticable implements FTappableMotionDelta {
  /// Returns itself.
  @override
  FTappableMotion call(Object _) => this as FTappableMotion;

  Duration get bounceDownDuration;
  Duration get bounceUpDuration;
  Curve get bounceDownCurve;
  Curve get bounceUpCurve;
  Animatable<double> get bounceTween;
  double? get bounceFloor;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('bounceDownDuration', bounceDownDuration, level: .debug))
      ..add(DiagnosticsProperty('bounceUpDuration', bounceUpDuration, level: .debug))
      ..add(DiagnosticsProperty('bounceDownCurve', bounceDownCurve, level: .debug))
      ..add(DiagnosticsProperty('bounceUpCurve', bounceUpCurve, level: .debug))
      ..add(DiagnosticsProperty('bounceTween', bounceTween, level: .debug))
      ..add(DoubleProperty('bounceFloor', bounceFloor, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTappableMotion &&
          runtimeType == other.runtimeType &&
          bounceDownDuration == other.bounceDownDuration &&
          bounceUpDuration == other.bounceUpDuration &&
          bounceDownCurve == other.bounceDownCurve &&
          bounceUpCurve == other.bounceUpCurve &&
          bounceTween == other.bounceTween &&
          bounceFloor == other.bounceFloor);

  @override
  int get hashCode =>
      bounceDownDuration.hashCode ^
      bounceUpDuration.hashCode ^
      bounceDownCurve.hashCode ^
      bounceUpCurve.hashCode ^
      bounceTween.hashCode ^
      bounceFloor.hashCode;
}

/// A delta that applies modifications to a [FTappableMotion].
///
/// A [FTappableMotion] is itself a [FTappableMotionDelta].
abstract class FTappableMotionDelta with Delta {
  /// Creates a partial modification of a [FTappableMotion].
  ///
  /// ## Parameters
  /// * [FTappableMotion.bounceDownDuration] - The bounce animation's duration when the tappable is pressed down.
  /// * [FTappableMotion.bounceUpDuration] - The bounce animation's duration when the tappable is released (up).
  /// * [FTappableMotion.bounceDownCurve] - The curve used to animate the scale of the tappable when pressed (down).
  /// * [FTappableMotion.bounceUpCurve] - The curve used to animate the scale of the tappable when released (up).
  /// * [FTappableMotion.bounceTween] - The bounce's tween.
  /// * [FTappableMotion.bounceFloor] - The maximum number of pixels that the tappable can shrink during the bounce animation regardless of widget size.
  const factory FTappableMotionDelta.delta({
    Duration? bounceDownDuration,
    Duration? bounceUpDuration,
    Curve? bounceDownCurve,
    Curve? bounceUpCurve,
    Animatable<double>? bounceTween,
    double? Function()? bounceFloor,
  }) = _FTappableMotionDelta;

  /// Creates a delta that returns the [FTappableMotion] in the current context.
  const factory FTappableMotionDelta.context() = _FTappableMotionContext;

  @override
  FTappableMotion call(covariant FTappableMotion value);
}

class _FTappableMotionDelta implements FTappableMotionDelta {
  const _FTappableMotionDelta({
    this.bounceDownDuration,
    this.bounceUpDuration,
    this.bounceDownCurve,
    this.bounceUpCurve,
    this.bounceTween,
    this.bounceFloor,
  });

  final Duration? bounceDownDuration;

  final Duration? bounceUpDuration;

  final Curve? bounceDownCurve;

  final Curve? bounceUpCurve;

  final Animatable<double>? bounceTween;

  final double? Function()? bounceFloor;

  @override
  FTappableMotion call(FTappableMotion original) => FTappableMotion(
    bounceDownDuration: bounceDownDuration ?? original.bounceDownDuration,
    bounceUpDuration: bounceUpDuration ?? original.bounceUpDuration,
    bounceDownCurve: bounceDownCurve ?? original.bounceDownCurve,
    bounceUpCurve: bounceUpCurve ?? original.bounceUpCurve,
    bounceTween: bounceTween ?? original.bounceTween,
    bounceFloor: bounceFloor == null ? original.bounceFloor : bounceFloor!(),
  );
}

class _FTappableMotionContext implements FTappableMotionDelta {
  const _FTappableMotionContext();

  @override
  FTappableMotion call(FTappableMotion original) => original;
}

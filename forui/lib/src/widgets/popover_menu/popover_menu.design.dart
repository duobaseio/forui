// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover_menu.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverMenuStyleTransformations on FPopoverMenuStyle {
  /// Returns a copy of this [FPopoverMenuStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FPopoverMenuStyle.itemGroupStyle] - The item group's style.
  /// * [FPopoverMenuStyle.tileGroupStyle] - The tile group's style.
  /// * [FPopoverMenuStyle.minWidth] - The menu's min width.
  /// * [FPopoverMenuStyle.maxWidth] - The menu's max width.
  /// * [FPopoverMenuStyle.hoverEnterDuration] - The delay before showing a submenu when the pointer enters an item.
  /// * [FPopoverMenuStyle.menuMotion] - The popover menu's motion configuration.
  /// * [FPopoverMenuStyle.hapticFeedback] - The haptic feedback for when a submenu is shown via long press.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverMenuStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverMenuStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  /// * [FPopoverMenuStyle.motion] - The popover's motion configuration.
  @useResult
  FPopoverMenuStyle copyWith({
    FItemGroupStyleDelta? itemGroupStyle,
    FTileGroupStyleDelta? tileGroupStyle,
    double? minWidth,
    double? maxWidth,
    Duration? hoverEnterDuration,
    FPopoverMenuMotionDelta? menuMotion,
    Future<void> Function()? hapticFeedback,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
    FPopoverMotionDelta? motion,
  }) => .new(
    itemGroupStyle: itemGroupStyle?.call(this.itemGroupStyle) ?? this.itemGroupStyle,
    tileGroupStyle: tileGroupStyle?.call(this.tileGroupStyle) ?? this.tileGroupStyle,
    minWidth: minWidth ?? this.minWidth,
    maxWidth: maxWidth ?? this.maxWidth,
    hoverEnterDuration: hoverEnterDuration ?? this.hoverEnterDuration,
    menuMotion: menuMotion?.call(this.menuMotion) ?? this.menuMotion,
    hapticFeedback: hapticFeedback ?? this.hapticFeedback,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    backgroundFilter: backgroundFilter == null ? this.backgroundFilter : backgroundFilter(),
    popoverPadding: popoverPadding?.call(this.popoverPadding) ?? this.popoverPadding,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FPopoverMenuStyle] using the given factor [t].
  @useResult
  FPopoverMenuStyle lerp(FPopoverMenuStyle other, double t) => .new(
    itemGroupStyle: itemGroupStyle.lerp(other.itemGroupStyle, t),
    tileGroupStyle: tileGroupStyle.lerp(other.tileGroupStyle, t),
    minWidth: lerpDouble(minWidth, other.minWidth, t) ?? minWidth,
    maxWidth: lerpDouble(maxWidth, other.maxWidth, t) ?? maxWidth,
    hoverEnterDuration: t < 0.5 ? hoverEnterDuration : other.hoverEnterDuration,
    menuMotion: menuMotion.lerp(other.menuMotion, t),
    hapticFeedback: t < 0.5 ? hapticFeedback : other.hapticFeedback,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    popoverPadding: .lerp(popoverPadding, other.popoverPadding, t) ?? popoverPadding,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FPopoverMenuStyleFunctions on Diagnosticable implements FPopoverMenuStyleDelta {
  /// Returns itself.
  @override
  FPopoverMenuStyle call(Object _) => this as FPopoverMenuStyle;

  FItemGroupStyle get itemGroupStyle;
  FTileGroupStyle get tileGroupStyle;
  double get minWidth;
  double get maxWidth;
  Duration get hoverEnterDuration;
  FPopoverMenuMotion get menuMotion;
  Future<void> Function() get hapticFeedback;
  Decoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get popoverPadding;
  FPopoverMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemGroupStyle', itemGroupStyle, level: .debug))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle, level: .debug))
      ..add(DoubleProperty('minWidth', minWidth, level: .debug))
      ..add(DoubleProperty('maxWidth', maxWidth, level: .debug))
      ..add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration, level: .debug))
      ..add(DiagnosticsProperty('menuMotion', menuMotion, level: .debug))
      ..add(DiagnosticsProperty('hapticFeedback', hapticFeedback, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMenuStyle &&
          runtimeType == other.runtimeType &&
          itemGroupStyle == other.itemGroupStyle &&
          tileGroupStyle == other.tileGroupStyle &&
          minWidth == other.minWidth &&
          maxWidth == other.maxWidth &&
          hoverEnterDuration == other.hoverEnterDuration &&
          menuMotion == other.menuMotion &&
          hapticFeedback == other.hapticFeedback &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          popoverPadding == other.popoverPadding &&
          motion == other.motion);

  @override
  int get hashCode =>
      itemGroupStyle.hashCode ^
      tileGroupStyle.hashCode ^
      minWidth.hashCode ^
      maxWidth.hashCode ^
      hoverEnterDuration.hashCode ^
      menuMotion.hashCode ^
      hapticFeedback.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      popoverPadding.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FPopoverMenuStyle].
///
/// A [FPopoverMenuStyle] is itself a [FPopoverMenuStyleDelta].
abstract class FPopoverMenuStyleDelta with Delta {
  /// Creates a partial modification of a [FPopoverMenuStyle].
  ///
  /// ## Parameters
  /// * [FPopoverMenuStyle.itemGroupStyle] - The item group's style.
  /// * [FPopoverMenuStyle.tileGroupStyle] - The tile group's style.
  /// * [FPopoverMenuStyle.minWidth] - The menu's min width.
  /// * [FPopoverMenuStyle.maxWidth] - The menu's max width.
  /// * [FPopoverMenuStyle.hoverEnterDuration] - The delay before showing a submenu when the pointer enters an item.
  /// * [FPopoverMenuStyle.menuMotion] - The popover menu's motion configuration.
  /// * [FPopoverMenuStyle.hapticFeedback] - The haptic feedback for when a submenu is shown via long press.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverMenuStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverMenuStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  /// * [FPopoverMenuStyle.motion] - The popover's motion configuration.
  const factory FPopoverMenuStyleDelta.delta({
    FItemGroupStyleDelta? itemGroupStyle,
    FTileGroupStyleDelta? tileGroupStyle,
    double? minWidth,
    double? maxWidth,
    Duration? hoverEnterDuration,
    FPopoverMenuMotionDelta? menuMotion,
    Future<void> Function()? hapticFeedback,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
    FPopoverMotionDelta? motion,
  }) = _FPopoverMenuStyleDelta;

  /// Creates a delta that returns the [FPopoverMenuStyle] in the current context.
  const factory FPopoverMenuStyleDelta.context() = _FPopoverMenuStyleContext;

  @override
  FPopoverMenuStyle call(covariant FPopoverMenuStyle value);
}

class _FPopoverMenuStyleDelta implements FPopoverMenuStyleDelta {
  const _FPopoverMenuStyleDelta({
    this.itemGroupStyle,
    this.tileGroupStyle,
    this.minWidth,
    this.maxWidth,
    this.hoverEnterDuration,
    this.menuMotion,
    this.hapticFeedback,
    this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.popoverPadding,
    this.motion,
  });

  final FItemGroupStyleDelta? itemGroupStyle;

  final FTileGroupStyleDelta? tileGroupStyle;

  final double? minWidth;

  final double? maxWidth;

  final Duration? hoverEnterDuration;

  final FPopoverMenuMotionDelta? menuMotion;

  final Future<void> Function()? hapticFeedback;

  final DecorationDelta? decoration;

  final ImageFilter Function(double)? Function()? barrierFilter;

  final ImageFilter Function(double)? Function()? backgroundFilter;

  final EdgeInsetsGeometryDelta? popoverPadding;

  final FPopoverMotionDelta? motion;

  @override
  FPopoverMenuStyle call(FPopoverMenuStyle original) => FPopoverMenuStyle(
    itemGroupStyle: itemGroupStyle?.call(original.itemGroupStyle) ?? original.itemGroupStyle,
    tileGroupStyle: tileGroupStyle?.call(original.tileGroupStyle) ?? original.tileGroupStyle,
    minWidth: minWidth ?? original.minWidth,
    maxWidth: maxWidth ?? original.maxWidth,
    hoverEnterDuration: hoverEnterDuration ?? original.hoverEnterDuration,
    menuMotion: menuMotion?.call(original.menuMotion) ?? original.menuMotion,
    hapticFeedback: hapticFeedback ?? original.hapticFeedback,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    popoverPadding: popoverPadding?.call(original.popoverPadding) ?? original.popoverPadding,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FPopoverMenuStyleContext implements FPopoverMenuStyleDelta {
  const _FPopoverMenuStyleContext();

  @override
  FPopoverMenuStyle call(FPopoverMenuStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverMenuMotionTransformations on FPopoverMenuMotion {
  /// Returns a copy of this [FPopoverMenuMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FPopoverMenuMotion.fade] - The fade applied to the parent menu when a submenu is active.
  /// * [FPopoverMenuMotion.fadeDuration] - The fade duration.
  /// * [FPopoverMenuMotion.fadeCurve] - The fade curve.
  @useResult
  FPopoverMenuMotion copyWith({double? fade, Duration? fadeDuration, Curve? fadeCurve}) => .new(
    fade: fade ?? this.fade,
    fadeDuration: fadeDuration ?? this.fadeDuration,
    fadeCurve: fadeCurve ?? this.fadeCurve,
  );

  /// Linearly interpolate between this and another [FPopoverMenuMotion] using the given factor [t].
  @useResult
  FPopoverMenuMotion lerp(FPopoverMenuMotion other, double t) => .new(
    fade: lerpDouble(fade, other.fade, t) ?? fade,
    fadeDuration: t < 0.5 ? fadeDuration : other.fadeDuration,
    fadeCurve: t < 0.5 ? fadeCurve : other.fadeCurve,
  );
}

mixin _$FPopoverMenuMotionFunctions on Diagnosticable implements FPopoverMenuMotionDelta {
  /// Returns itself.
  @override
  FPopoverMenuMotion call(Object _) => this as FPopoverMenuMotion;

  double get fade;
  Duration get fadeDuration;
  Curve get fadeCurve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('fade', fade, level: .debug))
      ..add(DiagnosticsProperty('fadeDuration', fadeDuration, level: .debug))
      ..add(DiagnosticsProperty('fadeCurve', fadeCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMenuMotion &&
          runtimeType == other.runtimeType &&
          fade == other.fade &&
          fadeDuration == other.fadeDuration &&
          fadeCurve == other.fadeCurve);

  @override
  int get hashCode => fade.hashCode ^ fadeDuration.hashCode ^ fadeCurve.hashCode;
}

/// A delta that applies modifications to a [FPopoverMenuMotion].
///
/// A [FPopoverMenuMotion] is itself a [FPopoverMenuMotionDelta].
abstract class FPopoverMenuMotionDelta with Delta {
  /// Creates a partial modification of a [FPopoverMenuMotion].
  ///
  /// ## Parameters
  /// * [FPopoverMenuMotion.fade] - The fade applied to the parent menu when a submenu is active.
  /// * [FPopoverMenuMotion.fadeDuration] - The fade duration.
  /// * [FPopoverMenuMotion.fadeCurve] - The fade curve.
  const factory FPopoverMenuMotionDelta.delta({double? fade, Duration? fadeDuration, Curve? fadeCurve}) =
      _FPopoverMenuMotionDelta;

  /// Creates a delta that returns the [FPopoverMenuMotion] in the current context.
  const factory FPopoverMenuMotionDelta.context() = _FPopoverMenuMotionContext;

  @override
  FPopoverMenuMotion call(covariant FPopoverMenuMotion value);
}

class _FPopoverMenuMotionDelta implements FPopoverMenuMotionDelta {
  const _FPopoverMenuMotionDelta({this.fade, this.fadeDuration, this.fadeCurve});

  final double? fade;

  final Duration? fadeDuration;

  final Curve? fadeCurve;

  @override
  FPopoverMenuMotion call(FPopoverMenuMotion original) => FPopoverMenuMotion(
    fade: fade ?? original.fade,
    fadeDuration: fadeDuration ?? original.fadeDuration,
    fadeCurve: fadeCurve ?? original.fadeCurve,
  );
}

class _FPopoverMenuMotionContext implements FPopoverMenuMotionDelta {
  const _FPopoverMenuMotionContext();

  @override
  FPopoverMenuMotion call(FPopoverMenuMotion original) => original;
}

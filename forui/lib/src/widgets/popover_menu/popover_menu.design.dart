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
  /// * [FPopoverMenuStyle.motion] - The hover motion configuration for submenus.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverMenuStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverMenuStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  @useResult
  FPopoverMenuStyle copyWith({
    FItemGroupStyleDelta? itemGroupStyle,
    FTileGroupStyleDelta? tileGroupStyle,
    double? minWidth,
    double? maxWidth,
    FPopoverMenuMotionDelta? motion,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
  }) => .new(
    itemGroupStyle: itemGroupStyle?.call(this.itemGroupStyle) ?? this.itemGroupStyle,
    tileGroupStyle: tileGroupStyle?.call(this.tileGroupStyle) ?? this.tileGroupStyle,
    minWidth: minWidth ?? this.minWidth,
    maxWidth: maxWidth ?? this.maxWidth,
    motion: motion?.call(this.motion) ?? this.motion,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    backgroundFilter: backgroundFilter == null ? this.backgroundFilter : backgroundFilter(),
    popoverPadding: popoverPadding?.call(this.popoverPadding) ?? this.popoverPadding,
  );

  /// Linearly interpolate between this and another [FPopoverMenuStyle] using the given factor [t].
  @useResult
  FPopoverMenuStyle lerp(FPopoverMenuStyle other, double t) => .new(
    itemGroupStyle: itemGroupStyle.lerp(other.itemGroupStyle, t),
    tileGroupStyle: tileGroupStyle.lerp(other.tileGroupStyle, t),
    minWidth: lerpDouble(minWidth, other.minWidth, t) ?? minWidth,
    maxWidth: lerpDouble(maxWidth, other.maxWidth, t) ?? maxWidth,
    motion: motion.lerp(other.motion, t),
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    popoverPadding: .lerp(popoverPadding, other.popoverPadding, t) ?? popoverPadding,
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
  FPopoverMenuMotion get motion;
  Decoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get popoverPadding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemGroupStyle', itemGroupStyle, level: .debug))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle, level: .debug))
      ..add(DoubleProperty('minWidth', minWidth, level: .debug))
      ..add(DoubleProperty('maxWidth', maxWidth, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
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
          motion == other.motion &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          popoverPadding == other.popoverPadding);

  @override
  int get hashCode =>
      itemGroupStyle.hashCode ^
      tileGroupStyle.hashCode ^
      minWidth.hashCode ^
      maxWidth.hashCode ^
      motion.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      popoverPadding.hashCode;
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
  /// * [FPopoverMenuStyle.motion] - The hover motion configuration for submenus.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverMenuStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverMenuStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  const factory FPopoverMenuStyleDelta.delta({
    FItemGroupStyleDelta? itemGroupStyle,
    FTileGroupStyleDelta? tileGroupStyle,
    double? minWidth,
    double? maxWidth,
    FPopoverMenuMotionDelta? motion,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
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
    this.motion,
    this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.popoverPadding,
  });

  final FItemGroupStyleDelta? itemGroupStyle;

  final FTileGroupStyleDelta? tileGroupStyle;

  final double? minWidth;

  final double? maxWidth;

  final FPopoverMenuMotionDelta? motion;

  final DecorationDelta? decoration;

  final ImageFilter Function(double)? Function()? barrierFilter;

  final ImageFilter Function(double)? Function()? backgroundFilter;

  final EdgeInsetsGeometryDelta? popoverPadding;

  @override
  FPopoverMenuStyle call(FPopoverMenuStyle original) => FPopoverMenuStyle(
    itemGroupStyle: itemGroupStyle?.call(original.itemGroupStyle) ?? original.itemGroupStyle,
    tileGroupStyle: tileGroupStyle?.call(original.tileGroupStyle) ?? original.tileGroupStyle,
    minWidth: minWidth ?? original.minWidth,
    maxWidth: maxWidth ?? original.maxWidth,
    motion: motion?.call(original.motion) ?? original.motion,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    popoverPadding: popoverPadding?.call(original.popoverPadding) ?? original.popoverPadding,
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
  /// * [FPopoverMenuMotion.hoverEnterDuration] - The delay before showing a submenu when the pointer enters an item.
  @useResult
  FPopoverMenuMotion copyWith({Duration? hoverEnterDuration}) =>
      .new(hoverEnterDuration: hoverEnterDuration ?? this.hoverEnterDuration);

  /// Linearly interpolate between this and another [FPopoverMenuMotion] using the given factor [t].
  @useResult
  FPopoverMenuMotion lerp(FPopoverMenuMotion other, double t) =>
      .new(hoverEnterDuration: t < 0.5 ? hoverEnterDuration : other.hoverEnterDuration);
}

mixin _$FPopoverMenuMotionFunctions on Diagnosticable implements FPopoverMenuMotionDelta {
  /// Returns itself.
  @override
  FPopoverMenuMotion call(Object _) => this as FPopoverMenuMotion;

  Duration get hoverEnterDuration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMenuMotion &&
          runtimeType == other.runtimeType &&
          hoverEnterDuration == other.hoverEnterDuration);

  @override
  int get hashCode => hoverEnterDuration.hashCode;
}

/// A delta that applies modifications to a [FPopoverMenuMotion].
///
/// A [FPopoverMenuMotion] is itself a [FPopoverMenuMotionDelta].
abstract class FPopoverMenuMotionDelta with Delta {
  /// Creates a partial modification of a [FPopoverMenuMotion].
  ///
  /// ## Parameters
  /// * [FPopoverMenuMotion.hoverEnterDuration] - The delay before showing a submenu when the pointer enters an item.
  const factory FPopoverMenuMotionDelta.delta({Duration? hoverEnterDuration}) = _FPopoverMenuMotionDelta;

  /// Creates a delta that returns the [FPopoverMenuMotion] in the current context.
  const factory FPopoverMenuMotionDelta.context() = _FPopoverMenuMotionContext;

  @override
  FPopoverMenuMotion call(covariant FPopoverMenuMotion value);
}

class _FPopoverMenuMotionDelta implements FPopoverMenuMotionDelta {
  const _FPopoverMenuMotionDelta({this.hoverEnterDuration});

  final Duration? hoverEnterDuration;

  @override
  FPopoverMenuMotion call(FPopoverMenuMotion original) =>
      FPopoverMenuMotion(hoverEnterDuration: hoverEnterDuration ?? original.hoverEnterDuration);
}

class _FPopoverMenuMotionContext implements FPopoverMenuMotionDelta {
  const _FPopoverMenuMotionContext();

  @override
  FPopoverMenuMotion call(FPopoverMenuMotion original) => original;
}

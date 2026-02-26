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
  /// * [FPopoverMenuStyle.maxWidth] - The menu's max width.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverMenuStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverMenuStyle.viewInsets] - The additional insets of the view.
  @useResult
  FPopoverMenuStyle copyWith({
    FItemGroupStyleDelta? itemGroupStyle,
    FTileGroupStyleDelta? tileGroupStyle,
    double? maxWidth,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? viewInsets,
  }) => .new(
    itemGroupStyle: itemGroupStyle?.call(this.itemGroupStyle) ?? this.itemGroupStyle,
    tileGroupStyle: tileGroupStyle?.call(this.tileGroupStyle) ?? this.tileGroupStyle,
    maxWidth: maxWidth ?? this.maxWidth,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    backgroundFilter: backgroundFilter == null ? this.backgroundFilter : backgroundFilter(),
    viewInsets: viewInsets?.call(this.viewInsets) ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FPopoverMenuStyle] using the given factor [t].
  @useResult
  FPopoverMenuStyle lerp(FPopoverMenuStyle other, double t) => .new(
    itemGroupStyle: itemGroupStyle.lerp(other.itemGroupStyle, t),
    tileGroupStyle: tileGroupStyle.lerp(other.tileGroupStyle, t),
    maxWidth: lerpDouble(maxWidth, other.maxWidth, t) ?? maxWidth,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: .lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FPopoverMenuStyleFunctions on Diagnosticable implements FPopoverMenuStyleDelta {
  /// Returns itself.
  @override
  FPopoverMenuStyle call(Object _) => this as FPopoverMenuStyle;

  FItemGroupStyle get itemGroupStyle;
  FTileGroupStyle get tileGroupStyle;
  double get maxWidth;
  Decoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemGroupStyle', itemGroupStyle, level: .debug))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle, level: .debug))
      ..add(DoubleProperty('maxWidth', maxWidth, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMenuStyle &&
          runtimeType == other.runtimeType &&
          itemGroupStyle == other.itemGroupStyle &&
          tileGroupStyle == other.tileGroupStyle &&
          maxWidth == other.maxWidth &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode =>
      itemGroupStyle.hashCode ^
      tileGroupStyle.hashCode ^
      maxWidth.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      viewInsets.hashCode;
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
  /// * [FPopoverMenuStyle.maxWidth] - The menu's max width.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FPopoverMenuStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FPopoverMenuStyle.viewInsets] - The additional insets of the view.
  const factory FPopoverMenuStyleDelta.delta({
    FItemGroupStyleDelta? itemGroupStyle,
    FTileGroupStyleDelta? tileGroupStyle,
    double? maxWidth,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? viewInsets,
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
    this.maxWidth,
    this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.viewInsets,
  });

  final FItemGroupStyleDelta? itemGroupStyle;

  final FTileGroupStyleDelta? tileGroupStyle;

  final double? maxWidth;

  final DecorationDelta? decoration;

  final ImageFilter Function(double)? Function()? barrierFilter;

  final ImageFilter Function(double)? Function()? backgroundFilter;

  final EdgeInsetsGeometryDelta? viewInsets;

  @override
  FPopoverMenuStyle call(FPopoverMenuStyle original) => FPopoverMenuStyle(
    itemGroupStyle: itemGroupStyle?.call(original.itemGroupStyle) ?? original.itemGroupStyle,
    tileGroupStyle: tileGroupStyle?.call(original.tileGroupStyle) ?? original.tileGroupStyle,
    maxWidth: maxWidth ?? original.maxWidth,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    viewInsets: viewInsets?.call(original.viewInsets) ?? original.viewInsets,
  );
}

class _FPopoverMenuStyleContext implements FPopoverMenuStyleDelta {
  const _FPopoverMenuStyleContext();

  @override
  FPopoverMenuStyle call(FPopoverMenuStyle original) => original;
}

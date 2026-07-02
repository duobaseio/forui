// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectContentStyleTransformations on FSelectContentStyle {
  /// Returns a copy of this [FSelectContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectContentStyle.sectionStyle] - A section's style.
  /// * [FSelectContentStyle.scrollHandleStyle] - A scroll handle's style.
  /// * [FSelectContentStyle.padding] - The padding surrounding the content.
  /// * [FSelectContentStyle.decoration] - The popover's decoration.
  /// * [FSelectContentStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FSelectContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FSelectContentStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  /// * [FSelectContentStyle.motion] - The popover's motion configuration.
  @useResult
  FSelectContentStyle copyWith({
    FSelectSectionStyleDelta? sectionStyle,
    FSelectScrollHandleStyleDelta? scrollHandleStyle,
    EdgeInsetsGeometryDelta? padding,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
    FPopoverMotionDelta? motion,
  }) => .new(
    sectionStyle: sectionStyle?.call(this.sectionStyle) ?? this.sectionStyle,
    scrollHandleStyle: scrollHandleStyle?.call(this.scrollHandleStyle) ?? this.scrollHandleStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    backgroundFilter: backgroundFilter == null ? this.backgroundFilter : backgroundFilter(),
    popoverPadding: popoverPadding?.call(this.popoverPadding) ?? this.popoverPadding,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FSelectContentStyle] using the given factor [t].
  @useResult
  FSelectContentStyle lerp(FSelectContentStyle other, double t) => .new(
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
    scrollHandleStyle: scrollHandleStyle.lerp(other.scrollHandleStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    popoverPadding: .lerp(popoverPadding, other.popoverPadding, t) ?? popoverPadding,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FSelectContentStyleFunctions on Diagnosticable implements FSelectContentStyleDelta {
  /// Returns itself.
  @override
  FSelectContentStyle call(Object _) => this as FSelectContentStyle;

  FSelectSectionStyle get sectionStyle;
  FSelectScrollHandleStyle get scrollHandleStyle;
  EdgeInsetsGeometry get padding;
  Decoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get popoverPadding;
  FPopoverMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: .debug))
      ..add(DiagnosticsProperty('scrollHandleStyle', scrollHandleStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectContentStyle &&
          runtimeType == other.runtimeType &&
          sectionStyle == other.sectionStyle &&
          scrollHandleStyle == other.scrollHandleStyle &&
          padding == other.padding &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          popoverPadding == other.popoverPadding &&
          motion == other.motion);

  @override
  int get hashCode =>
      sectionStyle.hashCode ^
      scrollHandleStyle.hashCode ^
      padding.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      popoverPadding.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FSelectContentStyle].
///
/// A [FSelectContentStyle] is itself a [FSelectContentStyleDelta].
abstract class FSelectContentStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectContentStyle].
  ///
  /// ## Parameters
  /// * [FSelectContentStyle.sectionStyle] - A section's style.
  /// * [FSelectContentStyle.scrollHandleStyle] - A scroll handle's style.
  /// * [FSelectContentStyle.padding] - The padding surrounding the content.
  /// * [FSelectContentStyle.decoration] - The popover's decoration.
  /// * [FSelectContentStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FSelectContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FSelectContentStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  /// * [FSelectContentStyle.motion] - The popover's motion configuration.
  const factory FSelectContentStyleDelta.delta({
    FSelectSectionStyleDelta? sectionStyle,
    FSelectScrollHandleStyleDelta? scrollHandleStyle,
    EdgeInsetsGeometryDelta? padding,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
    FPopoverMotionDelta? motion,
  }) = _FSelectContentStyleDelta;

  /// Creates a delta that returns the [FSelectContentStyle] in the current context.
  const factory FSelectContentStyleDelta.context() = _FSelectContentStyleContext;

  @override
  FSelectContentStyle call(covariant FSelectContentStyle value);
}

class _FSelectContentStyleDelta implements FSelectContentStyleDelta {
  const _FSelectContentStyleDelta({
    this.sectionStyle,
    this.scrollHandleStyle,
    this.padding,
    this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.popoverPadding,
    this.motion,
  });

  final FSelectSectionStyleDelta? sectionStyle;

  final FSelectScrollHandleStyleDelta? scrollHandleStyle;

  final EdgeInsetsGeometryDelta? padding;

  final DecorationDelta? decoration;

  final ImageFilter Function(double)? Function()? barrierFilter;

  final ImageFilter Function(double)? Function()? backgroundFilter;

  final EdgeInsetsGeometryDelta? popoverPadding;

  final FPopoverMotionDelta? motion;

  @override
  FSelectContentStyle call(FSelectContentStyle original) => FSelectContentStyle(
    sectionStyle: sectionStyle?.call(original.sectionStyle) ?? original.sectionStyle,
    scrollHandleStyle: scrollHandleStyle?.call(original.scrollHandleStyle) ?? original.scrollHandleStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    popoverPadding: popoverPadding?.call(original.popoverPadding) ?? original.popoverPadding,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FSelectContentStyleContext implements FSelectContentStyleDelta {
  const _FSelectContentStyleContext();

  @override
  FSelectContentStyle call(FSelectContentStyle original) => original;
}

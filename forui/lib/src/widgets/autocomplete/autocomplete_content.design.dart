// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteContentStyleTransformations on FAutocompleteContentStyle {
  /// Returns a copy of this [FAutocompleteContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteContentStyle.emptyTextStyle] - The default text style when there are no results.
  /// * [FAutocompleteContentStyle.progressStyle] - The loading progress's style.
  /// * [FAutocompleteContentStyle.sectionStyle] - The section's style.
  /// * [FAutocompleteContentStyle.padding] - The padding surrounding the content.
  /// * [FAutocompleteContentStyle.decoration] - The popover's decoration.
  /// * [FAutocompleteContentStyle.barrierFilter] - An optional callback that takes a [BuildContext] and the current animation transition value (0.0 to 1.0), and returns an [ImageFilter] that is used as the barrier.
  /// * [FAutocompleteContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FAutocompleteContentStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  /// * [FAutocompleteContentStyle.motion] - The popover's motion configuration.
  @useResult
  FAutocompleteContentStyle copyWith({
    TextStyleDelta? emptyTextStyle,
    FCircularProgressStyleDelta? progressStyle,
    FAutocompleteSectionStyleDelta? sectionStyle,
    EdgeInsetsGeometryDelta? padding,
    DecorationDelta? decoration,
    ImageFilter Function(BuildContext, double)? Function()? barrierFilter,
    ImageFilter Function(BuildContext, double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
    FPopoverMotionDelta? motion,
  }) => .new(
    emptyTextStyle: emptyTextStyle?.call(this.emptyTextStyle) ?? this.emptyTextStyle,
    progressStyle: progressStyle?.call(this.progressStyle) ?? this.progressStyle,
    sectionStyle: sectionStyle?.call(this.sectionStyle) ?? this.sectionStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    backgroundFilter: backgroundFilter == null ? this.backgroundFilter : backgroundFilter(),
    popoverPadding: popoverPadding?.call(this.popoverPadding) ?? this.popoverPadding,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FAutocompleteContentStyle] using the given factor [t].
  @useResult
  FAutocompleteContentStyle lerp(FAutocompleteContentStyle other, double t) => .new(
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
    progressStyle: progressStyle.lerp(other.progressStyle, t),
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    popoverPadding: .lerp(popoverPadding, other.popoverPadding, t) ?? popoverPadding,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FAutocompleteContentStyleFunctions on Diagnosticable implements FAutocompleteContentStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteContentStyle call(Object _) => this as FAutocompleteContentStyle;

  TextStyle get emptyTextStyle;
  FCircularProgressStyle get progressStyle;
  FAutocompleteSectionStyle get sectionStyle;
  EdgeInsetsGeometry get padding;
  Decoration get decoration;
  ImageFilter Function(BuildContext, double)? get barrierFilter;
  ImageFilter Function(BuildContext, double)? get backgroundFilter;
  EdgeInsetsGeometry get popoverPadding;
  FPopoverMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: .debug))
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteContentStyle &&
          runtimeType == other.runtimeType &&
          emptyTextStyle == other.emptyTextStyle &&
          progressStyle == other.progressStyle &&
          sectionStyle == other.sectionStyle &&
          padding == other.padding &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          popoverPadding == other.popoverPadding &&
          motion == other.motion);

  @override
  int get hashCode =>
      emptyTextStyle.hashCode ^
      progressStyle.hashCode ^
      sectionStyle.hashCode ^
      padding.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      popoverPadding.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FAutocompleteContentStyle].
///
/// A [FAutocompleteContentStyle] is itself a [FAutocompleteContentStyleDelta].
abstract class FAutocompleteContentStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteContentStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteContentStyle.emptyTextStyle] - The default text style when there are no results.
  /// * [FAutocompleteContentStyle.progressStyle] - The loading progress's style.
  /// * [FAutocompleteContentStyle.sectionStyle] - The section's style.
  /// * [FAutocompleteContentStyle.padding] - The padding surrounding the content.
  /// * [FAutocompleteContentStyle.decoration] - The popover's decoration.
  /// * [FAutocompleteContentStyle.barrierFilter] - An optional callback that takes a [BuildContext] and the current animation transition value (0.0 to 1.0), and returns an [ImageFilter] that is used as the barrier.
  /// * [FAutocompleteContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FAutocompleteContentStyle.popoverPadding] - The additional padding between the edges of the view and the edges of the popover.
  /// * [FAutocompleteContentStyle.motion] - The popover's motion configuration.
  const factory delta({
    TextStyleDelta? emptyTextStyle,
    FCircularProgressStyleDelta? progressStyle,
    FAutocompleteSectionStyleDelta? sectionStyle,
    EdgeInsetsGeometryDelta? padding,
    DecorationDelta? decoration,
    ImageFilter Function(BuildContext, double)? Function()? barrierFilter,
    ImageFilter Function(BuildContext, double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? popoverPadding,
    FPopoverMotionDelta? motion,
  }) = _FAutocompleteContentStyleDelta;

  /// Creates a delta that returns the [FAutocompleteContentStyle] in the current context.
  const factory context() = _FAutocompleteContentStyleContext;

  @override
  FAutocompleteContentStyle call(covariant FAutocompleteContentStyle value);
}

class _FAutocompleteContentStyleDelta implements FAutocompleteContentStyleDelta {
  const new({
    this.emptyTextStyle,
    this.progressStyle,
    this.sectionStyle,
    this.padding,
    this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.popoverPadding,
    this.motion,
  });

  final TextStyleDelta? emptyTextStyle;

  final FCircularProgressStyleDelta? progressStyle;

  final FAutocompleteSectionStyleDelta? sectionStyle;

  final EdgeInsetsGeometryDelta? padding;

  final DecorationDelta? decoration;

  final ImageFilter Function(BuildContext, double)? Function()? barrierFilter;

  final ImageFilter Function(BuildContext, double)? Function()? backgroundFilter;

  final EdgeInsetsGeometryDelta? popoverPadding;

  final FPopoverMotionDelta? motion;

  @override
  FAutocompleteContentStyle call(FAutocompleteContentStyle original) => FAutocompleteContentStyle(
    emptyTextStyle: emptyTextStyle?.call(original.emptyTextStyle) ?? original.emptyTextStyle,
    progressStyle: progressStyle?.call(original.progressStyle) ?? original.progressStyle,
    sectionStyle: sectionStyle?.call(original.sectionStyle) ?? original.sectionStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    popoverPadding: popoverPadding?.call(original.popoverPadding) ?? original.popoverPadding,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FAutocompleteContentStyleContext implements FAutocompleteContentStyleDelta {
  const new();

  @override
  FAutocompleteContentStyle call(FAutocompleteContentStyle original) => original;
}

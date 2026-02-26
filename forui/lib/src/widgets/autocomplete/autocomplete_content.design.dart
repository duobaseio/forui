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
  /// * [FAutocompleteContentStyle.padding] - The padding surrounding the content.
  /// * [FAutocompleteContentStyle.progressStyle] - The loading progress's style.
  /// * [FAutocompleteContentStyle.sectionStyle] - The section's style.
  /// * [FAutocompleteContentStyle.decoration] - The popover's decoration.
  /// * [FAutocompleteContentStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FAutocompleteContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FAutocompleteContentStyle.viewInsets] - The additional insets of the view.
  @useResult
  FAutocompleteContentStyle copyWith({
    TextStyleDelta? emptyTextStyle,
    EdgeInsetsGeometryDelta? padding,
    FCircularProgressStyleDelta? progressStyle,
    FAutocompleteSectionStyleDelta? sectionStyle,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? viewInsets,
  }) => .new(
    emptyTextStyle: emptyTextStyle?.call(this.emptyTextStyle) ?? this.emptyTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    progressStyle: progressStyle?.call(this.progressStyle) ?? this.progressStyle,
    sectionStyle: sectionStyle?.call(this.sectionStyle) ?? this.sectionStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    barrierFilter: barrierFilter == null ? this.barrierFilter : barrierFilter(),
    backgroundFilter: backgroundFilter == null ? this.backgroundFilter : backgroundFilter(),
    viewInsets: viewInsets?.call(this.viewInsets) ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FAutocompleteContentStyle] using the given factor [t].
  @useResult
  FAutocompleteContentStyle lerp(FAutocompleteContentStyle other, double t) => .new(
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    progressStyle: progressStyle.lerp(other.progressStyle, t),
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: .lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FAutocompleteContentStyleFunctions on Diagnosticable implements FAutocompleteContentStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteContentStyle call(Object _) => this as FAutocompleteContentStyle;

  TextStyle get emptyTextStyle;
  EdgeInsetsGeometry get padding;
  FCircularProgressStyle get progressStyle;
  FAutocompleteSectionStyle get sectionStyle;
  Decoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: .debug))
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteContentStyle &&
          runtimeType == other.runtimeType &&
          emptyTextStyle == other.emptyTextStyle &&
          padding == other.padding &&
          progressStyle == other.progressStyle &&
          sectionStyle == other.sectionStyle &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode =>
      emptyTextStyle.hashCode ^
      padding.hashCode ^
      progressStyle.hashCode ^
      sectionStyle.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      viewInsets.hashCode;
}

/// A delta that applies modifications to a [FAutocompleteContentStyle].
///
/// A [FAutocompleteContentStyle] is itself a [FAutocompleteContentStyleDelta].
abstract class FAutocompleteContentStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteContentStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteContentStyle.emptyTextStyle] - The default text style when there are no results.
  /// * [FAutocompleteContentStyle.padding] - The padding surrounding the content.
  /// * [FAutocompleteContentStyle.progressStyle] - The loading progress's style.
  /// * [FAutocompleteContentStyle.sectionStyle] - The section's style.
  /// * [FAutocompleteContentStyle.decoration] - The popover's decoration.
  /// * [FAutocompleteContentStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FAutocompleteContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FAutocompleteContentStyle.viewInsets] - The additional insets of the view.
  const factory FAutocompleteContentStyleDelta.delta({
    TextStyleDelta? emptyTextStyle,
    EdgeInsetsGeometryDelta? padding,
    FCircularProgressStyleDelta? progressStyle,
    FAutocompleteSectionStyleDelta? sectionStyle,
    DecorationDelta? decoration,
    ImageFilter Function(double)? Function()? barrierFilter,
    ImageFilter Function(double)? Function()? backgroundFilter,
    EdgeInsetsGeometryDelta? viewInsets,
  }) = _FAutocompleteContentStyleDelta;

  /// Creates a delta that returns the [FAutocompleteContentStyle] in the current context.
  const factory FAutocompleteContentStyleDelta.context() = _FAutocompleteContentStyleContext;

  @override
  FAutocompleteContentStyle call(covariant FAutocompleteContentStyle value);
}

class _FAutocompleteContentStyleDelta implements FAutocompleteContentStyleDelta {
  const _FAutocompleteContentStyleDelta({
    this.emptyTextStyle,
    this.padding,
    this.progressStyle,
    this.sectionStyle,
    this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.viewInsets,
  });

  final TextStyleDelta? emptyTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  final FCircularProgressStyleDelta? progressStyle;

  final FAutocompleteSectionStyleDelta? sectionStyle;

  final DecorationDelta? decoration;

  final ImageFilter Function(double)? Function()? barrierFilter;

  final ImageFilter Function(double)? Function()? backgroundFilter;

  final EdgeInsetsGeometryDelta? viewInsets;

  @override
  FAutocompleteContentStyle call(FAutocompleteContentStyle original) => FAutocompleteContentStyle(
    emptyTextStyle: emptyTextStyle?.call(original.emptyTextStyle) ?? original.emptyTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    progressStyle: progressStyle?.call(original.progressStyle) ?? original.progressStyle,
    sectionStyle: sectionStyle?.call(original.sectionStyle) ?? original.sectionStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    barrierFilter: barrierFilter == null ? original.barrierFilter : barrierFilter!(),
    backgroundFilter: backgroundFilter == null ? original.backgroundFilter : backgroundFilter!(),
    viewInsets: viewInsets?.call(original.viewInsets) ?? original.viewInsets,
  );
}

class _FAutocompleteContentStyleContext implements FAutocompleteContentStyleDelta {
  const _FAutocompleteContentStyleContext();

  @override
  FAutocompleteContentStyle call(FAutocompleteContentStyle original) => original;
}

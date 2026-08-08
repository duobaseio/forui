// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTileStyleTransformations on FTileStyle {
  /// Returns a copy of this [FTileStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTileStyle.shape] - The item's shape, only applied when outside an [FItemGroup] or other similar groups.
  /// * [FTileStyle.backgroundColor] - The item's background color, enclosing the [padding] and content, and below [contentDecoration].
  /// * [FTileStyle.padding] - The padding around the [contentDecoration].
  /// * [FTileStyle.contentDecoration] - The content's decoration, enclosed within [padding] and [shape], and above [backgroundColor].
  /// * [FTileStyle.contentStyle] - The content's style.
  /// * [FTileStyle.rawContentStyle] - The raw content's style.
  /// * [FTileStyle.tappableStyle] - The tappable style.
  /// * [FTileStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FTileStyle copyWith({
    ShapeBorder? Function()? shape,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? Function()? focusedOutlineStyle,
  }) => .new(
    shape: shape == null ? this.shape : shape(),
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    padding: padding?.call(this.padding) ?? this.padding,
    contentDecoration: contentDecoration?.call(this.contentDecoration) ?? this.contentDecoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    rawContentStyle: rawContentStyle?.call(this.rawContentStyle) ?? this.rawContentStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == null ? this.focusedOutlineStyle : focusedOutlineStyle(),
  );

  /// Linearly interpolate between this and another [FTileStyle] using the given factor [t].
  @useResult
  FTileStyle lerp(FTileStyle other, double t) => .new(
    shape: t < 0.5 ? shape : other.shape,
    backgroundColor: .lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    padding: .lerp(padding, other.padding, t) ?? padding,
    contentDecoration: .lerpDecoration(contentDecoration, other.contentDecoration, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawContentStyle: rawContentStyle.lerp(other.rawContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
  );
}

mixin _$FTileStyleFunctions on Diagnosticable implements FTileStyleDelta {
  /// Returns itself.
  @override
  FTileStyle call(Object _) => this as FTileStyle;

  ShapeBorder? get shape;
  FVariants<FTappableVariantConstraint, FTappableVariant, Color?, Delta> get backgroundColor;
  EdgeInsetsGeometry get padding;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get contentDecoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileStyle &&
          runtimeType == other.runtimeType &&
          shape == other.shape &&
          backgroundColor == other.backgroundColor &&
          padding == other.padding &&
          contentDecoration == other.contentDecoration &&
          contentStyle == other.contentStyle &&
          rawContentStyle == other.rawContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      shape.hashCode ^
      backgroundColor.hashCode ^
      padding.hashCode ^
      contentDecoration.hashCode ^
      contentStyle.hashCode ^
      rawContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FTileStyle].
///
/// A [FTileStyle] is itself a [FTileStyleDelta].
abstract class FTileStyleDelta with Delta {
  /// Creates a partial modification of a [FTileStyle].
  ///
  /// ## Parameters
  /// * [FTileStyle.shape] - The item's shape, only applied when outside an [FItemGroup] or other similar groups.
  /// * [FTileStyle.backgroundColor] - The item's background color, enclosing the [padding] and content, and below [contentDecoration].
  /// * [FTileStyle.padding] - The padding around the [contentDecoration].
  /// * [FTileStyle.contentDecoration] - The content's decoration, enclosed within [padding] and [shape], and above [backgroundColor].
  /// * [FTileStyle.contentStyle] - The content's style.
  /// * [FTileStyle.rawContentStyle] - The raw content's style.
  /// * [FTileStyle.tappableStyle] - The tappable style.
  /// * [FTileStyle.focusedOutlineStyle] - The focused outline style.
  const factory FTileStyleDelta.delta({
    ShapeBorder? Function()? shape,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? Function()? focusedOutlineStyle,
  }) = _FTileStyleDelta;

  /// Creates a delta that returns the [FTileStyle] in the current context.
  const factory FTileStyleDelta.context() = _FTileStyleContext;

  @override
  FTileStyle call(covariant FTileStyle value);
}

class _FTileStyleDelta implements FTileStyleDelta {
  const _FTileStyleDelta({
    this.shape,
    this.backgroundColor,
    this.padding,
    this.contentDecoration,
    this.contentStyle,
    this.rawContentStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final ShapeBorder? Function()? shape;

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor;

  final EdgeInsetsGeometryDelta? padding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration;

  final FItemContentStyleDelta? contentStyle;

  final FRawItemContentStyleDelta? rawContentStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyle? Function()? focusedOutlineStyle;

  @override
  FTileStyle call(FTileStyle original) => FTileStyle(
    shape: shape == null ? original.shape : shape!(),
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    padding: padding?.call(original.padding) ?? original.padding,
    contentDecoration: contentDecoration?.call(original.contentDecoration) ?? original.contentDecoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    rawContentStyle: rawContentStyle?.call(original.rawContentStyle) ?? original.rawContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == null ? original.focusedOutlineStyle : focusedOutlineStyle!(),
  );
}

class _FTileStyleContext implements FTileStyleDelta {
  const _FTileStyleContext();

  @override
  FTileStyle call(FTileStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FTileContentStyleTransformations on FTileContentStyle {
  /// Returns a copy of this [FTileContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTileContentStyle.suffixedPadding] - The content's padding when a suffix is present.
  /// * [FTileContentStyle.unsuffixedPadding] - The content's padding when no suffix is present.
  /// * [FTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FTileContentStyle.titleTextStyle] - The title's text style.
  /// * [FTileContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FTileContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FTileContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FTileContentStyle.detailsTextStyle] - The details text style.
  /// * [FTileContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FTileContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  @useResult
  FTileContentStyle copyWith({
    EdgeInsetsGeometryDelta? suffixedPadding,
    EdgeInsetsGeometryDelta? unsuffixedPadding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    double? prefixIconSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    double? titleSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle,
    double? middleSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? suffixIconStyle,
    double? suffixIconSpacing,
  }) => .new(
    suffixedPadding: suffixedPadding?.call(this.suffixedPadding) ?? this.suffixedPadding,
    unsuffixedPadding: unsuffixedPadding?.call(this.unsuffixedPadding) ?? this.unsuffixedPadding,
    prefixIconStyle: prefixIconStyle?.call(this.prefixIconStyle) ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    subtitleTextStyle: subtitleTextStyle?.call(this.subtitleTextStyle) ?? this.subtitleTextStyle,
    middleSpacing: middleSpacing ?? this.middleSpacing,
    detailsTextStyle: detailsTextStyle?.call(this.detailsTextStyle) ?? this.detailsTextStyle,
    suffixIconStyle: suffixIconStyle?.call(this.suffixIconStyle) ?? this.suffixIconStyle,
    suffixIconSpacing: suffixIconSpacing ?? this.suffixIconSpacing,
  );

  /// Linearly interpolate between this and another [FTileContentStyle] using the given factor [t].
  @useResult
  FTileContentStyle lerp(FTileContentStyle other, double t) => .new(
    suffixedPadding: .lerp(suffixedPadding, other.suffixedPadding, t) ?? suffixedPadding,
    unsuffixedPadding: .lerp(unsuffixedPadding, other.unsuffixedPadding, t) ?? unsuffixedPadding,
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    titleTextStyle: .lerpTextStyle(titleTextStyle, other.titleTextStyle, t),
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    subtitleTextStyle: .lerpTextStyle(subtitleTextStyle, other.subtitleTextStyle, t),
    middleSpacing: lerpDouble(middleSpacing, other.middleSpacing, t) ?? middleSpacing,
    detailsTextStyle: .lerpTextStyle(detailsTextStyle, other.detailsTextStyle, t),
    suffixIconStyle: .lerpIconThemeData(suffixIconStyle, other.suffixIconStyle, t),
    suffixIconSpacing: lerpDouble(suffixIconSpacing, other.suffixIconSpacing, t) ?? suffixIconSpacing,
  );
}

mixin _$FTileContentStyleFunctions on Diagnosticable implements FTileContentStyleDelta {
  /// Returns itself.
  @override
  FTileContentStyle call(Object _) => this as FTileContentStyle;

  EdgeInsetsGeometry get suffixedPadding;
  EdgeInsetsGeometry get unsuffixedPadding;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get prefixIconStyle;
  double get prefixIconSpacing;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get titleTextStyle;
  double get titleSpacing;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get subtitleTextStyle;
  double get middleSpacing;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get detailsTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get suffixIconStyle;
  double get suffixIconSpacing;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileContentStyle &&
          runtimeType == other.runtimeType &&
          suffixedPadding == other.suffixedPadding &&
          unsuffixedPadding == other.unsuffixedPadding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          titleTextStyle == other.titleTextStyle &&
          titleSpacing == other.titleSpacing &&
          subtitleTextStyle == other.subtitleTextStyle &&
          middleSpacing == other.middleSpacing &&
          detailsTextStyle == other.detailsTextStyle &&
          suffixIconStyle == other.suffixIconStyle &&
          suffixIconSpacing == other.suffixIconSpacing);

  @override
  int get hashCode =>
      suffixedPadding.hashCode ^
      unsuffixedPadding.hashCode ^
      prefixIconStyle.hashCode ^
      prefixIconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      subtitleTextStyle.hashCode ^
      middleSpacing.hashCode ^
      detailsTextStyle.hashCode ^
      suffixIconStyle.hashCode ^
      suffixIconSpacing.hashCode;
}

/// A delta that applies modifications to a [FTileContentStyle].
///
/// A [FTileContentStyle] is itself a [FTileContentStyleDelta].
abstract class FTileContentStyleDelta with Delta {
  /// Creates a partial modification of a [FTileContentStyle].
  ///
  /// ## Parameters
  /// * [FTileContentStyle.suffixedPadding] - The content's padding when a suffix is present.
  /// * [FTileContentStyle.unsuffixedPadding] - The content's padding when no suffix is present.
  /// * [FTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FTileContentStyle.titleTextStyle] - The title's text style.
  /// * [FTileContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FTileContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FTileContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FTileContentStyle.detailsTextStyle] - The details text style.
  /// * [FTileContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FTileContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  const factory FTileContentStyleDelta.delta({
    EdgeInsetsGeometryDelta? suffixedPadding,
    EdgeInsetsGeometryDelta? unsuffixedPadding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    double? prefixIconSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    double? titleSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle,
    double? middleSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? suffixIconStyle,
    double? suffixIconSpacing,
  }) = _FTileContentStyleDelta;

  /// Creates a delta that returns the [FTileContentStyle] in the current context.
  const factory FTileContentStyleDelta.context() = _FTileContentStyleContext;

  @override
  FTileContentStyle call(covariant FTileContentStyle value);
}

class _FTileContentStyleDelta implements FTileContentStyleDelta {
  const _FTileContentStyleDelta({
    this.suffixedPadding,
    this.unsuffixedPadding,
    this.prefixIconStyle,
    this.prefixIconSpacing,
    this.titleTextStyle,
    this.titleSpacing,
    this.subtitleTextStyle,
    this.middleSpacing,
    this.detailsTextStyle,
    this.suffixIconStyle,
    this.suffixIconSpacing,
  });

  final EdgeInsetsGeometryDelta? suffixedPadding;

  final EdgeInsetsGeometryDelta? unsuffixedPadding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  prefixIconStyle;

  final double? prefixIconSpacing;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle;

  final double? titleSpacing;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle;

  final double? middleSpacing;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  suffixIconStyle;

  final double? suffixIconSpacing;

  @override
  FTileContentStyle call(FTileContentStyle original) => FTileContentStyle(
    suffixedPadding: suffixedPadding?.call(original.suffixedPadding) ?? original.suffixedPadding,
    unsuffixedPadding: unsuffixedPadding?.call(original.unsuffixedPadding) ?? original.unsuffixedPadding,
    prefixIconStyle: prefixIconStyle?.call(original.prefixIconStyle) ?? original.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    titleSpacing: titleSpacing ?? original.titleSpacing,
    subtitleTextStyle: subtitleTextStyle?.call(original.subtitleTextStyle) ?? original.subtitleTextStyle,
    middleSpacing: middleSpacing ?? original.middleSpacing,
    detailsTextStyle: detailsTextStyle?.call(original.detailsTextStyle) ?? original.detailsTextStyle,
    suffixIconStyle: suffixIconStyle?.call(original.suffixIconStyle) ?? original.suffixIconStyle,
    suffixIconSpacing: suffixIconSpacing ?? original.suffixIconSpacing,
  );
}

class _FTileContentStyleContext implements FTileContentStyleDelta {
  const _FTileContentStyleContext();

  @override
  FTileContentStyle call(FTileContentStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FRawTileContentStyleTransformations on FRawTileContentStyle {
  /// Returns a copy of this [FRawTileContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FRawTileContentStyle.padding] - The content's padding.
  /// * [FRawTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  /// * [FRawTileContentStyle.childTextStyle] - The child's text style.
  @useResult
  FRawTileContentStyle copyWith({
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    double? prefixIconSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle,
  }) => .new(
    padding: padding?.call(this.padding) ?? this.padding,
    prefixIconStyle: prefixIconStyle?.call(this.prefixIconStyle) ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    childTextStyle: childTextStyle?.call(this.childTextStyle) ?? this.childTextStyle,
  );

  /// Linearly interpolate between this and another [FRawTileContentStyle] using the given factor [t].
  @useResult
  FRawTileContentStyle lerp(FRawTileContentStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    childTextStyle: .lerpTextStyle(childTextStyle, other.childTextStyle, t),
  );
}

mixin _$FRawTileContentStyleFunctions on Diagnosticable implements FRawTileContentStyleDelta {
  /// Returns itself.
  @override
  FRawTileContentStyle call(Object _) => this as FRawTileContentStyle;

  EdgeInsetsGeometry get padding;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get prefixIconStyle;
  double get prefixIconSpacing;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get childTextStyle;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRawTileContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          childTextStyle == other.childTextStyle);

  @override
  int get hashCode =>
      padding.hashCode ^ prefixIconStyle.hashCode ^ prefixIconSpacing.hashCode ^ childTextStyle.hashCode;
}

/// A delta that applies modifications to a [FRawTileContentStyle].
///
/// A [FRawTileContentStyle] is itself a [FRawTileContentStyleDelta].
abstract class FRawTileContentStyleDelta with Delta {
  /// Creates a partial modification of a [FRawTileContentStyle].
  ///
  /// ## Parameters
  /// * [FRawTileContentStyle.padding] - The content's padding.
  /// * [FRawTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  /// * [FRawTileContentStyle.childTextStyle] - The child's text style.
  const factory FRawTileContentStyleDelta.delta({
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    double? prefixIconSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle,
  }) = _FRawTileContentStyleDelta;

  /// Creates a delta that returns the [FRawTileContentStyle] in the current context.
  const factory FRawTileContentStyleDelta.context() = _FRawTileContentStyleContext;

  @override
  FRawTileContentStyle call(covariant FRawTileContentStyle value);
}

class _FRawTileContentStyleDelta implements FRawTileContentStyleDelta {
  const _FRawTileContentStyleDelta({this.padding, this.prefixIconStyle, this.prefixIconSpacing, this.childTextStyle});

  final EdgeInsetsGeometryDelta? padding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  prefixIconStyle;

  final double? prefixIconSpacing;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle;

  @override
  FRawTileContentStyle call(FRawTileContentStyle original) => FRawTileContentStyle(
    padding: padding?.call(original.padding) ?? original.padding,
    prefixIconStyle: prefixIconStyle?.call(original.prefixIconStyle) ?? original.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
    childTextStyle: childTextStyle?.call(original.childTextStyle) ?? original.childTextStyle,
  );
}

class _FRawTileContentStyleContext implements FRawTileContentStyleDelta {
  const _FRawTileContentStyleContext();

  @override
  FRawTileContentStyle call(FRawTileContentStyle original) => original;
}

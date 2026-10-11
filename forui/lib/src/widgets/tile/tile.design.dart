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
  /// * [FTileStyle.backgroundColor] - The item's background color, enclosing the [padding] and content, and below [contentDecoration].
  /// * [FTileStyle.contentDecoration] - The content's decoration, enclosed within [padding] and [shape], and above [backgroundColor].
  /// * [FTileStyle.contentStyle] - The content's style.
  /// * [FTileStyle.rawContentStyle] - The raw content's style.
  /// * [FTileStyle.tappableStyle] - The tappable style.
  /// * [FTileStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FTileStyle.padding] - The padding around the [contentDecoration].
  /// * [FTileStyle.shape] - The item's shape, only applied when outside an [FItemGroup] or other similar groups.
  @useResult
  FTileStyle copyWith({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? Function()? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    ShapeBorder? Function()? shape,
  }) => .new(
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    contentDecoration: contentDecoration?.call(this.contentDecoration) ?? this.contentDecoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    rawContentStyle: rawContentStyle?.call(this.rawContentStyle) ?? this.rawContentStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == null ? this.focusedOutlineStyle : focusedOutlineStyle(),
    padding: padding?.call(this.padding) ?? this.padding,
    shape: shape == null ? this.shape : shape(),
  );

  /// Linearly interpolate between this and another [FTileStyle] using the given factor [t].
  @useResult
  FTileStyle lerp(FTileStyle other, double t) => .new(
    backgroundColor: .lerpWhere(backgroundColor, other.backgroundColor, t, Color.lerp),
    contentDecoration: .lerpDecoration(contentDecoration, other.contentDecoration, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    rawContentStyle: rawContentStyle.lerp(other.rawContentStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: t < 0.5 ? focusedOutlineStyle : other.focusedOutlineStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    shape: t < 0.5 ? shape : other.shape,
  );
}

mixin _$FTileStyleFunctions on Diagnosticable implements FTileStyleDelta {
  /// Returns itself.
  @override
  FTileStyle call(Object _) => this as FTileStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Color?, Delta> get backgroundColor;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get contentDecoration;
  FItemContentStyle get contentStyle;
  FRawItemContentStyle get rawContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle? get focusedOutlineStyle;
  EdgeInsetsGeometry get padding;
  ShapeBorder? get shape;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          contentDecoration == other.contentDecoration &&
          contentStyle == other.contentStyle &&
          rawContentStyle == other.rawContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          padding == other.padding &&
          shape == other.shape);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      contentDecoration.hashCode ^
      contentStyle.hashCode ^
      rawContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      padding.hashCode ^
      shape.hashCode;
}

/// A delta that applies modifications to a [FTileStyle].
///
/// A [FTileStyle] is itself a [FTileStyleDelta].
abstract class FTileStyleDelta with Delta {
  /// Creates a partial modification of a [FTileStyle].
  ///
  /// ## Parameters
  /// * [FTileStyle.backgroundColor] - The item's background color, enclosing the [padding] and content, and below [contentDecoration].
  /// * [FTileStyle.contentDecoration] - The content's decoration, enclosed within [padding] and [shape], and above [backgroundColor].
  /// * [FTileStyle.contentStyle] - The content's style.
  /// * [FTileStyle.rawContentStyle] - The raw content's style.
  /// * [FTileStyle.tappableStyle] - The tappable style.
  /// * [FTileStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FTileStyle.padding] - The padding around the [contentDecoration].
  /// * [FTileStyle.shape] - The item's shape, only applied when outside an [FItemGroup] or other similar groups.
  const factory delta({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration,
    FItemContentStyleDelta? contentStyle,
    FRawItemContentStyleDelta? rawContentStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyle? Function()? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    ShapeBorder? Function()? shape,
  }) = _FTileStyleDelta;

  /// Creates a delta that returns the [FTileStyle] in the current context.
  const factory context() = _FTileStyleContext;

  @override
  FTileStyle call(covariant FTileStyle value);
}

class _FTileStyleDelta implements FTileStyleDelta {
  const new({
    this.backgroundColor,
    this.contentDecoration,
    this.contentStyle,
    this.rawContentStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.padding,
    this.shape,
  });

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? backgroundColor;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? contentDecoration;

  final FItemContentStyleDelta? contentStyle;

  final FRawItemContentStyleDelta? rawContentStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyle? Function()? focusedOutlineStyle;

  final EdgeInsetsGeometryDelta? padding;

  final ShapeBorder? Function()? shape;

  @override
  FTileStyle call(FTileStyle original) => FTileStyle(
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    contentDecoration: contentDecoration?.call(original.contentDecoration) ?? original.contentDecoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    rawContentStyle: rawContentStyle?.call(original.rawContentStyle) ?? original.rawContentStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle == null ? original.focusedOutlineStyle : focusedOutlineStyle!(),
    padding: padding?.call(original.padding) ?? original.padding,
    shape: shape == null ? original.shape : shape!(),
  );
}

class _FTileStyleContext implements FTileStyleDelta {
  const new();

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
  /// * [FTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FTileContentStyle.titleTextStyle] - The title's text style.
  /// * [FTileContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FTileContentStyle.detailsTextStyle] - The details text style.
  /// * [FTileContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FTileContentStyle.suffixedPadding] - The content's padding when a suffix is present.
  /// * [FTileContentStyle.unsuffixedPadding] - The content's padding when no suffix is present.
  /// * [FTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FTileContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FTileContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FTileContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  @useResult
  FTileContentStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? suffixIconStyle,
    EdgeInsetsGeometryDelta? suffixedPadding,
    EdgeInsetsGeometryDelta? unsuffixedPadding,
    double? prefixIconSpacing,
    double? titleSpacing,
    double? middleSpacing,
    double? suffixIconSpacing,
  }) => .new(
    prefixIconStyle: prefixIconStyle?.call(this.prefixIconStyle) ?? this.prefixIconStyle,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(this.subtitleTextStyle) ?? this.subtitleTextStyle,
    detailsTextStyle: detailsTextStyle?.call(this.detailsTextStyle) ?? this.detailsTextStyle,
    suffixIconStyle: suffixIconStyle?.call(this.suffixIconStyle) ?? this.suffixIconStyle,
    suffixedPadding: suffixedPadding?.call(this.suffixedPadding) ?? this.suffixedPadding,
    unsuffixedPadding: unsuffixedPadding?.call(this.unsuffixedPadding) ?? this.unsuffixedPadding,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    middleSpacing: middleSpacing ?? this.middleSpacing,
    suffixIconSpacing: suffixIconSpacing ?? this.suffixIconSpacing,
  );

  /// Linearly interpolate between this and another [FTileContentStyle] using the given factor [t].
  @useResult
  FTileContentStyle lerp(FTileContentStyle other, double t) => .new(
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    titleTextStyle: .lerpTextStyle(titleTextStyle, other.titleTextStyle, t),
    subtitleTextStyle: .lerpTextStyle(subtitleTextStyle, other.subtitleTextStyle, t),
    detailsTextStyle: .lerpTextStyle(detailsTextStyle, other.detailsTextStyle, t),
    suffixIconStyle: .lerpIconThemeData(suffixIconStyle, other.suffixIconStyle, t),
    suffixedPadding: .lerp(suffixedPadding, other.suffixedPadding, t) ?? suffixedPadding,
    unsuffixedPadding: .lerp(unsuffixedPadding, other.unsuffixedPadding, t) ?? unsuffixedPadding,
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    middleSpacing: lerpDouble(middleSpacing, other.middleSpacing, t) ?? middleSpacing,
    suffixIconSpacing: lerpDouble(suffixIconSpacing, other.suffixIconSpacing, t) ?? suffixIconSpacing,
  );
}

mixin _$FTileContentStyleFunctions on Diagnosticable implements FTileContentStyleDelta {
  /// Returns itself.
  @override
  FTileContentStyle call(Object _) => this as FTileContentStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get prefixIconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get titleTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get subtitleTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get detailsTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get suffixIconStyle;
  EdgeInsetsGeometry get suffixedPadding;
  EdgeInsetsGeometry get unsuffixedPadding;
  double get prefixIconSpacing;
  double get titleSpacing;
  double get middleSpacing;
  double get suffixIconSpacing;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileContentStyle &&
          runtimeType == other.runtimeType &&
          prefixIconStyle == other.prefixIconStyle &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle &&
          detailsTextStyle == other.detailsTextStyle &&
          suffixIconStyle == other.suffixIconStyle &&
          suffixedPadding == other.suffixedPadding &&
          unsuffixedPadding == other.unsuffixedPadding &&
          prefixIconSpacing == other.prefixIconSpacing &&
          titleSpacing == other.titleSpacing &&
          middleSpacing == other.middleSpacing &&
          suffixIconSpacing == other.suffixIconSpacing);

  @override
  int get hashCode =>
      prefixIconStyle.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode ^
      detailsTextStyle.hashCode ^
      suffixIconStyle.hashCode ^
      suffixedPadding.hashCode ^
      unsuffixedPadding.hashCode ^
      prefixIconSpacing.hashCode ^
      titleSpacing.hashCode ^
      middleSpacing.hashCode ^
      suffixIconSpacing.hashCode;
}

/// A delta that applies modifications to a [FTileContentStyle].
///
/// A [FTileContentStyle] is itself a [FTileContentStyleDelta].
abstract class FTileContentStyleDelta with Delta {
  /// Creates a partial modification of a [FTileContentStyle].
  ///
  /// ## Parameters
  /// * [FTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FTileContentStyle.titleTextStyle] - The title's text style.
  /// * [FTileContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FTileContentStyle.detailsTextStyle] - The details text style.
  /// * [FTileContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FTileContentStyle.suffixedPadding] - The content's padding when a suffix is present.
  /// * [FTileContentStyle.unsuffixedPadding] - The content's padding when no suffix is present.
  /// * [FTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FTileContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FTileContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FTileContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? suffixIconStyle,
    EdgeInsetsGeometryDelta? suffixedPadding,
    EdgeInsetsGeometryDelta? unsuffixedPadding,
    double? prefixIconSpacing,
    double? titleSpacing,
    double? middleSpacing,
    double? suffixIconSpacing,
  }) = _FTileContentStyleDelta;

  /// Creates a delta that returns the [FTileContentStyle] in the current context.
  const factory context() = _FTileContentStyleContext;

  @override
  FTileContentStyle call(covariant FTileContentStyle value);
}

class _FTileContentStyleDelta implements FTileContentStyleDelta {
  const new({
    this.prefixIconStyle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.detailsTextStyle,
    this.suffixIconStyle,
    this.suffixedPadding,
    this.unsuffixedPadding,
    this.prefixIconSpacing,
    this.titleSpacing,
    this.middleSpacing,
    this.suffixIconSpacing,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  prefixIconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  suffixIconStyle;

  final EdgeInsetsGeometryDelta? suffixedPadding;

  final EdgeInsetsGeometryDelta? unsuffixedPadding;

  final double? prefixIconSpacing;

  final double? titleSpacing;

  final double? middleSpacing;

  final double? suffixIconSpacing;

  @override
  FTileContentStyle call(FTileContentStyle original) => FTileContentStyle(
    prefixIconStyle: prefixIconStyle?.call(original.prefixIconStyle) ?? original.prefixIconStyle,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(original.subtitleTextStyle) ?? original.subtitleTextStyle,
    detailsTextStyle: detailsTextStyle?.call(original.detailsTextStyle) ?? original.detailsTextStyle,
    suffixIconStyle: suffixIconStyle?.call(original.suffixIconStyle) ?? original.suffixIconStyle,
    suffixedPadding: suffixedPadding?.call(original.suffixedPadding) ?? original.suffixedPadding,
    unsuffixedPadding: unsuffixedPadding?.call(original.unsuffixedPadding) ?? original.unsuffixedPadding,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
    titleSpacing: titleSpacing ?? original.titleSpacing,
    middleSpacing: middleSpacing ?? original.middleSpacing,
    suffixIconSpacing: suffixIconSpacing ?? original.suffixIconSpacing,
  );
}

class _FTileContentStyleContext implements FTileContentStyleDelta {
  const new();

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
  /// * [FRawTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawTileContentStyle.childTextStyle] - The child's text style.
  /// * [FRawTileContentStyle.padding] - The content's padding.
  /// * [FRawTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  @useResult
  FRawTileContentStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle,
    EdgeInsetsGeometryDelta? padding,
    double? prefixIconSpacing,
  }) => .new(
    prefixIconStyle: prefixIconStyle?.call(this.prefixIconStyle) ?? this.prefixIconStyle,
    childTextStyle: childTextStyle?.call(this.childTextStyle) ?? this.childTextStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
  );

  /// Linearly interpolate between this and another [FRawTileContentStyle] using the given factor [t].
  @useResult
  FRawTileContentStyle lerp(FRawTileContentStyle other, double t) => .new(
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    childTextStyle: .lerpTextStyle(childTextStyle, other.childTextStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
  );
}

mixin _$FRawTileContentStyleFunctions on Diagnosticable implements FRawTileContentStyleDelta {
  /// Returns itself.
  @override
  FRawTileContentStyle call(Object _) => this as FRawTileContentStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get prefixIconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get childTextStyle;
  EdgeInsetsGeometry get padding;
  double get prefixIconSpacing;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRawTileContentStyle &&
          runtimeType == other.runtimeType &&
          prefixIconStyle == other.prefixIconStyle &&
          childTextStyle == other.childTextStyle &&
          padding == other.padding &&
          prefixIconSpacing == other.prefixIconSpacing);

  @override
  int get hashCode =>
      prefixIconStyle.hashCode ^ childTextStyle.hashCode ^ padding.hashCode ^ prefixIconSpacing.hashCode;
}

/// A delta that applies modifications to a [FRawTileContentStyle].
///
/// A [FRawTileContentStyle] is itself a [FRawTileContentStyleDelta].
abstract class FRawTileContentStyleDelta with Delta {
  /// Creates a partial modification of a [FRawTileContentStyle].
  ///
  /// ## Parameters
  /// * [FRawTileContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawTileContentStyle.childTextStyle] - The child's text style.
  /// * [FRawTileContentStyle.padding] - The content's padding.
  /// * [FRawTileContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle,
    EdgeInsetsGeometryDelta? padding,
    double? prefixIconSpacing,
  }) = _FRawTileContentStyleDelta;

  /// Creates a delta that returns the [FRawTileContentStyle] in the current context.
  const factory context() = _FRawTileContentStyleContext;

  @override
  FRawTileContentStyle call(covariant FRawTileContentStyle value);
}

class _FRawTileContentStyleDelta implements FRawTileContentStyleDelta {
  const new({this.prefixIconStyle, this.childTextStyle, this.padding, this.prefixIconSpacing});

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  prefixIconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  final double? prefixIconSpacing;

  @override
  FRawTileContentStyle call(FRawTileContentStyle original) => FRawTileContentStyle(
    prefixIconStyle: prefixIconStyle?.call(original.prefixIconStyle) ?? original.prefixIconStyle,
    childTextStyle: childTextStyle?.call(original.childTextStyle) ?? original.childTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
  );
}

class _FRawTileContentStyleContext implements FRawTileContentStyleDelta {
  const new();

  @override
  FRawTileContentStyle call(FRawTileContentStyle original) => original;
}

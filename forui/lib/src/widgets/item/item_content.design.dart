// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FItemContentStyleTransformations on FItemContentStyle {
  /// Returns a copy of this [FItemContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemContentStyle.padding] - The content's padding.
  /// * [FItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FItemContentStyle.titleTextStyle] - The title's text style.
  /// * [FItemContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FItemContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FItemContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FItemContentStyle.detailsTextStyle] - The details text style.
  /// * [FItemContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FItemContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  @useResult
  FItemContentStyle copyWith({
    EdgeInsetsGeometryDelta? padding,
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
    padding: padding?.call(this.padding) ?? this.padding,
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

  /// Linearly interpolate between this and another [FItemContentStyle] using the given factor [t].
  @useResult
  FItemContentStyle lerp(FItemContentStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
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

mixin _$FItemContentStyleFunctions on Diagnosticable implements FItemContentStyleDelta {
  /// Returns itself.
  @override
  FItemContentStyle call(Object _) => this as FItemContentStyle;

  EdgeInsetsGeometry get padding;
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: .debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug))
      ..add(DoubleProperty('middleSpacing', middleSpacing, level: .debug))
      ..add(DiagnosticsProperty('detailsTextStyle', detailsTextStyle, level: .debug))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle, level: .debug))
      ..add(DoubleProperty('suffixIconSpacing', suffixIconSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
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
      padding.hashCode ^
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

/// A delta that applies modifications to a [FItemContentStyle].
///
/// A [FItemContentStyle] is itself a [FItemContentStyleDelta].
abstract class FItemContentStyleDelta with Delta {
  /// Creates a partial modification of a [FItemContentStyle].
  ///
  /// ## Parameters
  /// * [FItemContentStyle.padding] - The content's padding.
  /// * [FItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FItemContentStyle.titleTextStyle] - The title's text style.
  /// * [FItemContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FItemContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FItemContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FItemContentStyle.detailsTextStyle] - The details text style.
  /// * [FItemContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FItemContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  const factory FItemContentStyleDelta.delta({
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    double? prefixIconSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    double? titleSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? subtitleTextStyle,
    double? middleSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? detailsTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? suffixIconStyle,
    double? suffixIconSpacing,
  }) = _FItemContentStyleDelta;

  /// Creates a delta that returns the [FItemContentStyle] in the current context.
  const factory FItemContentStyleDelta.context() = _FItemContentStyleContext;

  @override
  FItemContentStyle call(covariant FItemContentStyle value);
}

class _FItemContentStyleDelta implements FItemContentStyleDelta {
  const _FItemContentStyleDelta({
    this.padding,
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

  final EdgeInsetsGeometryDelta? padding;

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
  FItemContentStyle call(FItemContentStyle original) => FItemContentStyle(
    padding: padding?.call(original.padding) ?? original.padding,
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

class _FItemContentStyleContext implements FItemContentStyleDelta {
  const _FItemContentStyleContext();

  @override
  FItemContentStyle call(FItemContentStyle original) => original;
}

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
  /// * [FItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FItemContentStyle.titleTextStyle] - The title's text style.
  /// * [FItemContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FItemContentStyle.detailsTextStyle] - The details text style.
  /// * [FItemContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FItemContentStyle.suffixedPadding] - The content's padding when a suffix is present.
  /// * [FItemContentStyle.unsuffixedPadding] - The content's padding when no suffix is present.
  /// * [FItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FItemContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FItemContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FItemContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  @useResult
  FItemContentStyle copyWith({
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

  /// Linearly interpolate between this and another [FItemContentStyle] using the given factor [t].
  @useResult
  FItemContentStyle lerp(FItemContentStyle other, double t) => .new(
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

mixin _$FItemContentStyleFunctions on Diagnosticable implements FItemContentStyleDelta {
  /// Returns itself.
  @override
  FItemContentStyle call(Object _) => this as FItemContentStyle;

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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('detailsTextStyle', detailsTextStyle, level: .debug))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle, level: .debug))
      ..add(DiagnosticsProperty('suffixedPadding', suffixedPadding, level: .debug))
      ..add(DiagnosticsProperty('unsuffixedPadding', unsuffixedPadding, level: .debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: .debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: .debug))
      ..add(DoubleProperty('middleSpacing', middleSpacing, level: .debug))
      ..add(DoubleProperty('suffixIconSpacing', suffixIconSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemContentStyle &&
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

/// A delta that applies modifications to a [FItemContentStyle].
///
/// A [FItemContentStyle] is itself a [FItemContentStyleDelta].
abstract class FItemContentStyleDelta with Delta {
  /// Creates a partial modification of a [FItemContentStyle].
  ///
  /// ## Parameters
  /// * [FItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FItemContentStyle.titleTextStyle] - The title's text style.
  /// * [FItemContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FItemContentStyle.detailsTextStyle] - The details text style.
  /// * [FItemContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FItemContentStyle.suffixedPadding] - The content's padding when a suffix is present.
  /// * [FItemContentStyle.unsuffixedPadding] - The content's padding when no suffix is present.
  /// * [FItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FItemContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FItemContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FItemContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
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
  }) = _FItemContentStyleDelta;

  /// Creates a delta that returns the [FItemContentStyle] in the current context.
  const factory context() = _FItemContentStyleContext;

  @override
  FItemContentStyle call(covariant FItemContentStyle value);
}

class _FItemContentStyleDelta implements FItemContentStyleDelta {
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
  FItemContentStyle call(FItemContentStyle original) => FItemContentStyle(
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

class _FItemContentStyleContext implements FItemContentStyleDelta {
  const new();

  @override
  FItemContentStyle call(FItemContentStyle original) => original;
}

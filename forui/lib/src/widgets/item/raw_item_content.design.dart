// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'raw_item_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FRawItemContentStyleTransformations on FRawItemContentStyle {
  /// Returns a copy of this [FRawItemContentStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FRawItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawItemContentStyle.childTextStyle] - The child's text style.
  /// * [FRawItemContentStyle.padding] - The content's padding.
  /// * [FRawItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  @useResult
  FRawItemContentStyle copyWith({
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

  /// Linearly interpolate between this and another [FRawItemContentStyle] using the given factor [t].
  @useResult
  FRawItemContentStyle lerp(FRawItemContentStyle other, double t) => .new(
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    childTextStyle: .lerpTextStyle(childTextStyle, other.childTextStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
  );
}

mixin _$FRawItemContentStyleFunctions on Diagnosticable implements FRawItemContentStyleDelta {
  /// Returns itself.
  @override
  FRawItemContentStyle call(Object _) => this as FRawItemContentStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get prefixIconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get childTextStyle;
  EdgeInsetsGeometry get padding;
  double get prefixIconSpacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: .debug))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRawItemContentStyle &&
          runtimeType == other.runtimeType &&
          prefixIconStyle == other.prefixIconStyle &&
          childTextStyle == other.childTextStyle &&
          padding == other.padding &&
          prefixIconSpacing == other.prefixIconSpacing);

  @override
  int get hashCode =>
      prefixIconStyle.hashCode ^ childTextStyle.hashCode ^ padding.hashCode ^ prefixIconSpacing.hashCode;
}

/// A delta that applies modifications to a [FRawItemContentStyle].
///
/// A [FRawItemContentStyle] is itself a [FRawItemContentStyleDelta].
abstract class FRawItemContentStyleDelta with Delta {
  /// Creates a partial modification of a [FRawItemContentStyle].
  ///
  /// ## Parameters
  /// * [FRawItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawItemContentStyle.childTextStyle] - The child's text style.
  /// * [FRawItemContentStyle.padding] - The content's padding.
  /// * [FRawItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle,
    EdgeInsetsGeometryDelta? padding,
    double? prefixIconSpacing,
  }) = _FRawItemContentStyleDelta;

  /// Creates a delta that returns the [FRawItemContentStyle] in the current context.
  const factory context() = _FRawItemContentStyleContext;

  @override
  FRawItemContentStyle call(covariant FRawItemContentStyle value);
}

class _FRawItemContentStyleDelta implements FRawItemContentStyleDelta {
  const new({this.prefixIconStyle, this.childTextStyle, this.padding, this.prefixIconSpacing});

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  prefixIconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle;

  final EdgeInsetsGeometryDelta? padding;

  final double? prefixIconSpacing;

  @override
  FRawItemContentStyle call(FRawItemContentStyle original) => FRawItemContentStyle(
    prefixIconStyle: prefixIconStyle?.call(original.prefixIconStyle) ?? original.prefixIconStyle,
    childTextStyle: childTextStyle?.call(original.childTextStyle) ?? original.childTextStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
  );
}

class _FRawItemContentStyleContext implements FRawItemContentStyleDelta {
  const new();

  @override
  FRawItemContentStyle call(FRawItemContentStyle original) => original;
}

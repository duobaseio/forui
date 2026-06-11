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
  /// * [FRawItemContentStyle.padding] - The content's padding.
  /// * [FRawItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  /// * [FRawItemContentStyle.childTextStyle] - The child's text style.
  @useResult
  FRawItemContentStyle copyWith({
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

  /// Linearly interpolate between this and another [FRawItemContentStyle] using the given factor [t].
  @useResult
  FRawItemContentStyle lerp(FRawItemContentStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    childTextStyle: .lerpTextStyle(childTextStyle, other.childTextStyle, t),
  );
}

mixin _$FRawItemContentStyleFunctions on Diagnosticable implements FRawItemContentStyleDelta {
  /// Returns itself.
  @override
  FRawItemContentStyle call(Object _) => this as FRawItemContentStyle;

  EdgeInsetsGeometry get padding;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get prefixIconStyle;
  double get prefixIconSpacing;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get childTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: .debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: .debug))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRawItemContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          childTextStyle == other.childTextStyle);

  @override
  int get hashCode =>
      padding.hashCode ^ prefixIconStyle.hashCode ^ prefixIconSpacing.hashCode ^ childTextStyle.hashCode;
}

/// A delta that applies modifications to a [FRawItemContentStyle].
///
/// A [FRawItemContentStyle] is itself a [FRawItemContentStyleDelta].
abstract class FRawItemContentStyleDelta with Delta {
  /// Creates a partial modification of a [FRawItemContentStyle].
  ///
  /// ## Parameters
  /// * [FRawItemContentStyle.padding] - The content's padding.
  /// * [FRawItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  /// * [FRawItemContentStyle.childTextStyle] - The child's text style.
  const factory FRawItemContentStyleDelta.delta({
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? prefixIconStyle,
    double? prefixIconSpacing,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle,
  }) = _FRawItemContentStyleDelta;

  /// Creates a delta that returns the [FRawItemContentStyle] in the current context.
  const factory FRawItemContentStyleDelta.context() = _FRawItemContentStyleContext;

  @override
  FRawItemContentStyle call(covariant FRawItemContentStyle value);
}

class _FRawItemContentStyleDelta implements FRawItemContentStyleDelta {
  const _FRawItemContentStyleDelta({this.padding, this.prefixIconStyle, this.prefixIconSpacing, this.childTextStyle});

  final EdgeInsetsGeometryDelta? padding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  prefixIconStyle;

  final double? prefixIconSpacing;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? childTextStyle;

  @override
  FRawItemContentStyle call(FRawItemContentStyle original) => FRawItemContentStyle(
    padding: padding?.call(original.padding) ?? original.padding,
    prefixIconStyle: prefixIconStyle?.call(original.prefixIconStyle) ?? original.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
    childTextStyle: childTextStyle?.call(original.childTextStyle) ?? original.childTextStyle,
  );
}

class _FRawItemContentStyleContext implements FRawItemContentStyleDelta {
  const _FRawItemContentStyleContext();

  @override
  FRawItemContentStyle call(FRawItemContentStyle original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_mark.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSliderMarkStyleTransformations on FSliderMarkStyle {
  /// Returns a copy of this [FSliderMarkStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderMarkStyle.tickColor] - The tick's color.
  /// * [FSliderMarkStyle.labelTextStyle] - The label's default text style.
  /// * [FSliderMarkStyle.labelAnchor] - The label's anchor to which the [labelOffset] is applied.
  /// * [FSliderMarkStyle.labelOffset] - The label's offset from the slider, along its cross axis, in logical pixels.
  /// * [FSliderMarkStyle.tickSize] - The tick's size.
  @useResult
  FSliderMarkStyle copyWith({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? tickColor,
    FVariantsDelta<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    AlignmentGeometry? labelAnchor,
    double? labelOffset,
    double? tickSize,
  }) => .new(
    tickColor: tickColor?.call(this.tickColor) ?? this.tickColor,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    labelAnchor: labelAnchor ?? this.labelAnchor,
    labelOffset: labelOffset ?? this.labelOffset,
    tickSize: tickSize ?? this.tickSize,
  );

  /// Linearly interpolate between this and another [FSliderMarkStyle] using the given factor [t].
  @useResult
  FSliderMarkStyle lerp(FSliderMarkStyle other, double t) => .new(
    tickColor: .lerpColor(tickColor, other.tickColor, t),
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelAnchor: .lerp(labelAnchor, other.labelAnchor, t) ?? labelAnchor,
    labelOffset: lerpDouble(labelOffset, other.labelOffset, t) ?? labelOffset,
    tickSize: lerpDouble(tickSize, other.tickSize, t) ?? tickSize,
  );
}

mixin _$FSliderMarkStyleFunctions on Diagnosticable implements FSliderMarkStyleDelta {
  /// Returns itself.
  @override
  FSliderMarkStyle call(Object _) => this as FSliderMarkStyle;

  FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> get tickColor;
  FVariants<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  AlignmentGeometry get labelAnchor;
  double get labelOffset;
  double get tickSize;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tickColor', tickColor, level: .debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('labelAnchor', labelAnchor, level: .debug))
      ..add(DoubleProperty('labelOffset', labelOffset, level: .debug))
      ..add(DoubleProperty('tickSize', tickSize, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderMarkStyle &&
          runtimeType == other.runtimeType &&
          tickColor == other.tickColor &&
          labelTextStyle == other.labelTextStyle &&
          labelAnchor == other.labelAnchor &&
          labelOffset == other.labelOffset &&
          tickSize == other.tickSize);

  @override
  int get hashCode =>
      tickColor.hashCode ^ labelTextStyle.hashCode ^ labelAnchor.hashCode ^ labelOffset.hashCode ^ tickSize.hashCode;
}

/// A delta that applies modifications to a [FSliderMarkStyle].
///
/// A [FSliderMarkStyle] is itself a [FSliderMarkStyleDelta].
abstract class FSliderMarkStyleDelta with Delta {
  /// Creates a partial modification of a [FSliderMarkStyle].
  ///
  /// ## Parameters
  /// * [FSliderMarkStyle.tickColor] - The tick's color.
  /// * [FSliderMarkStyle.labelTextStyle] - The label's default text style.
  /// * [FSliderMarkStyle.labelAnchor] - The label's anchor to which the [labelOffset] is applied.
  /// * [FSliderMarkStyle.labelOffset] - The label's offset from the slider, along its cross axis, in logical pixels.
  /// * [FSliderMarkStyle.tickSize] - The tick's size.
  const factory delta({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? tickColor,
    FVariantsDelta<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    AlignmentGeometry? labelAnchor,
    double? labelOffset,
    double? tickSize,
  }) = _FSliderMarkStyleDelta;

  /// Creates a delta that returns the [FSliderMarkStyle] in the current context.
  const factory context() = _FSliderMarkStyleContext;

  @override
  FSliderMarkStyle call(covariant FSliderMarkStyle value);
}

class _FSliderMarkStyleDelta implements FSliderMarkStyleDelta {
  const new({this.tickColor, this.labelTextStyle, this.labelAnchor, this.labelOffset, this.tickSize});

  final FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? tickColor;

  final FVariantsDelta<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final AlignmentGeometry? labelAnchor;

  final double? labelOffset;

  final double? tickSize;

  @override
  FSliderMarkStyle call(FSliderMarkStyle original) => FSliderMarkStyle(
    tickColor: tickColor?.call(original.tickColor) ?? original.tickColor,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    labelAnchor: labelAnchor ?? original.labelAnchor,
    labelOffset: labelOffset ?? original.labelOffset,
    tickSize: tickSize ?? original.tickSize,
  );
}

class _FSliderMarkStyleContext implements FSliderMarkStyleDelta {
  const new();

  @override
  FSliderMarkStyle call(FSliderMarkStyle original) => original;
}

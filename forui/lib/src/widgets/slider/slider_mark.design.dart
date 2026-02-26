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
  /// * [FSliderMarkStyle.tickSize] - The tick's size.
  /// * [FSliderMarkStyle.labelTextStyle] - The label's default text style.
  /// * [FSliderMarkStyle.labelAnchor] - The label's anchor to which the [labelOffset] is applied.
  /// * [FSliderMarkStyle.labelOffset] - The label's offset from the slider, along its cross axis, in logical pixels.
  @useResult
  FSliderMarkStyle copyWith({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? tickColor,
    double? tickSize,
    FVariantsDelta<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    AlignmentGeometry? labelAnchor,
    double? labelOffset,
  }) => .new(
    tickColor: tickColor?.call(this.tickColor) ?? this.tickColor,
    tickSize: tickSize ?? this.tickSize,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    labelAnchor: labelAnchor ?? this.labelAnchor,
    labelOffset: labelOffset ?? this.labelOffset,
  );

  /// Linearly interpolate between this and another [FSliderMarkStyle] using the given factor [t].
  @useResult
  FSliderMarkStyle lerp(FSliderMarkStyle other, double t) => .new(
    tickColor: .lerpColor(tickColor, other.tickColor, t),
    tickSize: lerpDouble(tickSize, other.tickSize, t) ?? tickSize,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelAnchor: .lerp(labelAnchor, other.labelAnchor, t) ?? labelAnchor,
    labelOffset: lerpDouble(labelOffset, other.labelOffset, t) ?? labelOffset,
  );
}

mixin _$FSliderMarkStyleFunctions on Diagnosticable implements FSliderMarkStyleDelta {
  /// Returns itself.
  @override
  FSliderMarkStyle call(Object _) => this as FSliderMarkStyle;

  FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> get tickColor;
  double get tickSize;
  FVariants<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  AlignmentGeometry get labelAnchor;
  double get labelOffset;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tickColor', tickColor, level: .debug))
      ..add(DoubleProperty('tickSize', tickSize, level: .debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('labelAnchor', labelAnchor, level: .debug))
      ..add(DoubleProperty('labelOffset', labelOffset, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderMarkStyle &&
          runtimeType == other.runtimeType &&
          tickColor == other.tickColor &&
          tickSize == other.tickSize &&
          labelTextStyle == other.labelTextStyle &&
          labelAnchor == other.labelAnchor &&
          labelOffset == other.labelOffset);

  @override
  int get hashCode =>
      tickColor.hashCode ^ tickSize.hashCode ^ labelTextStyle.hashCode ^ labelAnchor.hashCode ^ labelOffset.hashCode;
}

/// A delta that applies modifications to a [FSliderMarkStyle].
///
/// A [FSliderMarkStyle] is itself a [FSliderMarkStyleDelta].
abstract class FSliderMarkStyleDelta with Delta {
  /// Creates a partial modification of a [FSliderMarkStyle].
  ///
  /// ## Parameters
  /// * [FSliderMarkStyle.tickColor] - The tick's color.
  /// * [FSliderMarkStyle.tickSize] - The tick's size.
  /// * [FSliderMarkStyle.labelTextStyle] - The label's default text style.
  /// * [FSliderMarkStyle.labelAnchor] - The label's anchor to which the [labelOffset] is applied.
  /// * [FSliderMarkStyle.labelOffset] - The label's offset from the slider, along its cross axis, in logical pixels.
  const factory FSliderMarkStyleDelta.delta({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? tickColor,
    double? tickSize,
    FVariantsDelta<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    AlignmentGeometry? labelAnchor,
    double? labelOffset,
  }) = _FSliderMarkStyleDelta;

  /// Creates a delta that returns the [FSliderMarkStyle] in the current context.
  const factory FSliderMarkStyleDelta.context() = _FSliderMarkStyleContext;

  @override
  FSliderMarkStyle call(covariant FSliderMarkStyle value);
}

class _FSliderMarkStyleDelta implements FSliderMarkStyleDelta {
  const _FSliderMarkStyleDelta({
    this.tickColor,
    this.tickSize,
    this.labelTextStyle,
    this.labelAnchor,
    this.labelOffset,
  });

  final FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? tickColor;

  final double? tickSize;

  final FVariantsDelta<FSliderVariantConstraint, FSliderVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final AlignmentGeometry? labelAnchor;

  final double? labelOffset;

  @override
  FSliderMarkStyle call(FSliderMarkStyle original) => FSliderMarkStyle(
    tickColor: tickColor?.call(original.tickColor) ?? original.tickColor,
    tickSize: tickSize ?? original.tickSize,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    labelAnchor: labelAnchor ?? original.labelAnchor,
    labelOffset: labelOffset ?? original.labelOffset,
  );
}

class _FSliderMarkStyleContext implements FSliderMarkStyleDelta {
  const _FSliderMarkStyleContext();

  @override
  FSliderMarkStyle call(FSliderMarkStyle original) => original;
}

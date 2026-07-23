// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'thumb.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSliderThumbStyleTransformations on FSliderThumbStyle {
  /// Returns a copy of this [FSliderThumbStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderThumbStyle.color] - The thumb's color.
  /// * [FSliderThumbStyle.borderColor] - The border's color.
  /// * [FSliderThumbStyle.borderWidth] - The border's width.
  /// * [FSliderThumbStyle.focusedOutlineStyle] - The thumb's focused outline style.
  @useResult
  FSliderThumbStyle copyWith({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? color,
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? borderColor,
    double? borderWidth,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    color: color?.call(this.color) ?? this.color,
    borderColor: borderColor?.call(this.borderColor) ?? this.borderColor,
    borderWidth: borderWidth ?? this.borderWidth,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FSliderThumbStyle] using the given factor [t].
  @useResult
  FSliderThumbStyle lerp(FSliderThumbStyle other, double t) => .new(
    color: .lerpColor(color, other.color, t),
    borderColor: .lerpColor(borderColor, other.borderColor, t),
    borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FSliderThumbStyleFunctions on Diagnosticable implements FSliderThumbStyleDelta {
  /// Returns itself.
  @override
  FSliderThumbStyle call(Object _) => this as FSliderThumbStyle;

  FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> get color;
  FVariants<FSliderVariantConstraint, FSliderVariant, Color, Delta> get borderColor;
  double get borderWidth;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('color', color, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DoubleProperty('borderWidth', borderWidth, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderThumbStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode => color.hashCode ^ borderColor.hashCode ^ borderWidth.hashCode ^ focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FSliderThumbStyle].
///
/// A [FSliderThumbStyle] is itself a [FSliderThumbStyleDelta].
abstract class FSliderThumbStyleDelta with Delta {
  /// Creates a partial modification of a [FSliderThumbStyle].
  ///
  /// ## Parameters
  /// * [FSliderThumbStyle.color] - The thumb's color.
  /// * [FSliderThumbStyle.borderColor] - The border's color.
  /// * [FSliderThumbStyle.borderWidth] - The border's width.
  /// * [FSliderThumbStyle.focusedOutlineStyle] - The thumb's focused outline style.
  const factory FSliderThumbStyleDelta.delta({
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? color,
    FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? borderColor,
    double? borderWidth,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FSliderThumbStyleDelta;

  /// Creates a delta that returns the [FSliderThumbStyle] in the current context.
  const factory FSliderThumbStyleDelta.context() = _FSliderThumbStyleContext;

  @override
  FSliderThumbStyle call(covariant FSliderThumbStyle value);
}

class _FSliderThumbStyleDelta implements FSliderThumbStyleDelta {
  const _FSliderThumbStyleDelta({this.color, this.borderColor, this.borderWidth, this.focusedOutlineStyle});

  final FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? color;

  final FVariantsValueDelta<FSliderVariantConstraint, FSliderVariant, Color, Delta>? borderColor;

  final double? borderWidth;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FSliderThumbStyle call(FSliderThumbStyle original) => FSliderThumbStyle(
    color: color?.call(original.color) ?? original.color,
    borderColor: borderColor?.call(original.borderColor) ?? original.borderColor,
    borderWidth: borderWidth ?? original.borderWidth,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FSliderThumbStyleContext implements FSliderThumbStyleDelta {
  const _FSliderThumbStyleContext();

  @override
  FSliderThumbStyle call(FSliderThumbStyle original) => original;
}

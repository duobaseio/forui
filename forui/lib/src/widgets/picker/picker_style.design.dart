// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'picker_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPickerStyleTransformations on FPickerStyle {
  /// Returns a copy of this [FPickerStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FPickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FPickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FPickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FPickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FPickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FPickerStyle.textStyle] - The picker's default text style.
  /// * [FPickerStyle.textHeightBehavior] - The picker's default text height behavior.
  /// * [FPickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FPickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FPickerStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FPickerStyle copyWith({
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextStyleDelta? textStyle,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
    DecorationDelta? selectionDecoration,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    diameterRatio: diameterRatio ?? this.diameterRatio,
    squeeze: squeeze ?? this.squeeze,
    magnification: magnification ?? this.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? this.overAndUnderCenterOpacity,
    spacing: spacing ?? this.spacing,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? this.selectionHeightAdjustment,
    selectionDecoration: selectionDecoration?.call(this.selectionDecoration) ?? this.selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FPickerStyle] using the given factor [t].
  @useResult
  FPickerStyle lerp(FPickerStyle other, double t) => .new(
    diameterRatio: lerpDouble(diameterRatio, other.diameterRatio, t) ?? diameterRatio,
    squeeze: lerpDouble(squeeze, other.squeeze, t) ?? squeeze,
    magnification: lerpDouble(magnification, other.magnification, t) ?? magnification,
    overAndUnderCenterOpacity:
        lerpDouble(overAndUnderCenterOpacity, other.overAndUnderCenterOpacity, t) ?? overAndUnderCenterOpacity,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    textHeightBehavior: t < 0.5 ? textHeightBehavior : other.textHeightBehavior,
    selectionHeightAdjustment:
        lerpDouble(selectionHeightAdjustment, other.selectionHeightAdjustment, t) ?? selectionHeightAdjustment,
    selectionDecoration: .lerp(selectionDecoration, other.selectionDecoration, t) ?? selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FPickerStyleFunctions on Diagnosticable implements FPickerStyleDelta {
  /// Returns itself.
  @override
  FPickerStyle call(Object _) => this as FPickerStyle;

  double get diameterRatio;
  double get squeeze;
  double get magnification;
  double get overAndUnderCenterOpacity;
  double get spacing;
  TextStyle get textStyle;
  TextHeightBehavior get textHeightBehavior;
  double get selectionHeightAdjustment;
  Decoration get selectionDecoration;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('diameterRatio', diameterRatio, level: .debug))
      ..add(DoubleProperty('squeeze', squeeze, level: .debug))
      ..add(DoubleProperty('magnification', magnification, level: .debug))
      ..add(DoubleProperty('overAndUnderCenterOpacity', overAndUnderCenterOpacity, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('textHeightBehavior', textHeightBehavior, level: .debug))
      ..add(DoubleProperty('selectionHeightAdjustment', selectionHeightAdjustment, level: .debug))
      ..add(DiagnosticsProperty('selectionDecoration', selectionDecoration, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPickerStyle &&
          runtimeType == other.runtimeType &&
          diameterRatio == other.diameterRatio &&
          squeeze == other.squeeze &&
          magnification == other.magnification &&
          overAndUnderCenterOpacity == other.overAndUnderCenterOpacity &&
          spacing == other.spacing &&
          textStyle == other.textStyle &&
          textHeightBehavior == other.textHeightBehavior &&
          selectionHeightAdjustment == other.selectionHeightAdjustment &&
          selectionDecoration == other.selectionDecoration &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      diameterRatio.hashCode ^
      squeeze.hashCode ^
      magnification.hashCode ^
      overAndUnderCenterOpacity.hashCode ^
      spacing.hashCode ^
      textStyle.hashCode ^
      textHeightBehavior.hashCode ^
      selectionHeightAdjustment.hashCode ^
      selectionDecoration.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FPickerStyle].
///
/// A [FPickerStyle] is itself a [FPickerStyleDelta].
abstract class FPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FPickerStyle].
  ///
  /// ## Parameters
  /// * [FPickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FPickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FPickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FPickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FPickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FPickerStyle.textStyle] - The picker's default text style.
  /// * [FPickerStyle.textHeightBehavior] - The picker's default text height behavior.
  /// * [FPickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FPickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FPickerStyle.focusedOutlineStyle] - The focused outline style.
  const factory FPickerStyleDelta.delta({
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextStyleDelta? textStyle,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
    DecorationDelta? selectionDecoration,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FPickerStyleDelta;

  /// Creates a delta that returns the [FPickerStyle] in the current context.
  const factory FPickerStyleDelta.context() = _FPickerStyleContext;

  @override
  FPickerStyle call(covariant FPickerStyle value);
}

class _FPickerStyleDelta implements FPickerStyleDelta {
  const _FPickerStyleDelta({
    this.diameterRatio,
    this.squeeze,
    this.magnification,
    this.overAndUnderCenterOpacity,
    this.spacing,
    this.textStyle,
    this.textHeightBehavior,
    this.selectionHeightAdjustment,
    this.selectionDecoration,
    this.focusedOutlineStyle,
  });

  final double? diameterRatio;

  final double? squeeze;

  final double? magnification;

  final double? overAndUnderCenterOpacity;

  final double? spacing;

  final TextStyleDelta? textStyle;

  final TextHeightBehavior? textHeightBehavior;

  final double? selectionHeightAdjustment;

  final DecorationDelta? selectionDecoration;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FPickerStyle call(FPickerStyle original) => FPickerStyle(
    diameterRatio: diameterRatio ?? original.diameterRatio,
    squeeze: squeeze ?? original.squeeze,
    magnification: magnification ?? original.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? original.overAndUnderCenterOpacity,
    spacing: spacing ?? original.spacing,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    textHeightBehavior: textHeightBehavior ?? original.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? original.selectionHeightAdjustment,
    selectionDecoration: selectionDecoration?.call(original.selectionDecoration) ?? original.selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FPickerStyleContext implements FPickerStyleDelta {
  const _FPickerStyleContext();

  @override
  FPickerStyle call(FPickerStyle original) => original;
}

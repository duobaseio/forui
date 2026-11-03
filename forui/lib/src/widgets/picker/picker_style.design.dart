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
  /// * [FPickerStyle.textStyle] - The picker's text style.
  /// * [FPickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FPickerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FPickerStyle.hapticFeedback] - The haptic feedback for when the picker snaps to an item.
  /// * [FPickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FPickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FPickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FPickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FPickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FPickerStyle.textHeightBehavior] - The picker's text height behavior.
  /// * [FPickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  @useResult
  FPickerStyle copyWith({
    TextStyleDelta? textStyle,
    DecorationDelta? selectionDecoration,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    Future<void> Function()? hapticFeedback,
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
  }) => .new(
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    selectionDecoration: selectionDecoration?.call(this.selectionDecoration) ?? this.selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    hapticFeedback: hapticFeedback ?? this.hapticFeedback,
    diameterRatio: diameterRatio ?? this.diameterRatio,
    squeeze: squeeze ?? this.squeeze,
    magnification: magnification ?? this.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? this.overAndUnderCenterOpacity,
    spacing: spacing ?? this.spacing,
    textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? this.selectionHeightAdjustment,
  );

  /// Linearly interpolate between this and another [FPickerStyle] using the given factor [t].
  @useResult
  FPickerStyle lerp(FPickerStyle other, double t) => .new(
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    selectionDecoration: .lerp(selectionDecoration, other.selectionDecoration, t) ?? selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    hapticFeedback: t < 0.5 ? hapticFeedback : other.hapticFeedback,
    diameterRatio: lerpDouble(diameterRatio, other.diameterRatio, t) ?? diameterRatio,
    squeeze: lerpDouble(squeeze, other.squeeze, t) ?? squeeze,
    magnification: lerpDouble(magnification, other.magnification, t) ?? magnification,
    overAndUnderCenterOpacity:
        lerpDouble(overAndUnderCenterOpacity, other.overAndUnderCenterOpacity, t) ?? overAndUnderCenterOpacity,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    textHeightBehavior: t < 0.5 ? textHeightBehavior : other.textHeightBehavior,
    selectionHeightAdjustment:
        lerpDouble(selectionHeightAdjustment, other.selectionHeightAdjustment, t) ?? selectionHeightAdjustment,
  );
}

mixin _$FPickerStyleFunctions on Diagnosticable implements FPickerStyleDelta {
  /// Returns itself.
  @override
  FPickerStyle call(Object _) => this as FPickerStyle;

  TextStyle get textStyle;
  Decoration get selectionDecoration;
  FFocusedOutlineStyle get focusedOutlineStyle;
  Future<void> Function() get hapticFeedback;
  double get diameterRatio;
  double get squeeze;
  double get magnification;
  double get overAndUnderCenterOpacity;
  double get spacing;
  TextHeightBehavior get textHeightBehavior;
  double get selectionHeightAdjustment;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('selectionDecoration', selectionDecoration, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('hapticFeedback', hapticFeedback, level: .debug))
      ..add(DoubleProperty('diameterRatio', diameterRatio, level: .debug))
      ..add(DoubleProperty('squeeze', squeeze, level: .debug))
      ..add(DoubleProperty('magnification', magnification, level: .debug))
      ..add(DoubleProperty('overAndUnderCenterOpacity', overAndUnderCenterOpacity, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('textHeightBehavior', textHeightBehavior, level: .debug))
      ..add(DoubleProperty('selectionHeightAdjustment', selectionHeightAdjustment, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPickerStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          selectionDecoration == other.selectionDecoration &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          hapticFeedback == other.hapticFeedback &&
          diameterRatio == other.diameterRatio &&
          squeeze == other.squeeze &&
          magnification == other.magnification &&
          overAndUnderCenterOpacity == other.overAndUnderCenterOpacity &&
          spacing == other.spacing &&
          textHeightBehavior == other.textHeightBehavior &&
          selectionHeightAdjustment == other.selectionHeightAdjustment);

  @override
  int get hashCode =>
      textStyle.hashCode ^
      selectionDecoration.hashCode ^
      focusedOutlineStyle.hashCode ^
      hapticFeedback.hashCode ^
      diameterRatio.hashCode ^
      squeeze.hashCode ^
      magnification.hashCode ^
      overAndUnderCenterOpacity.hashCode ^
      spacing.hashCode ^
      textHeightBehavior.hashCode ^
      selectionHeightAdjustment.hashCode;
}

/// A delta that applies modifications to a [FPickerStyle].
///
/// A [FPickerStyle] is itself a [FPickerStyleDelta].
abstract class FPickerStyleDelta with Delta {
  /// Creates a partial modification of a [FPickerStyle].
  ///
  /// ## Parameters
  /// * [FPickerStyle.textStyle] - The picker's text style.
  /// * [FPickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FPickerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FPickerStyle.hapticFeedback] - The haptic feedback for when the picker snaps to an item.
  /// * [FPickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FPickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FPickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FPickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FPickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FPickerStyle.textHeightBehavior] - The picker's text height behavior.
  /// * [FPickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  const factory delta({
    TextStyleDelta? textStyle,
    DecorationDelta? selectionDecoration,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    Future<void> Function()? hapticFeedback,
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
  }) = _FPickerStyleDelta;

  /// Creates a delta that returns the [FPickerStyle] in the current context.
  const factory context() = _FPickerStyleContext;

  @override
  FPickerStyle call(covariant FPickerStyle value);
}

class _FPickerStyleDelta implements FPickerStyleDelta {
  const new({
    this.textStyle,
    this.selectionDecoration,
    this.focusedOutlineStyle,
    this.hapticFeedback,
    this.diameterRatio,
    this.squeeze,
    this.magnification,
    this.overAndUnderCenterOpacity,
    this.spacing,
    this.textHeightBehavior,
    this.selectionHeightAdjustment,
  });

  final TextStyleDelta? textStyle;

  final DecorationDelta? selectionDecoration;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final Future<void> Function()? hapticFeedback;

  final double? diameterRatio;

  final double? squeeze;

  final double? magnification;

  final double? overAndUnderCenterOpacity;

  final double? spacing;

  final TextHeightBehavior? textHeightBehavior;

  final double? selectionHeightAdjustment;

  @override
  FPickerStyle call(FPickerStyle original) => FPickerStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    selectionDecoration: selectionDecoration?.call(original.selectionDecoration) ?? original.selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    hapticFeedback: hapticFeedback ?? original.hapticFeedback,
    diameterRatio: diameterRatio ?? original.diameterRatio,
    squeeze: squeeze ?? original.squeeze,
    magnification: magnification ?? original.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? original.overAndUnderCenterOpacity,
    spacing: spacing ?? original.spacing,
    textHeightBehavior: textHeightBehavior ?? original.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? original.selectionHeightAdjustment,
  );
}

class _FPickerStyleContext implements FPickerStyleDelta {
  const new();

  @override
  FPickerStyle call(FPickerStyle original) => original;
}

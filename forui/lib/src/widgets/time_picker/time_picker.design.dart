// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'time_picker.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTimePickerStyleTransformations on FTimePickerStyle {
  /// Returns a copy of this [FTimePickerStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTimePickerStyle.padding] - The padding.
  /// * [FTimePickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FTimePickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FTimePickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FTimePickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FTimePickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FTimePickerStyle.textStyle] - The picker's default text style.
  /// * [FTimePickerStyle.textHeightBehavior] - The picker's default text height behavior.
  /// * [FTimePickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FTimePickerStyle.selectionBorderRadius] - The selection's border radius.
  /// * [FTimePickerStyle.selectionColor] - The selection's color.
  /// * [FTimePickerStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FTimePickerStyle copyWith({
    EdgeInsetsDirectionalDelta? padding,
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextStyleDelta? textStyle,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
    BorderRadiusGeometry? selectionBorderRadius,
    Color? selectionColor,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    padding: padding?.call(this.padding) ?? this.padding,
    diameterRatio: diameterRatio ?? this.diameterRatio,
    squeeze: squeeze ?? this.squeeze,
    magnification: magnification ?? this.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? this.overAndUnderCenterOpacity,
    spacing: spacing ?? this.spacing,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? this.selectionHeightAdjustment,
    selectionBorderRadius: selectionBorderRadius ?? this.selectionBorderRadius,
    selectionColor: selectionColor ?? this.selectionColor,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FTimePickerStyle] using the given factor [t].
  @useResult
  FTimePickerStyle lerp(FTimePickerStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
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
    selectionBorderRadius: .lerp(selectionBorderRadius, other.selectionBorderRadius, t) ?? selectionBorderRadius,
    selectionColor: FColors.lerpColor(selectionColor, other.selectionColor, t) ?? selectionColor,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FTimePickerStyleFunctions on Diagnosticable implements FTimePickerStyleDelta {
  /// Returns itself.
  @override
  FTimePickerStyle call(Object _) => this as FTimePickerStyle;

  EdgeInsetsDirectional get padding;
  double get diameterRatio;
  double get squeeze;
  double get magnification;
  double get overAndUnderCenterOpacity;
  double get spacing;
  TextStyle get textStyle;
  TextHeightBehavior get textHeightBehavior;
  double get selectionHeightAdjustment;
  BorderRadiusGeometry get selectionBorderRadius;
  Color get selectionColor;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimePickerStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          diameterRatio == other.diameterRatio &&
          squeeze == other.squeeze &&
          magnification == other.magnification &&
          overAndUnderCenterOpacity == other.overAndUnderCenterOpacity &&
          spacing == other.spacing &&
          textStyle == other.textStyle &&
          textHeightBehavior == other.textHeightBehavior &&
          selectionHeightAdjustment == other.selectionHeightAdjustment &&
          selectionBorderRadius == other.selectionBorderRadius &&
          selectionColor == other.selectionColor &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      padding.hashCode ^
      diameterRatio.hashCode ^
      squeeze.hashCode ^
      magnification.hashCode ^
      overAndUnderCenterOpacity.hashCode ^
      spacing.hashCode ^
      textStyle.hashCode ^
      textHeightBehavior.hashCode ^
      selectionHeightAdjustment.hashCode ^
      selectionBorderRadius.hashCode ^
      selectionColor.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FTimePickerStyle].
///
/// A [FTimePickerStyle] is itself a [FTimePickerStyleDelta].
abstract class FTimePickerStyleDelta with Delta {
  /// Creates a partial modification of a [FTimePickerStyle].
  ///
  /// ## Parameters
  /// * [FTimePickerStyle.padding] - The padding.
  /// * [FTimePickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FTimePickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FTimePickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FTimePickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FTimePickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FTimePickerStyle.textStyle] - The picker's default text style.
  /// * [FTimePickerStyle.textHeightBehavior] - The picker's default text height behavior.
  /// * [FTimePickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FTimePickerStyle.selectionBorderRadius] - The selection's border radius.
  /// * [FTimePickerStyle.selectionColor] - The selection's color.
  /// * [FTimePickerStyle.focusedOutlineStyle] - The focused outline style.
  const factory FTimePickerStyleDelta.delta({
    EdgeInsetsDirectionalDelta? padding,
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextStyleDelta? textStyle,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
    BorderRadiusGeometry? selectionBorderRadius,
    Color? selectionColor,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FTimePickerStyleDelta;

  /// Creates a delta that returns the [FTimePickerStyle] in the current context.
  const factory FTimePickerStyleDelta.context() = _FTimePickerStyleContext;

  @override
  FTimePickerStyle call(covariant FTimePickerStyle value);
}

class _FTimePickerStyleDelta implements FTimePickerStyleDelta {
  const _FTimePickerStyleDelta({
    this.padding,
    this.diameterRatio,
    this.squeeze,
    this.magnification,
    this.overAndUnderCenterOpacity,
    this.spacing,
    this.textStyle,
    this.textHeightBehavior,
    this.selectionHeightAdjustment,
    this.selectionBorderRadius,
    this.selectionColor,
    this.focusedOutlineStyle,
  });

  final EdgeInsetsDirectionalDelta? padding;

  final double? diameterRatio;

  final double? squeeze;

  final double? magnification;

  final double? overAndUnderCenterOpacity;

  final double? spacing;

  final TextStyleDelta? textStyle;

  final TextHeightBehavior? textHeightBehavior;

  final double? selectionHeightAdjustment;

  final BorderRadiusGeometry? selectionBorderRadius;

  final Color? selectionColor;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FTimePickerStyle call(FTimePickerStyle original) => FTimePickerStyle(
    padding: padding?.call(original.padding) ?? original.padding,
    diameterRatio: diameterRatio ?? original.diameterRatio,
    squeeze: squeeze ?? original.squeeze,
    magnification: magnification ?? original.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? original.overAndUnderCenterOpacity,
    spacing: spacing ?? original.spacing,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    textHeightBehavior: textHeightBehavior ?? original.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? original.selectionHeightAdjustment,
    selectionBorderRadius: selectionBorderRadius ?? original.selectionBorderRadius,
    selectionColor: selectionColor ?? original.selectionColor,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FTimePickerStyleContext implements FTimePickerStyleDelta {
  const _FTimePickerStyleContext();

  @override
  FTimePickerStyle call(FTimePickerStyle original) => original;
}

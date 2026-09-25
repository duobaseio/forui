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
  /// * [FTimePickerStyle.hourFlex] - The hour wheel's flex factor.
  /// * [FTimePickerStyle.minuteFlex] - The minute wheel's flex factor.
  /// * [FTimePickerStyle.periodFlex] - The period (AM/PM) wheel's flex factor.
  /// * [FTimePickerStyle.padding] - The padding.
  /// * [FTimePickerStyle.textStyle] - The picker's text style.
  /// * [FTimePickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FTimePickerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FTimePickerStyle.hapticFeedback] - The haptic feedback for when the picker snaps to an item.
  /// * [FTimePickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FTimePickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FTimePickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FTimePickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FTimePickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FTimePickerStyle.textHeightBehavior] - The picker's text height behavior.
  /// * [FTimePickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  @useResult
  FTimePickerStyle copyWith({
    int? hourFlex,
    int? minuteFlex,
    int? periodFlex,
    EdgeInsetsDirectionalDelta? padding,
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
    hourFlex: hourFlex ?? this.hourFlex,
    minuteFlex: minuteFlex ?? this.minuteFlex,
    periodFlex: periodFlex ?? this.periodFlex,
    padding: padding?.call(this.padding) ?? this.padding,
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

  /// Linearly interpolate between this and another [FTimePickerStyle] using the given factor [t].
  @useResult
  FTimePickerStyle lerp(FTimePickerStyle other, double t) => .new(
    hourFlex: t < 0.5 ? hourFlex : other.hourFlex,
    minuteFlex: t < 0.5 ? minuteFlex : other.minuteFlex,
    periodFlex: t < 0.5 ? periodFlex : other.periodFlex,
    padding: .lerp(padding, other.padding, t) ?? padding,
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

mixin _$FTimePickerStyleFunctions on Diagnosticable implements FTimePickerStyleDelta {
  /// Returns itself.
  @override
  FTimePickerStyle call(Object _) => this as FTimePickerStyle;

  int get hourFlex;
  int get minuteFlex;
  int get periodFlex;
  EdgeInsetsDirectional get padding;
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
      ..add(IntProperty('hourFlex', hourFlex, level: .debug))
      ..add(IntProperty('minuteFlex', minuteFlex, level: .debug))
      ..add(IntProperty('periodFlex', periodFlex, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimePickerStyle &&
          runtimeType == other.runtimeType &&
          hourFlex == other.hourFlex &&
          minuteFlex == other.minuteFlex &&
          periodFlex == other.periodFlex &&
          padding == other.padding &&
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
      hourFlex.hashCode ^
      minuteFlex.hashCode ^
      periodFlex.hashCode ^
      padding.hashCode ^
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

/// A delta that applies modifications to a [FTimePickerStyle].
///
/// A [FTimePickerStyle] is itself a [FTimePickerStyleDelta].
abstract class FTimePickerStyleDelta with Delta {
  /// Creates a partial modification of a [FTimePickerStyle].
  ///
  /// ## Parameters
  /// * [FTimePickerStyle.hourFlex] - The hour wheel's flex factor.
  /// * [FTimePickerStyle.minuteFlex] - The minute wheel's flex factor.
  /// * [FTimePickerStyle.periodFlex] - The period (AM/PM) wheel's flex factor.
  /// * [FTimePickerStyle.padding] - The padding.
  /// * [FTimePickerStyle.textStyle] - The picker's text style.
  /// * [FTimePickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FTimePickerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FTimePickerStyle.hapticFeedback] - The haptic feedback for when the picker snaps to an item.
  /// * [FTimePickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FTimePickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FTimePickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FTimePickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FTimePickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FTimePickerStyle.textHeightBehavior] - The picker's text height behavior.
  /// * [FTimePickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  const factory delta({
    int? hourFlex,
    int? minuteFlex,
    int? periodFlex,
    EdgeInsetsDirectionalDelta? padding,
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
  }) = _FTimePickerStyleDelta;

  /// Creates a delta that returns the [FTimePickerStyle] in the current context.
  const factory context() = _FTimePickerStyleContext;

  @override
  FTimePickerStyle call(covariant FTimePickerStyle value);
}

class _FTimePickerStyleDelta implements FTimePickerStyleDelta {
  const new({
    this.hourFlex,
    this.minuteFlex,
    this.periodFlex,
    this.padding,
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

  final int? hourFlex;

  final int? minuteFlex;

  final int? periodFlex;

  final EdgeInsetsDirectionalDelta? padding;

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
  FTimePickerStyle call(FTimePickerStyle original) => FTimePickerStyle(
    hourFlex: hourFlex ?? original.hourFlex,
    minuteFlex: minuteFlex ?? original.minuteFlex,
    periodFlex: periodFlex ?? original.periodFlex,
    padding: padding?.call(original.padding) ?? original.padding,
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

class _FTimePickerStyleContext implements FTimePickerStyleDelta {
  const new();

  @override
  FTimePickerStyle call(FTimePickerStyle original) => original;
}

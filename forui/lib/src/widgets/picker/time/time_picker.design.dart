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
  /// * [FTimePickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FTimePickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FTimePickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FTimePickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FTimePickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FTimePickerStyle.textStyle] - The picker's text style.
  /// * [FTimePickerStyle.textHeightBehavior] - The picker's text height behavior.
  /// * [FTimePickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FTimePickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FTimePickerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FTimePickerStyle.hapticFeedback] - The haptic feedback for when the picker snaps to an item.
  @useResult
  FTimePickerStyle copyWith({
    int? hourFlex,
    int? minuteFlex,
    int? periodFlex,
    EdgeInsetsDirectionalDelta? padding,
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
    Future<void> Function()? hapticFeedback,
  }) => .new(
    hourFlex: hourFlex ?? this.hourFlex,
    minuteFlex: minuteFlex ?? this.minuteFlex,
    periodFlex: periodFlex ?? this.periodFlex,
    padding: padding?.call(this.padding) ?? this.padding,
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
    hapticFeedback: hapticFeedback ?? this.hapticFeedback,
  );

  /// Linearly interpolate between this and another [FTimePickerStyle] using the given factor [t].
  @useResult
  FTimePickerStyle lerp(FTimePickerStyle other, double t) => .new(
    hourFlex: t < 0.5 ? hourFlex : other.hourFlex,
    minuteFlex: t < 0.5 ? minuteFlex : other.minuteFlex,
    periodFlex: t < 0.5 ? periodFlex : other.periodFlex,
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
    selectionDecoration: .lerp(selectionDecoration, other.selectionDecoration, t) ?? selectionDecoration,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    hapticFeedback: t < 0.5 ? hapticFeedback : other.hapticFeedback,
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
  Future<void> Function() get hapticFeedback;
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
          diameterRatio == other.diameterRatio &&
          squeeze == other.squeeze &&
          magnification == other.magnification &&
          overAndUnderCenterOpacity == other.overAndUnderCenterOpacity &&
          spacing == other.spacing &&
          textStyle == other.textStyle &&
          textHeightBehavior == other.textHeightBehavior &&
          selectionHeightAdjustment == other.selectionHeightAdjustment &&
          selectionDecoration == other.selectionDecoration &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          hapticFeedback == other.hapticFeedback);

  @override
  int get hashCode =>
      hourFlex.hashCode ^
      minuteFlex.hashCode ^
      periodFlex.hashCode ^
      padding.hashCode ^
      diameterRatio.hashCode ^
      squeeze.hashCode ^
      magnification.hashCode ^
      overAndUnderCenterOpacity.hashCode ^
      spacing.hashCode ^
      textStyle.hashCode ^
      textHeightBehavior.hashCode ^
      selectionHeightAdjustment.hashCode ^
      selectionDecoration.hashCode ^
      focusedOutlineStyle.hashCode ^
      hapticFeedback.hashCode;
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
  /// * [FTimePickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FTimePickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FTimePickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FTimePickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FTimePickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FTimePickerStyle.textStyle] - The picker's text style.
  /// * [FTimePickerStyle.textHeightBehavior] - The picker's text height behavior.
  /// * [FTimePickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FTimePickerStyle.selectionDecoration] - The selection's decoration.
  /// * [FTimePickerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FTimePickerStyle.hapticFeedback] - The haptic feedback for when the picker snaps to an item.
  const factory FTimePickerStyleDelta.delta({
    int? hourFlex,
    int? minuteFlex,
    int? periodFlex,
    EdgeInsetsDirectionalDelta? padding,
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
    Future<void> Function()? hapticFeedback,
  }) = _FTimePickerStyleDelta;

  /// Creates a delta that returns the [FTimePickerStyle] in the current context.
  const factory FTimePickerStyleDelta.context() = _FTimePickerStyleContext;

  @override
  FTimePickerStyle call(covariant FTimePickerStyle value);
}

class _FTimePickerStyleDelta implements FTimePickerStyleDelta {
  const _FTimePickerStyleDelta({
    this.hourFlex,
    this.minuteFlex,
    this.periodFlex,
    this.padding,
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
    this.hapticFeedback,
  });

  final int? hourFlex;

  final int? minuteFlex;

  final int? periodFlex;

  final EdgeInsetsDirectionalDelta? padding;

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

  final Future<void> Function()? hapticFeedback;

  @override
  FTimePickerStyle call(FTimePickerStyle original) => FTimePickerStyle(
    hourFlex: hourFlex ?? original.hourFlex,
    minuteFlex: minuteFlex ?? original.minuteFlex,
    periodFlex: periodFlex ?? original.periodFlex,
    padding: padding?.call(original.padding) ?? original.padding,
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
    hapticFeedback: hapticFeedback ?? original.hapticFeedback,
  );
}

class _FTimePickerStyleContext implements FTimePickerStyleDelta {
  const _FTimePickerStyleContext();

  @override
  FTimePickerStyle call(FTimePickerStyle original) => original;
}

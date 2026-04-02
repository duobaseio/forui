// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteStyleTransformations on FAutocompleteStyle {
  /// Returns a copy of this [FAutocompleteStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteStyle.fieldStyles] - The field's styles.
  /// * [FAutocompleteStyle.contentStyle] - The content's style.
  @useResult
  FAutocompleteStyle copyWith({
    FVariantsDelta<
      FTextFieldSizeVariantConstraint,
      FTextFieldSizeVariant,
      FAutocompleteFieldStyle,
      FAutocompleteFieldStyleDelta
    >?
    fieldStyles,
    FAutocompleteContentStyleDelta? contentStyle,
  }) => .new(
    fieldStyles: FAutocompleteFieldSizeStyles(fieldStyles?.call(this.fieldStyles) ?? this.fieldStyles),
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteStyle] using the given factor [t].
  @useResult
  FAutocompleteStyle lerp(FAutocompleteStyle other, double t) => .new(
    fieldStyles: FAutocompleteFieldSizeStyles(
      .lerpWhere(fieldStyles, other.fieldStyles, t, (a, b, t) => a!.lerp(b!, t)),
    ),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FAutocompleteStyleFunctions on Diagnosticable implements FAutocompleteStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteStyle call(Object _) => this as FAutocompleteStyle;

  FAutocompleteFieldSizeStyles get fieldStyles;
  FAutocompleteContentStyle get contentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyles', fieldStyles, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteStyle &&
          runtimeType == other.runtimeType &&
          fieldStyles == other.fieldStyles &&
          contentStyle == other.contentStyle);

  @override
  int get hashCode => fieldStyles.hashCode ^ contentStyle.hashCode;
}

/// A delta that applies modifications to a [FAutocompleteStyle].
///
/// A [FAutocompleteStyle] is itself a [FAutocompleteStyleDelta].
abstract class FAutocompleteStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteStyle.fieldStyles] - The field's styles.
  /// * [FAutocompleteStyle.contentStyle] - The content's style.
  const factory FAutocompleteStyleDelta.delta({
    FVariantsDelta<
      FTextFieldSizeVariantConstraint,
      FTextFieldSizeVariant,
      FAutocompleteFieldStyle,
      FAutocompleteFieldStyleDelta
    >?
    fieldStyles,
    FAutocompleteContentStyleDelta? contentStyle,
  }) = _FAutocompleteStyleDelta;

  /// Creates a delta that returns the [FAutocompleteStyle] in the current context.
  const factory FAutocompleteStyleDelta.context() = _FAutocompleteStyleContext;

  @override
  FAutocompleteStyle call(covariant FAutocompleteStyle value);
}

class _FAutocompleteStyleDelta implements FAutocompleteStyleDelta {
  const _FAutocompleteStyleDelta({this.fieldStyles, this.contentStyle});

  final FVariantsDelta<
    FTextFieldSizeVariantConstraint,
    FTextFieldSizeVariant,
    FAutocompleteFieldStyle,
    FAutocompleteFieldStyleDelta
  >?
  fieldStyles;

  final FAutocompleteContentStyleDelta? contentStyle;

  @override
  FAutocompleteStyle call(FAutocompleteStyle original) => FAutocompleteStyle(
    fieldStyles: FAutocompleteFieldSizeStyles(fieldStyles?.call(original.fieldStyles) ?? original.fieldStyles),
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
  );
}

class _FAutocompleteStyleContext implements FAutocompleteStyleDelta {
  const _FAutocompleteStyleContext();

  @override
  FAutocompleteStyle call(FAutocompleteStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteFieldStyleTransformations on FAutocompleteFieldStyle {
  /// Returns a copy of this [FAutocompleteFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteFieldStyle.composingTextStyle] - The composing text's [TextStyle].
  /// * [FAutocompleteFieldStyle.typeaheadTextStyle] - The typeahead's [TextStyle].
  /// * [FAutocompleteFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FAutocompleteFieldStyle.color] - The fill color of the text-field.
  /// * [FAutocompleteFieldStyle.cursorColor] - The color of the cursor.
  /// * [FAutocompleteFieldStyle.cursorWidth] - The width of the cursor.
  /// * [FAutocompleteFieldStyle.cursorOpacityAnimates] - Whether the cursor opacity animates.
  /// * [FAutocompleteFieldStyle.contentPadding] - The padding surrounding this text field's content.
  /// * [FAutocompleteFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FAutocompleteFieldStyle.obscureButtonPadding] - The padding surrounding the obscured text toggle.
  /// * [FAutocompleteFieldStyle.scrollPadding] - Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  /// * [FAutocompleteFieldStyle.iconStyle] - The prefix & suffix icon styles.
  /// * [FAutocompleteFieldStyle.clearButtonStyle] - The clear button's style when [FTextField.clearable] is true.
  /// * [FAutocompleteFieldStyle.obscureButtonStyle] - The obscured text toggle's style when enabled in [FTextField.password].
  /// * [FAutocompleteFieldStyle.contentTextStyle] - The content's [TextStyle].
  /// * [FAutocompleteFieldStyle.hintTextStyle] - The hint's [TextStyle].
  /// * [FAutocompleteFieldStyle.counterTextStyle] - The counter's [TextStyle].
  /// * [FAutocompleteFieldStyle.border] - The border.
  /// * [FAutocompleteFieldStyle.labelPadding] - The label's padding.
  /// * [FAutocompleteFieldStyle.descriptionPadding] - The description's padding.
  /// * [FAutocompleteFieldStyle.errorPadding] - The error's padding.
  /// * [FAutocompleteFieldStyle.childPadding] - The child's padding.
  /// * [FAutocompleteFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FAutocompleteFieldStyle.labelTextStyle] - The label's text style.
  /// * [FAutocompleteFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FAutocompleteFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FAutocompleteFieldStyle copyWith({
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? composingTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle?, TextStyleDelta>? typeaheadTextStyle,
    Brightness? keyboardAppearance,
    FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta>? color,
    Color? cursorColor,
    double? cursorWidth,
    bool? Function()? cursorOpacityAnimates,
    EdgeInsetsGeometryDelta? contentPadding,
    EdgeInsetsGeometryDelta? clearButtonPadding,
    EdgeInsetsGeometryDelta? obscureButtonPadding,
    EdgeInsetsDelta? scrollPadding,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FButtonStyleDelta? clearButtonStyle,
    FButtonStyleDelta? obscureButtonStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? contentTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? hintTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? counterTextStyle,
    FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, InputBorder, Delta>? border,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    composingTextStyle: composingTextStyle?.call(this.composingTextStyle) ?? this.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle?.call(this.typeaheadTextStyle) ?? this.typeaheadTextStyle,
    keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
    color: color?.call(this.color) ?? this.color,
    cursorColor: cursorColor ?? this.cursorColor,
    cursorWidth: cursorWidth ?? this.cursorWidth,
    cursorOpacityAnimates: cursorOpacityAnimates == null ? this.cursorOpacityAnimates : cursorOpacityAnimates(),
    contentPadding: contentPadding?.call(this.contentPadding) ?? this.contentPadding,
    clearButtonPadding: clearButtonPadding?.call(this.clearButtonPadding) ?? this.clearButtonPadding,
    obscureButtonPadding: obscureButtonPadding?.call(this.obscureButtonPadding) ?? this.obscureButtonPadding,
    scrollPadding: scrollPadding?.call(this.scrollPadding) ?? this.scrollPadding,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    clearButtonStyle: clearButtonStyle?.call(this.clearButtonStyle) ?? this.clearButtonStyle,
    obscureButtonStyle: obscureButtonStyle?.call(this.obscureButtonStyle) ?? this.obscureButtonStyle,
    contentTextStyle: contentTextStyle?.call(this.contentTextStyle) ?? this.contentTextStyle,
    hintTextStyle: hintTextStyle?.call(this.hintTextStyle) ?? this.hintTextStyle,
    counterTextStyle: counterTextStyle?.call(this.counterTextStyle) ?? this.counterTextStyle,
    border: border?.call(this.border) ?? this.border,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteFieldStyle] using the given factor [t].
  @useResult
  FAutocompleteFieldStyle lerp(FAutocompleteFieldStyle other, double t) => .new(
    composingTextStyle: .lerpTextStyle(composingTextStyle, other.composingTextStyle, t),
    typeaheadTextStyle: .lerpWhere(typeaheadTextStyle, other.typeaheadTextStyle, t, TextStyle.lerp),
    keyboardAppearance: t < 0.5 ? keyboardAppearance : other.keyboardAppearance,
    color: .lerpWhere(color, other.color, t, Color.lerp),
    cursorColor: FColors.lerpColor(cursorColor, other.cursorColor, t) ?? cursorColor,
    cursorWidth: lerpDouble(cursorWidth, other.cursorWidth, t) ?? cursorWidth,
    cursorOpacityAnimates: t < 0.5 ? cursorOpacityAnimates : other.cursorOpacityAnimates,
    contentPadding: .lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    clearButtonPadding: .lerp(clearButtonPadding, other.clearButtonPadding, t) ?? clearButtonPadding,
    obscureButtonPadding: .lerp(obscureButtonPadding, other.obscureButtonPadding, t) ?? obscureButtonPadding,
    scrollPadding: .lerp(scrollPadding, other.scrollPadding, t) ?? scrollPadding,
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    clearButtonStyle: clearButtonStyle.lerp(other.clearButtonStyle, t),
    obscureButtonStyle: obscureButtonStyle.lerp(other.obscureButtonStyle, t),
    contentTextStyle: .lerpTextStyle(contentTextStyle, other.contentTextStyle, t),
    hintTextStyle: .lerpTextStyle(hintTextStyle, other.hintTextStyle, t),
    counterTextStyle: .lerpTextStyle(counterTextStyle, other.counterTextStyle, t),
    border: t < 0.5 ? border : other.border,
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelMotion: labelMotion.lerp(other.labelMotion, t),
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerpTextStyle(errorTextStyle, other.errorTextStyle, t),
  );
}

mixin _$FAutocompleteFieldStyleFunctions on Diagnosticable implements FAutocompleteFieldStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteFieldStyle call(Object _) => this as FAutocompleteFieldStyle;

  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get composingTextStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle?, TextStyleDelta> get typeaheadTextStyle;
  Brightness get keyboardAppearance;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta> get color;
  Color get cursorColor;
  double get cursorWidth;
  bool? get cursorOpacityAnimates;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get clearButtonPadding;
  EdgeInsetsGeometry get obscureButtonPadding;
  EdgeInsets get scrollPadding;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FButtonStyle get clearButtonStyle;
  FButtonStyle get obscureButtonStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get contentTextStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get hintTextStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get counterTextStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, InputBorder, Delta> get border;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FLabelMotion get labelMotion;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get descriptionTextStyle;
  FVariants<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta> get errorTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('composingTextStyle', composingTextStyle, level: .debug))
      ..add(DiagnosticsProperty('typeaheadTextStyle', typeaheadTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteFieldStyle &&
          runtimeType == other.runtimeType &&
          composingTextStyle == other.composingTextStyle &&
          typeaheadTextStyle == other.typeaheadTextStyle &&
          keyboardAppearance == other.keyboardAppearance &&
          color == other.color &&
          cursorColor == other.cursorColor &&
          cursorWidth == other.cursorWidth &&
          cursorOpacityAnimates == other.cursorOpacityAnimates &&
          contentPadding == other.contentPadding &&
          clearButtonPadding == other.clearButtonPadding &&
          obscureButtonPadding == other.obscureButtonPadding &&
          scrollPadding == other.scrollPadding &&
          iconStyle == other.iconStyle &&
          clearButtonStyle == other.clearButtonStyle &&
          obscureButtonStyle == other.obscureButtonStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          counterTextStyle == other.counterTextStyle &&
          border == other.border &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelMotion == other.labelMotion &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      composingTextStyle.hashCode ^
      typeaheadTextStyle.hashCode ^
      keyboardAppearance.hashCode ^
      color.hashCode ^
      cursorColor.hashCode ^
      cursorWidth.hashCode ^
      cursorOpacityAnimates.hashCode ^
      contentPadding.hashCode ^
      clearButtonPadding.hashCode ^
      obscureButtonPadding.hashCode ^
      scrollPadding.hashCode ^
      iconStyle.hashCode ^
      clearButtonStyle.hashCode ^
      obscureButtonStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      counterTextStyle.hashCode ^
      border.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FAutocompleteFieldStyle].
///
/// A [FAutocompleteFieldStyle] is itself a [FAutocompleteFieldStyleDelta].
abstract class FAutocompleteFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteFieldStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteFieldStyle.composingTextStyle] - The composing text's [TextStyle].
  /// * [FAutocompleteFieldStyle.typeaheadTextStyle] - The typeahead's [TextStyle].
  /// * [FAutocompleteFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FAutocompleteFieldStyle.color] - The fill color of the text-field.
  /// * [FAutocompleteFieldStyle.cursorColor] - The color of the cursor.
  /// * [FAutocompleteFieldStyle.cursorWidth] - The width of the cursor.
  /// * [FAutocompleteFieldStyle.cursorOpacityAnimates] - Whether the cursor opacity animates.
  /// * [FAutocompleteFieldStyle.contentPadding] - The padding surrounding this text field's content.
  /// * [FAutocompleteFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FAutocompleteFieldStyle.obscureButtonPadding] - The padding surrounding the obscured text toggle.
  /// * [FAutocompleteFieldStyle.scrollPadding] - Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  /// * [FAutocompleteFieldStyle.iconStyle] - The prefix & suffix icon styles.
  /// * [FAutocompleteFieldStyle.clearButtonStyle] - The clear button's style when [FTextField.clearable] is true.
  /// * [FAutocompleteFieldStyle.obscureButtonStyle] - The obscured text toggle's style when enabled in [FTextField.password].
  /// * [FAutocompleteFieldStyle.contentTextStyle] - The content's [TextStyle].
  /// * [FAutocompleteFieldStyle.hintTextStyle] - The hint's [TextStyle].
  /// * [FAutocompleteFieldStyle.counterTextStyle] - The counter's [TextStyle].
  /// * [FAutocompleteFieldStyle.border] - The border.
  /// * [FAutocompleteFieldStyle.labelPadding] - The label's padding.
  /// * [FAutocompleteFieldStyle.descriptionPadding] - The description's padding.
  /// * [FAutocompleteFieldStyle.errorPadding] - The error's padding.
  /// * [FAutocompleteFieldStyle.childPadding] - The child's padding.
  /// * [FAutocompleteFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FAutocompleteFieldStyle.labelTextStyle] - The label's text style.
  /// * [FAutocompleteFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FAutocompleteFieldStyle.errorTextStyle] - The error's text style.
  const factory FAutocompleteFieldStyleDelta.delta({
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? composingTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle?, TextStyleDelta>? typeaheadTextStyle,
    Brightness? keyboardAppearance,
    FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta>? color,
    Color? cursorColor,
    double? cursorWidth,
    bool? Function()? cursorOpacityAnimates,
    EdgeInsetsGeometryDelta? contentPadding,
    EdgeInsetsGeometryDelta? clearButtonPadding,
    EdgeInsetsGeometryDelta? obscureButtonPadding,
    EdgeInsetsDelta? scrollPadding,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FButtonStyleDelta? clearButtonStyle,
    FButtonStyleDelta? obscureButtonStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? contentTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? hintTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? counterTextStyle,
    FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, InputBorder, Delta>? border,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FAutocompleteFieldStyleDelta;

  /// Creates a delta that returns the [FAutocompleteFieldStyle] in the current context.
  const factory FAutocompleteFieldStyleDelta.context() = _FAutocompleteFieldStyleContext;

  @override
  FAutocompleteFieldStyle call(covariant FAutocompleteFieldStyle value);
}

class _FAutocompleteFieldStyleDelta implements FAutocompleteFieldStyleDelta {
  const _FAutocompleteFieldStyleDelta({
    this.composingTextStyle,
    this.typeaheadTextStyle,
    this.keyboardAppearance,
    this.color,
    this.cursorColor,
    this.cursorWidth,
    this.cursorOpacityAnimates,
    this.contentPadding,
    this.clearButtonPadding,
    this.obscureButtonPadding,
    this.scrollPadding,
    this.iconStyle,
    this.clearButtonStyle,
    this.obscureButtonStyle,
    this.contentTextStyle,
    this.hintTextStyle,
    this.counterTextStyle,
    this.border,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? composingTextStyle;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle?, TextStyleDelta>? typeaheadTextStyle;

  final Brightness? keyboardAppearance;

  final FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta>? color;

  final Color? cursorColor;

  final double? cursorWidth;

  final bool? Function()? cursorOpacityAnimates;

  final EdgeInsetsGeometryDelta? contentPadding;

  final EdgeInsetsGeometryDelta? clearButtonPadding;

  final EdgeInsetsGeometryDelta? obscureButtonPadding;

  final EdgeInsetsDelta? scrollPadding;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FButtonStyleDelta? clearButtonStyle;

  final FButtonStyleDelta? obscureButtonStyle;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? contentTextStyle;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? hintTextStyle;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? counterTextStyle;

  final FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, InputBorder, Delta>? border;

  final EdgeInsetsGeometryDelta? labelPadding;

  final EdgeInsetsGeometryDelta? descriptionPadding;

  final EdgeInsetsGeometryDelta? errorPadding;

  final EdgeInsetsGeometryDelta? childPadding;

  final FLabelMotionDelta? labelMotion;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle;

  final FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>?
  errorTextStyle;

  @override
  FAutocompleteFieldStyle call(FAutocompleteFieldStyle original) => FAutocompleteFieldStyle(
    composingTextStyle: composingTextStyle?.call(original.composingTextStyle) ?? original.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle?.call(original.typeaheadTextStyle) ?? original.typeaheadTextStyle,
    keyboardAppearance: keyboardAppearance ?? original.keyboardAppearance,
    color: color?.call(original.color) ?? original.color,
    cursorColor: cursorColor ?? original.cursorColor,
    cursorWidth: cursorWidth ?? original.cursorWidth,
    cursorOpacityAnimates: cursorOpacityAnimates == null ? original.cursorOpacityAnimates : cursorOpacityAnimates!(),
    contentPadding: contentPadding?.call(original.contentPadding) ?? original.contentPadding,
    clearButtonPadding: clearButtonPadding?.call(original.clearButtonPadding) ?? original.clearButtonPadding,
    obscureButtonPadding: obscureButtonPadding?.call(original.obscureButtonPadding) ?? original.obscureButtonPadding,
    scrollPadding: scrollPadding?.call(original.scrollPadding) ?? original.scrollPadding,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    clearButtonStyle: clearButtonStyle?.call(original.clearButtonStyle) ?? original.clearButtonStyle,
    obscureButtonStyle: obscureButtonStyle?.call(original.obscureButtonStyle) ?? original.obscureButtonStyle,
    contentTextStyle: contentTextStyle?.call(original.contentTextStyle) ?? original.contentTextStyle,
    hintTextStyle: hintTextStyle?.call(original.hintTextStyle) ?? original.hintTextStyle,
    counterTextStyle: counterTextStyle?.call(original.counterTextStyle) ?? original.counterTextStyle,
    border: border?.call(original.border) ?? original.border,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    descriptionPadding: descriptionPadding?.call(original.descriptionPadding) ?? original.descriptionPadding,
    errorPadding: errorPadding?.call(original.errorPadding) ?? original.errorPadding,
    childPadding: childPadding?.call(original.childPadding) ?? original.childPadding,
    labelMotion: labelMotion?.call(original.labelMotion) ?? original.labelMotion,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(original.descriptionTextStyle) ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

class _FAutocompleteFieldStyleContext implements FAutocompleteFieldStyleDelta {
  const _FAutocompleteFieldStyleContext();

  @override
  FAutocompleteFieldStyle call(FAutocompleteFieldStyle original) => original;
}

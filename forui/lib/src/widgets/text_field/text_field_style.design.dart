// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'text_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FTextFieldVariant], which represents individual variants.
extension type const FTextFieldVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FTextFieldVariantConstraint] that negates [variant].
  factory FTextFieldVariantConstraint.not(FTextFieldVariant variant) => FTextFieldVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FTextFieldVariant.disabled;

  /// The semantic variant when this widget is in an error state.
  static const error = FTextFieldVariant.error;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FTextFieldVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FTextFieldVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FTextFieldVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FTextFieldVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FTextFieldVariant._(Desktop());

  /// The Android platform variant.
  static const android = FTextFieldVariant.android;

  /// The iOS platform variant.
  static const iOS = FTextFieldVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FTextFieldVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FTextFieldVariant.windows;

  /// The macOS platform variant.
  static const macOS = FTextFieldVariant.macOS;

  /// The Linux platform variant.
  static const linux = FTextFieldVariant.linux;

  /// The web platform variant.
  static const web = FTextFieldVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FTextFieldVariantConstraint and(FTextFieldVariantConstraint other) => FTextFieldVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FTextFieldVariantConstraint], which represents combinations of variants.
extension type const FTextFieldVariant._(FVariant _) implements FTextFieldVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FTextFieldVariant._(.new(2, 'disabled'));

  /// The semantic variant when this widget is in an error state.
  static const error = FTextFieldVariant._(.new(2, 'error'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FTextFieldVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FTextFieldVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FTextFieldVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FTextFieldVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FTextFieldVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FTextFieldVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FTextFieldVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FTextFieldVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FTextFieldVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FTextFieldVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FTextFieldStyleTransformations on FTextFieldStyle {
  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTextFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FTextFieldStyle.color] - The fill color of the text-field.
  /// * [FTextFieldStyle.cursorColor] - The color of the cursor.
  /// * [FTextFieldStyle.contentPadding] - The padding surrounding this text field's content.
  /// * [FTextFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FTextFieldStyle.obscureButtonPadding] - The padding surrounding the obscured text toggle.
  /// * [FTextFieldStyle.scrollPadding] - Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  /// * [FTextFieldStyle.iconStyle] - The prefix & suffix icon styles.
  /// * [FTextFieldStyle.clearButtonStyle] - The clear button's style when [FTextField.clearable] is true.
  /// * [FTextFieldStyle.obscureButtonStyle] - The obscured text toggle's style when enabled in [FTextField.password].
  /// * [FTextFieldStyle.contentTextStyle] - The content's [TextStyle].
  /// * [FTextFieldStyle.hintTextStyle] - The hint's [TextStyle].
  /// * [FTextFieldStyle.counterTextStyle] - The counter's [TextStyle].
  /// * [FTextFieldStyle.border] - The border.
  /// * [FTextFieldStyle.labelPadding] - The label's padding.
  /// * [FTextFieldStyle.descriptionPadding] - The description's padding.
  /// * [FTextFieldStyle.errorPadding] - The error's padding.
  /// * [FTextFieldStyle.childPadding] - The child's padding.
  /// * [FTextFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FTextFieldStyle.labelTextStyle] - The label's text style.
  /// * [FTextFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FTextFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta>? color,
    Color? cursorColor,
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
    keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
    color: color?.call(this.color) ?? this.color,
    cursorColor: cursorColor ?? this.cursorColor,
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

  /// Linearly interpolate between this and another [FTextFieldStyle] using the given factor [t].
  @useResult
  FTextFieldStyle lerp(FTextFieldStyle other, double t) => .new(
    keyboardAppearance: t < 0.5 ? keyboardAppearance : other.keyboardAppearance,
    color: .lerpWhere(color, other.color, t, Color.lerp),
    cursorColor: FColors.lerpColor(cursorColor, other.cursorColor, t) ?? cursorColor,
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

mixin _$FTextFieldStyleFunctions on Diagnosticable implements FTextFieldStyleDelta {
  /// Returns itself.
  @override
  FTextFieldStyle call(Object _) => this as FTextFieldStyle;

  Brightness get keyboardAppearance;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta> get color;
  Color get cursorColor;
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
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance, level: .debug))
      ..add(DiagnosticsProperty('color', color, level: .debug))
      ..add(ColorProperty('cursorColor', cursorColor, level: .debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: .debug))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding, level: .debug))
      ..add(DiagnosticsProperty('obscureButtonPadding', obscureButtonPadding, level: .debug))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle, level: .debug))
      ..add(DiagnosticsProperty('obscureButtonStyle', obscureButtonStyle, level: .debug))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle, level: .debug))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle, level: .debug))
      ..add(DiagnosticsProperty('counterTextStyle', counterTextStyle, level: .debug))
      ..add(DiagnosticsProperty('border', border, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTextFieldStyle &&
          runtimeType == other.runtimeType &&
          keyboardAppearance == other.keyboardAppearance &&
          color == other.color &&
          cursorColor == other.cursorColor &&
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
      keyboardAppearance.hashCode ^
      color.hashCode ^
      cursorColor.hashCode ^
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

/// A delta that applies modifications to a [FTextFieldStyle].
///
/// A [FTextFieldStyle] is itself a [FTextFieldStyleDelta].
abstract class FTextFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FTextFieldStyle].
  ///
  /// ## Parameters
  /// * [FTextFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FTextFieldStyle.color] - The fill color of the text-field.
  /// * [FTextFieldStyle.cursorColor] - The color of the cursor.
  /// * [FTextFieldStyle.contentPadding] - The padding surrounding this text field's content.
  /// * [FTextFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FTextFieldStyle.obscureButtonPadding] - The padding surrounding the obscured text toggle.
  /// * [FTextFieldStyle.scrollPadding] - Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  /// * [FTextFieldStyle.iconStyle] - The prefix & suffix icon styles.
  /// * [FTextFieldStyle.clearButtonStyle] - The clear button's style when [FTextField.clearable] is true.
  /// * [FTextFieldStyle.obscureButtonStyle] - The obscured text toggle's style when enabled in [FTextField.password].
  /// * [FTextFieldStyle.contentTextStyle] - The content's [TextStyle].
  /// * [FTextFieldStyle.hintTextStyle] - The hint's [TextStyle].
  /// * [FTextFieldStyle.counterTextStyle] - The counter's [TextStyle].
  /// * [FTextFieldStyle.border] - The border.
  /// * [FTextFieldStyle.labelPadding] - The label's padding.
  /// * [FTextFieldStyle.descriptionPadding] - The description's padding.
  /// * [FTextFieldStyle.errorPadding] - The error's padding.
  /// * [FTextFieldStyle.childPadding] - The child's padding.
  /// * [FTextFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FTextFieldStyle.labelTextStyle] - The label's text style.
  /// * [FTextFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FTextFieldStyle.errorTextStyle] - The error's text style.
  const factory FTextFieldStyleDelta.delta({
    Brightness? keyboardAppearance,
    FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta>? color,
    Color? cursorColor,
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
  }) = _FTextFieldStyleDelta;

  /// Creates a delta that returns the [FTextFieldStyle] in the current context.
  const factory FTextFieldStyleDelta.context() = _FTextFieldStyleContext;

  @override
  FTextFieldStyle call(covariant FTextFieldStyle value);
}

class _FTextFieldStyleDelta implements FTextFieldStyleDelta {
  const _FTextFieldStyleDelta({
    this.keyboardAppearance,
    this.color,
    this.cursorColor,
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

  final Brightness? keyboardAppearance;

  final FVariantsValueDelta<FTextFieldVariantConstraint, FTextFieldVariant, Color?, Delta>? color;

  final Color? cursorColor;

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
  FTextFieldStyle call(FTextFieldStyle original) => FTextFieldStyle(
    keyboardAppearance: keyboardAppearance ?? original.keyboardAppearance,
    color: color?.call(original.color) ?? original.color,
    cursorColor: cursorColor ?? original.cursorColor,
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

class _FTextFieldStyleContext implements FTextFieldStyleDelta {
  const _FTextFieldStyleContext();

  @override
  FTextFieldStyle call(FTextFieldStyle original) => original;
}

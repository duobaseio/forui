// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectGroupStyleTransformations on FSelectGroupStyle {
  /// Returns a copy of this [FSelectGroupStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectGroupStyle.checkboxStyle] - The [FCheckbox]'s style.
  /// * [FSelectGroupStyle.radioStyle] - The [FRadio]'s style.
  /// * [FSelectGroupStyle.itemPadding] - The padding surrounding an item.
  /// * [FSelectGroupStyle.labelPadding] - The label's padding.
  /// * [FSelectGroupStyle.descriptionPadding] - The description's padding.
  /// * [FSelectGroupStyle.errorPadding] - The error's padding.
  /// * [FSelectGroupStyle.childPadding] - The child's padding.
  /// * [FSelectGroupStyle.labelMotion] - The motion properties for error animations.
  /// * [FSelectGroupStyle.labelTextStyle] - The label's text style.
  /// * [FSelectGroupStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectGroupStyle.errorTextStyle] - The error's text style.
  @useResult
  FSelectGroupStyle copyWith({
    FCheckboxStyleDelta? checkboxStyle,
    FRadioStyleDelta? radioStyle,
    EdgeInsetsGeometryDelta? itemPadding,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    checkboxStyle: checkboxStyle?.call(this.checkboxStyle) ?? this.checkboxStyle,
    radioStyle: radioStyle?.call(this.radioStyle) ?? this.radioStyle,
    itemPadding: itemPadding?.call(this.itemPadding) ?? this.itemPadding,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectGroupStyle] using the given factor [t].
  @useResult
  FSelectGroupStyle lerp(FSelectGroupStyle other, double t) => .new(
    checkboxStyle: checkboxStyle.lerp(other.checkboxStyle, t),
    radioStyle: radioStyle.lerp(other.radioStyle, t),
    itemPadding: .lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
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

mixin _$FSelectGroupStyleFunctions on Diagnosticable implements FSelectGroupStyleDelta {
  /// Returns itself.
  @override
  FSelectGroupStyle call(Object _) => this as FSelectGroupStyle;

  FCheckboxStyle get checkboxStyle;
  FRadioStyle get radioStyle;
  EdgeInsetsGeometry get itemPadding;
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
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle, level: .debug))
      ..add(DiagnosticsProperty('radioStyle', radioStyle, level: .debug))
      ..add(DiagnosticsProperty('itemPadding', itemPadding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectGroupStyle &&
          runtimeType == other.runtimeType &&
          checkboxStyle == other.checkboxStyle &&
          radioStyle == other.radioStyle &&
          itemPadding == other.itemPadding &&
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
      checkboxStyle.hashCode ^
      radioStyle.hashCode ^
      itemPadding.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FSelectGroupStyle].
///
/// A [FSelectGroupStyle] is itself a [FSelectGroupStyleDelta].
abstract class FSelectGroupStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectGroupStyle].
  ///
  /// ## Parameters
  /// * [FSelectGroupStyle.checkboxStyle] - The [FCheckbox]'s style.
  /// * [FSelectGroupStyle.radioStyle] - The [FRadio]'s style.
  /// * [FSelectGroupStyle.itemPadding] - The padding surrounding an item.
  /// * [FSelectGroupStyle.labelPadding] - The label's padding.
  /// * [FSelectGroupStyle.descriptionPadding] - The description's padding.
  /// * [FSelectGroupStyle.errorPadding] - The error's padding.
  /// * [FSelectGroupStyle.childPadding] - The child's padding.
  /// * [FSelectGroupStyle.labelMotion] - The motion properties for error animations.
  /// * [FSelectGroupStyle.labelTextStyle] - The label's text style.
  /// * [FSelectGroupStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectGroupStyle.errorTextStyle] - The error's text style.
  const factory FSelectGroupStyleDelta.delta({
    FCheckboxStyleDelta? checkboxStyle,
    FRadioStyleDelta? radioStyle,
    EdgeInsetsGeometryDelta? itemPadding,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FSelectGroupStyleDelta;

  /// Creates a delta that returns the [FSelectGroupStyle] in the current context.
  const factory FSelectGroupStyleDelta.context() = _FSelectGroupStyleContext;

  @override
  FSelectGroupStyle call(covariant FSelectGroupStyle value);
}

class _FSelectGroupStyleDelta implements FSelectGroupStyleDelta {
  const _FSelectGroupStyleDelta({
    this.checkboxStyle,
    this.radioStyle,
    this.itemPadding,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FCheckboxStyleDelta? checkboxStyle;

  final FRadioStyleDelta? radioStyle;

  final EdgeInsetsGeometryDelta? itemPadding;

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
  FSelectGroupStyle call(FSelectGroupStyle original) => FSelectGroupStyle(
    checkboxStyle: checkboxStyle?.call(original.checkboxStyle) ?? original.checkboxStyle,
    radioStyle: radioStyle?.call(original.radioStyle) ?? original.radioStyle,
    itemPadding: itemPadding?.call(original.itemPadding) ?? original.itemPadding,
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

class _FSelectGroupStyleContext implements FSelectGroupStyleDelta {
  const _FSelectGroupStyleContext();

  @override
  FSelectGroupStyle call(FSelectGroupStyle original) => original;
}

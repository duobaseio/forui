// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectStyleTransformations on FMultiSelectStyle {
  /// Returns a copy of this [FMultiSelectStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectStyle.fieldStyles] - The field's size styles.
  /// * [FMultiSelectStyle.searchStyle] - The search's style.
  /// * [FMultiSelectStyle.contentStyle] - The content's style.
  /// * [FMultiSelectStyle.emptyTextStyle] - The default text style when there are no results.
  @useResult
  FMultiSelectStyle copyWith({
    FVariantsDelta<
      FTextFieldSizeVariantConstraint,
      FTextFieldSizeVariant,
      FMultiSelectFieldStyle,
      FMultiSelectFieldStyleDelta
    >?
    fieldStyles,
    FSelectSearchStyleDelta? searchStyle,
    FSelectContentStyleDelta? contentStyle,
    TextStyleDelta? emptyTextStyle,
  }) => .new(
    fieldStyles: FMultiSelectFieldSizeStyles(fieldStyles?.call(this.fieldStyles) ?? this.fieldStyles),
    searchStyle: searchStyle?.call(this.searchStyle) ?? this.searchStyle,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    emptyTextStyle: emptyTextStyle?.call(this.emptyTextStyle) ?? this.emptyTextStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectStyle] using the given factor [t].
  @useResult
  FMultiSelectStyle lerp(FMultiSelectStyle other, double t) => .new(
    fieldStyles: FMultiSelectFieldSizeStyles(
      .lerpWhere(fieldStyles, other.fieldStyles, t, (a, b, t) => a!.lerp(b!, t)),
    ),
    searchStyle: searchStyle.lerp(other.searchStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
  );
}

mixin _$FMultiSelectStyleFunctions on Diagnosticable implements FMultiSelectStyleDelta {
  /// Returns itself.
  @override
  FMultiSelectStyle call(Object _) => this as FMultiSelectStyle;

  FMultiSelectFieldSizeStyles get fieldStyles;
  FSelectSearchStyle get searchStyle;
  FSelectContentStyle get contentStyle;
  TextStyle get emptyTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyles', fieldStyles, level: .debug))
      ..add(DiagnosticsProperty('searchStyle', searchStyle, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectStyle &&
          runtimeType == other.runtimeType &&
          fieldStyles == other.fieldStyles &&
          searchStyle == other.searchStyle &&
          contentStyle == other.contentStyle &&
          emptyTextStyle == other.emptyTextStyle);

  @override
  int get hashCode => fieldStyles.hashCode ^ searchStyle.hashCode ^ contentStyle.hashCode ^ emptyTextStyle.hashCode;
}

/// A delta that applies modifications to a [FMultiSelectStyle].
///
/// A [FMultiSelectStyle] is itself a [FMultiSelectStyleDelta].
abstract class FMultiSelectStyleDelta with Delta {
  /// Creates a partial modification of a [FMultiSelectStyle].
  ///
  /// ## Parameters
  /// * [FMultiSelectStyle.fieldStyles] - The field's size styles.
  /// * [FMultiSelectStyle.searchStyle] - The search's style.
  /// * [FMultiSelectStyle.contentStyle] - The content's style.
  /// * [FMultiSelectStyle.emptyTextStyle] - The default text style when there are no results.
  const factory FMultiSelectStyleDelta.delta({
    FVariantsDelta<
      FTextFieldSizeVariantConstraint,
      FTextFieldSizeVariant,
      FMultiSelectFieldStyle,
      FMultiSelectFieldStyleDelta
    >?
    fieldStyles,
    FSelectSearchStyleDelta? searchStyle,
    FSelectContentStyleDelta? contentStyle,
    TextStyleDelta? emptyTextStyle,
  }) = _FMultiSelectStyleDelta;

  /// Creates a delta that returns the [FMultiSelectStyle] in the current context.
  const factory FMultiSelectStyleDelta.context() = _FMultiSelectStyleContext;

  @override
  FMultiSelectStyle call(covariant FMultiSelectStyle value);
}

class _FMultiSelectStyleDelta implements FMultiSelectStyleDelta {
  const _FMultiSelectStyleDelta({this.fieldStyles, this.searchStyle, this.contentStyle, this.emptyTextStyle});

  final FVariantsDelta<
    FTextFieldSizeVariantConstraint,
    FTextFieldSizeVariant,
    FMultiSelectFieldStyle,
    FMultiSelectFieldStyleDelta
  >?
  fieldStyles;

  final FSelectSearchStyleDelta? searchStyle;

  final FSelectContentStyleDelta? contentStyle;

  final TextStyleDelta? emptyTextStyle;

  @override
  FMultiSelectStyle call(FMultiSelectStyle original) => FMultiSelectStyle(
    fieldStyles: FMultiSelectFieldSizeStyles(fieldStyles?.call(original.fieldStyles) ?? original.fieldStyles),
    searchStyle: searchStyle?.call(original.searchStyle) ?? original.searchStyle,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    emptyTextStyle: emptyTextStyle?.call(original.emptyTextStyle) ?? original.emptyTextStyle,
  );
}

class _FMultiSelectStyleContext implements FMultiSelectStyleDelta {
  const _FMultiSelectStyleContext();

  @override
  FMultiSelectStyle call(FMultiSelectStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectFieldStyleTransformations on FMultiSelectFieldStyle {
  /// Returns a copy of this [FMultiSelectFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectFieldStyle.decoration] - The multi-select field's decoration.
  /// * [FMultiSelectFieldStyle.contentPadding] - The multi-select field's padding.
  /// * [FMultiSelectFieldStyle.spacing] - The spacing between tags.
  /// * [FMultiSelectFieldStyle.runSpacing] - The spacing between the rows of tags.
  /// * [FMultiSelectFieldStyle.hintTextStyle] - The multi-select field hint's text style.
  /// * [FMultiSelectFieldStyle.hintPadding] - The multi-select field's hint padding.
  /// * [FMultiSelectFieldStyle.iconStyle] - The multi-select field's icon style.
  /// * [FMultiSelectFieldStyle.clearButtonStyle] - The clear button's style when [FMultiSelect.clearable] is true.
  /// * [FMultiSelectFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FMultiSelectFieldStyle.tappableStyle] - The multi-select field's tappable style.
  /// * [FMultiSelectFieldStyle.tagStyle] - The tag's style.
  /// * [FMultiSelectFieldStyle.labelPadding] - The label's padding.
  /// * [FMultiSelectFieldStyle.descriptionPadding] - The description's padding.
  /// * [FMultiSelectFieldStyle.errorPadding] - The error's padding.
  /// * [FMultiSelectFieldStyle.childPadding] - The child's padding.
  /// * [FMultiSelectFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FMultiSelectFieldStyle.labelTextStyle] - The label's text style.
  /// * [FMultiSelectFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FMultiSelectFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FMultiSelectFieldStyle copyWith({
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, Decoration, DecorationDelta>? decoration,
    EdgeInsetsGeometryDelta? contentPadding,
    double? spacing,
    double? runSpacing,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? hintTextStyle,
    EdgeInsetsGeometryDelta? hintPadding,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FButtonStyleDelta? clearButtonStyle,
    EdgeInsetsGeometryDelta? clearButtonPadding,
    FTappableStyleDelta? tappableStyle,
    FMultiSelectTagStyleDelta? tagStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    contentPadding: contentPadding?.call(this.contentPadding) ?? this.contentPadding,
    spacing: spacing ?? this.spacing,
    runSpacing: runSpacing ?? this.runSpacing,
    hintTextStyle: hintTextStyle?.call(this.hintTextStyle) ?? this.hintTextStyle,
    hintPadding: hintPadding?.call(this.hintPadding) ?? this.hintPadding,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    clearButtonStyle: clearButtonStyle?.call(this.clearButtonStyle) ?? this.clearButtonStyle,
    clearButtonPadding: clearButtonPadding?.call(this.clearButtonPadding) ?? this.clearButtonPadding,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    tagStyle: tagStyle?.call(this.tagStyle) ?? this.tagStyle,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectFieldStyle] using the given factor [t].
  @useResult
  FMultiSelectFieldStyle lerp(FMultiSelectFieldStyle other, double t) => .new(
    decoration: .lerpDecoration(decoration, other.decoration, t),
    contentPadding: .lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    runSpacing: lerpDouble(runSpacing, other.runSpacing, t) ?? runSpacing,
    hintTextStyle: .lerpTextStyle(hintTextStyle, other.hintTextStyle, t),
    hintPadding: .lerp(hintPadding, other.hintPadding, t) ?? hintPadding,
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    clearButtonStyle: clearButtonStyle.lerp(other.clearButtonStyle, t),
    clearButtonPadding: .lerp(clearButtonPadding, other.clearButtonPadding, t) ?? clearButtonPadding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    tagStyle: tagStyle.lerp(other.tagStyle, t),
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

mixin _$FMultiSelectFieldStyleFunctions on Diagnosticable implements FMultiSelectFieldStyleDelta {
  /// Returns itself.
  @override
  FMultiSelectFieldStyle call(Object _) => this as FMultiSelectFieldStyle;

  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, Decoration, DecorationDelta> get decoration;
  EdgeInsetsGeometry get contentPadding;
  double get spacing;
  double get runSpacing;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get hintTextStyle;
  EdgeInsetsGeometry get hintPadding;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FButtonStyle get clearButtonStyle;
  EdgeInsetsGeometry get clearButtonPadding;
  FTappableStyle get tappableStyle;
  FMultiSelectTagStyle get tagStyle;
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
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DoubleProperty('runSpacing', runSpacing, level: .debug))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle, level: .debug))
      ..add(DiagnosticsProperty('hintPadding', hintPadding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle, level: .debug))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('tagStyle', tagStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectFieldStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          contentPadding == other.contentPadding &&
          spacing == other.spacing &&
          runSpacing == other.runSpacing &&
          hintTextStyle == other.hintTextStyle &&
          hintPadding == other.hintPadding &&
          iconStyle == other.iconStyle &&
          clearButtonStyle == other.clearButtonStyle &&
          clearButtonPadding == other.clearButtonPadding &&
          tappableStyle == other.tappableStyle &&
          tagStyle == other.tagStyle &&
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
      decoration.hashCode ^
      contentPadding.hashCode ^
      spacing.hashCode ^
      runSpacing.hashCode ^
      hintTextStyle.hashCode ^
      hintPadding.hashCode ^
      iconStyle.hashCode ^
      clearButtonStyle.hashCode ^
      clearButtonPadding.hashCode ^
      tappableStyle.hashCode ^
      tagStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FMultiSelectFieldStyle].
///
/// A [FMultiSelectFieldStyle] is itself a [FMultiSelectFieldStyleDelta].
abstract class FMultiSelectFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FMultiSelectFieldStyle].
  ///
  /// ## Parameters
  /// * [FMultiSelectFieldStyle.decoration] - The multi-select field's decoration.
  /// * [FMultiSelectFieldStyle.contentPadding] - The multi-select field's padding.
  /// * [FMultiSelectFieldStyle.spacing] - The spacing between tags.
  /// * [FMultiSelectFieldStyle.runSpacing] - The spacing between the rows of tags.
  /// * [FMultiSelectFieldStyle.hintTextStyle] - The multi-select field hint's text style.
  /// * [FMultiSelectFieldStyle.hintPadding] - The multi-select field's hint padding.
  /// * [FMultiSelectFieldStyle.iconStyle] - The multi-select field's icon style.
  /// * [FMultiSelectFieldStyle.clearButtonStyle] - The clear button's style when [FMultiSelect.clearable] is true.
  /// * [FMultiSelectFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FMultiSelectFieldStyle.tappableStyle] - The multi-select field's tappable style.
  /// * [FMultiSelectFieldStyle.tagStyle] - The tag's style.
  /// * [FMultiSelectFieldStyle.labelPadding] - The label's padding.
  /// * [FMultiSelectFieldStyle.descriptionPadding] - The description's padding.
  /// * [FMultiSelectFieldStyle.errorPadding] - The error's padding.
  /// * [FMultiSelectFieldStyle.childPadding] - The child's padding.
  /// * [FMultiSelectFieldStyle.labelMotion] - The motion properties for error animations.
  /// * [FMultiSelectFieldStyle.labelTextStyle] - The label's text style.
  /// * [FMultiSelectFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FMultiSelectFieldStyle.errorTextStyle] - The error's text style.
  const factory FMultiSelectFieldStyleDelta.delta({
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, Decoration, DecorationDelta>? decoration,
    EdgeInsetsGeometryDelta? contentPadding,
    double? spacing,
    double? runSpacing,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? hintTextStyle,
    EdgeInsetsGeometryDelta? hintPadding,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FButtonStyleDelta? clearButtonStyle,
    EdgeInsetsGeometryDelta? clearButtonPadding,
    FTappableStyleDelta? tappableStyle,
    FMultiSelectTagStyleDelta? tagStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FMultiSelectFieldStyleDelta;

  /// Creates a delta that returns the [FMultiSelectFieldStyle] in the current context.
  const factory FMultiSelectFieldStyleDelta.context() = _FMultiSelectFieldStyleContext;

  @override
  FMultiSelectFieldStyle call(covariant FMultiSelectFieldStyle value);
}

class _FMultiSelectFieldStyleDelta implements FMultiSelectFieldStyleDelta {
  const _FMultiSelectFieldStyleDelta({
    this.decoration,
    this.contentPadding,
    this.spacing,
    this.runSpacing,
    this.hintTextStyle,
    this.hintPadding,
    this.iconStyle,
    this.clearButtonStyle,
    this.clearButtonPadding,
    this.tappableStyle,
    this.tagStyle,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, Decoration, DecorationDelta>? decoration;

  final EdgeInsetsGeometryDelta? contentPadding;

  final double? spacing;

  final double? runSpacing;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? hintTextStyle;

  final EdgeInsetsGeometryDelta? hintPadding;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FButtonStyleDelta? clearButtonStyle;

  final EdgeInsetsGeometryDelta? clearButtonPadding;

  final FTappableStyleDelta? tappableStyle;

  final FMultiSelectTagStyleDelta? tagStyle;

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
  FMultiSelectFieldStyle call(FMultiSelectFieldStyle original) => FMultiSelectFieldStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    contentPadding: contentPadding?.call(original.contentPadding) ?? original.contentPadding,
    spacing: spacing ?? original.spacing,
    runSpacing: runSpacing ?? original.runSpacing,
    hintTextStyle: hintTextStyle?.call(original.hintTextStyle) ?? original.hintTextStyle,
    hintPadding: hintPadding?.call(original.hintPadding) ?? original.hintPadding,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    clearButtonStyle: clearButtonStyle?.call(original.clearButtonStyle) ?? original.clearButtonStyle,
    clearButtonPadding: clearButtonPadding?.call(original.clearButtonPadding) ?? original.clearButtonPadding,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    tagStyle: tagStyle?.call(original.tagStyle) ?? original.tagStyle,
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

class _FMultiSelectFieldStyleContext implements FMultiSelectFieldStyleDelta {
  const _FMultiSelectFieldStyleContext();

  @override
  FMultiSelectFieldStyle call(FMultiSelectFieldStyle original) => original;
}

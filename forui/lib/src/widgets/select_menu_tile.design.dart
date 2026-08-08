// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_menu_tile.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectMenuTileStyleTransformations on FSelectMenuTileStyle {
  /// Returns a copy of this [FSelectMenuTileStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectMenuTileStyle.menuStyle] - The menu's style.
  /// * [FSelectMenuTileStyle.tileStyle] - The tile's style.
  /// * [FSelectMenuTileStyle.labelPadding] - The label's padding.
  /// * [FSelectMenuTileStyle.descriptionPadding] - The description's padding.
  /// * [FSelectMenuTileStyle.errorPadding] - The error's padding.
  /// * [FSelectMenuTileStyle.childPadding] - The child's padding.
  /// * [FSelectMenuTileStyle.labelMotion] - The motion properties for error animations.
  /// * [FSelectMenuTileStyle.labelTextStyle] - The label's text style.
  /// * [FSelectMenuTileStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectMenuTileStyle.errorTextStyle] - The error's text style.
  @useResult
  FSelectMenuTileStyle copyWith({
    FPopoverMenuStyleDelta? menuStyle,
    FTileStyleDelta? tileStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    menuStyle: menuStyle?.call(this.menuStyle) ?? this.menuStyle,
    tileStyle: tileStyle?.call(this.tileStyle) ?? this.tileStyle,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectMenuTileStyle] using the given factor [t].
  @useResult
  FSelectMenuTileStyle lerp(FSelectMenuTileStyle other, double t) => .new(
    menuStyle: menuStyle.lerp(other.menuStyle, t),
    tileStyle: tileStyle.lerp(other.tileStyle, t),
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

mixin _$FSelectMenuTileStyleFunctions on Diagnosticable implements FSelectMenuTileStyleDelta {
  /// Returns itself.
  @override
  FSelectMenuTileStyle call(Object _) => this as FSelectMenuTileStyle;

  FPopoverMenuStyle get menuStyle;
  FTileStyle get tileStyle;
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
      ..add(DiagnosticsProperty('menuStyle', menuStyle, level: .debug))
      ..add(DiagnosticsProperty('tileStyle', tileStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectMenuTileStyle &&
          runtimeType == other.runtimeType &&
          menuStyle == other.menuStyle &&
          tileStyle == other.tileStyle &&
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
      menuStyle.hashCode ^
      tileStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FSelectMenuTileStyle].
///
/// A [FSelectMenuTileStyle] is itself a [FSelectMenuTileStyleDelta].
abstract class FSelectMenuTileStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectMenuTileStyle].
  ///
  /// ## Parameters
  /// * [FSelectMenuTileStyle.menuStyle] - The menu's style.
  /// * [FSelectMenuTileStyle.tileStyle] - The tile's style.
  /// * [FSelectMenuTileStyle.labelPadding] - The label's padding.
  /// * [FSelectMenuTileStyle.descriptionPadding] - The description's padding.
  /// * [FSelectMenuTileStyle.errorPadding] - The error's padding.
  /// * [FSelectMenuTileStyle.childPadding] - The child's padding.
  /// * [FSelectMenuTileStyle.labelMotion] - The motion properties for error animations.
  /// * [FSelectMenuTileStyle.labelTextStyle] - The label's text style.
  /// * [FSelectMenuTileStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectMenuTileStyle.errorTextStyle] - The error's text style.
  const factory FSelectMenuTileStyleDelta.delta({
    FPopoverMenuStyleDelta? menuStyle,
    FTileStyleDelta? tileStyle,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FSelectMenuTileStyleDelta;

  /// Creates a delta that returns the [FSelectMenuTileStyle] in the current context.
  const factory FSelectMenuTileStyleDelta.context() = _FSelectMenuTileStyleContext;

  @override
  FSelectMenuTileStyle call(covariant FSelectMenuTileStyle value);
}

class _FSelectMenuTileStyleDelta implements FSelectMenuTileStyleDelta {
  const _FSelectMenuTileStyleDelta({
    this.menuStyle,
    this.tileStyle,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FPopoverMenuStyleDelta? menuStyle;

  final FTileStyleDelta? tileStyle;

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
  FSelectMenuTileStyle call(FSelectMenuTileStyle original) => FSelectMenuTileStyle(
    menuStyle: menuStyle?.call(original.menuStyle) ?? original.menuStyle,
    tileStyle: tileStyle?.call(original.tileStyle) ?? original.tileStyle,
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

class _FSelectMenuTileStyleContext implements FSelectMenuTileStyleDelta {
  const _FSelectMenuTileStyleContext();

  @override
  FSelectMenuTileStyle call(FSelectMenuTileStyle original) => original;
}

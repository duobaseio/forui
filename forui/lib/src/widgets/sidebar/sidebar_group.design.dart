// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarGroupStyleTransformations on FSidebarGroupStyle {
  /// Returns a copy of this [FSidebarGroupStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarGroupStyle.labelStyle] - The label's text style.
  /// * [FSidebarGroupStyle.actionStyle] - The action's style.
  /// * [FSidebarGroupStyle.tappableStyle] - The tappable action's style.
  /// * [FSidebarGroupStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarGroupStyle.itemStyle] - The item's style.
  /// * [FSidebarGroupStyle.padding] - The padding.
  /// * [FSidebarGroupStyle.headerSpacing] - The spacing between the label and action in the header.
  /// * [FSidebarGroupStyle.headerPadding] - The padding around the header.
  /// * [FSidebarGroupStyle.childrenSpacing] - The spacing between children.
  /// * [FSidebarGroupStyle.childrenPadding] - The padding around the children.
  @useResult
  FSidebarGroupStyle copyWith({
    TextStyleDelta? labelStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? actionStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FSidebarItemStyleDelta? itemStyle,
    EdgeInsetsDelta? padding,
    double? headerSpacing,
    EdgeInsetsGeometryDelta? headerPadding,
    double? childrenSpacing,
    EdgeInsetsGeometryDelta? childrenPadding,
  }) => .new(
    labelStyle: labelStyle?.call(this.labelStyle) ?? this.labelStyle,
    actionStyle: actionStyle?.call(this.actionStyle) ?? this.actionStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    itemStyle: itemStyle?.call(this.itemStyle) ?? this.itemStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    headerSpacing: headerSpacing ?? this.headerSpacing,
    headerPadding: headerPadding?.call(this.headerPadding) ?? this.headerPadding,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding?.call(this.childrenPadding) ?? this.childrenPadding,
  );

  /// Linearly interpolate between this and another [FSidebarGroupStyle] using the given factor [t].
  @useResult
  FSidebarGroupStyle lerp(FSidebarGroupStyle other, double t) => .new(
    labelStyle: .lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
    actionStyle: .lerpIconThemeData(actionStyle, other.actionStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    itemStyle: itemStyle.lerp(other.itemStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    headerPadding: .lerp(headerPadding, other.headerPadding, t) ?? headerPadding,
    childrenSpacing: lerpDouble(childrenSpacing, other.childrenSpacing, t) ?? childrenSpacing,
    childrenPadding: .lerp(childrenPadding, other.childrenPadding, t) ?? childrenPadding,
  );
}

mixin _$FSidebarGroupStyleFunctions on Diagnosticable implements FSidebarGroupStyleDelta {
  /// Returns itself.
  @override
  FSidebarGroupStyle call(Object _) => this as FSidebarGroupStyle;

  TextStyle get labelStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get actionStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FSidebarItemStyle get itemStyle;
  EdgeInsets get padding;
  double get headerSpacing;
  EdgeInsetsGeometry get headerPadding;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelStyle', labelStyle, level: .debug))
      ..add(DiagnosticsProperty('actionStyle', actionStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(DiagnosticsProperty('headerPadding', headerPadding, level: .debug))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing, level: .debug))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarGroupStyle &&
          runtimeType == other.runtimeType &&
          labelStyle == other.labelStyle &&
          actionStyle == other.actionStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          itemStyle == other.itemStyle &&
          padding == other.padding &&
          headerSpacing == other.headerSpacing &&
          headerPadding == other.headerPadding &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding);

  @override
  int get hashCode =>
      labelStyle.hashCode ^
      actionStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      itemStyle.hashCode ^
      padding.hashCode ^
      headerSpacing.hashCode ^
      headerPadding.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode;
}

/// A delta that applies modifications to a [FSidebarGroupStyle].
///
/// A [FSidebarGroupStyle] is itself a [FSidebarGroupStyleDelta].
abstract class FSidebarGroupStyleDelta with Delta {
  /// Creates a partial modification of a [FSidebarGroupStyle].
  ///
  /// ## Parameters
  /// * [FSidebarGroupStyle.labelStyle] - The label's text style.
  /// * [FSidebarGroupStyle.actionStyle] - The action's style.
  /// * [FSidebarGroupStyle.tappableStyle] - The tappable action's style.
  /// * [FSidebarGroupStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarGroupStyle.itemStyle] - The item's style.
  /// * [FSidebarGroupStyle.padding] - The padding.
  /// * [FSidebarGroupStyle.headerSpacing] - The spacing between the label and action in the header.
  /// * [FSidebarGroupStyle.headerPadding] - The padding around the header.
  /// * [FSidebarGroupStyle.childrenSpacing] - The spacing between children.
  /// * [FSidebarGroupStyle.childrenPadding] - The padding around the children.
  const factory delta({
    TextStyleDelta? labelStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? actionStyle,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FSidebarItemStyleDelta? itemStyle,
    EdgeInsetsDelta? padding,
    double? headerSpacing,
    EdgeInsetsGeometryDelta? headerPadding,
    double? childrenSpacing,
    EdgeInsetsGeometryDelta? childrenPadding,
  }) = _FSidebarGroupStyleDelta;

  /// Creates a delta that returns the [FSidebarGroupStyle] in the current context.
  const factory context() = _FSidebarGroupStyleContext;

  @override
  FSidebarGroupStyle call(covariant FSidebarGroupStyle value);
}

class _FSidebarGroupStyleDelta implements FSidebarGroupStyleDelta {
  const new({
    this.labelStyle,
    this.actionStyle,
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.itemStyle,
    this.padding,
    this.headerSpacing,
    this.headerPadding,
    this.childrenSpacing,
    this.childrenPadding,
  });

  final TextStyleDelta? labelStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? actionStyle;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FSidebarItemStyleDelta? itemStyle;

  final EdgeInsetsDelta? padding;

  final double? headerSpacing;

  final EdgeInsetsGeometryDelta? headerPadding;

  final double? childrenSpacing;

  final EdgeInsetsGeometryDelta? childrenPadding;

  @override
  FSidebarGroupStyle call(FSidebarGroupStyle original) => FSidebarGroupStyle(
    labelStyle: labelStyle?.call(original.labelStyle) ?? original.labelStyle,
    actionStyle: actionStyle?.call(original.actionStyle) ?? original.actionStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    headerSpacing: headerSpacing ?? original.headerSpacing,
    headerPadding: headerPadding?.call(original.headerPadding) ?? original.headerPadding,
    childrenSpacing: childrenSpacing ?? original.childrenSpacing,
    childrenPadding: childrenPadding?.call(original.childrenPadding) ?? original.childrenPadding,
  );
}

class _FSidebarGroupStyleContext implements FSidebarGroupStyleDelta {
  const new();

  @override
  FSidebarGroupStyle call(FSidebarGroupStyle original) => original;
}

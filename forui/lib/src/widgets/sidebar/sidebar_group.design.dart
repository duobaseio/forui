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
  /// * [FSidebarGroupStyle.padding] - The padding.
  /// * [FSidebarGroupStyle.headerSpacing] - The spacing between the label and action in the header.
  /// * [FSidebarGroupStyle.headerPadding] - The padding around the header.
  /// * [FSidebarGroupStyle.labelStyle] - The label's text style.
  /// * [FSidebarGroupStyle.actionStyle] - The action's style.
  /// * [FSidebarGroupStyle.childrenSpacing] - The spacing between children.
  /// * [FSidebarGroupStyle.childrenPadding] - The padding around the children.
  /// * [FSidebarGroupStyle.tappableStyle] - The tappable action's style.
  /// * [FSidebarGroupStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarGroupStyle.itemStyle] - The item's style.
  @useResult
  FSidebarGroupStyle copyWith({
    EdgeInsetsDelta? padding,
    double? headerSpacing,
    EdgeInsetsGeometryDelta? headerPadding,
    TextStyleDelta? labelStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? actionStyle,
    double? childrenSpacing,
    EdgeInsetsGeometryDelta? childrenPadding,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FSidebarItemStyleDelta? itemStyle,
  }) => .new(
    padding: padding?.call(this.padding) ?? this.padding,
    headerSpacing: headerSpacing ?? this.headerSpacing,
    headerPadding: headerPadding?.call(this.headerPadding) ?? this.headerPadding,
    labelStyle: labelStyle?.call(this.labelStyle) ?? this.labelStyle,
    actionStyle: actionStyle?.call(this.actionStyle) ?? this.actionStyle,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding?.call(this.childrenPadding) ?? this.childrenPadding,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    itemStyle: itemStyle?.call(this.itemStyle) ?? this.itemStyle,
  );

  /// Linearly interpolate between this and another [FSidebarGroupStyle] using the given factor [t].
  @useResult
  FSidebarGroupStyle lerp(FSidebarGroupStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    headerPadding: .lerp(headerPadding, other.headerPadding, t) ?? headerPadding,
    labelStyle: .lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
    actionStyle: .lerpIconThemeData(actionStyle, other.actionStyle, t),
    childrenSpacing: lerpDouble(childrenSpacing, other.childrenSpacing, t) ?? childrenSpacing,
    childrenPadding: .lerp(childrenPadding, other.childrenPadding, t) ?? childrenPadding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FSidebarGroupStyleFunctions on Diagnosticable implements FSidebarGroupStyleDelta {
  /// Returns itself.
  @override
  FSidebarGroupStyle call(Object _) => this as FSidebarGroupStyle;

  EdgeInsets get padding;
  double get headerSpacing;
  EdgeInsetsGeometry get headerPadding;
  TextStyle get labelStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get actionStyle;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FSidebarItemStyle get itemStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: .debug))
      ..add(DiagnosticsProperty('headerPadding', headerPadding, level: .debug))
      ..add(DiagnosticsProperty('labelStyle', labelStyle, level: .debug))
      ..add(DiagnosticsProperty('actionStyle', actionStyle, level: .debug))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing, level: .debug))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarGroupStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          headerSpacing == other.headerSpacing &&
          headerPadding == other.headerPadding &&
          labelStyle == other.labelStyle &&
          actionStyle == other.actionStyle &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          itemStyle == other.itemStyle);

  @override
  int get hashCode =>
      padding.hashCode ^
      headerSpacing.hashCode ^
      headerPadding.hashCode ^
      labelStyle.hashCode ^
      actionStyle.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      itemStyle.hashCode;
}

/// A delta that applies modifications to a [FSidebarGroupStyle].
///
/// A [FSidebarGroupStyle] is itself a [FSidebarGroupStyleDelta].
abstract class FSidebarGroupStyleDelta with Delta {
  /// Creates a partial modification of a [FSidebarGroupStyle].
  ///
  /// ## Parameters
  /// * [FSidebarGroupStyle.padding] - The padding.
  /// * [FSidebarGroupStyle.headerSpacing] - The spacing between the label and action in the header.
  /// * [FSidebarGroupStyle.headerPadding] - The padding around the header.
  /// * [FSidebarGroupStyle.labelStyle] - The label's text style.
  /// * [FSidebarGroupStyle.actionStyle] - The action's style.
  /// * [FSidebarGroupStyle.childrenSpacing] - The spacing between children.
  /// * [FSidebarGroupStyle.childrenPadding] - The padding around the children.
  /// * [FSidebarGroupStyle.tappableStyle] - The tappable action's style.
  /// * [FSidebarGroupStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarGroupStyle.itemStyle] - The item's style.
  const factory FSidebarGroupStyleDelta.delta({
    EdgeInsetsDelta? padding,
    double? headerSpacing,
    EdgeInsetsGeometryDelta? headerPadding,
    TextStyleDelta? labelStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? actionStyle,
    double? childrenSpacing,
    EdgeInsetsGeometryDelta? childrenPadding,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FSidebarItemStyleDelta? itemStyle,
  }) = _FSidebarGroupStyleDelta;

  /// Creates a delta that returns the [FSidebarGroupStyle] in the current context.
  const factory FSidebarGroupStyleDelta.context() = _FSidebarGroupStyleContext;

  @override
  FSidebarGroupStyle call(covariant FSidebarGroupStyle value);
}

class _FSidebarGroupStyleDelta implements FSidebarGroupStyleDelta {
  const _FSidebarGroupStyleDelta({
    this.padding,
    this.headerSpacing,
    this.headerPadding,
    this.labelStyle,
    this.actionStyle,
    this.childrenSpacing,
    this.childrenPadding,
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.itemStyle,
  });

  final EdgeInsetsDelta? padding;

  final double? headerSpacing;

  final EdgeInsetsGeometryDelta? headerPadding;

  final TextStyleDelta? labelStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? actionStyle;

  final double? childrenSpacing;

  final EdgeInsetsGeometryDelta? childrenPadding;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FSidebarItemStyleDelta? itemStyle;

  @override
  FSidebarGroupStyle call(FSidebarGroupStyle original) => FSidebarGroupStyle(
    padding: padding?.call(original.padding) ?? original.padding,
    headerSpacing: headerSpacing ?? original.headerSpacing,
    headerPadding: headerPadding?.call(original.headerPadding) ?? original.headerPadding,
    labelStyle: labelStyle?.call(original.labelStyle) ?? original.labelStyle,
    actionStyle: actionStyle?.call(original.actionStyle) ?? original.actionStyle,
    childrenSpacing: childrenSpacing ?? original.childrenSpacing,
    childrenPadding: childrenPadding?.call(original.childrenPadding) ?? original.childrenPadding,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
  );
}

class _FSidebarGroupStyleContext implements FSidebarGroupStyleDelta {
  const _FSidebarGroupStyleContext();

  @override
  FSidebarGroupStyle call(FSidebarGroupStyle original) => original;
}

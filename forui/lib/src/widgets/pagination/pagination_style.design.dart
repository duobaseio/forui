// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'pagination_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPaginationStyleTransformations on FPaginationStyle {
  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FPaginationStyle.itemIconStyle] - The icon's style.
  /// * [FPaginationStyle.itemDecoration] - The decoration applied to the pagination item.
  /// * [FPaginationStyle.itemTextStyle] - The default text style applied to the pagination item.
  /// * [FPaginationStyle.ellipsisTextStyle] - The ellipsis's text style.
  /// * [FPaginationStyle.actionTappableStyle] - The action's tappable style.
  /// * [FPaginationStyle.pageTappableStyle] - The pagination item's tappable style.
  /// * [FPaginationStyle.focusedOutlineStyle] - The pagination item's focused outline style.
  /// * [FPaginationStyle.itemConstraints] - The item's constraints.
  /// * [FPaginationStyle.itemPadding] - The padding around each item.
  @useResult
  FPaginationStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? itemIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? itemDecoration,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? itemTextStyle,
    TextStyleDelta? ellipsisTextStyle,
    FTappableStyleDelta? actionTappableStyle,
    FTappableStyleDelta? pageTappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    BoxConstraints? itemConstraints,
    EdgeInsetsDelta? itemPadding,
  }) => .new(
    itemIconStyle: itemIconStyle?.call(this.itemIconStyle) ?? this.itemIconStyle,
    itemDecoration: itemDecoration?.call(this.itemDecoration) ?? this.itemDecoration,
    itemTextStyle: itemTextStyle?.call(this.itemTextStyle) ?? this.itemTextStyle,
    ellipsisTextStyle: ellipsisTextStyle?.call(this.ellipsisTextStyle) ?? this.ellipsisTextStyle,
    actionTappableStyle: actionTappableStyle?.call(this.actionTappableStyle) ?? this.actionTappableStyle,
    pageTappableStyle: pageTappableStyle?.call(this.pageTappableStyle) ?? this.pageTappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    itemConstraints: itemConstraints ?? this.itemConstraints,
    itemPadding: itemPadding?.call(this.itemPadding) ?? this.itemPadding,
  );

  /// Linearly interpolate between this and another [FPaginationStyle] using the given factor [t].
  @useResult
  FPaginationStyle lerp(FPaginationStyle other, double t) => .new(
    itemIconStyle: .lerpIconThemeData(itemIconStyle, other.itemIconStyle, t),
    itemDecoration: .lerpDecoration(itemDecoration, other.itemDecoration, t),
    itemTextStyle: .lerpTextStyle(itemTextStyle, other.itemTextStyle, t),
    ellipsisTextStyle: .lerp(ellipsisTextStyle, other.ellipsisTextStyle, t) ?? ellipsisTextStyle,
    actionTappableStyle: actionTappableStyle.lerp(other.actionTappableStyle, t),
    pageTappableStyle: pageTappableStyle.lerp(other.pageTappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    itemConstraints: .lerp(itemConstraints, other.itemConstraints, t) ?? itemConstraints,
    itemPadding: .lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
  );
}

mixin _$FPaginationStyleFunctions on Diagnosticable implements FPaginationStyleDelta {
  /// Returns itself.
  @override
  FPaginationStyle call(Object _) => this as FPaginationStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get itemIconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get itemDecoration;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get itemTextStyle;
  TextStyle get ellipsisTextStyle;
  FTappableStyle get actionTappableStyle;
  FTappableStyle get pageTappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  BoxConstraints get itemConstraints;
  EdgeInsets get itemPadding;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemIconStyle', itemIconStyle, level: .debug))
      ..add(DiagnosticsProperty('itemDecoration', itemDecoration, level: .debug))
      ..add(DiagnosticsProperty('itemTextStyle', itemTextStyle, level: .debug))
      ..add(DiagnosticsProperty('ellipsisTextStyle', ellipsisTextStyle, level: .debug))
      ..add(DiagnosticsProperty('actionTappableStyle', actionTappableStyle, level: .debug))
      ..add(DiagnosticsProperty('pageTappableStyle', pageTappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('itemConstraints', itemConstraints, level: .debug))
      ..add(DiagnosticsProperty('itemPadding', itemPadding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPaginationStyle &&
          runtimeType == other.runtimeType &&
          itemIconStyle == other.itemIconStyle &&
          itemDecoration == other.itemDecoration &&
          itemTextStyle == other.itemTextStyle &&
          ellipsisTextStyle == other.ellipsisTextStyle &&
          actionTappableStyle == other.actionTappableStyle &&
          pageTappableStyle == other.pageTappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          itemConstraints == other.itemConstraints &&
          itemPadding == other.itemPadding);

  @override
  int get hashCode =>
      itemIconStyle.hashCode ^
      itemDecoration.hashCode ^
      itemTextStyle.hashCode ^
      ellipsisTextStyle.hashCode ^
      actionTappableStyle.hashCode ^
      pageTappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      itemConstraints.hashCode ^
      itemPadding.hashCode;
}

/// A delta that applies modifications to a [FPaginationStyle].
///
/// A [FPaginationStyle] is itself a [FPaginationStyleDelta].
abstract class FPaginationStyleDelta with Delta {
  /// Creates a partial modification of a [FPaginationStyle].
  ///
  /// ## Parameters
  /// * [FPaginationStyle.itemIconStyle] - The icon's style.
  /// * [FPaginationStyle.itemDecoration] - The decoration applied to the pagination item.
  /// * [FPaginationStyle.itemTextStyle] - The default text style applied to the pagination item.
  /// * [FPaginationStyle.ellipsisTextStyle] - The ellipsis's text style.
  /// * [FPaginationStyle.actionTappableStyle] - The action's tappable style.
  /// * [FPaginationStyle.pageTappableStyle] - The pagination item's tappable style.
  /// * [FPaginationStyle.focusedOutlineStyle] - The pagination item's focused outline style.
  /// * [FPaginationStyle.itemConstraints] - The item's constraints.
  /// * [FPaginationStyle.itemPadding] - The padding around each item.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? itemIconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? itemDecoration,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? itemTextStyle,
    TextStyleDelta? ellipsisTextStyle,
    FTappableStyleDelta? actionTappableStyle,
    FTappableStyleDelta? pageTappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    BoxConstraints? itemConstraints,
    EdgeInsetsDelta? itemPadding,
  }) = _FPaginationStyleDelta;

  /// Creates a delta that returns the [FPaginationStyle] in the current context.
  const factory context() = _FPaginationStyleContext;

  @override
  FPaginationStyle call(covariant FPaginationStyle value);
}

class _FPaginationStyleDelta implements FPaginationStyleDelta {
  const new({
    this.itemIconStyle,
    this.itemDecoration,
    this.itemTextStyle,
    this.ellipsisTextStyle,
    this.actionTappableStyle,
    this.pageTappableStyle,
    this.focusedOutlineStyle,
    this.itemConstraints,
    this.itemPadding,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? itemIconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? itemDecoration;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? itemTextStyle;

  final TextStyleDelta? ellipsisTextStyle;

  final FTappableStyleDelta? actionTappableStyle;

  final FTappableStyleDelta? pageTappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final BoxConstraints? itemConstraints;

  final EdgeInsetsDelta? itemPadding;

  @override
  FPaginationStyle call(FPaginationStyle original) => FPaginationStyle(
    itemIconStyle: itemIconStyle?.call(original.itemIconStyle) ?? original.itemIconStyle,
    itemDecoration: itemDecoration?.call(original.itemDecoration) ?? original.itemDecoration,
    itemTextStyle: itemTextStyle?.call(original.itemTextStyle) ?? original.itemTextStyle,
    ellipsisTextStyle: ellipsisTextStyle?.call(original.ellipsisTextStyle) ?? original.ellipsisTextStyle,
    actionTappableStyle: actionTappableStyle?.call(original.actionTappableStyle) ?? original.actionTappableStyle,
    pageTappableStyle: pageTappableStyle?.call(original.pageTappableStyle) ?? original.pageTappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    itemConstraints: itemConstraints ?? original.itemConstraints,
    itemPadding: itemPadding?.call(original.itemPadding) ?? original.itemPadding,
  );
}

class _FPaginationStyleContext implements FPaginationStyleDelta {
  const new();

  @override
  FPaginationStyle call(FPaginationStyle original) => original;
}

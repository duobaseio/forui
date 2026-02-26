// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FItemGroupVariant], which represents individual variants.
extension type const FItemGroupVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FItemGroupVariantConstraint] that negates [variant].
  factory FItemGroupVariantConstraint.not(FItemGroupVariant variant) => FItemGroupVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FItemGroupVariant.disabled;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FItemGroupVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FItemGroupVariant._(Desktop());

  /// The Android platform variant.
  static const android = FItemGroupVariant.android;

  /// The iOS platform variant.
  static const iOS = FItemGroupVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FItemGroupVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FItemGroupVariant.windows;

  /// The macOS platform variant.
  static const macOS = FItemGroupVariant.macOS;

  /// The Linux platform variant.
  static const linux = FItemGroupVariant.linux;

  /// The web platform variant.
  static const web = FItemGroupVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FItemGroupVariantConstraint and(FItemGroupVariantConstraint other) => FItemGroupVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FItemGroupVariantConstraint], which represents combinations of variants.
extension type const FItemGroupVariant._(FVariant _) implements FItemGroupVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FItemGroupVariant._(.new(2, 'disabled'));

  /// The Android platform variant.
  static const android = FItemGroupVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FItemGroupVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FItemGroupVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FItemGroupVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FItemGroupVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FItemGroupVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FItemGroupVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FItemGroupStyleTransformations on FItemGroupStyle {
  /// Returns a copy of this [FItemGroupStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemGroupStyle.decoration] - The group's decoration.
  /// * [FItemGroupStyle.spacing] - The vertical spacing at the top and bottom of each group.
  /// * [FItemGroupStyle.dividerColor] - The divider's style.
  /// * [FItemGroupStyle.dividerWidth] - The divider's width.
  /// * [FItemGroupStyle.itemStyles] - The item's styles.
  /// * [FItemGroupStyle.slideableItems] - Whether the items support pressing an item and sliding to another.
  @useResult
  FItemGroupStyle copyWith({
    DecorationDelta? decoration,
    double? spacing,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FVariantsDelta<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta>? itemStyles,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta>? slideableItems,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    spacing: spacing ?? this.spacing,
    dividerColor: dividerColor?.call(this.dividerColor) ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyles: itemStyles?.call(this.itemStyles) ?? this.itemStyles,
    slideableItems: slideableItems?.call(this.slideableItems) ?? this.slideableItems,
  );

  /// Linearly interpolate between this and another [FItemGroupStyle] using the given factor [t].
  @useResult
  FItemGroupStyle lerp(FItemGroupStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    dividerColor: .lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyles: .lerpWhere(itemStyles, other.itemStyles, t, (a, b, t) => a!.lerp(b!, t)),
    slideableItems: t < 0.5 ? slideableItems : other.slideableItems,
  );
}

mixin _$FItemGroupStyleFunctions on Diagnosticable implements FItemGroupStyleDelta {
  /// Returns itself.
  @override
  FItemGroupStyle call(Object _) => this as FItemGroupStyle;

  Decoration get decoration;
  double get spacing;
  FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta> get dividerColor;
  double get dividerWidth;
  FVariants<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta> get itemStyles;
  FVariants<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta> get slideableItems;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: .debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: .debug))
      ..add(DiagnosticsProperty('itemStyles', itemStyles, level: .debug))
      ..add(DiagnosticsProperty('slideableItems', slideableItems, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemGroupStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          spacing == other.spacing &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          itemStyles == other.itemStyles &&
          slideableItems == other.slideableItems);

  @override
  int get hashCode =>
      decoration.hashCode ^
      spacing.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      itemStyles.hashCode ^
      slideableItems.hashCode;
}

/// A delta that applies modifications to a [FItemGroupStyle].
///
/// A [FItemGroupStyle] is itself a [FItemGroupStyleDelta].
abstract class FItemGroupStyleDelta with Delta {
  /// Creates a partial modification of a [FItemGroupStyle].
  ///
  /// ## Parameters
  /// * [FItemGroupStyle.decoration] - The group's decoration.
  /// * [FItemGroupStyle.spacing] - The vertical spacing at the top and bottom of each group.
  /// * [FItemGroupStyle.dividerColor] - The divider's style.
  /// * [FItemGroupStyle.dividerWidth] - The divider's width.
  /// * [FItemGroupStyle.itemStyles] - The item's styles.
  /// * [FItemGroupStyle.slideableItems] - Whether the items support pressing an item and sliding to another.
  const factory FItemGroupStyleDelta.delta({
    DecorationDelta? decoration,
    double? spacing,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor,
    double? dividerWidth,
    FVariantsDelta<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta>? itemStyles,
    FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta>? slideableItems,
  }) = _FItemGroupStyleDelta;

  /// Creates a delta that returns the [FItemGroupStyle] in the current context.
  const factory FItemGroupStyleDelta.context() = _FItemGroupStyleContext;

  @override
  FItemGroupStyle call(covariant FItemGroupStyle value);
}

class _FItemGroupStyleDelta implements FItemGroupStyleDelta {
  const _FItemGroupStyleDelta({
    this.decoration,
    this.spacing,
    this.dividerColor,
    this.dividerWidth,
    this.itemStyles,
    this.slideableItems,
  });

  final DecorationDelta? decoration;

  final double? spacing;

  final FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor;

  final double? dividerWidth;

  final FVariantsDelta<FItemVariantConstraint, FItemVariant, FItemStyle, FItemStyleDelta>? itemStyles;

  final FVariantsValueDelta<FItemGroupVariantConstraint, FItemGroupVariant, bool, Delta>? slideableItems;

  @override
  FItemGroupStyle call(FItemGroupStyle original) => FItemGroupStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    spacing: spacing ?? original.spacing,
    dividerColor: dividerColor?.call(original.dividerColor) ?? original.dividerColor,
    dividerWidth: dividerWidth ?? original.dividerWidth,
    itemStyles: itemStyles?.call(original.itemStyles) ?? original.itemStyles,
    slideableItems: slideableItems?.call(original.slideableItems) ?? original.slideableItems,
  );
}

class _FItemGroupStyleContext implements FItemGroupStyleDelta {
  const _FItemGroupStyleContext();

  @override
  FItemGroupStyle call(FItemGroupStyle original) => original;
}

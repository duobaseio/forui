// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBottomNavigationBarStyleTransformations on FBottomNavigationBarStyle {
  /// Returns a copy of this [FBottomNavigationBarStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FBottomNavigationBarStyle.decoration] - The decoration.
  /// * [FBottomNavigationBarStyle.backgroundFilter] - An optional background filter.
  /// * [FBottomNavigationBarStyle.padding] - The padding.
  /// * [FBottomNavigationBarStyle.itemStyle] - The item's style.
  /// * [FBottomNavigationBarStyle.slideableItems] - Whether the items support pressing an item and sliding to another.
  @useResult
  FBottomNavigationBarStyle copyWith({
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter = imageFilterSentinel,
    EdgeInsetsGeometryDelta? padding,
    FBottomNavigationBarItemStyleDelta? itemStyle,
    FVariantsValueDelta<FPlatformVariantConstraint, FPlatformVariant, bool, Delta>? slideableItems,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    backgroundFilter: backgroundFilter == imageFilterSentinel ? this.backgroundFilter : backgroundFilter,
    padding: padding?.call(this.padding) ?? this.padding,
    itemStyle: itemStyle?.call(this.itemStyle) ?? this.itemStyle,
    slideableItems: slideableItems?.call(this.slideableItems) ?? this.slideableItems,
  );

  /// Linearly interpolate between this and another [FBottomNavigationBarStyle] using the given factor [t].
  @useResult
  FBottomNavigationBarStyle lerp(FBottomNavigationBarStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: .lerp(padding, other.padding, t) ?? padding,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
    slideableItems: t < 0.5 ? slideableItems : other.slideableItems,
  );
}

mixin _$FBottomNavigationBarStyleFunctions on Diagnosticable implements FBottomNavigationBarStyleDelta {
  /// Returns itself.
  @override
  FBottomNavigationBarStyle call(Object _) => this as FBottomNavigationBarStyle;

  Decoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  FBottomNavigationBarItemStyle get itemStyle;
  FVariants<FPlatformVariantConstraint, FPlatformVariant, bool, Delta> get slideableItems;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: .debug))
      ..add(DiagnosticsProperty('slideableItems', slideableItems, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          itemStyle == other.itemStyle &&
          slideableItems == other.slideableItems);

  @override
  int get hashCode =>
      decoration.hashCode ^ backgroundFilter.hashCode ^ padding.hashCode ^ itemStyle.hashCode ^ slideableItems.hashCode;
}

/// A delta that applies modifications to a [FBottomNavigationBarStyle].
///
/// A [FBottomNavigationBarStyle] is itself a [FBottomNavigationBarStyleDelta].
abstract class FBottomNavigationBarStyleDelta with Delta {
  /// Creates a partial modification of a [FBottomNavigationBarStyle].
  ///
  /// ## Parameters
  /// * [FBottomNavigationBarStyle.decoration] - The decoration.
  /// * [FBottomNavigationBarStyle.backgroundFilter] - An optional background filter.
  /// * [FBottomNavigationBarStyle.padding] - The padding.
  /// * [FBottomNavigationBarStyle.itemStyle] - The item's style.
  /// * [FBottomNavigationBarStyle.slideableItems] - Whether the items support pressing an item and sliding to another.
  const factory FBottomNavigationBarStyleDelta.delta({
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometryDelta? padding,
    FBottomNavigationBarItemStyleDelta? itemStyle,
    FVariantsValueDelta<FPlatformVariantConstraint, FPlatformVariant, bool, Delta>? slideableItems,
  }) = _FBottomNavigationBarStyleDelta;

  /// Creates a delta that returns the [FBottomNavigationBarStyle] in the current context.
  const factory FBottomNavigationBarStyleDelta.context() = _FBottomNavigationBarStyleContext;

  @override
  FBottomNavigationBarStyle call(covariant FBottomNavigationBarStyle value);
}

class _FBottomNavigationBarStyleDelta implements FBottomNavigationBarStyleDelta {
  const _FBottomNavigationBarStyleDelta({
    this.decoration,
    this.backgroundFilter = imageFilterSentinel,
    this.padding,
    this.itemStyle,
    this.slideableItems,
  });

  final DecorationDelta? decoration;

  final ImageFilter? backgroundFilter;

  final EdgeInsetsGeometryDelta? padding;

  final FBottomNavigationBarItemStyleDelta? itemStyle;

  final FVariantsValueDelta<FPlatformVariantConstraint, FPlatformVariant, bool, Delta>? slideableItems;

  @override
  FBottomNavigationBarStyle call(FBottomNavigationBarStyle original) => FBottomNavigationBarStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    backgroundFilter: backgroundFilter == imageFilterSentinel ? original.backgroundFilter : backgroundFilter,
    padding: padding?.call(original.padding) ?? original.padding,
    itemStyle: itemStyle?.call(original.itemStyle) ?? original.itemStyle,
    slideableItems: slideableItems?.call(original.slideableItems) ?? original.slideableItems,
  );
}

class _FBottomNavigationBarStyleContext implements FBottomNavigationBarStyleDelta {
  const _FBottomNavigationBarStyleContext();

  @override
  FBottomNavigationBarStyle call(FBottomNavigationBarStyle original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FHeaderVariant], which represents individual variants.
extension type const FHeaderVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FHeaderVariantConstraint] that negates [variant].
  factory FHeaderVariantConstraint.not(FHeaderVariant variant) => FHeaderVariantConstraint._(Not(variant));

  /// The root header variant.
  static const root = FHeaderVariant.root;

  /// The nested header variant.
  static const nested = FHeaderVariant.nested;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FHeaderVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FHeaderVariant._(Desktop());

  /// The Android platform variant.
  static const android = FHeaderVariant.android;

  /// The iOS platform variant.
  static const iOS = FHeaderVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FHeaderVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FHeaderVariant.windows;

  /// The macOS platform variant.
  static const macOS = FHeaderVariant.macOS;

  /// The Linux platform variant.
  static const linux = FHeaderVariant.linux;

  /// The web platform variant.
  static const web = FHeaderVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FHeaderVariantConstraint and(FHeaderVariantConstraint other) => FHeaderVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FHeaderVariantConstraint], which represents combinations of variants.
extension type const FHeaderVariant._(FVariant _) implements FHeaderVariantConstraint, FVariant {
  /// The root header variant.
  static const root = FHeaderVariant._(.new(1, 'root'));

  /// The nested header variant.
  static const nested = FHeaderVariant._(.new(1, 'nested'));

  /// The Android platform variant.
  static const android = FHeaderVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FHeaderVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FHeaderVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FHeaderVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FHeaderVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FHeaderVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FHeaderVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderStyleTransformations on FHeaderStyle {
  /// Returns a copy of this [FHeaderStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderStyle.systemOverlayStyle] - The system overlay style.
  /// * [FHeaderStyle.decoration] - The decoration.
  /// * [FHeaderStyle.backgroundFilter] - An optional background filter.
  /// * [FHeaderStyle.padding] - The padding.
  /// * [FHeaderStyle.actionSpacing] - The spacing between [FHeaderAction]s.
  /// * [FHeaderStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FHeaderStyle.actionStyle] - The [FHeaderAction]s' style.
  @useResult
  FHeaderStyle copyWith({
    SystemUiOverlayStyle? systemOverlayStyle,
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter = imageFilterSentinel,
    EdgeInsetsGeometryDelta? padding,
    double? actionSpacing,
    TextStyleDelta? titleTextStyle,
    FHeaderActionStyleDelta? actionStyle,
  }) => .new(
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    backgroundFilter: backgroundFilter == imageFilterSentinel ? this.backgroundFilter : backgroundFilter,
    padding: padding?.call(this.padding) ?? this.padding,
    actionSpacing: actionSpacing ?? this.actionSpacing,
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    actionStyle: actionStyle?.call(this.actionStyle) ?? this.actionStyle,
  );

  /// Linearly interpolate between this and another [FHeaderStyle] using the given factor [t].
  @useResult
  FHeaderStyle lerp(FHeaderStyle other, double t) => .new(
    systemOverlayStyle: t < 0.5 ? systemOverlayStyle : other.systemOverlayStyle,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: .lerp(padding, other.padding, t) ?? padding,
    actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    actionStyle: actionStyle.lerp(other.actionStyle, t),
  );
}

mixin _$FHeaderStyleFunctions on Diagnosticable implements FHeaderStyleDelta {
  /// Returns itself.
  @override
  FHeaderStyle call(Object _) => this as FHeaderStyle;

  SystemUiOverlayStyle get systemOverlayStyle;
  Decoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  double get actionSpacing;
  TextStyle get titleTextStyle;
  FHeaderActionStyle get actionStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DoubleProperty('actionSpacing', actionSpacing, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('actionStyle', actionStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyle &&
          runtimeType == other.runtimeType &&
          systemOverlayStyle == other.systemOverlayStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          actionSpacing == other.actionSpacing &&
          titleTextStyle == other.titleTextStyle &&
          actionStyle == other.actionStyle);

  @override
  int get hashCode =>
      systemOverlayStyle.hashCode ^
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      actionSpacing.hashCode ^
      titleTextStyle.hashCode ^
      actionStyle.hashCode;
}

/// A delta that applies modifications to a [FHeaderStyle].
///
/// A [FHeaderStyle] is itself a [FHeaderStyleDelta].
abstract class FHeaderStyleDelta with Delta {
  /// Creates a partial modification of a [FHeaderStyle].
  ///
  /// ## Parameters
  /// * [FHeaderStyle.systemOverlayStyle] - The system overlay style.
  /// * [FHeaderStyle.decoration] - The decoration.
  /// * [FHeaderStyle.backgroundFilter] - An optional background filter.
  /// * [FHeaderStyle.padding] - The padding.
  /// * [FHeaderStyle.actionSpacing] - The spacing between [FHeaderAction]s.
  /// * [FHeaderStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FHeaderStyle.actionStyle] - The [FHeaderAction]s' style.
  const factory FHeaderStyleDelta.delta({
    SystemUiOverlayStyle? systemOverlayStyle,
    DecorationDelta? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometryDelta? padding,
    double? actionSpacing,
    TextStyleDelta? titleTextStyle,
    FHeaderActionStyleDelta? actionStyle,
  }) = _FHeaderStyleDelta;

  /// Creates a delta that returns the [FHeaderStyle] in the current context.
  const factory FHeaderStyleDelta.context() = _FHeaderStyleContext;

  @override
  FHeaderStyle call(covariant FHeaderStyle value);
}

class _FHeaderStyleDelta implements FHeaderStyleDelta {
  const _FHeaderStyleDelta({
    this.systemOverlayStyle,
    this.decoration,
    this.backgroundFilter = imageFilterSentinel,
    this.padding,
    this.actionSpacing,
    this.titleTextStyle,
    this.actionStyle,
  });

  final SystemUiOverlayStyle? systemOverlayStyle;

  final DecorationDelta? decoration;

  final ImageFilter? backgroundFilter;

  final EdgeInsetsGeometryDelta? padding;

  final double? actionSpacing;

  final TextStyleDelta? titleTextStyle;

  final FHeaderActionStyleDelta? actionStyle;

  @override
  FHeaderStyle call(FHeaderStyle original) => FHeaderStyle(
    systemOverlayStyle: systemOverlayStyle ?? original.systemOverlayStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    backgroundFilter: backgroundFilter == imageFilterSentinel ? original.backgroundFilter : backgroundFilter,
    padding: padding?.call(original.padding) ?? original.padding,
    actionSpacing: actionSpacing ?? original.actionSpacing,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    actionStyle: actionStyle?.call(original.actionStyle) ?? original.actionStyle,
  );
}

class _FHeaderStyleContext implements FHeaderStyleDelta {
  const _FHeaderStyleContext();

  @override
  FHeaderStyle call(FHeaderStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FHeaderActionStyleTransformations on FHeaderActionStyle {
  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FHeaderActionStyle.iconStyle] - The icon's style.
  /// * [FHeaderActionStyle.focusedOutlineStyle] - The outline style when this action is focused.
  /// * [FHeaderActionStyle.tappableStyle] - The tappable's style.
  @useResult
  FHeaderActionStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FTappableStyleDelta? tappableStyle,
  }) => .new(
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FHeaderActionStyle] using the given factor [t].
  @useResult
  FHeaderActionStyle lerp(FHeaderActionStyle other, double t) => .new(
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FHeaderActionStyleFunctions on Diagnosticable implements FHeaderActionStyleDelta {
  /// Returns itself.
  @override
  FHeaderActionStyle call(Object _) => this as FHeaderActionStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FTappableStyle get tappableStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderActionStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode => iconStyle.hashCode ^ focusedOutlineStyle.hashCode ^ tappableStyle.hashCode;
}

/// A delta that applies modifications to a [FHeaderActionStyle].
///
/// A [FHeaderActionStyle] is itself a [FHeaderActionStyleDelta].
abstract class FHeaderActionStyleDelta with Delta {
  /// Creates a partial modification of a [FHeaderActionStyle].
  ///
  /// ## Parameters
  /// * [FHeaderActionStyle.iconStyle] - The icon's style.
  /// * [FHeaderActionStyle.focusedOutlineStyle] - The outline style when this action is focused.
  /// * [FHeaderActionStyle.tappableStyle] - The tappable's style.
  const factory FHeaderActionStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FTappableStyleDelta? tappableStyle,
  }) = _FHeaderActionStyleDelta;

  /// Creates a delta that returns the [FHeaderActionStyle] in the current context.
  const factory FHeaderActionStyleDelta.context() = _FHeaderActionStyleContext;

  @override
  FHeaderActionStyle call(covariant FHeaderActionStyle value);
}

class _FHeaderActionStyleDelta implements FHeaderActionStyleDelta {
  const _FHeaderActionStyleDelta({this.iconStyle, this.focusedOutlineStyle, this.tappableStyle});

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FTappableStyleDelta? tappableStyle;

  @override
  FHeaderActionStyle call(FHeaderActionStyle original) => FHeaderActionStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
  );
}

class _FHeaderActionStyleContext implements FHeaderActionStyleDelta {
  const _FHeaderActionStyleContext();

  @override
  FHeaderActionStyle call(FHeaderActionStyle original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tabs.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FTabVariant], which represents individual variants.
extension type const FTabVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FTabVariantConstraint] that negates [variant].
  factory FTabVariantConstraint.not(FTabVariant variant) => FTabVariantConstraint._(Not(variant));

  /// The selected tab variant.
  static const selected = FTabVariant.selected;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FTabVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FTabVariant._(Desktop());

  /// The Android platform variant.
  static const android = FTabVariant.android;

  /// The iOS platform variant.
  static const iOS = FTabVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FTabVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FTabVariant.windows;

  /// The macOS platform variant.
  static const macOS = FTabVariant.macOS;

  /// The Linux platform variant.
  static const linux = FTabVariant.linux;

  /// The web platform variant.
  static const web = FTabVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FTabVariantConstraint and(FTabVariantConstraint other) => FTabVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FTabVariantConstraint], which represents combinations of variants.
extension type const FTabVariant._(FVariant _) implements FTabVariantConstraint, FVariant {
  /// The selected tab variant.
  static const selected = FTabVariant._(.new(2, 'selected'));

  /// The Android platform variant.
  static const android = FTabVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FTabVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FTabVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FTabVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FTabVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FTabVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FTabVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FTabMotionTransformations on FTabMotion {
  /// Returns a copy of this [FTabMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FTabMotion.duration] - The duration of the tab change animation.
  /// * [FTabMotion.curve] - The curve of the tab change animation.
  @useResult
  FTabMotion copyWith({Duration? duration, Curve? curve}) =>
      .new(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FTabMotion] using the given factor [t].
  @useResult
  FTabMotion lerp(FTabMotion other, double t) =>
      .new(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FTabMotionFunctions on Diagnosticable implements FTabMotionDelta {
  /// Returns itself.
  @override
  FTabMotion call(Object _) => this as FTabMotion;

  Duration get duration;
  Curve get curve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTabMotion && runtimeType == other.runtimeType && duration == other.duration && curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

/// A delta that applies modifications to a [FTabMotion].
///
/// A [FTabMotion] is itself a [FTabMotionDelta].
abstract class FTabMotionDelta with Delta {
  /// Creates a partial modification of a [FTabMotion].
  ///
  /// ## Parameters
  /// * [FTabMotion.duration] - The duration of the tab change animation.
  /// * [FTabMotion.curve] - The curve of the tab change animation.
  const factory FTabMotionDelta.delta({Duration? duration, Curve? curve}) = _FTabMotionDelta;

  /// Creates a delta that returns the [FTabMotion] in the current context.
  const factory FTabMotionDelta.context() = _FTabMotionContext;

  @override
  FTabMotion call(covariant FTabMotion value);
}

class _FTabMotionDelta implements FTabMotionDelta {
  const _FTabMotionDelta({this.duration, this.curve});

  final Duration? duration;

  final Curve? curve;

  @override
  FTabMotion call(FTabMotion original) =>
      FTabMotion(duration: duration ?? original.duration, curve: curve ?? original.curve);
}

class _FTabMotionContext implements FTabMotionDelta {
  const _FTabMotionContext();

  @override
  FTabMotion call(FTabMotion original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FTabsStyleTransformations on FTabsStyle {
  /// Returns a copy of this [FTabsStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTabsStyle.decoration] - The decoration.
  /// * [FTabsStyle.padding] - The padding.
  /// * [FTabsStyle.labelTextStyle] - The label's [TextStyle].
  /// * [FTabsStyle.indicatorDecoration] - The indicator.
  /// * [FTabsStyle.indicatorSize] - The indicator size.
  /// * [FTabsStyle.height] - The height.
  /// * [FTabsStyle.spacing] - The spacing between the tab bar and the views.
  /// * [FTabsStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FTabsStyle copyWith({
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTabVariantConstraint, FTabVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    DecorationDelta? indicatorDecoration,
    FTabBarIndicatorSize? indicatorSize,
    double? height,
    double? spacing,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    padding: padding?.call(this.padding) ?? this.padding,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    indicatorDecoration: indicatorDecoration?.call(this.indicatorDecoration) ?? this.indicatorDecoration,
    indicatorSize: indicatorSize ?? this.indicatorSize,
    height: height ?? this.height,
    spacing: spacing ?? this.spacing,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FTabsStyle] using the given factor [t].
  @useResult
  FTabsStyle lerp(FTabsStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    indicatorDecoration: .lerp(indicatorDecoration, other.indicatorDecoration, t) ?? indicatorDecoration,
    indicatorSize: t < 0.5 ? indicatorSize : other.indicatorSize,
    height: lerpDouble(height, other.height, t) ?? height,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FTabsStyleFunctions on Diagnosticable implements FTabsStyleDelta {
  /// Returns itself.
  @override
  FTabsStyle call(Object _) => this as FTabsStyle;

  Decoration get decoration;
  EdgeInsetsGeometry get padding;
  FVariants<FTabVariantConstraint, FTabVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  Decoration get indicatorDecoration;
  FTabBarIndicatorSize get indicatorSize;
  double get height;
  double get spacing;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('indicatorDecoration', indicatorDecoration, level: .debug))
      ..add(EnumProperty('indicatorSize', indicatorSize, level: .debug))
      ..add(DoubleProperty('height', height, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTabsStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          labelTextStyle == other.labelTextStyle &&
          indicatorDecoration == other.indicatorDecoration &&
          indicatorSize == other.indicatorSize &&
          height == other.height &&
          spacing == other.spacing &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      labelTextStyle.hashCode ^
      indicatorDecoration.hashCode ^
      indicatorSize.hashCode ^
      height.hashCode ^
      spacing.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FTabsStyle].
///
/// A [FTabsStyle] is itself a [FTabsStyleDelta].
abstract class FTabsStyleDelta with Delta {
  /// Creates a partial modification of a [FTabsStyle].
  ///
  /// ## Parameters
  /// * [FTabsStyle.decoration] - The decoration.
  /// * [FTabsStyle.padding] - The padding.
  /// * [FTabsStyle.labelTextStyle] - The label's [TextStyle].
  /// * [FTabsStyle.indicatorDecoration] - The indicator.
  /// * [FTabsStyle.indicatorSize] - The indicator size.
  /// * [FTabsStyle.height] - The height.
  /// * [FTabsStyle.spacing] - The spacing between the tab bar and the views.
  /// * [FTabsStyle.focusedOutlineStyle] - The focused outline style.
  const factory FTabsStyleDelta.delta({
    DecorationDelta? decoration,
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTabVariantConstraint, FTabVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    DecorationDelta? indicatorDecoration,
    FTabBarIndicatorSize? indicatorSize,
    double? height,
    double? spacing,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FTabsStyleDelta;

  /// Creates a delta that returns the [FTabsStyle] in the current context.
  const factory FTabsStyleDelta.context() = _FTabsStyleContext;

  @override
  FTabsStyle call(covariant FTabsStyle value);
}

class _FTabsStyleDelta implements FTabsStyleDelta {
  const _FTabsStyleDelta({
    this.decoration,
    this.padding,
    this.labelTextStyle,
    this.indicatorDecoration,
    this.indicatorSize,
    this.height,
    this.spacing,
    this.focusedOutlineStyle,
  });

  final DecorationDelta? decoration;

  final EdgeInsetsGeometryDelta? padding;

  final FVariantsDelta<FTabVariantConstraint, FTabVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final DecorationDelta? indicatorDecoration;

  final FTabBarIndicatorSize? indicatorSize;

  final double? height;

  final double? spacing;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FTabsStyle call(FTabsStyle original) => FTabsStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    padding: padding?.call(original.padding) ?? original.padding,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    indicatorDecoration: indicatorDecoration?.call(original.indicatorDecoration) ?? original.indicatorDecoration,
    indicatorSize: indicatorSize ?? original.indicatorSize,
    height: height ?? original.height,
    spacing: spacing ?? original.spacing,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FTabsStyleContext implements FTabsStyleDelta {
  const _FTabsStyleContext();

  @override
  FTabsStyle call(FTabsStyle original) => original;
}

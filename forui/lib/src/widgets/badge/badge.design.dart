// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FBadgeVariant], which represents individual variants.
extension type const FBadgeVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FBadgeVariantConstraint] that negates [variant].
  factory FBadgeVariantConstraint.not(FBadgeVariant variant) => FBadgeVariantConstraint._(Not(variant));

  /// The primary badge style.
  static const primary = FBadgeVariant.primary;

  /// The secondary badge style.
  static const secondary = FBadgeVariant.secondary;

  /// The outline badge style.
  static const outline = FBadgeVariant.outline;

  /// The destructive badge style.
  static const destructive = FBadgeVariant.destructive;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FBadgeVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FBadgeVariant._(Desktop());

  /// The Android platform variant.
  static const android = FBadgeVariant.android;

  /// The iOS platform variant.
  static const iOS = FBadgeVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FBadgeVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FBadgeVariant.windows;

  /// The macOS platform variant.
  static const macOS = FBadgeVariant.macOS;

  /// The Linux platform variant.
  static const linux = FBadgeVariant.linux;

  /// The web platform variant.
  static const web = FBadgeVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FBadgeVariantConstraint and(FBadgeVariantConstraint other) => FBadgeVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FBadgeVariantConstraint], which represents combinations of variants.
extension type const FBadgeVariant._(FVariant _) implements FBadgeVariantConstraint, FVariant {
  /// The primary badge style.
  static const primary = FBadgeVariant._(.new(2, 'primary'));

  /// The secondary badge style.
  static const secondary = FBadgeVariant._(.new(2, 'secondary'));

  /// The outline badge style.
  static const outline = FBadgeVariant._(.new(2, 'outline'));

  /// The destructive badge style.
  static const destructive = FBadgeVariant._(.new(2, 'destructive'));

  /// The Android platform variant.
  static const android = FBadgeVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FBadgeVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FBadgeVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FBadgeVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FBadgeVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FBadgeVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FBadgeVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FBadgeStyleTransformations on FBadgeStyle {
  /// Returns a copy of this [FBadgeStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FBadgeStyle.decoration] - The decoration.
  /// * [FBadgeStyle.contentStyle] - The content's style.
  @useResult
  FBadgeStyle copyWith({DecorationDelta? decoration, FBadgeContentStyleDelta? contentStyle}) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
  );

  /// Linearly interpolate between this and another [FBadgeStyle] using the given factor [t].
  @useResult
  FBadgeStyle lerp(FBadgeStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FBadgeStyleFunctions on Diagnosticable implements FBadgeStyleDelta {
  /// Returns itself.
  @override
  FBadgeStyle call(Object _) => this as FBadgeStyle;

  Decoration get decoration;
  FBadgeContentStyle get contentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle);

  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}

/// A delta that applies modifications to a [FBadgeStyle].
///
/// A [FBadgeStyle] is itself a [FBadgeStyleDelta].
abstract class FBadgeStyleDelta with Delta {
  /// Creates a partial modification of a [FBadgeStyle].
  ///
  /// ## Parameters
  /// * [FBadgeStyle.decoration] - The decoration.
  /// * [FBadgeStyle.contentStyle] - The content's style.
  const factory FBadgeStyleDelta.delta({DecorationDelta? decoration, FBadgeContentStyleDelta? contentStyle}) =
      _FBadgeStyleDelta;

  /// Creates a delta that returns the [FBadgeStyle] in the current context.
  const factory FBadgeStyleDelta.context() = _FBadgeStyleContext;

  @override
  FBadgeStyle call(covariant FBadgeStyle value);
}

class _FBadgeStyleDelta implements FBadgeStyleDelta {
  const _FBadgeStyleDelta({this.decoration, this.contentStyle});

  final DecorationDelta? decoration;

  final FBadgeContentStyleDelta? contentStyle;

  @override
  FBadgeStyle call(FBadgeStyle original) => FBadgeStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
  );
}

class _FBadgeStyleContext implements FBadgeStyleDelta {
  const _FBadgeStyleContext();

  @override
  FBadgeStyle call(FBadgeStyle original) => original;
}

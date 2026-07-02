// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'year.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FCalendarYearVariant], which represents individual variants.
extension type const FCalendarYearVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FCalendarYearVariantConstraint] that negates [variant].
  factory FCalendarYearVariantConstraint.not(FCalendarYearVariant variant) =>
      FCalendarYearVariantConstraint._(Not(variant));

  /// The semantic variant when the year is the current year.
  static const today = FCalendarYearVariant.today;

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCalendarYearVariant.disabled;

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FCalendarYearVariant.primaryFocused;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCalendarYearVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCalendarYearVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCalendarYearVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FCalendarYearVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FCalendarYearVariant._(Desktop());

  /// The Android platform variant.
  static const android = FCalendarYearVariant.android;

  /// The iOS platform variant.
  static const iOS = FCalendarYearVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FCalendarYearVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FCalendarYearVariant.windows;

  /// The macOS platform variant.
  static const macOS = FCalendarYearVariant.macOS;

  /// The Linux platform variant.
  static const linux = FCalendarYearVariant.linux;

  /// The web platform variant.
  static const web = FCalendarYearVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FCalendarYearVariantConstraint and(FCalendarYearVariantConstraint other) =>
      FCalendarYearVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FCalendarYearVariantConstraint], which represents combinations of variants.
extension type const FCalendarYearVariant._(FVariant _) implements FCalendarYearVariantConstraint, FVariant {
  /// The semantic variant when the year is the current year.
  static const today = FCalendarYearVariant._(.new(3, 'today'));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCalendarYearVariant._(.new(2, 'disabled'));

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FCalendarYearVariant._(.new(1, 'primaryFocused'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCalendarYearVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCalendarYearVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCalendarYearVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FCalendarYearVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FCalendarYearVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FCalendarYearVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FCalendarYearVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FCalendarYearVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FCalendarYearVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FCalendarYearVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarYearStyleTransformations on FCalendarYearStyle {
  /// Returns a copy of this [FCalendarYearStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarYearStyle.textStyle] - The year's text style.
  /// * [FCalendarYearStyle.decoration] - The decoration painted behind the year's text.
  @useResult
  FCalendarYearStyle copyWith({TextStyleDelta? textStyle, DecorationDelta? decoration}) => .new(
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
  );

  /// Linearly interpolate between this and another [FCalendarYearStyle] using the given factor [t].
  @useResult
  FCalendarYearStyle lerp(FCalendarYearStyle other, double t) => .new(
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
  );
}

mixin _$FCalendarYearStyleFunctions on Diagnosticable implements FCalendarYearStyleDelta {
  /// Returns itself.
  @override
  FCalendarYearStyle call(Object _) => this as FCalendarYearStyle;

  TextStyle get textStyle;
  Decoration get decoration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarYearStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          decoration == other.decoration);

  @override
  int get hashCode => textStyle.hashCode ^ decoration.hashCode;
}

/// A delta that applies modifications to a [FCalendarYearStyle].
///
/// A [FCalendarYearStyle] is itself a [FCalendarYearStyleDelta].
abstract class FCalendarYearStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarYearStyle].
  ///
  /// ## Parameters
  /// * [FCalendarYearStyle.textStyle] - The year's text style.
  /// * [FCalendarYearStyle.decoration] - The decoration painted behind the year's text.
  const factory FCalendarYearStyleDelta.delta({TextStyleDelta? textStyle, DecorationDelta? decoration}) =
      _FCalendarYearStyleDelta;

  /// Creates a delta that returns the [FCalendarYearStyle] in the current context.
  const factory FCalendarYearStyleDelta.context() = _FCalendarYearStyleContext;

  @override
  FCalendarYearStyle call(covariant FCalendarYearStyle value);
}

class _FCalendarYearStyleDelta implements FCalendarYearStyleDelta {
  const _FCalendarYearStyleDelta({this.textStyle, this.decoration});

  final TextStyleDelta? textStyle;

  final DecorationDelta? decoration;

  @override
  FCalendarYearStyle call(FCalendarYearStyle original) => FCalendarYearStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
  );
}

class _FCalendarYearStyleContext implements FCalendarYearStyleDelta {
  const _FCalendarYearStyleContext();

  @override
  FCalendarYearStyle call(FCalendarYearStyle original) => original;
}

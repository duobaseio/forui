// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'month.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FCalendarMonthVariant], which represents individual variants.
extension type const FCalendarMonthVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FCalendarMonthVariantConstraint] that negates [variant].
  factory FCalendarMonthVariantConstraint.not(FCalendarMonthVariant variant) =>
      FCalendarMonthVariantConstraint._(Not(variant));

  /// The semantic variant when the month is the current month.
  static const today = FCalendarMonthVariant.today;

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCalendarMonthVariant.disabled;

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FCalendarMonthVariant.primaryFocused;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCalendarMonthVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCalendarMonthVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCalendarMonthVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FCalendarMonthVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FCalendarMonthVariant._(Desktop());

  /// The Android platform variant.
  static const android = FCalendarMonthVariant.android;

  /// The iOS platform variant.
  static const iOS = FCalendarMonthVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FCalendarMonthVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FCalendarMonthVariant.windows;

  /// The macOS platform variant.
  static const macOS = FCalendarMonthVariant.macOS;

  /// The Linux platform variant.
  static const linux = FCalendarMonthVariant.linux;

  /// The web platform variant.
  static const web = FCalendarMonthVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FCalendarMonthVariantConstraint and(FCalendarMonthVariantConstraint other) =>
      FCalendarMonthVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FCalendarMonthVariantConstraint], which represents combinations of variants.
extension type const FCalendarMonthVariant._(FVariant _) implements FCalendarMonthVariantConstraint, FVariant {
  /// The semantic variant when the month is the current month.
  static const today = FCalendarMonthVariant._(.new(3, 'today'));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCalendarMonthVariant._(.new(2, 'disabled'));

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FCalendarMonthVariant._(.new(1, 'primaryFocused'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCalendarMonthVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCalendarMonthVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCalendarMonthVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FCalendarMonthVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FCalendarMonthVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FCalendarMonthVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FCalendarMonthVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FCalendarMonthVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FCalendarMonthVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FCalendarMonthVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarMonthStyleTransformations on FCalendarMonthStyle {
  /// Returns a copy of this [FCalendarMonthStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarMonthStyle.textStyle] - The month's text style.
  /// * [FCalendarMonthStyle.decoration] - The decoration painted behind the month's text.
  @useResult
  FCalendarMonthStyle copyWith({TextStyleDelta? textStyle, DecorationDelta? decoration}) => .new(
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    decoration: decoration?.call(this.decoration) ?? this.decoration,
  );

  /// Linearly interpolate between this and another [FCalendarMonthStyle] using the given factor [t].
  @useResult
  FCalendarMonthStyle lerp(FCalendarMonthStyle other, double t) => .new(
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
  );
}

mixin _$FCalendarMonthStyleFunctions on Diagnosticable implements FCalendarMonthStyleDelta {
  /// Returns itself.
  @override
  FCalendarMonthStyle call(Object _) => this as FCalendarMonthStyle;

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
      (other is FCalendarMonthStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          decoration == other.decoration);

  @override
  int get hashCode => textStyle.hashCode ^ decoration.hashCode;
}

/// A delta that applies modifications to a [FCalendarMonthStyle].
///
/// A [FCalendarMonthStyle] is itself a [FCalendarMonthStyleDelta].
abstract class FCalendarMonthStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarMonthStyle].
  ///
  /// ## Parameters
  /// * [FCalendarMonthStyle.textStyle] - The month's text style.
  /// * [FCalendarMonthStyle.decoration] - The decoration painted behind the month's text.
  const factory FCalendarMonthStyleDelta.delta({TextStyleDelta? textStyle, DecorationDelta? decoration}) =
      _FCalendarMonthStyleDelta;

  /// Creates a delta that returns the [FCalendarMonthStyle] in the current context.
  const factory FCalendarMonthStyleDelta.context() = _FCalendarMonthStyleContext;

  @override
  FCalendarMonthStyle call(covariant FCalendarMonthStyle value);
}

class _FCalendarMonthStyleDelta implements FCalendarMonthStyleDelta {
  const _FCalendarMonthStyleDelta({this.textStyle, this.decoration});

  final TextStyleDelta? textStyle;

  final DecorationDelta? decoration;

  @override
  FCalendarMonthStyle call(FCalendarMonthStyle original) => FCalendarMonthStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    decoration: decoration?.call(original.decoration) ?? original.decoration,
  );
}

class _FCalendarMonthStyleContext implements FCalendarMonthStyleDelta {
  const _FCalendarMonthStyleContext();

  @override
  FCalendarMonthStyle call(FCalendarMonthStyle original) => original;
}

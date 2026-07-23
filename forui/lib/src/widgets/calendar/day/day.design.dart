// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'day.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FCalendarDayVariant], which represents individual variants.
extension type const FCalendarDayVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FCalendarDayVariantConstraint] that negates [variant].
  factory FCalendarDayVariantConstraint.not(FCalendarDayVariant variant) =>
      FCalendarDayVariantConstraint._(Not(variant));

  /// The day is selected but is not part of a contiguous selection.
  static const single = FCalendarDayVariant.single;

  /// The day is the start of a contiguous selection.
  static const start = FCalendarDayVariant.start;

  /// The day is inside a contiguous selection, between a start and end.
  static const middle = FCalendarDayVariant.middle;

  /// The day is the end of a contiguous selection.
  static const end = FCalendarDayVariant.end;

  /// The semantic variant when the day is not in the current month.
  static const adjacent = FCalendarDayVariant.adjacent;

  /// The semantic variant when the day is the current day.
  static const today = FCalendarDayVariant.today;

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCalendarDayVariant.disabled;

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FCalendarDayVariant.primaryFocused;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCalendarDayVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCalendarDayVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCalendarDayVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FCalendarDayVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FCalendarDayVariant._(Desktop());

  /// The Android platform variant.
  static const android = FCalendarDayVariant.android;

  /// The iOS platform variant.
  static const iOS = FCalendarDayVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FCalendarDayVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FCalendarDayVariant.windows;

  /// The macOS platform variant.
  static const macOS = FCalendarDayVariant.macOS;

  /// The Linux platform variant.
  static const linux = FCalendarDayVariant.linux;

  /// The web platform variant.
  static const web = FCalendarDayVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FCalendarDayVariantConstraint and(FCalendarDayVariantConstraint other) =>
      FCalendarDayVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FCalendarDayVariantConstraint], which represents combinations of variants.
extension type const FCalendarDayVariant._(FVariant _) implements FCalendarDayVariantConstraint, FVariant {
  /// The day is selected but is not part of a contiguous selection.
  static const single = FCalendarDayVariant._(.new(4, 'single'));

  /// The day is the start of a contiguous selection.
  static const start = FCalendarDayVariant._(.new(4, 'start'));

  /// The day is inside a contiguous selection, between a start and end.
  static const middle = FCalendarDayVariant._(.new(4, 'middle'));

  /// The day is the end of a contiguous selection.
  static const end = FCalendarDayVariant._(.new(4, 'end'));

  /// The semantic variant when the day is not in the current month.
  static const adjacent = FCalendarDayVariant._(.new(3, 'adjacent'));

  /// The semantic variant when the day is the current day.
  static const today = FCalendarDayVariant._(.new(3, 'today'));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FCalendarDayVariant._(.new(2, 'disabled'));

  /// The interaction variant when a given widget (and not its descendants) has focus.
  static const primaryFocused = FCalendarDayVariant._(.new(1, 'primaryFocused'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FCalendarDayVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FCalendarDayVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FCalendarDayVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FCalendarDayVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FCalendarDayVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FCalendarDayVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FCalendarDayVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FCalendarDayVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FCalendarDayVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FCalendarDayVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarDayStyleTransformations on FCalendarDayStyle {
  /// Returns a copy of this [FCalendarDayStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarDayStyle.textStyle] - The day's text style.
  /// * [FCalendarDayStyle.foreground] - The decoration painted in front of [background].
  /// * [FCalendarDayStyle.background] - The decoration painted behind [foreground].
  @useResult
  FCalendarDayStyle copyWith({TextStyleDelta? textStyle, DecorationDelta? foreground, DecorationDelta? background}) =>
      .new(
        textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
        foreground: foreground?.call(this.foreground) ?? this.foreground,
        background: background?.call(this.background) ?? this.background,
      );

  /// Linearly interpolate between this and another [FCalendarDayStyle] using the given factor [t].
  @useResult
  FCalendarDayStyle lerp(FCalendarDayStyle other, double t) => .new(
    textStyle: .lerp(textStyle, other.textStyle, t) ?? textStyle,
    foreground: .lerp(foreground, other.foreground, t) ?? foreground,
    background: .lerp(background, other.background, t) ?? background,
  );
}

mixin _$FCalendarDayStyleFunctions on Diagnosticable implements FCalendarDayStyleDelta {
  /// Returns itself.
  @override
  FCalendarDayStyle call(Object _) => this as FCalendarDayStyle;

  TextStyle get textStyle;
  Decoration get foreground;
  Decoration get background;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('foreground', foreground, level: .debug))
      ..add(DiagnosticsProperty('background', background, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarDayStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          foreground == other.foreground &&
          background == other.background);

  @override
  int get hashCode => textStyle.hashCode ^ foreground.hashCode ^ background.hashCode;
}

/// A delta that applies modifications to a [FCalendarDayStyle].
///
/// A [FCalendarDayStyle] is itself a [FCalendarDayStyleDelta].
abstract class FCalendarDayStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarDayStyle].
  ///
  /// ## Parameters
  /// * [FCalendarDayStyle.textStyle] - The day's text style.
  /// * [FCalendarDayStyle.foreground] - The decoration painted in front of [background].
  /// * [FCalendarDayStyle.background] - The decoration painted behind [foreground].
  const factory FCalendarDayStyleDelta.delta({
    TextStyleDelta? textStyle,
    DecorationDelta? foreground,
    DecorationDelta? background,
  }) = _FCalendarDayStyleDelta;

  /// Creates a delta that returns the [FCalendarDayStyle] in the current context.
  const factory FCalendarDayStyleDelta.context() = _FCalendarDayStyleContext;

  @override
  FCalendarDayStyle call(covariant FCalendarDayStyle value);
}

class _FCalendarDayStyleDelta implements FCalendarDayStyleDelta {
  const _FCalendarDayStyleDelta({this.textStyle, this.foreground, this.background});

  final TextStyleDelta? textStyle;

  final DecorationDelta? foreground;

  final DecorationDelta? background;

  @override
  FCalendarDayStyle call(FCalendarDayStyle original) => FCalendarDayStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    foreground: foreground?.call(original.foreground) ?? original.foreground,
    background: background?.call(original.background) ?? original.background,
  );
}

class _FCalendarDayStyleContext implements FCalendarDayStyleDelta {
  const _FCalendarDayStyleContext();

  @override
  FCalendarDayStyle call(FCalendarDayStyle original) => original;
}

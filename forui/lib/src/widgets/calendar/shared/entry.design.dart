// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'entry.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarEntryStyleTransformations on FCalendarEntryStyle {
  /// Returns a copy of this [FCalendarEntryStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarEntryStyle.backgroundColor] - The day's background color.
  /// * [FCalendarEntryStyle.borderColor] - The border.
  /// * [FCalendarEntryStyle.textStyle] - The day's text style.
  /// * [FCalendarEntryStyle.radius] - The entry border's radius.
  @useResult
  FCalendarEntryStyle copyWith({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? borderColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    Radius? radius,
  }) => .new(
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    borderColor: borderColor?.call(this.borderColor) ?? this.borderColor,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    radius: radius ?? this.radius,
  );

  /// Linearly interpolate between this and another [FCalendarEntryStyle] using the given factor [t].
  @useResult
  FCalendarEntryStyle lerp(FCalendarEntryStyle other, double t) => .new(
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    borderColor: .lerpWhere(borderColor, other.borderColor, t, Color.lerp),
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    radius: t < 0.5 ? radius : other.radius,
  );
}

mixin _$FCalendarEntryStyleFunctions on Diagnosticable implements FCalendarEntryStyleDelta {
  /// Returns itself.
  @override
  FCalendarEntryStyle call(Object _) => this as FCalendarEntryStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Color, Delta> get backgroundColor;
  FVariants<FTappableVariantConstraint, FTappableVariant, Color?, Delta> get borderColor;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  Radius get radius;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('radius', radius, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarEntryStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          textStyle == other.textStyle &&
          radius == other.radius);

  @override
  int get hashCode => backgroundColor.hashCode ^ borderColor.hashCode ^ textStyle.hashCode ^ radius.hashCode;
}

/// A delta that applies modifications to a [FCalendarEntryStyle].
///
/// A [FCalendarEntryStyle] is itself a [FCalendarEntryStyleDelta].
abstract class FCalendarEntryStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarEntryStyle].
  ///
  /// ## Parameters
  /// * [FCalendarEntryStyle.backgroundColor] - The day's background color.
  /// * [FCalendarEntryStyle.borderColor] - The border.
  /// * [FCalendarEntryStyle.textStyle] - The day's text style.
  /// * [FCalendarEntryStyle.radius] - The entry border's radius.
  const factory FCalendarEntryStyleDelta.delta({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? borderColor,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    Radius? radius,
  }) = _FCalendarEntryStyleDelta;

  /// Creates a delta that returns the [FCalendarEntryStyle] in the current context.
  const factory FCalendarEntryStyleDelta.context() = _FCalendarEntryStyleContext;

  @override
  FCalendarEntryStyle call(covariant FCalendarEntryStyle value);
}

class _FCalendarEntryStyleDelta implements FCalendarEntryStyleDelta {
  const _FCalendarEntryStyleDelta({this.backgroundColor, this.borderColor, this.textStyle, this.radius});

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor;

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color?, Delta>? borderColor;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final Radius? radius;

  @override
  FCalendarEntryStyle call(FCalendarEntryStyle original) => FCalendarEntryStyle(
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    borderColor: borderColor?.call(original.borderColor) ?? original.borderColor,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    radius: radius ?? original.radius,
  );
}

class _FCalendarEntryStyleContext implements FCalendarEntryStyleDelta {
  const _FCalendarEntryStyleContext();

  @override
  FCalendarEntryStyle call(FCalendarEntryStyle original) => original;
}

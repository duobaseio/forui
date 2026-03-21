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
  /// * [FCalendarEntryStyle.borderSide] - The border side.
  /// * [FCalendarEntryStyle.textStyle] - The day's text style.
  /// * [FCalendarEntryStyle.borderRadius] - The entry border's radius.
  @useResult
  FCalendarEntryStyle copyWith({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, BorderSide?, Delta>? borderSide,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    BorderRadius? borderRadius,
  }) => .new(
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    borderSide: borderSide?.call(this.borderSide) ?? this.borderSide,
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    borderRadius: borderRadius ?? this.borderRadius,
  );

  /// Linearly interpolate between this and another [FCalendarEntryStyle] using the given factor [t].
  @useResult
  FCalendarEntryStyle lerp(FCalendarEntryStyle other, double t) => .new(
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    borderSide: t < 0.5 ? borderSide : other.borderSide,
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    borderRadius: .lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
  );
}

mixin _$FCalendarEntryStyleFunctions on Diagnosticable implements FCalendarEntryStyleDelta {
  /// Returns itself.
  @override
  FCalendarEntryStyle call(Object _) => this as FCalendarEntryStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Color, Delta> get backgroundColor;
  FVariants<FTappableVariantConstraint, FTappableVariant, BorderSide?, Delta> get borderSide;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  BorderRadius get borderRadius;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('borderSide', borderSide, level: .debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarEntryStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          borderSide == other.borderSide &&
          textStyle == other.textStyle &&
          borderRadius == other.borderRadius);

  @override
  int get hashCode => backgroundColor.hashCode ^ borderSide.hashCode ^ textStyle.hashCode ^ borderRadius.hashCode;
}

/// A delta that applies modifications to a [FCalendarEntryStyle].
///
/// A [FCalendarEntryStyle] is itself a [FCalendarEntryStyleDelta].
abstract class FCalendarEntryStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarEntryStyle].
  ///
  /// ## Parameters
  /// * [FCalendarEntryStyle.backgroundColor] - The day's background color.
  /// * [FCalendarEntryStyle.borderSide] - The border side.
  /// * [FCalendarEntryStyle.textStyle] - The day's text style.
  /// * [FCalendarEntryStyle.borderRadius] - The entry border's radius.
  const factory FCalendarEntryStyleDelta.delta({
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, BorderSide?, Delta>? borderSide,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    BorderRadius? borderRadius,
  }) = _FCalendarEntryStyleDelta;

  /// Creates a delta that returns the [FCalendarEntryStyle] in the current context.
  const factory FCalendarEntryStyleDelta.context() = _FCalendarEntryStyleContext;

  @override
  FCalendarEntryStyle call(covariant FCalendarEntryStyle value);
}

class _FCalendarEntryStyleDelta implements FCalendarEntryStyleDelta {
  const _FCalendarEntryStyleDelta({this.backgroundColor, this.borderSide, this.textStyle, this.borderRadius});

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor;

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, BorderSide?, Delta>? borderSide;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final BorderRadius? borderRadius;

  @override
  FCalendarEntryStyle call(FCalendarEntryStyle original) => FCalendarEntryStyle(
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    borderSide: borderSide?.call(original.borderSide) ?? original.borderSide,
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    borderRadius: borderRadius ?? original.borderRadius,
  );
}

class _FCalendarEntryStyleContext implements FCalendarEntryStyleDelta {
  const _FCalendarEntryStyleContext();

  @override
  FCalendarEntryStyle call(FCalendarEntryStyle original) => original;
}

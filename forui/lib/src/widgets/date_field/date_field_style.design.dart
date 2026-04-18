// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'date_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDateFieldStyleTransformations on FDateFieldStyle {
  /// Returns a copy of this [FDateFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FDateFieldStyle.fieldStyles] - The date field's textfield styles.
  /// * [FDateFieldStyle.popoverStyle] - The date field calendar's popover style.
  /// * [FDateFieldStyle.calendarStyle] - The date field's calendar style.
  @useResult
  FDateFieldStyle copyWith({
    FVariantsDelta<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FTextFieldStyle, FTextFieldStyleDelta>?
    fieldStyles,
    FPopoverStyleDelta? popoverStyle,
    FCalendarStyleDelta? calendarStyle,
  }) => .new(
    fieldStyles: FTextFieldSizeStyles(fieldStyles?.call(this.fieldStyles) ?? this.fieldStyles),
    popoverStyle: popoverStyle?.call(this.popoverStyle) ?? this.popoverStyle,
    calendarStyle: calendarStyle?.call(this.calendarStyle) ?? this.calendarStyle,
  );

  /// Linearly interpolate between this and another [FDateFieldStyle] using the given factor [t].
  @useResult
  FDateFieldStyle lerp(FDateFieldStyle other, double t) => .new(
    fieldStyles: FTextFieldSizeStyles(.lerpWhere(fieldStyles, other.fieldStyles, t, (a, b, t) => a!.lerp(b!, t))),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    calendarStyle: calendarStyle.lerp(other.calendarStyle, t),
  );
}

mixin _$FDateFieldStyleFunctions on Diagnosticable implements FDateFieldStyleDelta {
  /// Returns itself.
  @override
  FDateFieldStyle call(Object _) => this as FDateFieldStyle;

  FTextFieldSizeStyles get fieldStyles;
  FPopoverStyle get popoverStyle;
  FCalendarStyle get calendarStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyles', fieldStyles, level: .debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: .debug))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDateFieldStyle &&
          runtimeType == other.runtimeType &&
          fieldStyles == other.fieldStyles &&
          popoverStyle == other.popoverStyle &&
          calendarStyle == other.calendarStyle);

  @override
  int get hashCode => fieldStyles.hashCode ^ popoverStyle.hashCode ^ calendarStyle.hashCode;
}

/// A delta that applies modifications to a [FDateFieldStyle].
///
/// A [FDateFieldStyle] is itself a [FDateFieldStyleDelta].
abstract class FDateFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FDateFieldStyle].
  ///
  /// ## Parameters
  /// * [FDateFieldStyle.fieldStyles] - The date field's textfield styles.
  /// * [FDateFieldStyle.popoverStyle] - The date field calendar's popover style.
  /// * [FDateFieldStyle.calendarStyle] - The date field's calendar style.
  const factory FDateFieldStyleDelta.delta({
    FVariantsDelta<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FTextFieldStyle, FTextFieldStyleDelta>?
    fieldStyles,
    FPopoverStyleDelta? popoverStyle,
    FCalendarStyleDelta? calendarStyle,
  }) = _FDateFieldStyleDelta;

  /// Creates a delta that returns the [FDateFieldStyle] in the current context.
  const factory FDateFieldStyleDelta.context() = _FDateFieldStyleContext;

  @override
  FDateFieldStyle call(covariant FDateFieldStyle value);
}

class _FDateFieldStyleDelta implements FDateFieldStyleDelta {
  const _FDateFieldStyleDelta({this.fieldStyles, this.popoverStyle, this.calendarStyle});

  final FVariantsDelta<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FTextFieldStyle, FTextFieldStyleDelta>?
  fieldStyles;

  final FPopoverStyleDelta? popoverStyle;

  final FCalendarStyleDelta? calendarStyle;

  @override
  FDateFieldStyle call(FDateFieldStyle original) => FDateFieldStyle(
    fieldStyles: FTextFieldSizeStyles(fieldStyles?.call(original.fieldStyles) ?? original.fieldStyles),
    popoverStyle: popoverStyle?.call(original.popoverStyle) ?? original.popoverStyle,
    calendarStyle: calendarStyle?.call(original.calendarStyle) ?? original.calendarStyle,
  );
}

class _FDateFieldStyleContext implements FDateFieldStyleDelta {
  const _FDateFieldStyleContext();

  @override
  FDateFieldStyle call(FDateFieldStyle original) => original;
}

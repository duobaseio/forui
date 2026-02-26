// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'time_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTimeFieldStyleTransformations on FTimeFieldStyle {
  /// Returns a copy of this [FTimeFieldStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FTimeFieldStyle.fieldStyle] - The time field's text field style.
  /// * [FTimeFieldStyle.popoverStyle] - The time field picker's popover style.
  /// * [FTimeFieldStyle.pickerStyle] - The time field's picker style.
  @useResult
  FTimeFieldStyle copyWith({
    FTextFieldStyleDelta? fieldStyle,
    FPopoverStyleDelta? popoverStyle,
    FTimePickerStyleDelta? pickerStyle,
  }) => .new(
    fieldStyle: fieldStyle?.call(this.fieldStyle) ?? this.fieldStyle,
    popoverStyle: popoverStyle?.call(this.popoverStyle) ?? this.popoverStyle,
    pickerStyle: pickerStyle?.call(this.pickerStyle) ?? this.pickerStyle,
  );

  /// Linearly interpolate between this and another [FTimeFieldStyle] using the given factor [t].
  @useResult
  FTimeFieldStyle lerp(FTimeFieldStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    pickerStyle: pickerStyle.lerp(other.pickerStyle, t),
  );
}

mixin _$FTimeFieldStyleFunctions on Diagnosticable implements FTimeFieldStyleDelta {
  /// Returns itself.
  @override
  FTimeFieldStyle call(Object _) => this as FTimeFieldStyle;

  FTextFieldStyle get fieldStyle;
  FPopoverStyle get popoverStyle;
  FTimePickerStyle get pickerStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: .debug))
      ..add(DiagnosticsProperty('pickerStyle', pickerStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimeFieldStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          popoverStyle == other.popoverStyle &&
          pickerStyle == other.pickerStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ popoverStyle.hashCode ^ pickerStyle.hashCode;
}

/// A delta that applies modifications to a [FTimeFieldStyle].
///
/// A [FTimeFieldStyle] is itself a [FTimeFieldStyleDelta].
abstract class FTimeFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FTimeFieldStyle].
  ///
  /// ## Parameters
  /// * [FTimeFieldStyle.fieldStyle] - The time field's text field style.
  /// * [FTimeFieldStyle.popoverStyle] - The time field picker's popover style.
  /// * [FTimeFieldStyle.pickerStyle] - The time field's picker style.
  const factory FTimeFieldStyleDelta.delta({
    FTextFieldStyleDelta? fieldStyle,
    FPopoverStyleDelta? popoverStyle,
    FTimePickerStyleDelta? pickerStyle,
  }) = _FTimeFieldStyleDelta;

  /// Creates a delta that returns the [FTimeFieldStyle] in the current context.
  const factory FTimeFieldStyleDelta.context() = _FTimeFieldStyleContext;

  @override
  FTimeFieldStyle call(covariant FTimeFieldStyle value);
}

class _FTimeFieldStyleDelta implements FTimeFieldStyleDelta {
  const _FTimeFieldStyleDelta({this.fieldStyle, this.popoverStyle, this.pickerStyle});

  final FTextFieldStyleDelta? fieldStyle;

  final FPopoverStyleDelta? popoverStyle;

  final FTimePickerStyleDelta? pickerStyle;

  @override
  FTimeFieldStyle call(FTimeFieldStyle original) => FTimeFieldStyle(
    fieldStyle: fieldStyle?.call(original.fieldStyle) ?? original.fieldStyle,
    popoverStyle: popoverStyle?.call(original.popoverStyle) ?? original.popoverStyle,
    pickerStyle: pickerStyle?.call(original.pickerStyle) ?? original.pickerStyle,
  );
}

class _FTimeFieldStyleContext implements FTimeFieldStyleDelta {
  const _FTimeFieldStyleContext();

  @override
  FTimeFieldStyle call(FTimeFieldStyle original) => original;
}

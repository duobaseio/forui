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
  /// * [FTimeFieldStyle.fieldStyles] - The time field's text field size styles.
  /// * [FTimeFieldStyle.popoverStyle] - The time field picker's popover style.
  /// * [FTimeFieldStyle.pickerStyle] - The time field's picker style.
  @useResult
  FTimeFieldStyle copyWith({
    FVariantsDelta<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FTextFieldStyle, FTextFieldStyleDelta>?
    fieldStyles,
    FPopoverStyleDelta? popoverStyle,
    FTimePickerStyleDelta? pickerStyle,
  }) => .new(
    fieldStyles: FTextFieldSizeStyles(fieldStyles?.call(this.fieldStyles) ?? this.fieldStyles),
    popoverStyle: popoverStyle?.call(this.popoverStyle) ?? this.popoverStyle,
    pickerStyle: pickerStyle?.call(this.pickerStyle) ?? this.pickerStyle,
  );

  /// Linearly interpolate between this and another [FTimeFieldStyle] using the given factor [t].
  @useResult
  FTimeFieldStyle lerp(FTimeFieldStyle other, double t) => .new(
    fieldStyles: FTextFieldSizeStyles(.lerpWhere(fieldStyles, other.fieldStyles, t, (a, b, t) => a!.lerp(b!, t))),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    pickerStyle: pickerStyle.lerp(other.pickerStyle, t),
  );
}

mixin _$FTimeFieldStyleFunctions on Diagnosticable implements FTimeFieldStyleDelta {
  /// Returns itself.
  @override
  FTimeFieldStyle call(Object _) => this as FTimeFieldStyle;

  FTextFieldSizeStyles get fieldStyles;
  FPopoverStyle get popoverStyle;
  FTimePickerStyle get pickerStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyles', fieldStyles, level: .debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: .debug))
      ..add(DiagnosticsProperty('pickerStyle', pickerStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimeFieldStyle &&
          runtimeType == other.runtimeType &&
          fieldStyles == other.fieldStyles &&
          popoverStyle == other.popoverStyle &&
          pickerStyle == other.pickerStyle);

  @override
  int get hashCode => fieldStyles.hashCode ^ popoverStyle.hashCode ^ pickerStyle.hashCode;
}

/// A delta that applies modifications to a [FTimeFieldStyle].
///
/// A [FTimeFieldStyle] is itself a [FTimeFieldStyleDelta].
abstract class FTimeFieldStyleDelta with Delta {
  /// Creates a partial modification of a [FTimeFieldStyle].
  ///
  /// ## Parameters
  /// * [FTimeFieldStyle.fieldStyles] - The time field's text field size styles.
  /// * [FTimeFieldStyle.popoverStyle] - The time field picker's popover style.
  /// * [FTimeFieldStyle.pickerStyle] - The time field's picker style.
  const factory FTimeFieldStyleDelta.delta({
    FVariantsDelta<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FTextFieldStyle, FTextFieldStyleDelta>?
    fieldStyles,
    FPopoverStyleDelta? popoverStyle,
    FTimePickerStyleDelta? pickerStyle,
  }) = _FTimeFieldStyleDelta;

  /// Creates a delta that returns the [FTimeFieldStyle] in the current context.
  const factory FTimeFieldStyleDelta.context() = _FTimeFieldStyleContext;

  @override
  FTimeFieldStyle call(covariant FTimeFieldStyle value);
}

class _FTimeFieldStyleDelta implements FTimeFieldStyleDelta {
  const _FTimeFieldStyleDelta({this.fieldStyles, this.popoverStyle, this.pickerStyle});

  final FVariantsDelta<FTextFieldSizeVariantConstraint, FTextFieldSizeVariant, FTextFieldStyle, FTextFieldStyleDelta>?
  fieldStyles;

  final FPopoverStyleDelta? popoverStyle;

  final FTimePickerStyleDelta? pickerStyle;

  @override
  FTimeFieldStyle call(FTimeFieldStyle original) => FTimeFieldStyle(
    fieldStyles: FTextFieldSizeStyles(fieldStyles?.call(original.fieldStyles) ?? original.fieldStyles),
    popoverStyle: popoverStyle?.call(original.popoverStyle) ?? original.popoverStyle,
    pickerStyle: pickerStyle?.call(original.pickerStyle) ?? original.pickerStyle,
  );
}

class _FTimeFieldStyleContext implements FTimeFieldStyleDelta {
  const _FTimeFieldStyleContext();

  @override
  FTimeFieldStyle call(FTimeFieldStyle original) => original;
}

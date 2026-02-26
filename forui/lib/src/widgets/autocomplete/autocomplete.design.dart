// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteStyleTransformations on FAutocompleteStyle {
  /// Returns a copy of this [FAutocompleteStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteStyle.fieldStyle] - The select field's style.
  /// * [FAutocompleteStyle.composingTextStyle] - The composing text's [TextStyle].
  /// * [FAutocompleteStyle.typeaheadTextStyle] - The typeahead's [TextStyle].
  /// * [FAutocompleteStyle.contentStyle] - The content's style.
  @useResult
  FAutocompleteStyle copyWith({
    FTextFieldStyleDelta? fieldStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? composingTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? typeaheadTextStyle,
    FAutocompleteContentStyleDelta? contentStyle,
  }) => .new(
    fieldStyle: fieldStyle?.call(this.fieldStyle) ?? this.fieldStyle,
    composingTextStyle: composingTextStyle?.call(this.composingTextStyle) ?? this.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle?.call(this.typeaheadTextStyle) ?? this.typeaheadTextStyle,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteStyle] using the given factor [t].
  @useResult
  FAutocompleteStyle lerp(FAutocompleteStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    composingTextStyle: .lerpTextStyle(composingTextStyle, other.composingTextStyle, t),
    typeaheadTextStyle: .lerpTextStyle(typeaheadTextStyle, other.typeaheadTextStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FAutocompleteStyleFunctions on Diagnosticable implements FAutocompleteStyleDelta {
  /// Returns itself.
  @override
  FAutocompleteStyle call(Object _) => this as FAutocompleteStyle;

  FTextFieldStyle get fieldStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get composingTextStyle;
  FVariants<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta> get typeaheadTextStyle;
  FAutocompleteContentStyle get contentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('composingTextStyle', composingTextStyle, level: .debug))
      ..add(DiagnosticsProperty('typeaheadTextStyle', typeaheadTextStyle, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          composingTextStyle == other.composingTextStyle &&
          typeaheadTextStyle == other.typeaheadTextStyle &&
          contentStyle == other.contentStyle);

  @override
  int get hashCode =>
      fieldStyle.hashCode ^ composingTextStyle.hashCode ^ typeaheadTextStyle.hashCode ^ contentStyle.hashCode;
}

/// A delta that applies modifications to a [FAutocompleteStyle].
///
/// A [FAutocompleteStyle] is itself a [FAutocompleteStyleDelta].
abstract class FAutocompleteStyleDelta with Delta {
  /// Creates a partial modification of a [FAutocompleteStyle].
  ///
  /// ## Parameters
  /// * [FAutocompleteStyle.fieldStyle] - The select field's style.
  /// * [FAutocompleteStyle.composingTextStyle] - The composing text's [TextStyle].
  /// * [FAutocompleteStyle.typeaheadTextStyle] - The typeahead's [TextStyle].
  /// * [FAutocompleteStyle.contentStyle] - The content's style.
  const factory FAutocompleteStyleDelta.delta({
    FTextFieldStyleDelta? fieldStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? composingTextStyle,
    FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? typeaheadTextStyle,
    FAutocompleteContentStyleDelta? contentStyle,
  }) = _FAutocompleteStyleDelta;

  /// Creates a delta that returns the [FAutocompleteStyle] in the current context.
  const factory FAutocompleteStyleDelta.context() = _FAutocompleteStyleContext;

  @override
  FAutocompleteStyle call(covariant FAutocompleteStyle value);
}

class _FAutocompleteStyleDelta implements FAutocompleteStyleDelta {
  const _FAutocompleteStyleDelta({
    this.fieldStyle,
    this.composingTextStyle,
    this.typeaheadTextStyle,
    this.contentStyle,
  });

  final FTextFieldStyleDelta? fieldStyle;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? composingTextStyle;

  final FVariantsDelta<FTextFieldVariantConstraint, FTextFieldVariant, TextStyle, TextStyleDelta>? typeaheadTextStyle;

  final FAutocompleteContentStyleDelta? contentStyle;

  @override
  FAutocompleteStyle call(FAutocompleteStyle original) => FAutocompleteStyle(
    fieldStyle: fieldStyle?.call(original.fieldStyle) ?? original.fieldStyle,
    composingTextStyle: composingTextStyle?.call(original.composingTextStyle) ?? original.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle?.call(original.typeaheadTextStyle) ?? original.typeaheadTextStyle,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
  );
}

class _FAutocompleteStyleContext implements FAutocompleteStyleDelta {
  const _FAutocompleteStyleContext();

  @override
  FAutocompleteStyle call(FAutocompleteStyle original) => original;
}

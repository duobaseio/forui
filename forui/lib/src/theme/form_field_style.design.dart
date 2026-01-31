// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'form_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FFormFieldStyleTransformations on FFormFieldStyle {
  /// Returns a copy of this [FFormFieldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FFormFieldStyle.labelTextStyle] - The label's text style.
  /// * [FFormFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FFormFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FFormFieldStyle copyWith({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => .new(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FFormFieldStyle] using the given factor [t].
  @useResult
  FFormFieldStyle lerp(FFormFieldStyle other, double t) => .new(
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FFormFieldStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FFormFieldStyle] to replace functions that accept and return a [FFormFieldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FFormFieldStyle Function(FFormFieldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FFormFieldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FFormFieldStyle(...));
  /// ```
  @useResult
  FFormFieldStyle call(Object? _) => this as FFormFieldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: .debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: .debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FFormFieldStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FFormFieldStyle].
sealed class FFormFieldStyleDelta with Delta<FFormFieldStyle> {
  /// Creates a complete replacement for a [FFormFieldStyle].
  const factory FFormFieldStyleDelta.replace(FFormFieldStyle replacement) = _FFormFieldStyleReplace;

  /// Creates a partial modification of a [FFormFieldStyle].
  const factory FFormFieldStyleDelta.merge({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyleDelta? errorTextStyle,
  }) = _FFormFieldStyleMerge;
}

class _FFormFieldStyleReplace implements FFormFieldStyleDelta {
  const _FFormFieldStyleReplace(this._replacement);

  final FFormFieldStyle _replacement;

  @override
  FFormFieldStyle call(FFormFieldStyle _) => _replacement;
}

class _FFormFieldStyleMerge implements FFormFieldStyleDelta {
  const _FFormFieldStyleMerge({this.labelTextStyle, this.descriptionTextStyle, this.errorTextStyle});

  final FWidgetStateMap<TextStyle>? labelTextStyle;

  final FWidgetStateMap<TextStyle>? descriptionTextStyle;

  final TextStyleDelta? errorTextStyle;

  @override
  FFormFieldStyle call(FFormFieldStyle original) => FFormFieldStyle(
    labelTextStyle: labelTextStyle ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectStyleTransformations on FSelectStyle {
  /// Returns a copy of this [FSelectStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectStyle.fieldStyle] - The select field's style.
  /// * [FSelectStyle.searchStyle] - The search's style.
  /// * [FSelectStyle.contentStyle] - The content's style.
  /// * [FSelectStyle.emptyTextStyle] - The default text style when there are no results.
  @useResult
  FSelectStyle copyWith({
    FTextFieldStyleDelta? fieldStyle,
    FSelectSearchStyleDelta? searchStyle,
    FSelectContentStyleDelta? contentStyle,
    TextStyleDelta? emptyTextStyle,
  }) => .new(
    fieldStyle: fieldStyle?.call(this.fieldStyle) ?? this.fieldStyle,
    searchStyle: searchStyle?.call(this.searchStyle) ?? this.searchStyle,
    contentStyle: contentStyle?.call(this.contentStyle) ?? this.contentStyle,
    emptyTextStyle: emptyTextStyle?.call(this.emptyTextStyle) ?? this.emptyTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectStyle] using the given factor [t].
  @useResult
  FSelectStyle lerp(FSelectStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    searchStyle: searchStyle.lerp(other.searchStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
  );
}

mixin _$FSelectStyleFunctions on Diagnosticable implements FSelectStyleDelta {
  /// Returns itself.
  @override
  FSelectStyle call(Object _) => this as FSelectStyle;

  FTextFieldStyle get fieldStyle;
  FSelectSearchStyle get searchStyle;
  FSelectContentStyle get contentStyle;
  TextStyle get emptyTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('searchStyle', searchStyle, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          searchStyle == other.searchStyle &&
          contentStyle == other.contentStyle &&
          emptyTextStyle == other.emptyTextStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ searchStyle.hashCode ^ contentStyle.hashCode ^ emptyTextStyle.hashCode;
}

/// A delta that applies modifications to a [FSelectStyle].
///
/// A [FSelectStyle] is itself a [FSelectStyleDelta].
abstract class FSelectStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectStyle].
  ///
  /// ## Parameters
  /// * [FSelectStyle.fieldStyle] - The select field's style.
  /// * [FSelectStyle.searchStyle] - The search's style.
  /// * [FSelectStyle.contentStyle] - The content's style.
  /// * [FSelectStyle.emptyTextStyle] - The default text style when there are no results.
  const factory FSelectStyleDelta.delta({
    FTextFieldStyleDelta? fieldStyle,
    FSelectSearchStyleDelta? searchStyle,
    FSelectContentStyleDelta? contentStyle,
    TextStyleDelta? emptyTextStyle,
  }) = _FSelectStyleDelta;

  /// Creates a delta that returns the [FSelectStyle] in the current context.
  const factory FSelectStyleDelta.context() = _FSelectStyleContext;

  @override
  FSelectStyle call(covariant FSelectStyle value);
}

class _FSelectStyleDelta implements FSelectStyleDelta {
  const _FSelectStyleDelta({this.fieldStyle, this.searchStyle, this.contentStyle, this.emptyTextStyle});

  final FTextFieldStyleDelta? fieldStyle;

  final FSelectSearchStyleDelta? searchStyle;

  final FSelectContentStyleDelta? contentStyle;

  final TextStyleDelta? emptyTextStyle;

  @override
  FSelectStyle call(FSelectStyle original) => FSelectStyle(
    fieldStyle: fieldStyle?.call(original.fieldStyle) ?? original.fieldStyle,
    searchStyle: searchStyle?.call(original.searchStyle) ?? original.searchStyle,
    contentStyle: contentStyle?.call(original.contentStyle) ?? original.contentStyle,
    emptyTextStyle: emptyTextStyle?.call(original.emptyTextStyle) ?? original.emptyTextStyle,
  );
}

class _FSelectStyleContext implements FSelectStyleDelta {
  const _FSelectStyleContext();

  @override
  FSelectStyle call(FSelectStyle original) => original;
}

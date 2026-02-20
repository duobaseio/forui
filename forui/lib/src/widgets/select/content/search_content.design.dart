// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'search_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectSearchStyleTransformations on FSelectSearchStyle {
  /// Returns a copy of this [FSelectSearchStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectSearchStyle.fieldStyle] - The search field's style.
  /// * [FSelectSearchStyle.dividerStyle] - The style of the divider between the search field and results.
  /// * [FSelectSearchStyle.progressStyle] - The loading progress's style.
  @useResult
  FSelectSearchStyle copyWith({
    FTextFieldStyleDelta? fieldStyle,
    FDividerStyleDelta? dividerStyle,
    FCircularProgressStyleDelta? progressStyle,
  }) => .new(
    fieldStyle: fieldStyle?.call(this.fieldStyle) ?? this.fieldStyle,
    dividerStyle: dividerStyle?.call(this.dividerStyle) ?? this.dividerStyle,
    progressStyle: progressStyle?.call(this.progressStyle) ?? this.progressStyle,
  );

  /// Linearly interpolate between this and another [FSelectSearchStyle] using the given factor [t].
  @useResult
  FSelectSearchStyle lerp(FSelectSearchStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
    progressStyle: progressStyle.lerp(other.progressStyle, t),
  );
}

mixin _$FSelectSearchStyleFunctions on Diagnosticable implements FSelectSearchStyleDelta {
  /// Returns itself.
  @override
  FSelectSearchStyle call(Object _) => this as FSelectSearchStyle;

  FTextFieldStyle get fieldStyle;
  FDividerStyle get dividerStyle;
  FCircularProgressStyle get progressStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle, level: .debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSearchStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          dividerStyle == other.dividerStyle &&
          progressStyle == other.progressStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ dividerStyle.hashCode ^ progressStyle.hashCode;
}

/// A delta that applies modifications to a [FSelectSearchStyle].
///
/// A [FSelectSearchStyle] is itself a [FSelectSearchStyleDelta].
abstract class FSelectSearchStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectSearchStyle].
  ///
  /// ## Parameters
  /// * [FSelectSearchStyle.fieldStyle] - The search field's style.
  /// * [FSelectSearchStyle.dividerStyle] - The style of the divider between the search field and results.
  /// * [FSelectSearchStyle.progressStyle] - The loading progress's style.
  const factory FSelectSearchStyleDelta.delta({
    FTextFieldStyleDelta? fieldStyle,
    FDividerStyleDelta? dividerStyle,
    FCircularProgressStyleDelta? progressStyle,
  }) = _FSelectSearchStyleDelta;

  /// Creates a delta that returns the [FSelectSearchStyle] in the current context.
  const factory FSelectSearchStyleDelta.context() = _FSelectSearchStyleContext;

  @override
  FSelectSearchStyle call(covariant FSelectSearchStyle value);
}

class _FSelectSearchStyleDelta implements FSelectSearchStyleDelta {
  const _FSelectSearchStyleDelta({this.fieldStyle, this.dividerStyle, this.progressStyle});

  final FTextFieldStyleDelta? fieldStyle;

  final FDividerStyleDelta? dividerStyle;

  final FCircularProgressStyleDelta? progressStyle;

  @override
  FSelectSearchStyle call(FSelectSearchStyle original) => FSelectSearchStyle(
    fieldStyle: fieldStyle?.call(original.fieldStyle) ?? original.fieldStyle,
    dividerStyle: dividerStyle?.call(original.dividerStyle) ?? original.dividerStyle,
    progressStyle: progressStyle?.call(original.progressStyle) ?? original.progressStyle,
  );
}

class _FSelectSearchStyleContext implements FSelectSearchStyleDelta {
  const _FSelectSearchStyleContext();

  @override
  FSelectSearchStyle call(FSelectSearchStyle original) => original;
}

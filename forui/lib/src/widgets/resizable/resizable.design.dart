// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'resizable.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FResizableStyleTransformations on FResizableStyle {
  /// Returns a copy of this [FResizableStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableStyle.horizontalDividerStyle] - The horizontal divider style.
  /// * [FResizableStyle.verticalDividerStyle] - The vertical divider style.
  @useResult
  FResizableStyle copyWith({
    FResizableDividerStyle Function(FResizableDividerStyle style)? horizontalDividerStyle,
    FResizableDividerStyle Function(FResizableDividerStyle style)? verticalDividerStyle,
  }) => .new(
    horizontalDividerStyle: horizontalDividerStyle != null
        ? horizontalDividerStyle(this.horizontalDividerStyle)
        : this.horizontalDividerStyle,
    verticalDividerStyle: verticalDividerStyle != null
        ? verticalDividerStyle(this.verticalDividerStyle)
        : this.verticalDividerStyle,
  );

  /// Linearly interpolate between this and another [FResizableStyle] using the given factor [t].
  @useResult
  FResizableStyle lerp(FResizableStyle other, double t) => .new(
    horizontalDividerStyle: horizontalDividerStyle.lerp(other.horizontalDividerStyle, t),
    verticalDividerStyle: verticalDividerStyle.lerp(other.verticalDividerStyle, t),
  );
}

mixin _$FResizableStyleFunctions on Diagnosticable {
  FResizableDividerStyle get horizontalDividerStyle;
  FResizableDividerStyle get verticalDividerStyle;

  /// Returns itself.
  ///
  /// Allows [FResizableStyle] to replace functions that accept and return a [FResizableStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableStyle Function(FResizableStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableStyle(...));
  /// ```
  @useResult
  FResizableStyle call(Object? _) => this as FResizableStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalDividerStyle', horizontalDividerStyle, level: .debug))
      ..add(DiagnosticsProperty('verticalDividerStyle', verticalDividerStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableStyle &&
          runtimeType == other.runtimeType &&
          horizontalDividerStyle == other.horizontalDividerStyle &&
          verticalDividerStyle == other.verticalDividerStyle);

  @override
  int get hashCode => horizontalDividerStyle.hashCode ^ verticalDividerStyle.hashCode;
}

/// A delta that applies modifications to a [FResizableStyle].
sealed class FResizableStyleDelta with Delta<FResizableStyle> {
  /// Creates a complete replacement for a [FResizableStyle].
  const factory FResizableStyleDelta.replace(FResizableStyle replacement) = _FResizableStyleReplace;

  /// Creates a partial modification of a [FResizableStyle].
  const factory FResizableStyleDelta.merge({
    FResizableDividerStyleDelta? horizontalDividerStyle,
    FResizableDividerStyleDelta? verticalDividerStyle,
  }) = _FResizableStyleMerge;
}

class _FResizableStyleReplace implements FResizableStyleDelta {
  const _FResizableStyleReplace(this._replacement);

  final FResizableStyle _replacement;

  @override
  FResizableStyle call(FResizableStyle _) => _replacement;
}

class _FResizableStyleMerge implements FResizableStyleDelta {
  const _FResizableStyleMerge({this.horizontalDividerStyle, this.verticalDividerStyle});

  final FResizableDividerStyleDelta? horizontalDividerStyle;

  final FResizableDividerStyleDelta? verticalDividerStyle;

  @override
  FResizableStyle call(FResizableStyle original) => FResizableStyle(
    horizontalDividerStyle:
        horizontalDividerStyle?.call(original.horizontalDividerStyle) ?? original.horizontalDividerStyle,
    verticalDividerStyle: verticalDividerStyle?.call(original.verticalDividerStyle) ?? original.verticalDividerStyle,
  );
}

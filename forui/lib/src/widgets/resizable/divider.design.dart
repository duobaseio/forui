// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FResizableDividerStyleTransformations on FResizableDividerStyle {
  /// Returns a copy of this [FResizableDividerStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableDividerStyle.color] - The divider's color.
  /// * [FResizableDividerStyle.width] - The divider's width (thickness).
  /// * [FResizableDividerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FResizableDividerStyle.thumbStyle] - The divider thumb's style.
  @useResult
  FResizableDividerStyle copyWith({
    Color? color,
    double? width,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FResizableDividerThumbStyle Function(FResizableDividerThumbStyle style)? thumbStyle,
  }) => .new(
    color: color ?? this.color,
    width: width ?? this.width,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    thumbStyle: thumbStyle != null ? thumbStyle(this.thumbStyle) : this.thumbStyle,
  );

  /// Linearly interpolate between this and another [FResizableDividerStyle] using the given factor [t].
  @useResult
  FResizableDividerStyle lerp(FResizableDividerStyle other, double t) => .new(
    color: .lerp(color, other.color, t) ?? color,
    width: lerpDouble(width, other.width, t) ?? width,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    thumbStyle: thumbStyle.lerp(other.thumbStyle, t),
  );
}

mixin _$FResizableDividerStyleFunctions on Diagnosticable {
  Color get color;
  double get width;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FResizableDividerThumbStyle get thumbStyle;

  /// Returns itself.
  ///
  /// Allows [FResizableDividerStyle] to replace functions that accept and return a [FResizableDividerStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableDividerStyle Function(FResizableDividerStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableDividerStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableDividerStyle(...));
  /// ```
  @useResult
  FResizableDividerStyle call(Object? _) => this as FResizableDividerStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, level: .debug))
      ..add(DoubleProperty('width', width, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableDividerStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          width == other.width &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          thumbStyle == other.thumbStyle);

  @override
  int get hashCode => color.hashCode ^ width.hashCode ^ focusedOutlineStyle.hashCode ^ thumbStyle.hashCode;
}

/// A delta that applies modifications to a [FResizableDividerStyle].
sealed class FResizableDividerStyleDelta with Delta<FResizableDividerStyle> {
  /// Creates a complete replacement for a [FResizableDividerStyle].
  const factory FResizableDividerStyleDelta.replace(FResizableDividerStyle replacement) =
      _FResizableDividerStyleReplace;

  /// Creates a partial modification of a [FResizableDividerStyle].
  const factory FResizableDividerStyleDelta.merge({
    Color? color,
    double? width,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FResizableDividerThumbStyleDelta? thumbStyle,
  }) = _FResizableDividerStyleMerge;
}

class _FResizableDividerStyleReplace implements FResizableDividerStyleDelta {
  const _FResizableDividerStyleReplace(this._replacement);

  final FResizableDividerStyle _replacement;

  @override
  FResizableDividerStyle call(FResizableDividerStyle _) => _replacement;
}

class _FResizableDividerStyleMerge implements FResizableDividerStyleDelta {
  const _FResizableDividerStyleMerge({this.color, this.width, this.focusedOutlineStyle, this.thumbStyle});

  final Color? color;

  final double? width;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FResizableDividerThumbStyleDelta? thumbStyle;

  @override
  FResizableDividerStyle call(FResizableDividerStyle original) => FResizableDividerStyle(
    color: color ?? original.color,
    width: width ?? original.width,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    thumbStyle: thumbStyle?.call(original.thumbStyle) ?? original.thumbStyle,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FResizableDividerThumbStyleTransformations on FResizableDividerThumbStyle {
  /// Returns a copy of this [FResizableDividerThumbStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableDividerThumbStyle.decoration] - The background color.
  /// * [FResizableDividerThumbStyle.foregroundColor] - The foreground color.
  /// * [FResizableDividerThumbStyle.height] - The height.
  /// * [FResizableDividerThumbStyle.width] - The width.
  @useResult
  FResizableDividerThumbStyle copyWith({
    BoxDecoration? decoration,
    Color? foregroundColor,
    double? height,
    double? width,
  }) => .new(
    decoration: decoration ?? this.decoration,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    height: height ?? this.height,
    width: width ?? this.width,
  );

  /// Linearly interpolate between this and another [FResizableDividerThumbStyle] using the given factor [t].
  @useResult
  FResizableDividerThumbStyle lerp(FResizableDividerThumbStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    foregroundColor: .lerp(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
    height: lerpDouble(height, other.height, t) ?? height,
    width: lerpDouble(width, other.width, t) ?? width,
  );
}

mixin _$FResizableDividerThumbStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  Color get foregroundColor;
  double get height;
  double get width;

  /// Returns itself.
  ///
  /// Allows [FResizableDividerThumbStyle] to replace functions that accept and return a [FResizableDividerThumbStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableDividerThumbStyle Function(FResizableDividerThumbStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableDividerThumbStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableDividerThumbStyle(...));
  /// ```
  @useResult
  FResizableDividerThumbStyle call(Object? _) => this as FResizableDividerThumbStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(ColorProperty('foregroundColor', foregroundColor, level: .debug))
      ..add(DoubleProperty('height', height, level: .debug))
      ..add(DoubleProperty('width', width, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableDividerThumbStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          foregroundColor == other.foregroundColor &&
          height == other.height &&
          width == other.width);

  @override
  int get hashCode => decoration.hashCode ^ foregroundColor.hashCode ^ height.hashCode ^ width.hashCode;
}

/// A delta that applies modifications to a [FResizableDividerThumbStyle].
sealed class FResizableDividerThumbStyleDelta with Delta<FResizableDividerThumbStyle> {
  /// Creates a complete replacement for a [FResizableDividerThumbStyle].
  const factory FResizableDividerThumbStyleDelta.replace(FResizableDividerThumbStyle replacement) =
      _FResizableDividerThumbStyleReplace;

  /// Creates a partial modification of a [FResizableDividerThumbStyle].
  const factory FResizableDividerThumbStyleDelta.merge({
    BoxDecorationDelta? decoration,
    Color? foregroundColor,
    double? height,
    double? width,
  }) = _FResizableDividerThumbStyleMerge;
}

class _FResizableDividerThumbStyleReplace implements FResizableDividerThumbStyleDelta {
  const _FResizableDividerThumbStyleReplace(this._replacement);

  final FResizableDividerThumbStyle _replacement;

  @override
  FResizableDividerThumbStyle call(FResizableDividerThumbStyle _) => _replacement;
}

class _FResizableDividerThumbStyleMerge implements FResizableDividerThumbStyleDelta {
  const _FResizableDividerThumbStyleMerge({this.decoration, this.foregroundColor, this.height, this.width});

  final BoxDecorationDelta? decoration;

  final Color? foregroundColor;

  final double? height;

  final double? width;

  @override
  FResizableDividerThumbStyle call(FResizableDividerThumbStyle original) => FResizableDividerThumbStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    foregroundColor: foregroundColor ?? original.foregroundColor,
    height: height ?? original.height,
    width: width ?? original.width,
  );
}

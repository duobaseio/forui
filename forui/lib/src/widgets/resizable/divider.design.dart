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
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
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
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FResizableDividerThumbStyleDelta? thumbStyle,
  }) => .new(
    color: color ?? this.color,
    width: width ?? this.width,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    thumbStyle: thumbStyle?.call(this.thumbStyle) ?? this.thumbStyle,
  );

  /// Linearly interpolate between this and another [FResizableDividerStyle] using the given factor [t].
  @useResult
  FResizableDividerStyle lerp(FResizableDividerStyle other, double t) => .new(
    color: FColors.lerpColor(color, other.color, t) ?? color,
    width: lerpDouble(width, other.width, t) ?? width,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    thumbStyle: thumbStyle.lerp(other.thumbStyle, t),
  );
}

mixin _$FResizableDividerStyleFunctions on Diagnosticable implements FResizableDividerStyleDelta {
  /// Returns itself.
  @override
  FResizableDividerStyle call(Object _) => this as FResizableDividerStyle;

  Color get color;
  double get width;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FResizableDividerThumbStyle get thumbStyle;
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
///
/// A [FResizableDividerStyle] is itself a [FResizableDividerStyleDelta].
abstract class FResizableDividerStyleDelta with Delta {
  /// Creates a partial modification of a [FResizableDividerStyle].
  ///
  /// ## Parameters
  /// * [FResizableDividerStyle.color] - The divider's color.
  /// * [FResizableDividerStyle.width] - The divider's width (thickness).
  /// * [FResizableDividerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FResizableDividerStyle.thumbStyle] - The divider thumb's style.
  const factory FResizableDividerStyleDelta.delta({
    Color? color,
    double? width,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FResizableDividerThumbStyleDelta? thumbStyle,
  }) = _FResizableDividerStyleDelta;

  /// Creates a delta that returns the [FResizableDividerStyle] in the current context.
  const factory FResizableDividerStyleDelta.context() = _FResizableDividerStyleContext;

  @override
  FResizableDividerStyle call(covariant FResizableDividerStyle value);
}

class _FResizableDividerStyleDelta implements FResizableDividerStyleDelta {
  const _FResizableDividerStyleDelta({this.color, this.width, this.focusedOutlineStyle, this.thumbStyle});

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

class _FResizableDividerStyleContext implements FResizableDividerStyleDelta {
  const _FResizableDividerStyleContext();

  @override
  FResizableDividerStyle call(FResizableDividerStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FResizableDividerThumbStyleTransformations on FResizableDividerThumbStyle {
  /// Returns a copy of this [FResizableDividerThumbStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableDividerThumbStyle.decoration] - The background color.
  /// * [FResizableDividerThumbStyle.foregroundColor] - The foreground color.
  /// * [FResizableDividerThumbStyle.height] - The height.
  /// * [FResizableDividerThumbStyle.width] - The width.
  @useResult
  FResizableDividerThumbStyle copyWith({
    DecorationDelta? decoration,
    Color? foregroundColor,
    double? height,
    double? width,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    height: height ?? this.height,
    width: width ?? this.width,
  );

  /// Linearly interpolate between this and another [FResizableDividerThumbStyle] using the given factor [t].
  @useResult
  FResizableDividerThumbStyle lerp(FResizableDividerThumbStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    foregroundColor: FColors.lerpColor(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
    height: lerpDouble(height, other.height, t) ?? height,
    width: lerpDouble(width, other.width, t) ?? width,
  );
}

mixin _$FResizableDividerThumbStyleFunctions on Diagnosticable implements FResizableDividerThumbStyleDelta {
  /// Returns itself.
  @override
  FResizableDividerThumbStyle call(Object _) => this as FResizableDividerThumbStyle;

  Decoration get decoration;
  Color get foregroundColor;
  double get height;
  double get width;
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
///
/// A [FResizableDividerThumbStyle] is itself a [FResizableDividerThumbStyleDelta].
abstract class FResizableDividerThumbStyleDelta with Delta {
  /// Creates a partial modification of a [FResizableDividerThumbStyle].
  ///
  /// ## Parameters
  /// * [FResizableDividerThumbStyle.decoration] - The background color.
  /// * [FResizableDividerThumbStyle.foregroundColor] - The foreground color.
  /// * [FResizableDividerThumbStyle.height] - The height.
  /// * [FResizableDividerThumbStyle.width] - The width.
  const factory FResizableDividerThumbStyleDelta.delta({
    DecorationDelta? decoration,
    Color? foregroundColor,
    double? height,
    double? width,
  }) = _FResizableDividerThumbStyleDelta;

  /// Creates a delta that returns the [FResizableDividerThumbStyle] in the current context.
  const factory FResizableDividerThumbStyleDelta.context() = _FResizableDividerThumbStyleContext;

  @override
  FResizableDividerThumbStyle call(covariant FResizableDividerThumbStyle value);
}

class _FResizableDividerThumbStyleDelta implements FResizableDividerThumbStyleDelta {
  const _FResizableDividerThumbStyleDelta({this.decoration, this.foregroundColor, this.height, this.width});

  final DecorationDelta? decoration;

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

class _FResizableDividerThumbStyleContext implements FResizableDividerThumbStyleDelta {
  const _FResizableDividerThumbStyleContext();

  @override
  FResizableDividerThumbStyle call(FResizableDividerThumbStyle original) => original;
}

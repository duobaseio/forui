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
  /// * [FResizableDividerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FResizableDividerStyle.thumbStyle] - The divider thumb's style.
  /// * [FResizableDividerStyle.hapticFeedback] - The haptic feedback when a region collides with its neighbour while resizing.
  /// * [FResizableDividerStyle.width] - The divider's width (thickness).
  @useResult
  FResizableDividerStyle copyWith({
    Color? color,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FResizableDividerThumbStyleDelta? thumbStyle,
    Future<void> Function()? hapticFeedback,
    double? width,
  }) => .new(
    color: color ?? this.color,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    thumbStyle: thumbStyle?.call(this.thumbStyle) ?? this.thumbStyle,
    hapticFeedback: hapticFeedback ?? this.hapticFeedback,
    width: width ?? this.width,
  );

  /// Linearly interpolate between this and another [FResizableDividerStyle] using the given factor [t].
  @useResult
  FResizableDividerStyle lerp(FResizableDividerStyle other, double t) => .new(
    color: FColors.lerpColor(color, other.color, t) ?? color,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    thumbStyle: thumbStyle.lerp(other.thumbStyle, t),
    hapticFeedback: t < 0.5 ? hapticFeedback : other.hapticFeedback,
    width: lerpDouble(width, other.width, t) ?? width,
  );
}

mixin _$FResizableDividerStyleFunctions on Diagnosticable implements FResizableDividerStyleDelta {
  /// Returns itself.
  @override
  FResizableDividerStyle call(Object _) => this as FResizableDividerStyle;

  Color get color;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FResizableDividerThumbStyle get thumbStyle;
  Future<void> Function() get hapticFeedback;
  double get width;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle, level: .debug))
      ..add(DiagnosticsProperty('hapticFeedback', hapticFeedback, level: .debug))
      ..add(DoubleProperty('width', width, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableDividerStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          thumbStyle == other.thumbStyle &&
          hapticFeedback == other.hapticFeedback &&
          width == other.width);

  @override
  int get hashCode =>
      color.hashCode ^ focusedOutlineStyle.hashCode ^ thumbStyle.hashCode ^ hapticFeedback.hashCode ^ width.hashCode;
}

/// A delta that applies modifications to a [FResizableDividerStyle].
///
/// A [FResizableDividerStyle] is itself a [FResizableDividerStyleDelta].
abstract class FResizableDividerStyleDelta with Delta {
  /// Creates a partial modification of a [FResizableDividerStyle].
  ///
  /// ## Parameters
  /// * [FResizableDividerStyle.color] - The divider's color.
  /// * [FResizableDividerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FResizableDividerStyle.thumbStyle] - The divider thumb's style.
  /// * [FResizableDividerStyle.hapticFeedback] - The haptic feedback when a region collides with its neighbour while resizing.
  /// * [FResizableDividerStyle.width] - The divider's width (thickness).
  const factory delta({
    Color? color,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FResizableDividerThumbStyleDelta? thumbStyle,
    Future<void> Function()? hapticFeedback,
    double? width,
  }) = _FResizableDividerStyleDelta;

  /// Creates a delta that returns the [FResizableDividerStyle] in the current context.
  const factory context() = _FResizableDividerStyleContext;

  @override
  FResizableDividerStyle call(covariant FResizableDividerStyle value);
}

class _FResizableDividerStyleDelta implements FResizableDividerStyleDelta {
  const new({this.color, this.focusedOutlineStyle, this.thumbStyle, this.hapticFeedback, this.width});

  final Color? color;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FResizableDividerThumbStyleDelta? thumbStyle;

  final Future<void> Function()? hapticFeedback;

  final double? width;

  @override
  FResizableDividerStyle call(FResizableDividerStyle original) => FResizableDividerStyle(
    color: color ?? original.color,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    thumbStyle: thumbStyle?.call(original.thumbStyle) ?? original.thumbStyle,
    hapticFeedback: hapticFeedback ?? original.hapticFeedback,
    width: width ?? original.width,
  );
}

class _FResizableDividerStyleContext implements FResizableDividerStyleDelta {
  const new();

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
  /// * [FResizableDividerThumbStyle.icon] - The thumb icon builder.
  /// * [FResizableDividerThumbStyle.height] - The height.
  /// * [FResizableDividerThumbStyle.width] - The width.
  @useResult
  FResizableDividerThumbStyle copyWith({
    DecorationDelta? decoration,
    Color? foregroundColor,
    FIcon? icon,
    double? height,
    double? width,
  }) => .new(
    decoration: decoration?.call(this.decoration) ?? this.decoration,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    icon: icon ?? this.icon,
    height: height ?? this.height,
    width: width ?? this.width,
  );

  /// Linearly interpolate between this and another [FResizableDividerThumbStyle] using the given factor [t].
  @useResult
  FResizableDividerThumbStyle lerp(FResizableDividerThumbStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    foregroundColor: FColors.lerpColor(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
    icon: t < 0.5 ? icon : other.icon,
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
  FIcon get icon;
  double get height;
  double get width;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(ColorProperty('foregroundColor', foregroundColor, level: .debug))
      ..add(DiagnosticsProperty('icon', icon, level: .debug))
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
          icon == other.icon &&
          height == other.height &&
          width == other.width);

  @override
  int get hashCode => decoration.hashCode ^ foregroundColor.hashCode ^ icon.hashCode ^ height.hashCode ^ width.hashCode;
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
  /// * [FResizableDividerThumbStyle.icon] - The thumb icon builder.
  /// * [FResizableDividerThumbStyle.height] - The height.
  /// * [FResizableDividerThumbStyle.width] - The width.
  const factory delta({
    DecorationDelta? decoration,
    Color? foregroundColor,
    FIcon? icon,
    double? height,
    double? width,
  }) = _FResizableDividerThumbStyleDelta;

  /// Creates a delta that returns the [FResizableDividerThumbStyle] in the current context.
  const factory context() = _FResizableDividerThumbStyleContext;

  @override
  FResizableDividerThumbStyle call(covariant FResizableDividerThumbStyle value);
}

class _FResizableDividerThumbStyleDelta implements FResizableDividerThumbStyleDelta {
  const new({this.decoration, this.foregroundColor, this.icon, this.height, this.width});

  final DecorationDelta? decoration;

  final Color? foregroundColor;

  final FIcon? icon;

  final double? height;

  final double? width;

  @override
  FResizableDividerThumbStyle call(FResizableDividerThumbStyle original) => FResizableDividerThumbStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    foregroundColor: foregroundColor ?? original.foregroundColor,
    icon: icon ?? original.icon,
    height: height ?? original.height,
    width: width ?? original.width,
  );
}

class _FResizableDividerThumbStyleContext implements FResizableDividerThumbStyleDelta {
  const new();

  @override
  FResizableDividerThumbStyle call(FResizableDividerThumbStyle original) => original;
}

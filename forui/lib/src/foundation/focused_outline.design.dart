// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'focused_outline.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FFocusedOutlineStyleTransformations on FFocusedOutlineStyle {
  /// Returns a copy of this [FFocusedOutlineStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FFocusedOutlineStyle.color] - The outline's color.
  /// * [FFocusedOutlineStyle.borderRadius] - The border radius.
  /// * [FFocusedOutlineStyle.width] - The outline's width.
  /// * [FFocusedOutlineStyle.spacing] - The spacing between the outline and the outlined widget.
  @useResult
  FFocusedOutlineStyle copyWith({Color? color, BorderRadiusGeometry? borderRadius, double? width, double? spacing}) =>
      .new(
        color: color ?? this.color,
        borderRadius: borderRadius ?? this.borderRadius,
        width: width ?? this.width,
        spacing: spacing ?? this.spacing,
      );

  /// Linearly interpolate between this and another [FFocusedOutlineStyle] using the given factor [t].
  @useResult
  FFocusedOutlineStyle lerp(FFocusedOutlineStyle other, double t) => .new(
    color: FColors.lerpColor(color, other.color, t) ?? color,
    borderRadius: .lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    width: lerpDouble(width, other.width, t) ?? width,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FFocusedOutlineStyleFunctions on Diagnosticable implements FFocusedOutlineStyleDelta {
  /// Returns itself.
  @override
  FFocusedOutlineStyle call(Object _) => this as FFocusedOutlineStyle;

  Color get color;
  BorderRadiusGeometry get borderRadius;
  double get width;
  double get spacing;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, level: .debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: .debug))
      ..add(DoubleProperty('width', width, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FFocusedOutlineStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          borderRadius == other.borderRadius &&
          width == other.width &&
          spacing == other.spacing);

  @override
  int get hashCode => color.hashCode ^ borderRadius.hashCode ^ width.hashCode ^ spacing.hashCode;
}

/// A delta that applies modifications to a [FFocusedOutlineStyle].
///
/// A [FFocusedOutlineStyle] is itself a [FFocusedOutlineStyleDelta].
abstract class FFocusedOutlineStyleDelta with Delta {
  /// Creates a partial modification of a [FFocusedOutlineStyle].
  ///
  /// ## Parameters
  /// * [FFocusedOutlineStyle.color] - The outline's color.
  /// * [FFocusedOutlineStyle.borderRadius] - The border radius.
  /// * [FFocusedOutlineStyle.width] - The outline's width.
  /// * [FFocusedOutlineStyle.spacing] - The spacing between the outline and the outlined widget.
  const factory FFocusedOutlineStyleDelta.delta({
    Color? color,
    BorderRadiusGeometry? borderRadius,
    double? width,
    double? spacing,
  }) = _FFocusedOutlineStyleDelta;

  /// Creates a delta that returns the [FFocusedOutlineStyle] in the current context.
  const factory FFocusedOutlineStyleDelta.context() = _FFocusedOutlineStyleContext;

  @override
  FFocusedOutlineStyle call(covariant FFocusedOutlineStyle value);
}

class _FFocusedOutlineStyleDelta implements FFocusedOutlineStyleDelta {
  const _FFocusedOutlineStyleDelta({this.color, this.borderRadius, this.width, this.spacing});

  final Color? color;

  final BorderRadiusGeometry? borderRadius;

  final double? width;

  final double? spacing;

  @override
  FFocusedOutlineStyle call(FFocusedOutlineStyle original) => FFocusedOutlineStyle(
    color: color ?? original.color,
    borderRadius: borderRadius ?? original.borderRadius,
    width: width ?? original.width,
    spacing: spacing ?? original.spacing,
  );
}

class _FFocusedOutlineStyleContext implements FFocusedOutlineStyleDelta {
  const _FFocusedOutlineStyleContext();

  @override
  FFocusedOutlineStyle call(FFocusedOutlineStyle original) => original;
}

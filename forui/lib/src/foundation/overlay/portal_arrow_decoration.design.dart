// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'portal_arrow_decoration.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPortalArrowStyleTransformations on FPortalArrowStyle {
  /// Returns a copy of this [FPortalArrowStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FPortalArrowStyle.cornerSpacing] - The minimum spacing between the arrow and the decoration's rounded corners.
  /// * [FPortalArrowStyle.baseRadius] - The radius of the rounded corners where the arrow's sides meet the decoration's edge.
  /// * [FPortalArrowStyle.width] - The base's width.
  /// * [FPortalArrowStyle.height] - The height from base to tip.
  /// * [FPortalArrowStyle.tipRadius] - The tip's radius.
  @useResult
  FPortalArrowStyle copyWith({
    double? cornerSpacing,
    double? baseRadius,
    double? width,
    double? height,
    double? tipRadius,
  }) => .new(
    cornerSpacing: cornerSpacing ?? this.cornerSpacing,
    baseRadius: baseRadius ?? this.baseRadius,
    width: width ?? this.width,
    height: height ?? this.height,
    tipRadius: tipRadius ?? this.tipRadius,
  );

  /// Linearly interpolate between this and another [FPortalArrowStyle] using the given factor [t].
  @useResult
  FPortalArrowStyle lerp(FPortalArrowStyle other, double t) => .new(
    cornerSpacing: lerpDouble(cornerSpacing, other.cornerSpacing, t) ?? cornerSpacing,
    baseRadius: lerpDouble(baseRadius, other.baseRadius, t) ?? baseRadius,
    width: lerpDouble(width, other.width, t) ?? width,
    height: lerpDouble(height, other.height, t) ?? height,
    tipRadius: lerpDouble(tipRadius, other.tipRadius, t) ?? tipRadius,
  );
}

mixin _$FPortalArrowStyleFunctions on Diagnosticable implements FPortalArrowStyleDelta {
  /// Returns itself.
  @override
  FPortalArrowStyle call(Object _) => this as FPortalArrowStyle;

  double get cornerSpacing;
  double get baseRadius;
  double get width;
  double get height;
  double get tipRadius;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('cornerSpacing', cornerSpacing, level: .debug))
      ..add(DoubleProperty('baseRadius', baseRadius, level: .debug))
      ..add(DoubleProperty('width', width, level: .debug))
      ..add(DoubleProperty('height', height, level: .debug))
      ..add(DoubleProperty('tipRadius', tipRadius, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPortalArrowStyle &&
          runtimeType == other.runtimeType &&
          cornerSpacing == other.cornerSpacing &&
          baseRadius == other.baseRadius &&
          width == other.width &&
          height == other.height &&
          tipRadius == other.tipRadius);

  @override
  int get hashCode =>
      cornerSpacing.hashCode ^ baseRadius.hashCode ^ width.hashCode ^ height.hashCode ^ tipRadius.hashCode;
}

/// A delta that applies modifications to a [FPortalArrowStyle].
///
/// A [FPortalArrowStyle] is itself a [FPortalArrowStyleDelta].
abstract class FPortalArrowStyleDelta with Delta {
  /// Creates a partial modification of a [FPortalArrowStyle].
  ///
  /// ## Parameters
  /// * [FPortalArrowStyle.cornerSpacing] - The minimum spacing between the arrow and the decoration's rounded corners.
  /// * [FPortalArrowStyle.baseRadius] - The radius of the rounded corners where the arrow's sides meet the decoration's edge.
  /// * [FPortalArrowStyle.width] - The base's width.
  /// * [FPortalArrowStyle.height] - The height from base to tip.
  /// * [FPortalArrowStyle.tipRadius] - The tip's radius.
  const factory delta({double? cornerSpacing, double? baseRadius, double? width, double? height, double? tipRadius}) =
      _FPortalArrowStyleDelta;

  /// Creates a delta that returns the [FPortalArrowStyle] in the current context.
  const factory context() = _FPortalArrowStyleContext;

  @override
  FPortalArrowStyle call(covariant FPortalArrowStyle value);
}

class _FPortalArrowStyleDelta implements FPortalArrowStyleDelta {
  const new({this.cornerSpacing, this.baseRadius, this.width, this.height, this.tipRadius});

  final double? cornerSpacing;

  final double? baseRadius;

  final double? width;

  final double? height;

  final double? tipRadius;

  @override
  FPortalArrowStyle call(FPortalArrowStyle original) => FPortalArrowStyle(
    cornerSpacing: cornerSpacing ?? original.cornerSpacing,
    baseRadius: baseRadius ?? original.baseRadius,
    width: width ?? original.width,
    height: height ?? original.height,
    tipRadius: tipRadius ?? original.tipRadius,
  );
}

class _FPortalArrowStyleContext implements FPortalArrowStyleDelta {
  const new();

  @override
  FPortalArrowStyle call(FPortalArrowStyle original) => original;
}

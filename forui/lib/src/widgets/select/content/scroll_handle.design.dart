// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scroll_handle.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectScrollHandleStyleTransformations on FSelectScrollHandleStyle {
  /// Returns a copy of this [FSelectScrollHandleStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectScrollHandleStyle.iconStyle] - The handle icon's style.
  /// * [FSelectScrollHandleStyle.background] - The background color.
  /// * [FSelectScrollHandleStyle.enterDuration] - The duration to wait before scrolling.
  /// * [FSelectScrollHandleStyle.pixelsPerSecond] - The number of pixels to scroll per second.
  @useResult
  FSelectScrollHandleStyle copyWith({
    IconThemeDataDelta? iconStyle,
    Color? background,
    Duration? enterDuration,
    double? pixelsPerSecond,
  }) => .new(
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    background: background ?? this.background,
    enterDuration: enterDuration ?? this.enterDuration,
    pixelsPerSecond: pixelsPerSecond ?? this.pixelsPerSecond,
  );

  /// Linearly interpolate between this and another [FSelectScrollHandleStyle] using the given factor [t].
  @useResult
  FSelectScrollHandleStyle lerp(FSelectScrollHandleStyle other, double t) => .new(
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    background: FColors.lerpColor(background, other.background, t) ?? background,
    enterDuration: t < 0.5 ? enterDuration : other.enterDuration,
    pixelsPerSecond: lerpDouble(pixelsPerSecond, other.pixelsPerSecond, t) ?? pixelsPerSecond,
  );
}

mixin _$FSelectScrollHandleStyleFunctions on Diagnosticable implements FSelectScrollHandleStyleDelta {
  /// Returns itself.
  @override
  FSelectScrollHandleStyle call(Object _) => this as FSelectScrollHandleStyle;

  IconThemeData get iconStyle;
  Color get background;
  Duration get enterDuration;
  double get pixelsPerSecond;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(ColorProperty('background', background, level: .debug))
      ..add(DiagnosticsProperty('enterDuration', enterDuration, level: .debug))
      ..add(DoubleProperty('pixelsPerSecond', pixelsPerSecond, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectScrollHandleStyle &&
          runtimeType == other.runtimeType &&
          iconStyle == other.iconStyle &&
          background == other.background &&
          enterDuration == other.enterDuration &&
          pixelsPerSecond == other.pixelsPerSecond);

  @override
  int get hashCode => iconStyle.hashCode ^ background.hashCode ^ enterDuration.hashCode ^ pixelsPerSecond.hashCode;
}

/// A delta that applies modifications to a [FSelectScrollHandleStyle].
///
/// A [FSelectScrollHandleStyle] is itself a [FSelectScrollHandleStyleDelta].
abstract class FSelectScrollHandleStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectScrollHandleStyle].
  ///
  /// ## Parameters
  /// * [FSelectScrollHandleStyle.iconStyle] - The handle icon's style.
  /// * [FSelectScrollHandleStyle.background] - The background color.
  /// * [FSelectScrollHandleStyle.enterDuration] - The duration to wait before scrolling.
  /// * [FSelectScrollHandleStyle.pixelsPerSecond] - The number of pixels to scroll per second.
  const factory FSelectScrollHandleStyleDelta.delta({
    IconThemeDataDelta? iconStyle,
    Color? background,
    Duration? enterDuration,
    double? pixelsPerSecond,
  }) = _FSelectScrollHandleStyleDelta;

  /// Creates a delta that returns the [FSelectScrollHandleStyle] in the current context.
  const factory FSelectScrollHandleStyleDelta.context() = _FSelectScrollHandleStyleContext;

  @override
  FSelectScrollHandleStyle call(covariant FSelectScrollHandleStyle value);
}

class _FSelectScrollHandleStyleDelta implements FSelectScrollHandleStyleDelta {
  const _FSelectScrollHandleStyleDelta({this.iconStyle, this.background, this.enterDuration, this.pixelsPerSecond});

  final IconThemeDataDelta? iconStyle;

  final Color? background;

  final Duration? enterDuration;

  final double? pixelsPerSecond;

  @override
  FSelectScrollHandleStyle call(FSelectScrollHandleStyle original) => FSelectScrollHandleStyle(
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    background: background ?? original.background,
    enterDuration: enterDuration ?? original.enterDuration,
    pixelsPerSecond: pixelsPerSecond ?? original.pixelsPerSecond,
  );
}

class _FSelectScrollHandleStyleContext implements FSelectScrollHandleStyleDelta {
  const _FSelectScrollHandleStyleContext();

  @override
  FSelectScrollHandleStyle call(FSelectScrollHandleStyle original) => original;
}

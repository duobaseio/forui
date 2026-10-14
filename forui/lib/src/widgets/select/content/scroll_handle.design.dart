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
  /// * [FSelectScrollHandleStyle.background] - The background color.
  /// * [FSelectScrollHandleStyle.iconStyle] - The handle icon's style.
  /// * [FSelectScrollHandleStyle.upIcon] - The up scroll handle icon builder.
  /// * [FSelectScrollHandleStyle.downIcon] - The down scroll handle icon builder.
  /// * [FSelectScrollHandleStyle.enterDuration] - The duration to wait before scrolling.
  /// * [FSelectScrollHandleStyle.pixelsPerSecond] - The number of pixels to scroll per second.
  @useResult
  FSelectScrollHandleStyle copyWith({
    Color? background,
    IconThemeDataDelta? iconStyle,
    FIcon? upIcon,
    FIcon? downIcon,
    Duration? enterDuration,
    double? pixelsPerSecond,
  }) => .new(
    background: background ?? this.background,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    upIcon: upIcon ?? this.upIcon,
    downIcon: downIcon ?? this.downIcon,
    enterDuration: enterDuration ?? this.enterDuration,
    pixelsPerSecond: pixelsPerSecond ?? this.pixelsPerSecond,
  );

  /// Linearly interpolate between this and another [FSelectScrollHandleStyle] using the given factor [t].
  @useResult
  FSelectScrollHandleStyle lerp(FSelectScrollHandleStyle other, double t) => .new(
    background: FColors.lerpColor(background, other.background, t) ?? background,
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    upIcon: t < 0.5 ? upIcon : other.upIcon,
    downIcon: t < 0.5 ? downIcon : other.downIcon,
    enterDuration: t < 0.5 ? enterDuration : other.enterDuration,
    pixelsPerSecond: lerpDouble(pixelsPerSecond, other.pixelsPerSecond, t) ?? pixelsPerSecond,
  );
}

mixin _$FSelectScrollHandleStyleFunctions on Diagnosticable implements FSelectScrollHandleStyleDelta {
  /// Returns itself.
  @override
  FSelectScrollHandleStyle call(Object _) => this as FSelectScrollHandleStyle;

  Color get background;
  IconThemeData get iconStyle;
  FIcon get upIcon;
  FIcon get downIcon;
  Duration get enterDuration;
  double get pixelsPerSecond;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('background', background, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('upIcon', upIcon, level: .debug))
      ..add(DiagnosticsProperty('downIcon', downIcon, level: .debug))
      ..add(DiagnosticsProperty('enterDuration', enterDuration, level: .debug))
      ..add(DoubleProperty('pixelsPerSecond', pixelsPerSecond, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectScrollHandleStyle &&
          runtimeType == other.runtimeType &&
          background == other.background &&
          iconStyle == other.iconStyle &&
          upIcon == other.upIcon &&
          downIcon == other.downIcon &&
          enterDuration == other.enterDuration &&
          pixelsPerSecond == other.pixelsPerSecond);

  @override
  int get hashCode =>
      background.hashCode ^
      iconStyle.hashCode ^
      upIcon.hashCode ^
      downIcon.hashCode ^
      enterDuration.hashCode ^
      pixelsPerSecond.hashCode;
}

/// A delta that applies modifications to a [FSelectScrollHandleStyle].
///
/// A [FSelectScrollHandleStyle] is itself a [FSelectScrollHandleStyleDelta].
abstract class FSelectScrollHandleStyleDelta with Delta {
  /// Creates a partial modification of a [FSelectScrollHandleStyle].
  ///
  /// ## Parameters
  /// * [FSelectScrollHandleStyle.background] - The background color.
  /// * [FSelectScrollHandleStyle.iconStyle] - The handle icon's style.
  /// * [FSelectScrollHandleStyle.upIcon] - The up scroll handle icon builder.
  /// * [FSelectScrollHandleStyle.downIcon] - The down scroll handle icon builder.
  /// * [FSelectScrollHandleStyle.enterDuration] - The duration to wait before scrolling.
  /// * [FSelectScrollHandleStyle.pixelsPerSecond] - The number of pixels to scroll per second.
  const factory delta({
    Color? background,
    IconThemeDataDelta? iconStyle,
    FIcon? upIcon,
    FIcon? downIcon,
    Duration? enterDuration,
    double? pixelsPerSecond,
  }) = _FSelectScrollHandleStyleDelta;

  /// Creates a delta that returns the [FSelectScrollHandleStyle] in the current context.
  const factory context() = _FSelectScrollHandleStyleContext;

  @override
  FSelectScrollHandleStyle call(covariant FSelectScrollHandleStyle value);
}

class _FSelectScrollHandleStyleDelta implements FSelectScrollHandleStyleDelta {
  const new({this.background, this.iconStyle, this.upIcon, this.downIcon, this.enterDuration, this.pixelsPerSecond});

  final Color? background;

  final IconThemeDataDelta? iconStyle;

  final FIcon? upIcon;

  final FIcon? downIcon;

  final Duration? enterDuration;

  final double? pixelsPerSecond;

  @override
  FSelectScrollHandleStyle call(FSelectScrollHandleStyle original) => FSelectScrollHandleStyle(
    background: background ?? original.background,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    upIcon: upIcon ?? original.upIcon,
    downIcon: downIcon ?? original.downIcon,
    enterDuration: enterDuration ?? original.enterDuration,
    pixelsPerSecond: pixelsPerSecond ?? original.pixelsPerSecond,
  );
}

class _FSelectScrollHandleStyleContext implements FSelectScrollHandleStyleDelta {
  const new();

  @override
  FSelectScrollHandleStyle call(FSelectScrollHandleStyle original) => original;
}

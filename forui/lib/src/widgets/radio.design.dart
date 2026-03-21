// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'radio.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Represents a combination of variants.
///
/// See also:
/// * [FRadioVariant], which represents individual variants.
extension type const FRadioVariantConstraint._(FVariantConstraint _) implements FVariantConstraint {
  /// Creates a [FRadioVariantConstraint] that negates [variant].
  factory FRadioVariantConstraint.not(FRadioVariant variant) => FRadioVariantConstraint._(Not(variant));

  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FRadioVariant.disabled;

  /// The semantic variant when this widget is in an error state.
  static const error = FRadioVariant.error;

  /// The semantic variant when this widget is selected.
  static const selected = FRadioVariant.selected;

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FRadioVariant.focused;

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FRadioVariant.hovered;

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FRadioVariant.pressed;

  /// A platform variant that matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FRadioVariant._(Touch());

  /// A platform variant that matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FRadioVariant._(Desktop());

  /// The Android platform variant.
  static const android = FRadioVariant.android;

  /// The iOS platform variant.
  static const iOS = FRadioVariant.iOS;

  /// The Fuchsia platform variant.
  static const fuchsia = FRadioVariant.fuchsia;

  /// The Windows platform variant.
  static const windows = FRadioVariant.windows;

  /// The macOS platform variant.
  static const macOS = FRadioVariant.macOS;

  /// The Linux platform variant.
  static const linux = FRadioVariant.linux;

  /// The web platform variant.
  static const web = FRadioVariant.web;

  /// Combines this with [other] using a logical AND operation.
  FRadioVariantConstraint and(FRadioVariantConstraint other) => FRadioVariantConstraint._(And(this, other));
}

/// Represents a variant.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence during resolution.
///
/// See also:
/// * [FRadioVariantConstraint], which represents combinations of variants.
extension type const FRadioVariant._(FVariant _) implements FRadioVariantConstraint, FVariant {
  /// The semantic variant when this widget is disabled and cannot be interacted with.
  static const disabled = FRadioVariant._(.new(2, 'disabled'));

  /// The semantic variant when this widget is in an error state.
  static const error = FRadioVariant._(.new(2, 'error'));

  /// The semantic variant when this widget is selected.
  static const selected = FRadioVariant._(.new(2, 'selected'));

  /// The interaction variant when the given widget or any of its descendants have focus.
  static const focused = FRadioVariant._(.new(1, 'focused'));

  /// The interaction variant when the user drags their mouse cursor over the given widget.
  static const hovered = FRadioVariant._(.new(1, 'hovered'));

  /// The interaction variant when the user is actively pressing down on the given widget.
  static const pressed = FRadioVariant._(.new(1, 'pressed'));

  /// The Android platform variant.
  static const android = FRadioVariant._(FPlatformVariant.android);

  /// The iOS platform variant.
  static const iOS = FRadioVariant._(FPlatformVariant.iOS);

  /// The Fuchsia platform variant.
  static const fuchsia = FRadioVariant._(FPlatformVariant.fuchsia);

  /// The Windows platform variant.
  static const windows = FRadioVariant._(FPlatformVariant.windows);

  /// The macOS platform variant.
  static const macOS = FRadioVariant._(FPlatformVariant.macOS);

  /// The Linux platform variant.
  static const linux = FRadioVariant._(FPlatformVariant.linux);

  /// The web platform variant.
  static const web = FRadioVariant._(FPlatformVariant.web);
}

/// Provides [copyWith] and [lerp] methods.
extension $FRadioStyleTransformations on FRadioStyle {
  /// Returns a copy of this [FRadioStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FRadioStyle.tappableStyle] - The tappable style.
  /// * [FRadioStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FRadioStyle.padding] - The padding between the border and indicator circles.
  /// * [FRadioStyle.borderColor] - The [FRadio]'s border color.
  /// * [FRadioStyle.borderWidth] - The border width.
  /// * [FRadioStyle.backgroundColor] - The [FRadio]'s background color.
  /// * [FRadioStyle.indicatorColor] - The [FRadio]'s indicator color.
  /// * [FRadioStyle.indicatorSize] - The inner indicator's size.
  /// * [FRadioStyle.motion] - The motion-related properties.
  /// * [FRadioStyle.labelPadding] - The label's padding.
  /// * [FRadioStyle.descriptionPadding] - The description's padding.
  /// * [FRadioStyle.errorPadding] - The error's padding.
  /// * [FRadioStyle.childPadding] - The child's padding.
  /// * [FRadioStyle.labelMotion] - The motion properties for error animations.
  /// * [FRadioStyle.labelTextStyle] - The label's text style.
  /// * [FRadioStyle.descriptionTextStyle] - The description's text style.
  /// * [FRadioStyle.errorTextStyle] - The error's text style.
  @useResult
  FRadioStyle copyWith({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? borderColor,
    double? borderWidth,
    FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? backgroundColor,
    FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? indicatorColor,
    double? indicatorSize,
    FRadioMotionDelta? motion,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    borderColor: borderColor?.call(this.borderColor) ?? this.borderColor,
    borderWidth: borderWidth ?? this.borderWidth,
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    indicatorColor: indicatorColor?.call(this.indicatorColor) ?? this.indicatorColor,
    indicatorSize: indicatorSize ?? this.indicatorSize,
    motion: motion?.call(this.motion) ?? this.motion,
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FRadioStyle] using the given factor [t].
  @useResult
  FRadioStyle lerp(FRadioStyle other, double t) => .new(
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    borderColor: .lerpColor(borderColor, other.borderColor, t),
    borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    indicatorColor: .lerpColor(indicatorColor, other.indicatorColor, t),
    indicatorSize: lerpDouble(indicatorSize, other.indicatorSize, t) ?? indicatorSize,
    motion: motion.lerp(other.motion, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelMotion: labelMotion.lerp(other.labelMotion, t),
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerpTextStyle(errorTextStyle, other.errorTextStyle, t),
  );
}

mixin _$FRadioStyleFunctions on Diagnosticable implements FRadioStyleDelta {
  /// Returns itself.
  @override
  FRadioStyle call(Object _) => this as FRadioStyle;

  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  EdgeInsetsGeometry get padding;
  FVariants<FRadioVariantConstraint, FRadioVariant, Color, Delta> get borderColor;
  double get borderWidth;
  FVariants<FRadioVariantConstraint, FRadioVariant, Color, Delta> get backgroundColor;
  FVariants<FRadioVariantConstraint, FRadioVariant, Color, Delta> get indicatorColor;
  double get indicatorSize;
  FRadioMotion get motion;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FLabelMotion get labelMotion;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get labelTextStyle;
  FVariants<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta> get descriptionTextStyle;
  FVariants<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta> get errorTextStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DoubleProperty('borderWidth', borderWidth, level: .debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('indicatorColor', indicatorColor, level: .debug))
      ..add(DoubleProperty('indicatorSize', indicatorSize, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioStyle &&
          runtimeType == other.runtimeType &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          padding == other.padding &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          backgroundColor == other.backgroundColor &&
          indicatorColor == other.indicatorColor &&
          indicatorSize == other.indicatorSize &&
          motion == other.motion &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelMotion == other.labelMotion &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      padding.hashCode ^
      borderColor.hashCode ^
      borderWidth.hashCode ^
      backgroundColor.hashCode ^
      indicatorColor.hashCode ^
      indicatorSize.hashCode ^
      motion.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FRadioStyle].
///
/// A [FRadioStyle] is itself a [FRadioStyleDelta].
abstract class FRadioStyleDelta with Delta {
  /// Creates a partial modification of a [FRadioStyle].
  ///
  /// ## Parameters
  /// * [FRadioStyle.tappableStyle] - The tappable style.
  /// * [FRadioStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FRadioStyle.padding] - The padding between the border and indicator circles.
  /// * [FRadioStyle.borderColor] - The [FRadio]'s border color.
  /// * [FRadioStyle.borderWidth] - The border width.
  /// * [FRadioStyle.backgroundColor] - The [FRadio]'s background color.
  /// * [FRadioStyle.indicatorColor] - The [FRadio]'s indicator color.
  /// * [FRadioStyle.indicatorSize] - The inner indicator's size.
  /// * [FRadioStyle.motion] - The motion-related properties.
  /// * [FRadioStyle.labelPadding] - The label's padding.
  /// * [FRadioStyle.descriptionPadding] - The description's padding.
  /// * [FRadioStyle.errorPadding] - The error's padding.
  /// * [FRadioStyle.childPadding] - The child's padding.
  /// * [FRadioStyle.labelMotion] - The motion properties for error animations.
  /// * [FRadioStyle.labelTextStyle] - The label's text style.
  /// * [FRadioStyle.descriptionTextStyle] - The description's text style.
  /// * [FRadioStyle.errorTextStyle] - The error's text style.
  const factory FRadioStyleDelta.delta({
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    EdgeInsetsGeometryDelta? padding,
    FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? borderColor,
    double? borderWidth,
    FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? backgroundColor,
    FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? indicatorColor,
    double? indicatorSize,
    FRadioMotionDelta? motion,
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FRadioStyleDelta;

  /// Creates a delta that returns the [FRadioStyle] in the current context.
  const factory FRadioStyleDelta.context() = _FRadioStyleContext;

  @override
  FRadioStyle call(covariant FRadioStyle value);
}

class _FRadioStyleDelta implements FRadioStyleDelta {
  const _FRadioStyleDelta({
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.indicatorColor,
    this.indicatorSize,
    this.motion,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final EdgeInsetsGeometryDelta? padding;

  final FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? borderColor;

  final double? borderWidth;

  final FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? backgroundColor;

  final FVariantsValueDelta<FRadioVariantConstraint, FRadioVariant, Color, Delta>? indicatorColor;

  final double? indicatorSize;

  final FRadioMotionDelta? motion;

  final EdgeInsetsGeometryDelta? labelPadding;

  final EdgeInsetsGeometryDelta? descriptionPadding;

  final EdgeInsetsGeometryDelta? errorPadding;

  final EdgeInsetsGeometryDelta? childPadding;

  final FLabelMotionDelta? labelMotion;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle;

  final FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle;

  final FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>?
  errorTextStyle;

  @override
  FRadioStyle call(FRadioStyle original) => FRadioStyle(
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    borderColor: borderColor?.call(original.borderColor) ?? original.borderColor,
    borderWidth: borderWidth ?? original.borderWidth,
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    indicatorColor: indicatorColor?.call(original.indicatorColor) ?? original.indicatorColor,
    indicatorSize: indicatorSize ?? original.indicatorSize,
    motion: motion?.call(original.motion) ?? original.motion,
    labelPadding: labelPadding?.call(original.labelPadding) ?? original.labelPadding,
    descriptionPadding: descriptionPadding?.call(original.descriptionPadding) ?? original.descriptionPadding,
    errorPadding: errorPadding?.call(original.errorPadding) ?? original.errorPadding,
    childPadding: childPadding?.call(original.childPadding) ?? original.childPadding,
    labelMotion: labelMotion?.call(original.labelMotion) ?? original.labelMotion,
    labelTextStyle: labelTextStyle?.call(original.labelTextStyle) ?? original.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(original.descriptionTextStyle) ?? original.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(original.errorTextStyle) ?? original.errorTextStyle,
  );
}

class _FRadioStyleContext implements FRadioStyleDelta {
  const _FRadioStyleContext();

  @override
  FRadioStyle call(FRadioStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FRadioMotionTransformations on FRadioMotion {
  /// Returns a copy of this [FRadioMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FRadioMotion.transitionDuration] - The duration of the transition between states.
  /// * [FRadioMotion.transitionCurve] - The curve of the transition between states.
  /// * [FRadioMotion.selectDuration] - The duration of the animation when selected.
  /// * [FRadioMotion.unselectDuration] - The duration of the animation when unselected.
  /// * [FRadioMotion.selectCurve] - The curve of the select & unselect animation.
  @useResult
  FRadioMotion copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    Duration? selectDuration,
    Duration? unselectDuration,
    Curve? selectCurve,
  }) => .new(
    transitionDuration: transitionDuration ?? this.transitionDuration,
    transitionCurve: transitionCurve ?? this.transitionCurve,
    selectDuration: selectDuration ?? this.selectDuration,
    unselectDuration: unselectDuration ?? this.unselectDuration,
    selectCurve: selectCurve ?? this.selectCurve,
  );

  /// Linearly interpolate between this and another [FRadioMotion] using the given factor [t].
  @useResult
  FRadioMotion lerp(FRadioMotion other, double t) => .new(
    transitionDuration: t < 0.5 ? transitionDuration : other.transitionDuration,
    transitionCurve: t < 0.5 ? transitionCurve : other.transitionCurve,
    selectDuration: t < 0.5 ? selectDuration : other.selectDuration,
    unselectDuration: t < 0.5 ? unselectDuration : other.unselectDuration,
    selectCurve: t < 0.5 ? selectCurve : other.selectCurve,
  );
}

mixin _$FRadioMotionFunctions on Diagnosticable implements FRadioMotionDelta {
  /// Returns itself.
  @override
  FRadioMotion call(Object _) => this as FRadioMotion;

  Duration get transitionDuration;
  Curve get transitionCurve;
  Duration get selectDuration;
  Duration get unselectDuration;
  Curve get selectCurve;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('transitionDuration', transitionDuration, level: .debug))
      ..add(DiagnosticsProperty('transitionCurve', transitionCurve, level: .debug))
      ..add(DiagnosticsProperty('selectDuration', selectDuration, level: .debug))
      ..add(DiagnosticsProperty('unselectDuration', unselectDuration, level: .debug))
      ..add(DiagnosticsProperty('selectCurve', selectCurve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioMotion &&
          runtimeType == other.runtimeType &&
          transitionDuration == other.transitionDuration &&
          transitionCurve == other.transitionCurve &&
          selectDuration == other.selectDuration &&
          unselectDuration == other.unselectDuration &&
          selectCurve == other.selectCurve);

  @override
  int get hashCode =>
      transitionDuration.hashCode ^
      transitionCurve.hashCode ^
      selectDuration.hashCode ^
      unselectDuration.hashCode ^
      selectCurve.hashCode;
}

/// A delta that applies modifications to a [FRadioMotion].
///
/// A [FRadioMotion] is itself a [FRadioMotionDelta].
abstract class FRadioMotionDelta with Delta {
  /// Creates a partial modification of a [FRadioMotion].
  ///
  /// ## Parameters
  /// * [FRadioMotion.transitionDuration] - The duration of the transition between states.
  /// * [FRadioMotion.transitionCurve] - The curve of the transition between states.
  /// * [FRadioMotion.selectDuration] - The duration of the animation when selected.
  /// * [FRadioMotion.unselectDuration] - The duration of the animation when unselected.
  /// * [FRadioMotion.selectCurve] - The curve of the select & unselect animation.
  const factory FRadioMotionDelta.delta({
    Duration? transitionDuration,
    Curve? transitionCurve,
    Duration? selectDuration,
    Duration? unselectDuration,
    Curve? selectCurve,
  }) = _FRadioMotionDelta;

  /// Creates a delta that returns the [FRadioMotion] in the current context.
  const factory FRadioMotionDelta.context() = _FRadioMotionContext;

  @override
  FRadioMotion call(covariant FRadioMotion value);
}

class _FRadioMotionDelta implements FRadioMotionDelta {
  const _FRadioMotionDelta({
    this.transitionDuration,
    this.transitionCurve,
    this.selectDuration,
    this.unselectDuration,
    this.selectCurve,
  });

  final Duration? transitionDuration;

  final Curve? transitionCurve;

  final Duration? selectDuration;

  final Duration? unselectDuration;

  final Curve? selectCurve;

  @override
  FRadioMotion call(FRadioMotion original) => FRadioMotion(
    transitionDuration: transitionDuration ?? original.transitionDuration,
    transitionCurve: transitionCurve ?? original.transitionCurve,
    selectDuration: selectDuration ?? original.selectDuration,
    unselectDuration: unselectDuration ?? original.unselectDuration,
    selectCurve: selectCurve ?? original.selectCurve,
  );
}

class _FRadioMotionContext implements FRadioMotionDelta {
  const _FRadioMotionContext();

  @override
  FRadioMotion call(FRadioMotion original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'label.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FLabelStylesTransformations on FLabelStyles {
  /// Returns a copy of this [FLabelStyles] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FLabelStyles.horizontalStyle] - The horizontal label's style.
  /// * [FLabelStyles.verticalStyle] - The vertical label's style.
  @useResult
  FLabelStyles copyWith({FLabelStyleDelta? horizontalStyle, FLabelStyleDelta? verticalStyle}) => .new(
    horizontalStyle: horizontalStyle?.call(this.horizontalStyle) ?? this.horizontalStyle,
    verticalStyle: verticalStyle?.call(this.verticalStyle) ?? this.verticalStyle,
  );

  /// Linearly interpolate between this and another [FLabelStyles] using the given factor [t].
  @useResult
  FLabelStyles lerp(FLabelStyles other, double t) => .new(
    horizontalStyle: horizontalStyle.lerp(other.horizontalStyle, t),
    verticalStyle: verticalStyle.lerp(other.verticalStyle, t),
  );
}

mixin _$FLabelStylesFunctions on Diagnosticable implements FLabelStylesDelta {
  /// Returns itself.
  @override
  FLabelStyles call(Object _) => this as FLabelStyles;

  FLabelStyle get horizontalStyle;
  FLabelStyle get verticalStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle, level: .debug))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLabelStyles &&
          runtimeType == other.runtimeType &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle);

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// A delta that applies modifications to a [FLabelStyles].
///
/// A [FLabelStyles] is itself a [FLabelStylesDelta].
abstract class FLabelStylesDelta with Delta {
  /// Creates a partial modification of a [FLabelStyles].
  ///
  /// ## Parameters
  /// * [FLabelStyles.horizontalStyle] - The horizontal label's style.
  /// * [FLabelStyles.verticalStyle] - The vertical label's style.
  const factory FLabelStylesDelta.delta({FLabelStyleDelta? horizontalStyle, FLabelStyleDelta? verticalStyle}) =
      _FLabelStylesDelta;

  /// Creates a delta that returns the [FLabelStyles] in the current context.
  const factory FLabelStylesDelta.context() = _FLabelStylesContext;

  @override
  FLabelStyles call(covariant FLabelStyles value);
}

class _FLabelStylesDelta implements FLabelStylesDelta {
  const _FLabelStylesDelta({this.horizontalStyle, this.verticalStyle});

  final FLabelStyleDelta? horizontalStyle;

  final FLabelStyleDelta? verticalStyle;

  @override
  FLabelStyles call(FLabelStyles original) => FLabelStyles(
    horizontalStyle: horizontalStyle?.call(original.horizontalStyle) ?? original.horizontalStyle,
    verticalStyle: verticalStyle?.call(original.verticalStyle) ?? original.verticalStyle,
  );
}

class _FLabelStylesContext implements FLabelStylesDelta {
  const _FLabelStylesContext();

  @override
  FLabelStyles call(FLabelStyles original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FLabelStyleTransformations on FLabelStyle {
  /// Returns a copy of this [FLabelStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FLabelStyle.labelPadding] - The label's padding.
  /// * [FLabelStyle.descriptionPadding] - The description's padding.
  /// * [FLabelStyle.errorPadding] - The error's padding.
  /// * [FLabelStyle.childPadding] - The child's padding.
  /// * [FLabelStyle.labelMotion] - The motion properties for error animations.
  /// * [FLabelStyle.labelTextStyle] - The label's text style.
  /// * [FLabelStyle.descriptionTextStyle] - The description's text style.
  /// * [FLabelStyle.errorTextStyle] - The error's text style.
  @useResult
  FLabelStyle copyWith({
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) => .new(
    labelPadding: labelPadding?.call(this.labelPadding) ?? this.labelPadding,
    descriptionPadding: descriptionPadding?.call(this.descriptionPadding) ?? this.descriptionPadding,
    errorPadding: errorPadding?.call(this.errorPadding) ?? this.errorPadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    labelMotion: labelMotion?.call(this.labelMotion) ?? this.labelMotion,
    labelTextStyle: labelTextStyle?.call(this.labelTextStyle) ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle?.call(this.descriptionTextStyle) ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle?.call(this.errorTextStyle) ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FLabelStyle] using the given factor [t].
  @useResult
  FLabelStyle lerp(FLabelStyle other, double t) => .new(
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

mixin _$FLabelStyleFunctions on Diagnosticable implements FLabelStyleDelta {
  /// Returns itself.
  @override
  FLabelStyle call(Object _) => this as FLabelStyle;

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
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: .debug))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding, level: .debug))
      ..add(DiagnosticsProperty('errorPadding', errorPadding, level: .debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: .debug))
      ..add(DiagnosticsProperty('labelMotion', labelMotion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLabelStyle &&
          runtimeType == other.runtimeType &&
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
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelMotion.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A delta that applies modifications to a [FLabelStyle].
///
/// A [FLabelStyle] is itself a [FLabelStyleDelta].
abstract class FLabelStyleDelta with Delta {
  /// Creates a partial modification of a [FLabelStyle].
  ///
  /// ## Parameters
  /// * [FLabelStyle.labelPadding] - The label's padding.
  /// * [FLabelStyle.descriptionPadding] - The description's padding.
  /// * [FLabelStyle.errorPadding] - The error's padding.
  /// * [FLabelStyle.childPadding] - The child's padding.
  /// * [FLabelStyle.labelMotion] - The motion properties for error animations.
  /// * [FLabelStyle.labelTextStyle] - The label's text style.
  /// * [FLabelStyle.descriptionTextStyle] - The description's text style.
  /// * [FLabelStyle.errorTextStyle] - The error's text style.
  const factory FLabelStyleDelta.delta({
    EdgeInsetsGeometryDelta? labelPadding,
    EdgeInsetsGeometryDelta? descriptionPadding,
    EdgeInsetsGeometryDelta? errorPadding,
    EdgeInsetsGeometryDelta? childPadding,
    FLabelMotionDelta? labelMotion,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? labelTextStyle,
    FVariantsDelta<FFormFieldVariantConstraint, FFormFieldVariant, TextStyle, TextStyleDelta>? descriptionTextStyle,
    FVariantsDelta<FFormFieldErrorVariantConstraint, FFormFieldErrorVariant, TextStyle, TextStyleDelta>? errorTextStyle,
  }) = _FLabelStyleDelta;

  /// Creates a delta that returns the [FLabelStyle] in the current context.
  const factory FLabelStyleDelta.context() = _FLabelStyleContext;

  @override
  FLabelStyle call(covariant FLabelStyle value);
}

class _FLabelStyleDelta implements FLabelStyleDelta {
  const _FLabelStyleDelta({
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.childPadding,
    this.labelMotion,
    this.labelTextStyle,
    this.descriptionTextStyle,
    this.errorTextStyle,
  });

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
  FLabelStyle call(FLabelStyle original) => FLabelStyle(
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

class _FLabelStyleContext implements FLabelStyleDelta {
  const _FLabelStyleContext();

  @override
  FLabelStyle call(FLabelStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FLabelMotionTransformations on FLabelMotion {
  /// Returns a copy of this [FLabelMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FLabelMotion.textStyleTransitionDuration] - The text style transition duration.
  /// * [FLabelMotion.textStyleTransitionCurve] - The text style transition curve.
  /// * [FLabelMotion.errorExpandDuration] - The error expansion duration.
  /// * [FLabelMotion.errorCollapseDuration] - The error collapse duration.
  /// * [FLabelMotion.errorExpandCurve] - The error expansion curve.
  /// * [FLabelMotion.errorCollapseCurve] - The error collapse curve.
  /// * [FLabelMotion.errorFadeInDuration] - The error fade in duration.
  /// * [FLabelMotion.errorFadeOutDuration] - The error fade out duration.
  /// * [FLabelMotion.errorFadeInCurve] - The error fade in curve.
  /// * [FLabelMotion.errorFadeOutCurve] - The error fade out curve.
  /// * [FLabelMotion.errorFadeTween] - The error fade tween.
  @useResult
  FLabelMotion copyWith({
    Duration? textStyleTransitionDuration,
    Curve? textStyleTransitionCurve,
    Duration? errorExpandDuration,
    Duration? errorCollapseDuration,
    Curve? errorExpandCurve,
    Curve? errorCollapseCurve,
    Duration? errorFadeInDuration,
    Duration? errorFadeOutDuration,
    Curve? errorFadeInCurve,
    Curve? errorFadeOutCurve,
    Animatable<double>? errorFadeTween,
  }) => .new(
    textStyleTransitionDuration: textStyleTransitionDuration ?? this.textStyleTransitionDuration,
    textStyleTransitionCurve: textStyleTransitionCurve ?? this.textStyleTransitionCurve,
    errorExpandDuration: errorExpandDuration ?? this.errorExpandDuration,
    errorCollapseDuration: errorCollapseDuration ?? this.errorCollapseDuration,
    errorExpandCurve: errorExpandCurve ?? this.errorExpandCurve,
    errorCollapseCurve: errorCollapseCurve ?? this.errorCollapseCurve,
    errorFadeInDuration: errorFadeInDuration ?? this.errorFadeInDuration,
    errorFadeOutDuration: errorFadeOutDuration ?? this.errorFadeOutDuration,
    errorFadeInCurve: errorFadeInCurve ?? this.errorFadeInCurve,
    errorFadeOutCurve: errorFadeOutCurve ?? this.errorFadeOutCurve,
    errorFadeTween: errorFadeTween ?? this.errorFadeTween,
  );

  /// Linearly interpolate between this and another [FLabelMotion] using the given factor [t].
  @useResult
  FLabelMotion lerp(FLabelMotion other, double t) => .new(
    textStyleTransitionDuration: t < 0.5 ? textStyleTransitionDuration : other.textStyleTransitionDuration,
    textStyleTransitionCurve: t < 0.5 ? textStyleTransitionCurve : other.textStyleTransitionCurve,
    errorExpandDuration: t < 0.5 ? errorExpandDuration : other.errorExpandDuration,
    errorCollapseDuration: t < 0.5 ? errorCollapseDuration : other.errorCollapseDuration,
    errorExpandCurve: t < 0.5 ? errorExpandCurve : other.errorExpandCurve,
    errorCollapseCurve: t < 0.5 ? errorCollapseCurve : other.errorCollapseCurve,
    errorFadeInDuration: t < 0.5 ? errorFadeInDuration : other.errorFadeInDuration,
    errorFadeOutDuration: t < 0.5 ? errorFadeOutDuration : other.errorFadeOutDuration,
    errorFadeInCurve: t < 0.5 ? errorFadeInCurve : other.errorFadeInCurve,
    errorFadeOutCurve: t < 0.5 ? errorFadeOutCurve : other.errorFadeOutCurve,
    errorFadeTween: t < 0.5 ? errorFadeTween : other.errorFadeTween,
  );
}

mixin _$FLabelMotionFunctions on Diagnosticable implements FLabelMotionDelta {
  /// Returns itself.
  @override
  FLabelMotion call(Object _) => this as FLabelMotion;

  Duration get textStyleTransitionDuration;
  Curve get textStyleTransitionCurve;
  Duration get errorExpandDuration;
  Duration get errorCollapseDuration;
  Curve get errorExpandCurve;
  Curve get errorCollapseCurve;
  Duration get errorFadeInDuration;
  Duration get errorFadeOutDuration;
  Curve get errorFadeInCurve;
  Curve get errorFadeOutCurve;
  Animatable<double> get errorFadeTween;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyleTransitionDuration', textStyleTransitionDuration, level: .debug))
      ..add(DiagnosticsProperty('textStyleTransitionCurve', textStyleTransitionCurve, level: .debug))
      ..add(DiagnosticsProperty('errorExpandDuration', errorExpandDuration, level: .debug))
      ..add(DiagnosticsProperty('errorCollapseDuration', errorCollapseDuration, level: .debug))
      ..add(DiagnosticsProperty('errorExpandCurve', errorExpandCurve, level: .debug))
      ..add(DiagnosticsProperty('errorCollapseCurve', errorCollapseCurve, level: .debug))
      ..add(DiagnosticsProperty('errorFadeInDuration', errorFadeInDuration, level: .debug))
      ..add(DiagnosticsProperty('errorFadeOutDuration', errorFadeOutDuration, level: .debug))
      ..add(DiagnosticsProperty('errorFadeInCurve', errorFadeInCurve, level: .debug))
      ..add(DiagnosticsProperty('errorFadeOutCurve', errorFadeOutCurve, level: .debug))
      ..add(DiagnosticsProperty('errorFadeTween', errorFadeTween, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLabelMotion &&
          runtimeType == other.runtimeType &&
          textStyleTransitionDuration == other.textStyleTransitionDuration &&
          textStyleTransitionCurve == other.textStyleTransitionCurve &&
          errorExpandDuration == other.errorExpandDuration &&
          errorCollapseDuration == other.errorCollapseDuration &&
          errorExpandCurve == other.errorExpandCurve &&
          errorCollapseCurve == other.errorCollapseCurve &&
          errorFadeInDuration == other.errorFadeInDuration &&
          errorFadeOutDuration == other.errorFadeOutDuration &&
          errorFadeInCurve == other.errorFadeInCurve &&
          errorFadeOutCurve == other.errorFadeOutCurve &&
          errorFadeTween == other.errorFadeTween);

  @override
  int get hashCode =>
      textStyleTransitionDuration.hashCode ^
      textStyleTransitionCurve.hashCode ^
      errorExpandDuration.hashCode ^
      errorCollapseDuration.hashCode ^
      errorExpandCurve.hashCode ^
      errorCollapseCurve.hashCode ^
      errorFadeInDuration.hashCode ^
      errorFadeOutDuration.hashCode ^
      errorFadeInCurve.hashCode ^
      errorFadeOutCurve.hashCode ^
      errorFadeTween.hashCode;
}

/// A delta that applies modifications to a [FLabelMotion].
///
/// A [FLabelMotion] is itself a [FLabelMotionDelta].
abstract class FLabelMotionDelta with Delta {
  /// Creates a partial modification of a [FLabelMotion].
  ///
  /// ## Parameters
  /// * [FLabelMotion.textStyleTransitionDuration] - The text style transition duration.
  /// * [FLabelMotion.textStyleTransitionCurve] - The text style transition curve.
  /// * [FLabelMotion.errorExpandDuration] - The error expansion duration.
  /// * [FLabelMotion.errorCollapseDuration] - The error collapse duration.
  /// * [FLabelMotion.errorExpandCurve] - The error expansion curve.
  /// * [FLabelMotion.errorCollapseCurve] - The error collapse curve.
  /// * [FLabelMotion.errorFadeInDuration] - The error fade in duration.
  /// * [FLabelMotion.errorFadeOutDuration] - The error fade out duration.
  /// * [FLabelMotion.errorFadeInCurve] - The error fade in curve.
  /// * [FLabelMotion.errorFadeOutCurve] - The error fade out curve.
  /// * [FLabelMotion.errorFadeTween] - The error fade tween.
  const factory FLabelMotionDelta.delta({
    Duration? textStyleTransitionDuration,
    Curve? textStyleTransitionCurve,
    Duration? errorExpandDuration,
    Duration? errorCollapseDuration,
    Curve? errorExpandCurve,
    Curve? errorCollapseCurve,
    Duration? errorFadeInDuration,
    Duration? errorFadeOutDuration,
    Curve? errorFadeInCurve,
    Curve? errorFadeOutCurve,
    Animatable<double>? errorFadeTween,
  }) = _FLabelMotionDelta;

  /// Creates a delta that returns the [FLabelMotion] in the current context.
  const factory FLabelMotionDelta.context() = _FLabelMotionContext;

  @override
  FLabelMotion call(covariant FLabelMotion value);
}

class _FLabelMotionDelta implements FLabelMotionDelta {
  const _FLabelMotionDelta({
    this.textStyleTransitionDuration,
    this.textStyleTransitionCurve,
    this.errorExpandDuration,
    this.errorCollapseDuration,
    this.errorExpandCurve,
    this.errorCollapseCurve,
    this.errorFadeInDuration,
    this.errorFadeOutDuration,
    this.errorFadeInCurve,
    this.errorFadeOutCurve,
    this.errorFadeTween,
  });

  final Duration? textStyleTransitionDuration;

  final Curve? textStyleTransitionCurve;

  final Duration? errorExpandDuration;

  final Duration? errorCollapseDuration;

  final Curve? errorExpandCurve;

  final Curve? errorCollapseCurve;

  final Duration? errorFadeInDuration;

  final Duration? errorFadeOutDuration;

  final Curve? errorFadeInCurve;

  final Curve? errorFadeOutCurve;

  final Animatable<double>? errorFadeTween;

  @override
  FLabelMotion call(FLabelMotion original) => FLabelMotion(
    textStyleTransitionDuration: textStyleTransitionDuration ?? original.textStyleTransitionDuration,
    textStyleTransitionCurve: textStyleTransitionCurve ?? original.textStyleTransitionCurve,
    errorExpandDuration: errorExpandDuration ?? original.errorExpandDuration,
    errorCollapseDuration: errorCollapseDuration ?? original.errorCollapseDuration,
    errorExpandCurve: errorExpandCurve ?? original.errorExpandCurve,
    errorCollapseCurve: errorCollapseCurve ?? original.errorCollapseCurve,
    errorFadeInDuration: errorFadeInDuration ?? original.errorFadeInDuration,
    errorFadeOutDuration: errorFadeOutDuration ?? original.errorFadeOutDuration,
    errorFadeInCurve: errorFadeInCurve ?? original.errorFadeInCurve,
    errorFadeOutCurve: errorFadeOutCurve ?? original.errorFadeOutCurve,
    errorFadeTween: errorFadeTween ?? original.errorFadeTween,
  );
}

class _FLabelMotionContext implements FLabelMotionDelta {
  const _FLabelMotionContext();

  @override
  FLabelMotion call(FLabelMotion original) => original;
}

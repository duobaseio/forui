// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'accordion.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAccordionStyleTransformations on FAccordionStyle {
  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FAccordionStyle.titleTextStyle] - The title's text style.
  /// * [FAccordionStyle.childTextStyle] - The child's default text style.
  /// * [FAccordionStyle.titlePadding] - The padding around the title.
  /// * [FAccordionStyle.childPadding] - The padding around the content.
  /// * [FAccordionStyle.iconStyle] - The icon's style.
  /// * [FAccordionStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FAccordionStyle.dividerStyle] - The divider's color.
  /// * [FAccordionStyle.tappableStyle] - The tappable's style.
  /// * [FAccordionStyle.motion] - The motion-related properties.
  @useResult
  FAccordionStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    TextStyleDelta? childTextStyle,
    EdgeInsetsGeometryDelta? titlePadding,
    EdgeInsetsGeometryDelta? childPadding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FDividerStyleDelta? dividerStyle,
    FTappableStyleDelta? tappableStyle,
    FAccordionMotionDelta? motion,
  }) => .new(
    titleTextStyle: titleTextStyle?.call(this.titleTextStyle) ?? this.titleTextStyle,
    childTextStyle: childTextStyle?.call(this.childTextStyle) ?? this.childTextStyle,
    titlePadding: titlePadding?.call(this.titlePadding) ?? this.titlePadding,
    childPadding: childPadding?.call(this.childPadding) ?? this.childPadding,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    dividerStyle: dividerStyle?.call(this.dividerStyle) ?? this.dividerStyle,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FAccordionStyle] using the given factor [t].
  @useResult
  FAccordionStyle lerp(FAccordionStyle other, double t) => .new(
    titleTextStyle: .lerpTextStyle(titleTextStyle, other.titleTextStyle, t),
    childTextStyle: .lerp(childTextStyle, other.childTextStyle, t) ?? childTextStyle,
    titlePadding: .lerp(titlePadding, other.titlePadding, t) ?? titlePadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FAccordionStyleFunctions on Diagnosticable implements FAccordionStyleDelta {
  /// Returns itself.
  @override
  FAccordionStyle call(Object _) => this as FAccordionStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get titleTextStyle;
  TextStyle get childTextStyle;
  EdgeInsetsGeometry get titlePadding;
  EdgeInsetsGeometry get childPadding;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FDividerStyle get dividerStyle;
  FTappableStyle get tappableStyle;
  FAccordionMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle, level: .debug))
      ..add(DiagnosticsProperty('titlePadding', titlePadding, level: .debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAccordionStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          childTextStyle == other.childTextStyle &&
          titlePadding == other.titlePadding &&
          childPadding == other.childPadding &&
          iconStyle == other.iconStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          dividerStyle == other.dividerStyle &&
          tappableStyle == other.tappableStyle &&
          motion == other.motion);

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      childTextStyle.hashCode ^
      titlePadding.hashCode ^
      childPadding.hashCode ^
      iconStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      dividerStyle.hashCode ^
      tappableStyle.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FAccordionStyle].
///
/// A [FAccordionStyle] is itself a [FAccordionStyleDelta].
abstract class FAccordionStyleDelta with Delta {
  /// Creates a partial modification of a [FAccordionStyle].
  ///
  /// ## Parameters
  /// * [FAccordionStyle.titleTextStyle] - The title's text style.
  /// * [FAccordionStyle.childTextStyle] - The child's default text style.
  /// * [FAccordionStyle.titlePadding] - The padding around the title.
  /// * [FAccordionStyle.childPadding] - The padding around the content.
  /// * [FAccordionStyle.iconStyle] - The icon's style.
  /// * [FAccordionStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FAccordionStyle.dividerStyle] - The divider's color.
  /// * [FAccordionStyle.tappableStyle] - The tappable's style.
  /// * [FAccordionStyle.motion] - The motion-related properties.
  const factory FAccordionStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle,
    TextStyleDelta? childTextStyle,
    EdgeInsetsGeometryDelta? titlePadding,
    EdgeInsetsGeometryDelta? childPadding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    FDividerStyleDelta? dividerStyle,
    FTappableStyleDelta? tappableStyle,
    FAccordionMotionDelta? motion,
  }) = _FAccordionStyleDelta;

  /// Creates a delta that returns the [FAccordionStyle] in the current context.
  const factory FAccordionStyleDelta.context() = _FAccordionStyleContext;

  @override
  FAccordionStyle call(covariant FAccordionStyle value);
}

class _FAccordionStyleDelta implements FAccordionStyleDelta {
  const _FAccordionStyleDelta({
    this.titleTextStyle,
    this.childTextStyle,
    this.titlePadding,
    this.childPadding,
    this.iconStyle,
    this.focusedOutlineStyle,
    this.dividerStyle,
    this.tappableStyle,
    this.motion,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? titleTextStyle;

  final TextStyleDelta? childTextStyle;

  final EdgeInsetsGeometryDelta? titlePadding;

  final EdgeInsetsGeometryDelta? childPadding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final FDividerStyleDelta? dividerStyle;

  final FTappableStyleDelta? tappableStyle;

  final FAccordionMotionDelta? motion;

  @override
  FAccordionStyle call(FAccordionStyle original) => FAccordionStyle(
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    childTextStyle: childTextStyle?.call(original.childTextStyle) ?? original.childTextStyle,
    titlePadding: titlePadding?.call(original.titlePadding) ?? original.titlePadding,
    childPadding: childPadding?.call(original.childPadding) ?? original.childPadding,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    dividerStyle: dividerStyle?.call(original.dividerStyle) ?? original.dividerStyle,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FAccordionStyleContext implements FAccordionStyleDelta {
  const _FAccordionStyleContext();

  @override
  FAccordionStyle call(FAccordionStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FAccordionMotionTransformations on FAccordionMotion {
  /// Returns a copy of this [FAccordionMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FAccordionMotion.expandDuration] - The expand animation's duration.
  /// * [FAccordionMotion.collapseDuration] - The collapse animation's duration.
  /// * [FAccordionMotion.expandCurve] - The expand animation's curve.
  /// * [FAccordionMotion.collapseCurve] - The collapse animation's curve.
  /// * [FAccordionMotion.iconExpandCurve] - The icon's animation curve when expanding.
  /// * [FAccordionMotion.iconCollapseCurve] - The icon's animation curve when collapsing.
  /// * [FAccordionMotion.revealTween] - The reveal animation's tween.
  /// * [FAccordionMotion.iconTween] - The icon animation's tween.
  @useResult
  FAccordionMotion copyWith({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? iconExpandCurve,
    Curve? iconCollapseCurve,
    Animatable<double>? revealTween,
    Animatable<double>? iconTween,
  }) => .new(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    iconExpandCurve: iconExpandCurve ?? this.iconExpandCurve,
    iconCollapseCurve: iconCollapseCurve ?? this.iconCollapseCurve,
    revealTween: revealTween ?? this.revealTween,
    iconTween: iconTween ?? this.iconTween,
  );

  /// Linearly interpolate between this and another [FAccordionMotion] using the given factor [t].
  @useResult
  FAccordionMotion lerp(FAccordionMotion other, double t) => .new(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    iconExpandCurve: t < 0.5 ? iconExpandCurve : other.iconExpandCurve,
    iconCollapseCurve: t < 0.5 ? iconCollapseCurve : other.iconCollapseCurve,
    revealTween: t < 0.5 ? revealTween : other.revealTween,
    iconTween: t < 0.5 ? iconTween : other.iconTween,
  );
}

mixin _$FAccordionMotionFunctions on Diagnosticable implements FAccordionMotionDelta {
  /// Returns itself.
  @override
  FAccordionMotion call(Object _) => this as FAccordionMotion;

  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get iconExpandCurve;
  Curve get iconCollapseCurve;
  Animatable<double> get revealTween;
  Animatable<double> get iconTween;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: .debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: .debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: .debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: .debug))
      ..add(DiagnosticsProperty('iconExpandCurve', iconExpandCurve, level: .debug))
      ..add(DiagnosticsProperty('iconCollapseCurve', iconCollapseCurve, level: .debug))
      ..add(DiagnosticsProperty('revealTween', revealTween, level: .debug))
      ..add(DiagnosticsProperty('iconTween', iconTween, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAccordionMotion &&
          runtimeType == other.runtimeType &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          iconExpandCurve == other.iconExpandCurve &&
          iconCollapseCurve == other.iconCollapseCurve &&
          revealTween == other.revealTween &&
          iconTween == other.iconTween);

  @override
  int get hashCode =>
      expandDuration.hashCode ^
      collapseDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      iconExpandCurve.hashCode ^
      iconCollapseCurve.hashCode ^
      revealTween.hashCode ^
      iconTween.hashCode;
}

/// A delta that applies modifications to a [FAccordionMotion].
///
/// A [FAccordionMotion] is itself a [FAccordionMotionDelta].
abstract class FAccordionMotionDelta with Delta {
  /// Creates a partial modification of a [FAccordionMotion].
  ///
  /// ## Parameters
  /// * [FAccordionMotion.expandDuration] - The expand animation's duration.
  /// * [FAccordionMotion.collapseDuration] - The collapse animation's duration.
  /// * [FAccordionMotion.expandCurve] - The expand animation's curve.
  /// * [FAccordionMotion.collapseCurve] - The collapse animation's curve.
  /// * [FAccordionMotion.iconExpandCurve] - The icon's animation curve when expanding.
  /// * [FAccordionMotion.iconCollapseCurve] - The icon's animation curve when collapsing.
  /// * [FAccordionMotion.revealTween] - The reveal animation's tween.
  /// * [FAccordionMotion.iconTween] - The icon animation's tween.
  const factory FAccordionMotionDelta.delta({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? iconExpandCurve,
    Curve? iconCollapseCurve,
    Animatable<double>? revealTween,
    Animatable<double>? iconTween,
  }) = _FAccordionMotionDelta;

  /// Creates a delta that returns the [FAccordionMotion] in the current context.
  const factory FAccordionMotionDelta.context() = _FAccordionMotionContext;

  @override
  FAccordionMotion call(covariant FAccordionMotion value);
}

class _FAccordionMotionDelta implements FAccordionMotionDelta {
  const _FAccordionMotionDelta({
    this.expandDuration,
    this.collapseDuration,
    this.expandCurve,
    this.collapseCurve,
    this.iconExpandCurve,
    this.iconCollapseCurve,
    this.revealTween,
    this.iconTween,
  });

  final Duration? expandDuration;

  final Duration? collapseDuration;

  final Curve? expandCurve;

  final Curve? collapseCurve;

  final Curve? iconExpandCurve;

  final Curve? iconCollapseCurve;

  final Animatable<double>? revealTween;

  final Animatable<double>? iconTween;

  @override
  FAccordionMotion call(FAccordionMotion original) => FAccordionMotion(
    expandDuration: expandDuration ?? original.expandDuration,
    collapseDuration: collapseDuration ?? original.collapseDuration,
    expandCurve: expandCurve ?? original.expandCurve,
    collapseCurve: collapseCurve ?? original.collapseCurve,
    iconExpandCurve: iconExpandCurve ?? original.iconExpandCurve,
    iconCollapseCurve: iconCollapseCurve ?? original.iconCollapseCurve,
    revealTween: revealTween ?? original.revealTween,
    iconTween: iconTween ?? original.iconTween,
  );
}

class _FAccordionMotionContext implements FAccordionMotionDelta {
  const _FAccordionMotionContext();

  @override
  FAccordionMotion call(FAccordionMotion original) => original;
}

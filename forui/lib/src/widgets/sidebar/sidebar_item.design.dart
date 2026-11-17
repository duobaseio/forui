// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarItemStyleTransformations on FSidebarItemStyle {
  /// Returns a copy of this [FSidebarItemStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarItemStyle.textStyle] - The label's text style.
  /// * [FSidebarItemStyle.iconStyle] - The icon's style.
  /// * [FSidebarItemStyle.collapsibleIconStyle] - The collapsible icon's style.
  /// * [FSidebarItemStyle.collapsibleIcon] - The collapsible icon builder.
  /// * [FSidebarItemStyle.backgroundColor] - The background color.
  /// * [FSidebarItemStyle.padding] - The padding around the content.
  /// * [FSidebarItemStyle.borderRadius] - The item's border radius.
  /// * [FSidebarItemStyle.tappableStyle] - The tappable's style.
  /// * [FSidebarItemStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarItemStyle.iconSpacing] - The spacing between the icon and label.
  /// * [FSidebarItemStyle.collapsibleIconSpacing] - The spacing between the label and collapsible widget.
  /// * [FSidebarItemStyle.childrenSpacing] - The spacing between child items.
  /// * [FSidebarItemStyle.childrenPadding] - The padding around the children container.
  /// * [FSidebarItemStyle.motion] - The motion-related properties.
  @useResult
  FSidebarItemStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
    collapsibleIconStyle,
    FIcon? collapsibleIcon,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor,
    EdgeInsetsGeometryDelta? padding,
    BorderRadius? borderRadius,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    double? iconSpacing,
    double? collapsibleIconSpacing,
    double? childrenSpacing,
    EdgeInsetsGeometryDelta? childrenPadding,
    FSidebarItemMotionDelta? motion,
  }) => .new(
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    collapsibleIconStyle: collapsibleIconStyle?.call(this.collapsibleIconStyle) ?? this.collapsibleIconStyle,
    collapsibleIcon: collapsibleIcon ?? this.collapsibleIcon,
    backgroundColor: backgroundColor?.call(this.backgroundColor) ?? this.backgroundColor,
    padding: padding?.call(this.padding) ?? this.padding,
    borderRadius: borderRadius ?? this.borderRadius,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    collapsibleIconSpacing: collapsibleIconSpacing ?? this.collapsibleIconSpacing,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding?.call(this.childrenPadding) ?? this.childrenPadding,
    motion: motion?.call(this.motion) ?? this.motion,
  );

  /// Linearly interpolate between this and another [FSidebarItemStyle] using the given factor [t].
  @useResult
  FSidebarItemStyle lerp(FSidebarItemStyle other, double t) => .new(
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    collapsibleIconStyle: .lerpIconThemeData(collapsibleIconStyle, other.collapsibleIconStyle, t),
    collapsibleIcon: t < 0.5 ? collapsibleIcon : other.collapsibleIcon,
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    borderRadius: .lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t) ?? iconSpacing,
    collapsibleIconSpacing:
        lerpDouble(collapsibleIconSpacing, other.collapsibleIconSpacing, t) ?? collapsibleIconSpacing,
    childrenSpacing: lerpDouble(childrenSpacing, other.childrenSpacing, t) ?? childrenSpacing,
    childrenPadding: .lerp(childrenPadding, other.childrenPadding, t) ?? childrenPadding,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FSidebarItemStyleFunctions on Diagnosticable implements FSidebarItemStyleDelta {
  /// Returns itself.
  @override
  FSidebarItemStyle call(Object _) => this as FSidebarItemStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get iconStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get collapsibleIconStyle;
  FIcon get collapsibleIcon;
  FVariants<FTappableVariantConstraint, FTappableVariant, Color, Delta> get backgroundColor;
  EdgeInsetsGeometry get padding;
  BorderRadius get borderRadius;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  double get iconSpacing;
  double get collapsibleIconSpacing;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FSidebarItemMotion get motion;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('collapsibleIconStyle', collapsibleIconStyle, level: .debug))
      ..add(DiagnosticsProperty('collapsibleIcon', collapsibleIcon, level: .debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DoubleProperty('iconSpacing', iconSpacing, level: .debug))
      ..add(DoubleProperty('collapsibleIconSpacing', collapsibleIconSpacing, level: .debug))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing, level: .debug))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarItemStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          collapsibleIconStyle == other.collapsibleIconStyle &&
          collapsibleIcon == other.collapsibleIcon &&
          backgroundColor == other.backgroundColor &&
          padding == other.padding &&
          borderRadius == other.borderRadius &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          iconSpacing == other.iconSpacing &&
          collapsibleIconSpacing == other.collapsibleIconSpacing &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          motion == other.motion);

  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconStyle.hashCode ^
      collapsibleIconStyle.hashCode ^
      collapsibleIcon.hashCode ^
      backgroundColor.hashCode ^
      padding.hashCode ^
      borderRadius.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      iconSpacing.hashCode ^
      collapsibleIconSpacing.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      motion.hashCode;
}

/// A delta that applies modifications to a [FSidebarItemStyle].
///
/// A [FSidebarItemStyle] is itself a [FSidebarItemStyleDelta].
abstract class FSidebarItemStyleDelta with Delta {
  /// Creates a partial modification of a [FSidebarItemStyle].
  ///
  /// ## Parameters
  /// * [FSidebarItemStyle.textStyle] - The label's text style.
  /// * [FSidebarItemStyle.iconStyle] - The icon's style.
  /// * [FSidebarItemStyle.collapsibleIconStyle] - The collapsible icon's style.
  /// * [FSidebarItemStyle.collapsibleIcon] - The collapsible icon builder.
  /// * [FSidebarItemStyle.backgroundColor] - The background color.
  /// * [FSidebarItemStyle.padding] - The padding around the content.
  /// * [FSidebarItemStyle.borderRadius] - The item's border radius.
  /// * [FSidebarItemStyle.tappableStyle] - The tappable's style.
  /// * [FSidebarItemStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarItemStyle.iconSpacing] - The spacing between the icon and label.
  /// * [FSidebarItemStyle.collapsibleIconSpacing] - The spacing between the label and collapsible widget.
  /// * [FSidebarItemStyle.childrenSpacing] - The spacing between child items.
  /// * [FSidebarItemStyle.childrenPadding] - The padding around the children container.
  /// * [FSidebarItemStyle.motion] - The motion-related properties.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
    collapsibleIconStyle,
    FIcon? collapsibleIcon,
    FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor,
    EdgeInsetsGeometryDelta? padding,
    BorderRadius? borderRadius,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    double? iconSpacing,
    double? collapsibleIconSpacing,
    double? childrenSpacing,
    EdgeInsetsGeometryDelta? childrenPadding,
    FSidebarItemMotionDelta? motion,
  }) = _FSidebarItemStyleDelta;

  /// Creates a delta that returns the [FSidebarItemStyle] in the current context.
  const factory context() = _FSidebarItemStyleContext;

  @override
  FSidebarItemStyle call(covariant FSidebarItemStyle value);
}

class _FSidebarItemStyleDelta implements FSidebarItemStyleDelta {
  const new({
    this.textStyle,
    this.iconStyle,
    this.collapsibleIconStyle,
    this.collapsibleIcon,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.tappableStyle,
    this.focusedOutlineStyle,
    this.iconSpacing,
    this.collapsibleIconSpacing,
    this.childrenSpacing,
    this.childrenPadding,
    this.motion,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? iconStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  collapsibleIconStyle;

  final FIcon? collapsibleIcon;

  final FVariantsValueDelta<FTappableVariantConstraint, FTappableVariant, Color, Delta>? backgroundColor;

  final EdgeInsetsGeometryDelta? padding;

  final BorderRadius? borderRadius;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final double? iconSpacing;

  final double? collapsibleIconSpacing;

  final double? childrenSpacing;

  final EdgeInsetsGeometryDelta? childrenPadding;

  final FSidebarItemMotionDelta? motion;

  @override
  FSidebarItemStyle call(FSidebarItemStyle original) => FSidebarItemStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    collapsibleIconStyle: collapsibleIconStyle?.call(original.collapsibleIconStyle) ?? original.collapsibleIconStyle,
    collapsibleIcon: collapsibleIcon ?? original.collapsibleIcon,
    backgroundColor: backgroundColor?.call(original.backgroundColor) ?? original.backgroundColor,
    padding: padding?.call(original.padding) ?? original.padding,
    borderRadius: borderRadius ?? original.borderRadius,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    iconSpacing: iconSpacing ?? original.iconSpacing,
    collapsibleIconSpacing: collapsibleIconSpacing ?? original.collapsibleIconSpacing,
    childrenSpacing: childrenSpacing ?? original.childrenSpacing,
    childrenPadding: childrenPadding?.call(original.childrenPadding) ?? original.childrenPadding,
    motion: motion?.call(original.motion) ?? original.motion,
  );
}

class _FSidebarItemStyleContext implements FSidebarItemStyleDelta {
  const new();

  @override
  FSidebarItemStyle call(FSidebarItemStyle original) => original;
}

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarItemMotionTransformations on FSidebarItemMotion {
  /// Returns a copy of this [FSidebarItemMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FSidebarItemMotion.expandDuration] - The expand animation's duration.
  /// * [FSidebarItemMotion.collapseDuration] - The collapse animation's duration.
  /// * [FSidebarItemMotion.expandCurve] - The expand animation's curve.
  /// * [FSidebarItemMotion.collapseCurve] - The collapse animation's curve.
  /// * [FSidebarItemMotion.fadeInCurve] - The fade-in animation's curve.
  /// * [FSidebarItemMotion.fadeOutCurve] - The fade-out animation's curve.
  /// * [FSidebarItemMotion.iconExpandCurve] - The icon's animation curve when expanding.
  /// * [FSidebarItemMotion.iconCollapseCurve] - The icon's animation curve when collapsing.
  /// * [FSidebarItemMotion.revealTween] - The reveal animation's tween.
  /// * [FSidebarItemMotion.fadeTween] - The fade animation's tween.
  /// * [FSidebarItemMotion.iconTween] - The icon animation's tween.
  @useResult
  FSidebarItemMotion copyWith({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Curve? iconExpandCurve,
    Curve? iconCollapseCurve,
    Animatable<double>? revealTween,
    Animatable<double>? fadeTween,
    Animatable<double>? iconTween,
  }) => .new(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    iconExpandCurve: iconExpandCurve ?? this.iconExpandCurve,
    iconCollapseCurve: iconCollapseCurve ?? this.iconCollapseCurve,
    revealTween: revealTween ?? this.revealTween,
    fadeTween: fadeTween ?? this.fadeTween,
    iconTween: iconTween ?? this.iconTween,
  );

  /// Linearly interpolate between this and another [FSidebarItemMotion] using the given factor [t].
  @useResult
  FSidebarItemMotion lerp(FSidebarItemMotion other, double t) => .new(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
    iconExpandCurve: t < 0.5 ? iconExpandCurve : other.iconExpandCurve,
    iconCollapseCurve: t < 0.5 ? iconCollapseCurve : other.iconCollapseCurve,
    revealTween: t < 0.5 ? revealTween : other.revealTween,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
    iconTween: t < 0.5 ? iconTween : other.iconTween,
  );
}

mixin _$FSidebarItemMotionFunctions on Diagnosticable implements FSidebarItemMotionDelta {
  /// Returns itself.
  @override
  FSidebarItemMotion call(Object _) => this as FSidebarItemMotion;

  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  Curve get iconExpandCurve;
  Curve get iconCollapseCurve;
  Animatable<double> get revealTween;
  Animatable<double> get fadeTween;
  Animatable<double> get iconTween;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: .debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: .debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: .debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: .debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: .debug))
      ..add(DiagnosticsProperty('iconExpandCurve', iconExpandCurve, level: .debug))
      ..add(DiagnosticsProperty('iconCollapseCurve', iconCollapseCurve, level: .debug))
      ..add(DiagnosticsProperty('revealTween', revealTween, level: .debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: .debug))
      ..add(DiagnosticsProperty('iconTween', iconTween, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarItemMotion &&
          runtimeType == other.runtimeType &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve &&
          iconExpandCurve == other.iconExpandCurve &&
          iconCollapseCurve == other.iconCollapseCurve &&
          revealTween == other.revealTween &&
          fadeTween == other.fadeTween &&
          iconTween == other.iconTween);

  @override
  int get hashCode =>
      expandDuration.hashCode ^
      collapseDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      fadeInCurve.hashCode ^
      fadeOutCurve.hashCode ^
      iconExpandCurve.hashCode ^
      iconCollapseCurve.hashCode ^
      revealTween.hashCode ^
      fadeTween.hashCode ^
      iconTween.hashCode;
}

/// A delta that applies modifications to a [FSidebarItemMotion].
///
/// A [FSidebarItemMotion] is itself a [FSidebarItemMotionDelta].
abstract class FSidebarItemMotionDelta with Delta {
  /// Creates a partial modification of a [FSidebarItemMotion].
  ///
  /// ## Parameters
  /// * [FSidebarItemMotion.expandDuration] - The expand animation's duration.
  /// * [FSidebarItemMotion.collapseDuration] - The collapse animation's duration.
  /// * [FSidebarItemMotion.expandCurve] - The expand animation's curve.
  /// * [FSidebarItemMotion.collapseCurve] - The collapse animation's curve.
  /// * [FSidebarItemMotion.fadeInCurve] - The fade-in animation's curve.
  /// * [FSidebarItemMotion.fadeOutCurve] - The fade-out animation's curve.
  /// * [FSidebarItemMotion.iconExpandCurve] - The icon's animation curve when expanding.
  /// * [FSidebarItemMotion.iconCollapseCurve] - The icon's animation curve when collapsing.
  /// * [FSidebarItemMotion.revealTween] - The reveal animation's tween.
  /// * [FSidebarItemMotion.fadeTween] - The fade animation's tween.
  /// * [FSidebarItemMotion.iconTween] - The icon animation's tween.
  const factory delta({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Curve? iconExpandCurve,
    Curve? iconCollapseCurve,
    Animatable<double>? revealTween,
    Animatable<double>? fadeTween,
    Animatable<double>? iconTween,
  }) = _FSidebarItemMotionDelta;

  /// Creates a delta that returns the [FSidebarItemMotion] in the current context.
  const factory context() = _FSidebarItemMotionContext;

  @override
  FSidebarItemMotion call(covariant FSidebarItemMotion value);
}

class _FSidebarItemMotionDelta implements FSidebarItemMotionDelta {
  const new({
    this.expandDuration,
    this.collapseDuration,
    this.expandCurve,
    this.collapseCurve,
    this.fadeInCurve,
    this.fadeOutCurve,
    this.iconExpandCurve,
    this.iconCollapseCurve,
    this.revealTween,
    this.fadeTween,
    this.iconTween,
  });

  final Duration? expandDuration;

  final Duration? collapseDuration;

  final Curve? expandCurve;

  final Curve? collapseCurve;

  final Curve? fadeInCurve;

  final Curve? fadeOutCurve;

  final Curve? iconExpandCurve;

  final Curve? iconCollapseCurve;

  final Animatable<double>? revealTween;

  final Animatable<double>? fadeTween;

  final Animatable<double>? iconTween;

  @override
  FSidebarItemMotion call(FSidebarItemMotion original) => FSidebarItemMotion(
    expandDuration: expandDuration ?? original.expandDuration,
    collapseDuration: collapseDuration ?? original.collapseDuration,
    expandCurve: expandCurve ?? original.expandCurve,
    collapseCurve: collapseCurve ?? original.collapseCurve,
    fadeInCurve: fadeInCurve ?? original.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? original.fadeOutCurve,
    iconExpandCurve: iconExpandCurve ?? original.iconExpandCurve,
    iconCollapseCurve: iconCollapseCurve ?? original.iconCollapseCurve,
    revealTween: revealTween ?? original.revealTween,
    fadeTween: fadeTween ?? original.fadeTween,
    iconTween: iconTween ?? original.iconTween,
  );
}

class _FSidebarItemMotionContext implements FSidebarItemMotionDelta {
  const new();

  @override
  FSidebarItemMotion call(FSidebarItemMotion original) => original;
}

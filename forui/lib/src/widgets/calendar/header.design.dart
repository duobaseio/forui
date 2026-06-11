// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarHeaderStyleTransformations on FCalendarHeaderStyle {
  /// Returns a copy of this [FCalendarHeaderStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarHeaderStyle.padding] - The padding around the entire header.
  /// * [FCalendarHeaderStyle.headerDecoration] - The month and year tap targets' decoration.
  /// * [FCalendarHeaderStyle.tappablePadding] - The month and year tap targets' padding.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The month and year labels' text style.
  /// * [FCalendarHeaderStyle.toggleIconStyle] - The month and year toggle icons' style.
  /// * [FCalendarHeaderStyle.headerFocusedOutlineStyle] - The focused outline style for the header tappable.
  /// * [FCalendarHeaderStyle.buttonStyle] - The navigation buttons' style.
  /// * [FCalendarHeaderStyle.toggleIcon] - The toggle icon builder.
  /// * [FCalendarHeaderStyle.previousIcon] - The previous-month icon builder.
  /// * [FCalendarHeaderStyle.nextIcon] - The next-month icon builder.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  @useResult
  FCalendarHeaderStyle copyWith({
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? headerDecoration,
    EdgeInsetsGeometryDelta? tappablePadding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? headerTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? toggleIconStyle,
    FFocusedOutlineStyleDelta? headerFocusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    Widget Function(BuildContext, {String? semanticsLabel})? toggleIcon,
    Widget Function(BuildContext, {String? semanticsLabel})? previousIcon,
    Widget Function(BuildContext, {String? semanticsLabel})? nextIcon,
    Duration? animationDuration,
  }) => .new(
    padding: padding?.call(this.padding) ?? this.padding,
    headerDecoration: headerDecoration?.call(this.headerDecoration) ?? this.headerDecoration,
    tappablePadding: tappablePadding?.call(this.tappablePadding) ?? this.tappablePadding,
    headerTextStyle: headerTextStyle?.call(this.headerTextStyle) ?? this.headerTextStyle,
    toggleIconStyle: toggleIconStyle?.call(this.toggleIconStyle) ?? this.toggleIconStyle,
    headerFocusedOutlineStyle:
        headerFocusedOutlineStyle?.call(this.headerFocusedOutlineStyle) ?? this.headerFocusedOutlineStyle,
    buttonStyle: buttonStyle?.call(this.buttonStyle) ?? this.buttonStyle,
    toggleIcon: toggleIcon ?? this.toggleIcon,
    previousIcon: previousIcon ?? this.previousIcon,
    nextIcon: nextIcon ?? this.nextIcon,
    animationDuration: animationDuration ?? this.animationDuration,
  );

  /// Linearly interpolate between this and another [FCalendarHeaderStyle] using the given factor [t].
  @useResult
  FCalendarHeaderStyle lerp(FCalendarHeaderStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
    headerDecoration: .lerpDecoration(headerDecoration, other.headerDecoration, t),
    tappablePadding: .lerp(tappablePadding, other.tappablePadding, t) ?? tappablePadding,
    headerTextStyle: .lerpTextStyle(headerTextStyle, other.headerTextStyle, t),
    toggleIconStyle: .lerpIconThemeData(toggleIconStyle, other.toggleIconStyle, t),
    headerFocusedOutlineStyle: headerFocusedOutlineStyle.lerp(other.headerFocusedOutlineStyle, t),
    buttonStyle: buttonStyle.lerp(other.buttonStyle, t),
    toggleIcon: t < 0.5 ? toggleIcon : other.toggleIcon,
    previousIcon: t < 0.5 ? previousIcon : other.previousIcon,
    nextIcon: t < 0.5 ? nextIcon : other.nextIcon,
    animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
  );
}

mixin _$FCalendarHeaderStyleFunctions on Diagnosticable implements FCalendarHeaderStyleDelta {
  /// Returns itself.
  @override
  FCalendarHeaderStyle call(Object _) => this as FCalendarHeaderStyle;

  EdgeInsetsGeometry get padding;
  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get headerDecoration;
  EdgeInsetsGeometry get tappablePadding;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get headerTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get toggleIconStyle;
  FFocusedOutlineStyle get headerFocusedOutlineStyle;
  FButtonStyle get buttonStyle;
  FIconBuilder get toggleIcon;
  FIconBuilder get previousIcon;
  FIconBuilder get nextIcon;
  Duration get animationDuration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration, level: .debug))
      ..add(DiagnosticsProperty('tappablePadding', tappablePadding, level: .debug))
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle, level: .debug))
      ..add(DiagnosticsProperty('toggleIconStyle', toggleIconStyle, level: .debug))
      ..add(DiagnosticsProperty('headerFocusedOutlineStyle', headerFocusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('buttonStyle', buttonStyle, level: .debug))
      ..add(DiagnosticsProperty('toggleIcon', toggleIcon, level: .debug))
      ..add(DiagnosticsProperty('previousIcon', previousIcon, level: .debug))
      ..add(DiagnosticsProperty('nextIcon', nextIcon, level: .debug))
      ..add(DiagnosticsProperty('animationDuration', animationDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarHeaderStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          headerDecoration == other.headerDecoration &&
          tappablePadding == other.tappablePadding &&
          headerTextStyle == other.headerTextStyle &&
          toggleIconStyle == other.toggleIconStyle &&
          headerFocusedOutlineStyle == other.headerFocusedOutlineStyle &&
          buttonStyle == other.buttonStyle &&
          toggleIcon == other.toggleIcon &&
          previousIcon == other.previousIcon &&
          nextIcon == other.nextIcon &&
          animationDuration == other.animationDuration);

  @override
  int get hashCode =>
      padding.hashCode ^
      headerDecoration.hashCode ^
      tappablePadding.hashCode ^
      headerTextStyle.hashCode ^
      toggleIconStyle.hashCode ^
      headerFocusedOutlineStyle.hashCode ^
      buttonStyle.hashCode ^
      toggleIcon.hashCode ^
      previousIcon.hashCode ^
      nextIcon.hashCode ^
      animationDuration.hashCode;
}

/// A delta that applies modifications to a [FCalendarHeaderStyle].
///
/// A [FCalendarHeaderStyle] is itself a [FCalendarHeaderStyleDelta].
abstract class FCalendarHeaderStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarHeaderStyle].
  ///
  /// ## Parameters
  /// * [FCalendarHeaderStyle.padding] - The padding around the entire header.
  /// * [FCalendarHeaderStyle.headerDecoration] - The month and year tap targets' decoration.
  /// * [FCalendarHeaderStyle.tappablePadding] - The month and year tap targets' padding.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The month and year labels' text style.
  /// * [FCalendarHeaderStyle.toggleIconStyle] - The month and year toggle icons' style.
  /// * [FCalendarHeaderStyle.headerFocusedOutlineStyle] - The focused outline style for the header tappable.
  /// * [FCalendarHeaderStyle.buttonStyle] - The navigation buttons' style.
  /// * [FCalendarHeaderStyle.toggleIcon] - The toggle icon builder.
  /// * [FCalendarHeaderStyle.previousIcon] - The previous-month icon builder.
  /// * [FCalendarHeaderStyle.nextIcon] - The next-month icon builder.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  const factory FCalendarHeaderStyleDelta.delta({
    EdgeInsetsGeometryDelta? padding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? headerDecoration,
    EdgeInsetsGeometryDelta? tappablePadding,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? headerTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? toggleIconStyle,
    FFocusedOutlineStyleDelta? headerFocusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    Widget Function(BuildContext, {String? semanticsLabel})? toggleIcon,
    Widget Function(BuildContext, {String? semanticsLabel})? previousIcon,
    Widget Function(BuildContext, {String? semanticsLabel})? nextIcon,
    Duration? animationDuration,
  }) = _FCalendarHeaderStyleDelta;

  /// Creates a delta that returns the [FCalendarHeaderStyle] in the current context.
  const factory FCalendarHeaderStyleDelta.context() = _FCalendarHeaderStyleContext;

  @override
  FCalendarHeaderStyle call(covariant FCalendarHeaderStyle value);
}

class _FCalendarHeaderStyleDelta implements FCalendarHeaderStyleDelta {
  const _FCalendarHeaderStyleDelta({
    this.padding,
    this.headerDecoration,
    this.tappablePadding,
    this.headerTextStyle,
    this.toggleIconStyle,
    this.headerFocusedOutlineStyle,
    this.buttonStyle,
    this.toggleIcon,
    this.previousIcon,
    this.nextIcon,
    this.animationDuration,
  });

  final EdgeInsetsGeometryDelta? padding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? headerDecoration;

  final EdgeInsetsGeometryDelta? tappablePadding;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? headerTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  toggleIconStyle;

  final FFocusedOutlineStyleDelta? headerFocusedOutlineStyle;

  final FButtonStyleDelta? buttonStyle;

  final Widget Function(BuildContext, {String? semanticsLabel})? toggleIcon;

  final Widget Function(BuildContext, {String? semanticsLabel})? previousIcon;

  final Widget Function(BuildContext, {String? semanticsLabel})? nextIcon;

  final Duration? animationDuration;

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle original) => FCalendarHeaderStyle(
    padding: padding?.call(original.padding) ?? original.padding,
    headerDecoration: headerDecoration?.call(original.headerDecoration) ?? original.headerDecoration,
    tappablePadding: tappablePadding?.call(original.tappablePadding) ?? original.tappablePadding,
    headerTextStyle: headerTextStyle?.call(original.headerTextStyle) ?? original.headerTextStyle,
    toggleIconStyle: toggleIconStyle?.call(original.toggleIconStyle) ?? original.toggleIconStyle,
    headerFocusedOutlineStyle:
        headerFocusedOutlineStyle?.call(original.headerFocusedOutlineStyle) ?? original.headerFocusedOutlineStyle,
    buttonStyle: buttonStyle?.call(original.buttonStyle) ?? original.buttonStyle,
    toggleIcon: toggleIcon ?? original.toggleIcon,
    previousIcon: previousIcon ?? original.previousIcon,
    nextIcon: nextIcon ?? original.nextIcon,
    animationDuration: animationDuration ?? original.animationDuration,
  );
}

class _FCalendarHeaderStyleContext implements FCalendarHeaderStyleDelta {
  const _FCalendarHeaderStyleContext();

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle original) => original;
}

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
  /// * [FCalendarHeaderStyle.headerDecoration] - The month and year tap targets' decoration.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The month and year labels' text style.
  /// * [FCalendarHeaderStyle.toggleIconStyle] - The month and year toggle icons' style.
  /// * [FCalendarHeaderStyle.headerFocusedOutlineStyle] - The focused outline style for the header tappable.
  /// * [FCalendarHeaderStyle.buttonStyle] - The navigation buttons' style.
  /// * [FCalendarHeaderStyle.toggleIcon] - The toggle icon builder.
  /// * [FCalendarHeaderStyle.previousIcon] - The previous-month icon builder.
  /// * [FCalendarHeaderStyle.nextIcon] - The next-month icon builder.
  /// * [FCalendarHeaderStyle.padding] - The padding around the entire header.
  /// * [FCalendarHeaderStyle.tappablePadding] - The month and year tap targets' padding.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  @useResult
  FCalendarHeaderStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? headerDecoration,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? headerTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? toggleIconStyle,
    FFocusedOutlineStyleDelta? headerFocusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    FIcon? toggleIcon,
    FIcon? previousIcon,
    FIcon? nextIcon,
    EdgeInsetsGeometryDelta? padding,
    EdgeInsetsGeometryDelta? tappablePadding,
    Duration? animationDuration,
  }) => .new(
    headerDecoration: headerDecoration?.call(this.headerDecoration) ?? this.headerDecoration,
    headerTextStyle: headerTextStyle?.call(this.headerTextStyle) ?? this.headerTextStyle,
    toggleIconStyle: toggleIconStyle?.call(this.toggleIconStyle) ?? this.toggleIconStyle,
    headerFocusedOutlineStyle:
        headerFocusedOutlineStyle?.call(this.headerFocusedOutlineStyle) ?? this.headerFocusedOutlineStyle,
    buttonStyle: buttonStyle?.call(this.buttonStyle) ?? this.buttonStyle,
    toggleIcon: toggleIcon ?? this.toggleIcon,
    previousIcon: previousIcon ?? this.previousIcon,
    nextIcon: nextIcon ?? this.nextIcon,
    padding: padding?.call(this.padding) ?? this.padding,
    tappablePadding: tappablePadding?.call(this.tappablePadding) ?? this.tappablePadding,
    animationDuration: animationDuration ?? this.animationDuration,
  );

  /// Linearly interpolate between this and another [FCalendarHeaderStyle] using the given factor [t].
  @useResult
  FCalendarHeaderStyle lerp(FCalendarHeaderStyle other, double t) => .new(
    headerDecoration: .lerpDecoration(headerDecoration, other.headerDecoration, t),
    headerTextStyle: .lerpTextStyle(headerTextStyle, other.headerTextStyle, t),
    toggleIconStyle: .lerpIconThemeData(toggleIconStyle, other.toggleIconStyle, t),
    headerFocusedOutlineStyle: headerFocusedOutlineStyle.lerp(other.headerFocusedOutlineStyle, t),
    buttonStyle: buttonStyle.lerp(other.buttonStyle, t),
    toggleIcon: t < 0.5 ? toggleIcon : other.toggleIcon,
    previousIcon: t < 0.5 ? previousIcon : other.previousIcon,
    nextIcon: t < 0.5 ? nextIcon : other.nextIcon,
    padding: .lerp(padding, other.padding, t) ?? padding,
    tappablePadding: .lerp(tappablePadding, other.tappablePadding, t) ?? tappablePadding,
    animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
  );
}

mixin _$FCalendarHeaderStyleFunctions on Diagnosticable implements FCalendarHeaderStyleDelta {
  /// Returns itself.
  @override
  FCalendarHeaderStyle call(Object _) => this as FCalendarHeaderStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> get headerDecoration;
  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get headerTextStyle;
  FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> get toggleIconStyle;
  FFocusedOutlineStyle get headerFocusedOutlineStyle;
  FButtonStyle get buttonStyle;
  FIcon get toggleIcon;
  FIcon get previousIcon;
  FIcon get nextIcon;
  EdgeInsetsGeometry get padding;
  EdgeInsetsGeometry get tappablePadding;
  Duration get animationDuration;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration, level: .debug))
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle, level: .debug))
      ..add(DiagnosticsProperty('toggleIconStyle', toggleIconStyle, level: .debug))
      ..add(DiagnosticsProperty('headerFocusedOutlineStyle', headerFocusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('buttonStyle', buttonStyle, level: .debug))
      ..add(DiagnosticsProperty('toggleIcon', toggleIcon, level: .debug))
      ..add(DiagnosticsProperty('previousIcon', previousIcon, level: .debug))
      ..add(DiagnosticsProperty('nextIcon', nextIcon, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('tappablePadding', tappablePadding, level: .debug))
      ..add(DiagnosticsProperty('animationDuration', animationDuration, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarHeaderStyle &&
          runtimeType == other.runtimeType &&
          headerDecoration == other.headerDecoration &&
          headerTextStyle == other.headerTextStyle &&
          toggleIconStyle == other.toggleIconStyle &&
          headerFocusedOutlineStyle == other.headerFocusedOutlineStyle &&
          buttonStyle == other.buttonStyle &&
          toggleIcon == other.toggleIcon &&
          previousIcon == other.previousIcon &&
          nextIcon == other.nextIcon &&
          padding == other.padding &&
          tappablePadding == other.tappablePadding &&
          animationDuration == other.animationDuration);

  @override
  int get hashCode =>
      headerDecoration.hashCode ^
      headerTextStyle.hashCode ^
      toggleIconStyle.hashCode ^
      headerFocusedOutlineStyle.hashCode ^
      buttonStyle.hashCode ^
      toggleIcon.hashCode ^
      previousIcon.hashCode ^
      nextIcon.hashCode ^
      padding.hashCode ^
      tappablePadding.hashCode ^
      animationDuration.hashCode;
}

/// A delta that applies modifications to a [FCalendarHeaderStyle].
///
/// A [FCalendarHeaderStyle] is itself a [FCalendarHeaderStyleDelta].
abstract class FCalendarHeaderStyleDelta with Delta {
  /// Creates a partial modification of a [FCalendarHeaderStyle].
  ///
  /// ## Parameters
  /// * [FCalendarHeaderStyle.headerDecoration] - The month and year tap targets' decoration.
  /// * [FCalendarHeaderStyle.headerTextStyle] - The month and year labels' text style.
  /// * [FCalendarHeaderStyle.toggleIconStyle] - The month and year toggle icons' style.
  /// * [FCalendarHeaderStyle.headerFocusedOutlineStyle] - The focused outline style for the header tappable.
  /// * [FCalendarHeaderStyle.buttonStyle] - The navigation buttons' style.
  /// * [FCalendarHeaderStyle.toggleIcon] - The toggle icon builder.
  /// * [FCalendarHeaderStyle.previousIcon] - The previous-month icon builder.
  /// * [FCalendarHeaderStyle.nextIcon] - The next-month icon builder.
  /// * [FCalendarHeaderStyle.padding] - The padding around the entire header.
  /// * [FCalendarHeaderStyle.tappablePadding] - The month and year tap targets' padding.
  /// * [FCalendarHeaderStyle.animationDuration] - The arrow turn animation's duration.
  const factory delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? headerDecoration,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? headerTextStyle,
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>? toggleIconStyle,
    FFocusedOutlineStyleDelta? headerFocusedOutlineStyle,
    FButtonStyleDelta? buttonStyle,
    FIcon? toggleIcon,
    FIcon? previousIcon,
    FIcon? nextIcon,
    EdgeInsetsGeometryDelta? padding,
    EdgeInsetsGeometryDelta? tappablePadding,
    Duration? animationDuration,
  }) = _FCalendarHeaderStyleDelta;

  /// Creates a delta that returns the [FCalendarHeaderStyle] in the current context.
  const factory context() = _FCalendarHeaderStyleContext;

  @override
  FCalendarHeaderStyle call(covariant FCalendarHeaderStyle value);
}

class _FCalendarHeaderStyleDelta implements FCalendarHeaderStyleDelta {
  const new({
    this.headerDecoration,
    this.headerTextStyle,
    this.toggleIconStyle,
    this.headerFocusedOutlineStyle,
    this.buttonStyle,
    this.toggleIcon,
    this.previousIcon,
    this.nextIcon,
    this.padding,
    this.tappablePadding,
    this.animationDuration,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta>? headerDecoration;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? headerTextStyle;

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>?
  toggleIconStyle;

  final FFocusedOutlineStyleDelta? headerFocusedOutlineStyle;

  final FButtonStyleDelta? buttonStyle;

  final FIcon? toggleIcon;

  final FIcon? previousIcon;

  final FIcon? nextIcon;

  final EdgeInsetsGeometryDelta? padding;

  final EdgeInsetsGeometryDelta? tappablePadding;

  final Duration? animationDuration;

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle original) => FCalendarHeaderStyle(
    headerDecoration: headerDecoration?.call(original.headerDecoration) ?? original.headerDecoration,
    headerTextStyle: headerTextStyle?.call(original.headerTextStyle) ?? original.headerTextStyle,
    toggleIconStyle: toggleIconStyle?.call(original.toggleIconStyle) ?? original.toggleIconStyle,
    headerFocusedOutlineStyle:
        headerFocusedOutlineStyle?.call(original.headerFocusedOutlineStyle) ?? original.headerFocusedOutlineStyle,
    buttonStyle: buttonStyle?.call(original.buttonStyle) ?? original.buttonStyle,
    toggleIcon: toggleIcon ?? original.toggleIcon,
    previousIcon: previousIcon ?? original.previousIcon,
    nextIcon: nextIcon ?? original.nextIcon,
    padding: padding?.call(original.padding) ?? original.padding,
    tappablePadding: tappablePadding?.call(original.tappablePadding) ?? original.tappablePadding,
    animationDuration: animationDuration ?? original.animationDuration,
  );
}

class _FCalendarHeaderStyleContext implements FCalendarHeaderStyleDelta {
  const new();

  @override
  FCalendarHeaderStyle call(FCalendarHeaderStyle original) => original;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'breadcrumb.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBreadcrumbStyleTransformations on FBreadcrumbStyle {
  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FBreadcrumbStyle.textStyle] - The text style.
  /// * [FBreadcrumbStyle.iconStyle] - The divider icon style.
  /// * [FBreadcrumbStyle.padding] - The padding.
  /// * [FBreadcrumbStyle.tappableStyle] - The tappable's style.
  /// * [FBreadcrumbStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FBreadcrumbStyle copyWith({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    IconThemeDataDelta? iconStyle,
    EdgeInsetsGeometryDelta? padding,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) => .new(
    textStyle: textStyle?.call(this.textStyle) ?? this.textStyle,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    padding: padding?.call(this.padding) ?? this.padding,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FBreadcrumbStyle] using the given factor [t].
  @useResult
  FBreadcrumbStyle lerp(FBreadcrumbStyle other, double t) => .new(
    textStyle: .lerpTextStyle(textStyle, other.textStyle, t),
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FBreadcrumbStyleFunctions on Diagnosticable implements FBreadcrumbStyleDelta {
  /// Returns itself.
  @override
  FBreadcrumbStyle call(Object _) => this as FBreadcrumbStyle;

  FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> get textStyle;
  IconThemeData get iconStyle;
  EdgeInsetsGeometry get padding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBreadcrumbStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconStyle.hashCode ^
      padding.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

/// A delta that applies modifications to a [FBreadcrumbStyle].
///
/// A [FBreadcrumbStyle] is itself a [FBreadcrumbStyleDelta].
abstract class FBreadcrumbStyleDelta with Delta {
  /// Creates a partial modification of a [FBreadcrumbStyle].
  ///
  /// ## Parameters
  /// * [FBreadcrumbStyle.textStyle] - The text style.
  /// * [FBreadcrumbStyle.iconStyle] - The divider icon style.
  /// * [FBreadcrumbStyle.padding] - The padding.
  /// * [FBreadcrumbStyle.tappableStyle] - The tappable's style.
  /// * [FBreadcrumbStyle.focusedOutlineStyle] - The focused outline style.
  const factory FBreadcrumbStyleDelta.delta({
    FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle,
    IconThemeDataDelta? iconStyle,
    EdgeInsetsGeometryDelta? padding,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FBreadcrumbStyleDelta;

  /// Creates a delta that returns the [FBreadcrumbStyle] in the current context.
  const factory FBreadcrumbStyleDelta.context() = _FBreadcrumbStyleContext;

  @override
  FBreadcrumbStyle call(covariant FBreadcrumbStyle value);
}

class _FBreadcrumbStyleDelta implements FBreadcrumbStyleDelta {
  const _FBreadcrumbStyleDelta({
    this.textStyle,
    this.iconStyle,
    this.padding,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FVariantsDelta<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta>? textStyle;

  final IconThemeDataDelta? iconStyle;

  final EdgeInsetsGeometryDelta? padding;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FBreadcrumbStyle call(FBreadcrumbStyle original) => FBreadcrumbStyle(
    textStyle: textStyle?.call(original.textStyle) ?? original.textStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    padding: padding?.call(original.padding) ?? original.padding,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

class _FBreadcrumbStyleContext implements FBreadcrumbStyleDelta {
  const _FBreadcrumbStyleContext();

  @override
  FBreadcrumbStyle call(FBreadcrumbStyle original) => original;
}

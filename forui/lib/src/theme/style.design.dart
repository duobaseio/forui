// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FStyleTransformations on FStyle {
  /// Returns a copy of this [FStyle] with the given properties replaced.
  ///
  /// See [customizing widget styles](https://forui.dev/docs/guides/customizing-widget-styles).
  ///
  /// ## Parameters
  /// * [FStyle.formFieldStyle] - The style for the form field.
  /// * [FStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FStyle.iconStyle] - The icon style.
  /// * [FStyle.borderRadius] - The border radius.
  /// * [FStyle.borderWidth] - The border width.
  /// * [FStyle.pagePadding] - The page's padding.
  /// * [FStyle.shadow] - The shadow used for elevated widgets.
  /// * [FStyle.tappableStyle] - The tappable style.
  @useResult
  FStyle copyWith({
    FFormFieldStyleDelta? formFieldStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    IconThemeDataDelta? iconStyle,
    FBorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsetsDelta? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyleDelta? tappableStyle,
  }) => .new(
    formFieldStyle: formFieldStyle?.call(this.formFieldStyle) ?? this.formFieldStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(this.focusedOutlineStyle) ?? this.focusedOutlineStyle,
    iconStyle: iconStyle?.call(this.iconStyle) ?? this.iconStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    borderWidth: borderWidth ?? this.borderWidth,
    pagePadding: pagePadding?.call(this.pagePadding) ?? this.pagePadding,
    shadow: shadow ?? this.shadow,
    tappableStyle: tappableStyle?.call(this.tappableStyle) ?? this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FStyle] using the given factor [t].
  @useResult
  FStyle lerp(FStyle other, double t) => .new(
    formFieldStyle: formFieldStyle.lerp(other.formFieldStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
    borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
    pagePadding: .lerp(pagePadding, other.pagePadding, t) ?? pagePadding,
    shadow: BoxShadow.lerpList(shadow, other.shadow, t) ?? shadow,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FStyleFunctions on Diagnosticable implements FStyleDelta {
  /// Returns itself.
  @override
  FStyle call(Object _) => this as FStyle;

  FFormFieldStyle get formFieldStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  IconThemeData get iconStyle;
  FBorderRadius get borderRadius;
  double get borderWidth;
  EdgeInsets get pagePadding;
  List<BoxShadow> get shadow;
  FTappableStyle get tappableStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('formFieldStyle', formFieldStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: .debug))
      ..add(DoubleProperty('borderWidth', borderWidth, level: .debug))
      ..add(DiagnosticsProperty('pagePadding', pagePadding, level: .debug))
      ..add(IterableProperty('shadow', shadow, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FStyle &&
          runtimeType == other.runtimeType &&
          formFieldStyle == other.formFieldStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          iconStyle == other.iconStyle &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          pagePadding == other.pagePadding &&
          listEquals(shadow, other.shadow) &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode =>
      formFieldStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      iconStyle.hashCode ^
      borderRadius.hashCode ^
      borderWidth.hashCode ^
      pagePadding.hashCode ^
      const ListEquality().hash(shadow) ^
      tappableStyle.hashCode;
}

/// A delta that applies modifications to a [FStyle].
///
/// A [FStyle] is itself a [FStyleDelta].
abstract class FStyleDelta with Delta {
  /// Creates a partial modification of a [FStyle].
  ///
  /// ## Parameters
  /// * [FStyle.formFieldStyle] - The style for the form field.
  /// * [FStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FStyle.iconStyle] - The icon style.
  /// * [FStyle.borderRadius] - The border radius.
  /// * [FStyle.borderWidth] - The border width.
  /// * [FStyle.pagePadding] - The page's padding.
  /// * [FStyle.shadow] - The shadow used for elevated widgets.
  /// * [FStyle.tappableStyle] - The tappable style.
  const factory FStyleDelta.delta({
    FFormFieldStyleDelta? formFieldStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    IconThemeDataDelta? iconStyle,
    FBorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsetsDelta? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyleDelta? tappableStyle,
  }) = _FStyleDelta;

  /// Creates a delta that returns the [FStyle] in the current context.
  const factory FStyleDelta.context() = _FStyleContext;

  @override
  FStyle call(covariant FStyle value);
}

class _FStyleDelta implements FStyleDelta {
  const _FStyleDelta({
    this.formFieldStyle,
    this.focusedOutlineStyle,
    this.iconStyle,
    this.borderRadius,
    this.borderWidth,
    this.pagePadding,
    this.shadow,
    this.tappableStyle,
  });

  final FFormFieldStyleDelta? formFieldStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  final IconThemeDataDelta? iconStyle;

  final FBorderRadius? borderRadius;

  final double? borderWidth;

  final EdgeInsetsDelta? pagePadding;

  final List<BoxShadow>? shadow;

  final FTappableStyleDelta? tappableStyle;

  @override
  FStyle call(FStyle original) => FStyle(
    formFieldStyle: formFieldStyle?.call(original.formFieldStyle) ?? original.formFieldStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    borderRadius: borderRadius ?? original.borderRadius,
    borderWidth: borderWidth ?? original.borderWidth,
    pagePadding: pagePadding?.call(original.pagePadding) ?? original.pagePadding,
    shadow: shadow ?? original.shadow,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
  );
}

class _FStyleContext implements FStyleDelta {
  const _FStyleContext();

  @override
  FStyle call(FStyle original) => original;
}

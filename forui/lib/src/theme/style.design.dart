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
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
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
    FFormFieldStyle Function(FFormFieldStyle style)? formFieldStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    IconThemeData? iconStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
  }) => .new(
    formFieldStyle: formFieldStyle != null ? formFieldStyle(this.formFieldStyle) : this.formFieldStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    borderWidth: borderWidth ?? this.borderWidth,
    pagePadding: pagePadding ?? this.pagePadding,
    shadow: shadow ?? this.shadow,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FStyle] using the given factor [t].
  @useResult
  FStyle lerp(FStyle other, double t) => .new(
    formFieldStyle: formFieldStyle.lerp(other.formFieldStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    borderRadius: .lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
    pagePadding: .lerp(pagePadding, other.pagePadding, t) ?? pagePadding,
    shadow: BoxShadow.lerpList(shadow, other.shadow, t) ?? shadow,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FStyleFunctions on Diagnosticable {
  FFormFieldStyle get formFieldStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  IconThemeData get iconStyle;
  BorderRadius get borderRadius;
  double get borderWidth;
  EdgeInsets get pagePadding;
  List<BoxShadow> get shadow;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FStyle] to replace functions that accept and return a [FStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FStyle Function(FStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FStyle(...));
  /// ```
  @useResult
  FStyle call(Object? _) => this as FStyle;

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
sealed class FStyleDelta with Delta<FStyle> {
  /// Creates a complete replacement for a [FStyle].
  const factory FStyleDelta.replace(FStyle replacement) = _FStyleReplace;

  /// Creates a partial modification of a [FStyle].
  const factory FStyleDelta.merge({
    FFormFieldStyleDelta? formFieldStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
    IconThemeDataDelta? iconStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyleDelta? tappableStyle,
  }) = _FStyleMerge;
}

class _FStyleReplace implements FStyleDelta {
  const _FStyleReplace(this._replacement);

  final FStyle _replacement;

  @override
  FStyle call(FStyle _) => _replacement;
}

class _FStyleMerge implements FStyleDelta {
  const _FStyleMerge({
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

  final BorderRadius? borderRadius;

  final double? borderWidth;

  final EdgeInsets? pagePadding;

  final List<BoxShadow>? shadow;

  final FTappableStyleDelta? tappableStyle;

  @override
  FStyle call(FStyle original) => FStyle(
    formFieldStyle: formFieldStyle?.call(original.formFieldStyle) ?? original.formFieldStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    borderRadius: borderRadius ?? original.borderRadius,
    borderWidth: borderWidth ?? original.borderWidth,
    pagePadding: pagePadding ?? original.pagePadding,
    shadow: shadow ?? original.shadow,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
  );
}

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
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBreadcrumbStyle.textStyle] - The text style.
  /// * [FBreadcrumbStyle.iconStyle] - The divider icon style.
  /// * [FBreadcrumbStyle.padding] - The padding.
  /// * [FBreadcrumbStyle.tappableStyle] - The tappable's style.
  /// * [FBreadcrumbStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FBreadcrumbStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    IconThemeData? iconStyle,
    EdgeInsetsGeometry? padding,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => .new(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    padding: padding ?? this.padding,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
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

mixin _$FBreadcrumbStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  IconThemeData get iconStyle;
  EdgeInsetsGeometry get padding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FBreadcrumbStyle] to replace functions that accept and return a [FBreadcrumbStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBreadcrumbStyle Function(FBreadcrumbStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBreadcrumbStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBreadcrumbStyle(...));
  /// ```
  @useResult
  FBreadcrumbStyle call(Object? _) => this as FBreadcrumbStyle;

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
sealed class FBreadcrumbStyleDelta with Delta<FBreadcrumbStyle> {
  /// Creates a complete replacement for a [FBreadcrumbStyle].
  const factory FBreadcrumbStyleDelta.replace(FBreadcrumbStyle replacement) = _FBreadcrumbStyleReplace;

  /// Creates a partial modification of a [FBreadcrumbStyle].
  const factory FBreadcrumbStyleDelta.merge({
    FWidgetStateMap<TextStyle>? textStyle,
    IconThemeDataDelta? iconStyle,
    EdgeInsetsGeometry? padding,
    FTappableStyleDelta? tappableStyle,
    FFocusedOutlineStyleDelta? focusedOutlineStyle,
  }) = _FBreadcrumbStyleMerge;
}

class _FBreadcrumbStyleReplace implements FBreadcrumbStyleDelta {
  const _FBreadcrumbStyleReplace(this._replacement);

  final FBreadcrumbStyle _replacement;

  @override
  FBreadcrumbStyle call(FBreadcrumbStyle _) => _replacement;
}

class _FBreadcrumbStyleMerge implements FBreadcrumbStyleDelta {
  const _FBreadcrumbStyleMerge({
    this.textStyle,
    this.iconStyle,
    this.padding,
    this.tappableStyle,
    this.focusedOutlineStyle,
  });

  final FWidgetStateMap<TextStyle>? textStyle;

  final IconThemeDataDelta? iconStyle;

  final EdgeInsetsGeometry? padding;

  final FTappableStyleDelta? tappableStyle;

  final FFocusedOutlineStyleDelta? focusedOutlineStyle;

  @override
  FBreadcrumbStyle call(FBreadcrumbStyle original) => FBreadcrumbStyle(
    textStyle: textStyle ?? original.textStyle,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    padding: padding ?? original.padding,
    tappableStyle: tappableStyle?.call(original.tappableStyle) ?? original.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle?.call(original.focusedOutlineStyle) ?? original.focusedOutlineStyle,
  );
}

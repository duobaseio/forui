// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'alert.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAlertStylesTransformations on FAlertStyles {
  /// Returns a copy of this [FAlertStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAlertStyles.primary] - The primary alert style.
  /// * [FAlertStyles.destructive] - The destructive alert style.
  @useResult
  FAlertStyles copyWith({
    FAlertStyle Function(FAlertStyle style)? primary,
    FAlertStyle Function(FAlertStyle style)? destructive,
  }) => .new(
    primary: primary != null ? primary(this.primary) : this.primary,
    destructive: destructive != null ? destructive(this.destructive) : this.destructive,
  );

  /// Linearly interpolate between this and another [FAlertStyles] using the given factor [t].
  @useResult
  FAlertStyles lerp(FAlertStyles other, double t) =>
      .new(primary: primary.lerp(other.primary, t), destructive: destructive.lerp(other.destructive, t));
}

mixin _$FAlertStylesFunctions on Diagnosticable {
  FAlertStyle get primary;
  FAlertStyle get destructive;

  /// Returns itself.
  ///
  /// Allows [FAlertStyles] to replace functions that accept and return a [FAlertStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAlertStyles Function(FAlertStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAlertStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAlertStyles(...));
  /// ```
  @useResult
  FAlertStyles call(Object? _) => this as FAlertStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary, level: .debug))
      ..add(DiagnosticsProperty('destructive', destructive, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAlertStyles &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          destructive == other.destructive);

  @override
  int get hashCode => primary.hashCode ^ destructive.hashCode;
}

/// A delta that applies modifications to a [FAlertStyles].
sealed class FAlertStylesDelta with Delta<FAlertStyles> {
  /// Creates a complete replacement for a [FAlertStyles].
  const factory FAlertStylesDelta.replace(FAlertStyles replacement) = _FAlertStylesReplace;

  /// Creates a partial modification of a [FAlertStyles].
  const factory FAlertStylesDelta.merge({FAlertStyleDelta? primary, FAlertStyleDelta? destructive}) =
      _FAlertStylesMerge;
}

class _FAlertStylesReplace implements FAlertStylesDelta {
  const _FAlertStylesReplace(this._replacement);

  final FAlertStyles _replacement;

  @override
  FAlertStyles call(FAlertStyles _) => _replacement;
}

class _FAlertStylesMerge implements FAlertStylesDelta {
  const _FAlertStylesMerge({this.primary, this.destructive});

  final FAlertStyleDelta? primary;

  final FAlertStyleDelta? destructive;

  @override
  FAlertStyles call(FAlertStyles original) => FAlertStyles(
    primary: primary?.call(original.primary) ?? original.primary,
    destructive: destructive?.call(original.destructive) ?? original.destructive,
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FAlertStyleTransformations on FAlertStyle {
  /// Returns a copy of this [FAlertStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAlertStyle.decoration] - The decoration.
  /// * [FAlertStyle.padding] - The padding.
  /// * [FAlertStyle.iconStyle] - The icon's style.
  /// * [FAlertStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FAlertStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  @useResult
  FAlertStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    IconThemeData? iconStyle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) => .new(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    iconStyle: iconStyle ?? this.iconStyle,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
  );

  /// Linearly interpolate between this and another [FAlertStyle] using the given factor [t].
  @useResult
  FAlertStyle lerp(FAlertStyle other, double t) => .new(
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    padding: .lerp(padding, other.padding, t) ?? padding,
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    titleTextStyle: .lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    subtitleTextStyle: .lerp(subtitleTextStyle, other.subtitleTextStyle, t) ?? subtitleTextStyle,
  );
}

mixin _$FAlertStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  IconThemeData get iconStyle;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;

  /// Returns itself.
  ///
  /// Allows [FAlertStyle] to replace functions that accept and return a [FAlertStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAlertStyle Function(FAlertStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAlertStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAlertStyle(...));
  /// ```
  @useResult
  FAlertStyle call(Object? _) => this as FAlertStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAlertStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          iconStyle == other.iconStyle &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode;
}

/// A delta that applies modifications to a [FAlertStyle].
sealed class FAlertStyleDelta with Delta<FAlertStyle> {
  /// Creates a complete replacement for a [FAlertStyle].
  const factory FAlertStyleDelta.replace(FAlertStyle replacement) = _FAlertStyleReplace;

  /// Creates a partial modification of a [FAlertStyle].
  const factory FAlertStyleDelta.merge({
    BoxDecorationDelta? decoration,
    EdgeInsetsGeometry? padding,
    IconThemeDataDelta? iconStyle,
    TextStyleDelta? titleTextStyle,
    TextStyleDelta? subtitleTextStyle,
  }) = _FAlertStyleMerge;
}

class _FAlertStyleReplace implements FAlertStyleDelta {
  const _FAlertStyleReplace(this._replacement);

  final FAlertStyle _replacement;

  @override
  FAlertStyle call(FAlertStyle _) => _replacement;
}

class _FAlertStyleMerge implements FAlertStyleDelta {
  const _FAlertStyleMerge({this.decoration, this.padding, this.iconStyle, this.titleTextStyle, this.subtitleTextStyle});

  final BoxDecorationDelta? decoration;

  final EdgeInsetsGeometry? padding;

  final IconThemeDataDelta? iconStyle;

  final TextStyleDelta? titleTextStyle;

  final TextStyleDelta? subtitleTextStyle;

  @override
  FAlertStyle call(FAlertStyle original) => FAlertStyle(
    decoration: decoration?.call(original.decoration) ?? original.decoration,
    padding: padding ?? original.padding,
    iconStyle: iconStyle?.call(original.iconStyle) ?? original.iconStyle,
    titleTextStyle: titleTextStyle?.call(original.titleTextStyle) ?? original.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle?.call(original.subtitleTextStyle) ?? original.subtitleTextStyle,
  );
}

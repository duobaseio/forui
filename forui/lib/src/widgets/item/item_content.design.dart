// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FItemContentStyleTransformations on FItemContentStyle {
  /// Returns a copy of this [FItemContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemContentStyle.padding] - The content's padding.
  /// * [FItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FItemContentStyle.titleTextStyle] - The title's text style.
  /// * [FItemContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FItemContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FItemContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FItemContentStyle.detailsTextStyle] - The details text style.
  /// * [FItemContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FItemContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  @useResult
  FItemContentStyle copyWith({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<IconThemeData>? prefixIconStyle,
    double? prefixIconSpacing,
    FWidgetStateMap<TextStyle>? titleTextStyle,
    double? titleSpacing,
    FWidgetStateMap<TextStyle>? subtitleTextStyle,
    double? middleSpacing,
    FWidgetStateMap<TextStyle>? detailsTextStyle,
    FWidgetStateMap<IconThemeData>? suffixIconStyle,
    double? suffixIconSpacing,
  }) => .new(
    padding: padding ?? this.padding,
    prefixIconStyle: prefixIconStyle ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    middleSpacing: middleSpacing ?? this.middleSpacing,
    detailsTextStyle: detailsTextStyle ?? this.detailsTextStyle,
    suffixIconStyle: suffixIconStyle ?? this.suffixIconStyle,
    suffixIconSpacing: suffixIconSpacing ?? this.suffixIconSpacing,
  );

  /// Linearly interpolate between this and another [FItemContentStyle] using the given factor [t].
  @useResult
  FItemContentStyle lerp(FItemContentStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    titleTextStyle: .lerpTextStyle(titleTextStyle, other.titleTextStyle, t),
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    subtitleTextStyle: .lerpTextStyle(subtitleTextStyle, other.subtitleTextStyle, t),
    middleSpacing: lerpDouble(middleSpacing, other.middleSpacing, t) ?? middleSpacing,
    detailsTextStyle: .lerpTextStyle(detailsTextStyle, other.detailsTextStyle, t),
    suffixIconStyle: .lerpIconThemeData(suffixIconStyle, other.suffixIconStyle, t),
    suffixIconSpacing: lerpDouble(suffixIconSpacing, other.suffixIconSpacing, t) ?? suffixIconSpacing,
  );
}

mixin _$FItemContentStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get padding;
  FWidgetStateMap<IconThemeData> get prefixIconStyle;
  double get prefixIconSpacing;
  FWidgetStateMap<TextStyle> get titleTextStyle;
  double get titleSpacing;
  FWidgetStateMap<TextStyle> get subtitleTextStyle;
  double get middleSpacing;
  FWidgetStateMap<TextStyle> get detailsTextStyle;
  FWidgetStateMap<IconThemeData> get suffixIconStyle;
  double get suffixIconSpacing;

  /// Returns itself.
  ///
  /// Allows [FItemContentStyle] to replace functions that accept and return a [FItemContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FItemContentStyle Function(FItemContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FItemContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FItemContentStyle(...));
  /// ```
  @useResult
  FItemContentStyle call(Object? _) => this as FItemContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: .debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: .debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: .debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: .debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: .debug))
      ..add(DoubleProperty('middleSpacing', middleSpacing, level: .debug))
      ..add(DiagnosticsProperty('detailsTextStyle', detailsTextStyle, level: .debug))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle, level: .debug))
      ..add(DoubleProperty('suffixIconSpacing', suffixIconSpacing, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          titleTextStyle == other.titleTextStyle &&
          titleSpacing == other.titleSpacing &&
          subtitleTextStyle == other.subtitleTextStyle &&
          middleSpacing == other.middleSpacing &&
          detailsTextStyle == other.detailsTextStyle &&
          suffixIconStyle == other.suffixIconStyle &&
          suffixIconSpacing == other.suffixIconSpacing);

  @override
  int get hashCode =>
      padding.hashCode ^
      prefixIconStyle.hashCode ^
      prefixIconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      subtitleTextStyle.hashCode ^
      middleSpacing.hashCode ^
      detailsTextStyle.hashCode ^
      suffixIconStyle.hashCode ^
      suffixIconSpacing.hashCode;
}

/// A delta that applies modifications to a [FItemContentStyle].
sealed class FItemContentStyleDelta with Delta<FItemContentStyle> {
  /// Creates a complete replacement for a [FItemContentStyle].
  const factory FItemContentStyleDelta.replace(FItemContentStyle replacement) = _FItemContentStyleReplace;

  /// Creates a partial modification of a [FItemContentStyle].
  const factory FItemContentStyleDelta.merge({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<IconThemeData>? prefixIconStyle,
    double? prefixIconSpacing,
    FWidgetStateMap<TextStyle>? titleTextStyle,
    double? titleSpacing,
    FWidgetStateMap<TextStyle>? subtitleTextStyle,
    double? middleSpacing,
    FWidgetStateMap<TextStyle>? detailsTextStyle,
    FWidgetStateMap<IconThemeData>? suffixIconStyle,
    double? suffixIconSpacing,
  }) = _FItemContentStyleMerge;
}

class _FItemContentStyleReplace implements FItemContentStyleDelta {
  const _FItemContentStyleReplace(this._replacement);

  final FItemContentStyle _replacement;

  @override
  FItemContentStyle call(FItemContentStyle _) => _replacement;
}

class _FItemContentStyleMerge implements FItemContentStyleDelta {
  const _FItemContentStyleMerge({
    this.padding,
    this.prefixIconStyle,
    this.prefixIconSpacing,
    this.titleTextStyle,
    this.titleSpacing,
    this.subtitleTextStyle,
    this.middleSpacing,
    this.detailsTextStyle,
    this.suffixIconStyle,
    this.suffixIconSpacing,
  });

  final EdgeInsetsGeometry? padding;

  final FWidgetStateMap<IconThemeData>? prefixIconStyle;

  final double? prefixIconSpacing;

  final FWidgetStateMap<TextStyle>? titleTextStyle;

  final double? titleSpacing;

  final FWidgetStateMap<TextStyle>? subtitleTextStyle;

  final double? middleSpacing;

  final FWidgetStateMap<TextStyle>? detailsTextStyle;

  final FWidgetStateMap<IconThemeData>? suffixIconStyle;

  final double? suffixIconSpacing;

  @override
  FItemContentStyle call(FItemContentStyle original) => FItemContentStyle(
    padding: padding ?? original.padding,
    prefixIconStyle: prefixIconStyle ?? original.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? original.prefixIconSpacing,
    titleTextStyle: titleTextStyle ?? original.titleTextStyle,
    titleSpacing: titleSpacing ?? original.titleSpacing,
    subtitleTextStyle: subtitleTextStyle ?? original.subtitleTextStyle,
    middleSpacing: middleSpacing ?? original.middleSpacing,
    detailsTextStyle: detailsTextStyle ?? original.detailsTextStyle,
    suffixIconStyle: suffixIconStyle ?? original.suffixIconStyle,
    suffixIconSpacing: suffixIconSpacing ?? original.suffixIconSpacing,
  );
}

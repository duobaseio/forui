import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

const _fontWeightSentinel = _FontWeightSentinel();
const _locale = Locale('sentinel');

// ignore: avoid_implementing_value_types
final class _FontWeightSentinel implements FontWeight {
  const _FontWeightSentinel();

  @override
  int get index => throw UnimplementedError();

  @override
  int get value => throw UnimplementedError();
}

/// A delta that applies modifications to a [TextStyle].
abstract class TextStyleDelta with Delta {
  /// Creates a partial modification of a [TextStyle].
  const factory TextStyleDelta.delta({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? Function()? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? Function()? textBaseline,
    double? height,
    TextLeadingDistribution? Function()? leadingDistribution,
    Locale? locale,
    Paint? Function()? foreground,
    Paint? Function()? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? Function()? decoration,
    Color? decorationColor,
    TextDecorationStyle? Function()? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? Function()? overflow,
  }) = _TextStyleDelta;

  /// Creates a complete replacement of a [TextStyle].
  const factory TextStyleDelta.value(TextStyle style) = _TextStyleValue;

  @override
  TextStyle call(TextStyle? style);
}

class _TextStyleDelta implements TextStyleDelta {
  final bool? inherit;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? Function()? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? Function()? textBaseline;
  final double? height;
  final TextLeadingDistribution? Function()? leadingDistribution;
  final Locale? locale;
  final Paint? Function()? foreground;
  final Paint? Function()? background;
  final List<Shadow>? shadows;
  final List<FontFeature>? fontFeatures;
  final List<FontVariation>? fontVariations;
  final TextDecoration? Function()? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? Function()? decorationStyle;
  final double? decorationThickness;
  final String? debugLabel;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;
  final String? package;
  final TextOverflow? Function()? overflow;

  const _TextStyleDelta({
    this.inherit,
    this.color = colorSentinel,
    this.backgroundColor = colorSentinel,
    this.fontSize = .infinity,
    this.fontWeight = _fontWeightSentinel,
    this.fontStyle,
    this.letterSpacing = .infinity,
    this.wordSpacing = .infinity,
    this.textBaseline,
    this.height = .infinity,
    this.leadingDistribution,
    this.locale = _locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor = colorSentinel,
    this.decorationStyle,
    this.decorationThickness = .infinity,
    this.debugLabel = stringSentinel,
    this.fontFamily = stringSentinel,
    this.fontFamilyFallback,
    this.package,
    this.overflow,
  });

  @override
  TextStyle call(TextStyle? style) => TextStyle(
    inherit: inherit ?? style?.inherit ?? true,
    color: identical(color, colorSentinel) ? style?.color : color,
    backgroundColor: identical(backgroundColor, colorSentinel) ? style?.backgroundColor : backgroundColor,
    fontSize: identical(fontSize, double.infinity) ? style?.fontSize : fontSize,
    fontWeight: identical(fontWeight, _fontWeightSentinel) ? style?.fontWeight : fontWeight,
    fontStyle: fontStyle != null ? fontStyle!() : style?.fontStyle,
    letterSpacing: identical(letterSpacing, double.infinity) ? style?.letterSpacing : letterSpacing,
    wordSpacing: identical(wordSpacing, double.infinity) ? style?.wordSpacing : wordSpacing,
    textBaseline: textBaseline != null ? textBaseline!() : style?.textBaseline,
    height: identical(height, double.infinity) ? style?.height : height,
    leadingDistribution: leadingDistribution != null ? leadingDistribution!() : style?.leadingDistribution,
    locale: identical(locale, _locale) ? style?.locale : locale,
    foreground: foreground != null ? foreground!() : style?.foreground,
    background: background != null ? background!() : style?.background,
    shadows: shadows ?? style?.shadows,
    fontFeatures: fontFeatures ?? style?.fontFeatures,
    fontVariations: fontVariations ?? style?.fontVariations,
    decoration: decoration != null ? decoration!() : style?.decoration,
    decorationColor: identical(decorationColor, colorSentinel) ? style?.decorationColor : decorationColor,
    decorationStyle: decorationStyle != null ? decorationStyle!() : style?.decorationStyle,
    decorationThickness: identical(decorationThickness, double.infinity)
        ? style?.decorationThickness
        : decorationThickness,
    debugLabel: identical(debugLabel, stringSentinel) ? style?.debugLabel : debugLabel,
    fontFamily: identical(fontFamily, stringSentinel) ? style?.fontFamily : fontFamily,
    fontFamilyFallback: fontFamilyFallback ?? style?.fontFamilyFallback,
    package: package, // Special case, null means no change since it is combined with fontFamily.
    overflow: overflow != null ? overflow!() : style?.overflow,
  );
}

class _TextStyleValue implements TextStyleDelta {
  final TextStyle _style;

  const _TextStyleValue(this._style);

  @override
  TextStyle call(TextStyle? style) => _style;
}

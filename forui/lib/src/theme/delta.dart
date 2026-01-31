import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
const nonNegativeIntSentinel = -1;

@internal
const stringSentinel = 'stringSentinel';

@internal
const colorSentinel = _ColorSentinel();

@internal
const imageFilterSentinel = _ImageFilterSentinel();

@internal
ImageFilter imageFilterFunctionSentinel(double animation) => throw UnimplementedError();

final class _ColorSentinel extends Color {
  const _ColorSentinel() : super(0);
}

final class _ImageFilterSentinel implements ImageFilter {
  const _ImageFilterSentinel();
}

/// A mixin for types that can be applied to a base value to produce a new value.
mixin Delta {
  /// Applies this delta to the given value.
  ///
  /// This method is covariant because of limitations with Dart's type system. Passing an [Object] to a [Delta] subclass
  /// will almost always result in a runtime error.
  ///
  /// ## Contract
  /// Subclasses must accept and return the same type. For example, a delta that accepts a [TextStyle] must return a
  /// [TextStyle]. The [value] may be nullable or non-null depending on the subclass.
  ///
  /// In general, deltas for in-built Flutter types accept nullable values, while style deltas do not.
  Object call(covariant Object? value);
}

const _borderRadiusSentinel = _BorderRadiusSentinel();
const _boxBorderSentinel = _BoxBorderSentinel();
const _decorationImageSentinel = _DecorationImageSentinel();
const _gradientSentinel = _GradientSentinel();

final class _BorderRadiusSentinel extends BorderRadiusGeometry {
  const _BorderRadiusSentinel();

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry subtract(BorderRadiusGeometry other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator -() => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator *(double other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator /(double other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator ~/(double other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator %(double other) => throw UnimplementedError();

  @override
  BorderRadius resolve(TextDirection? direction) => throw UnimplementedError();
}

final class _BoxBorderSentinel extends BoxBorder {
  const _BoxBorderSentinel();

  @override
  BorderSide get bottom => throw UnimplementedError();

  @override
  BorderSide get top => throw UnimplementedError();

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  bool get isUniform => throw UnimplementedError();

  @override
  ShapeBorder scale(double t) => throw UnimplementedError();

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) => throw UnimplementedError();
}

final class _DecorationImageSentinel extends DecorationImage {
  const _DecorationImageSentinel() : super(image: const _ImageProvider());
}

final class _ImageProvider extends ImageProvider {
  const _ImageProvider();

  @override
  Future<Object> obtainKey(ImageConfiguration configuration) => throw UnimplementedError();
}

final class _GradientSentinel extends Gradient {
  const _GradientSentinel() : super(colors: const []);

  @override
  Gradient scale(double factor) => throw UnimplementedError();

  @override
  Shader createShader(Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  Gradient withOpacity(double opacity) => throw UnimplementedError();
}

/// A delta that applies modifications to a [BoxDecoration].
sealed class BoxDecorationDelta with Delta {
  /// Creates a partial modification of a [BoxDecoration].
  const factory BoxDecorationDelta.delta({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? Function()? backgroundBlendMode,
    BoxShape? shape,
  }) = _BoxDecorationDelta;

  /// Creates a complete replacement for a [BoxDecoration].
  const factory BoxDecorationDelta.value(BoxDecoration decoration) = _BoxDecorationValue;

  @override
  BoxDecoration call(BoxDecoration? decoration);
}

class _BoxDecorationDelta implements BoxDecorationDelta {
  final Color? color;
  final DecorationImage? image;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BlendMode? Function()? backgroundBlendMode;
  final BoxShape? shape;

  const _BoxDecorationDelta({
    this.color = colorSentinel,
    this.image = _decorationImageSentinel,
    this.border = _boxBorderSentinel,
    this.borderRadius = _borderRadiusSentinel,
    this.boxShadow,
    this.gradient = _gradientSentinel,
    this.backgroundBlendMode,
    this.shape,
  });

  @override
  BoxDecoration call(BoxDecoration? decoration) => BoxDecoration(
    color: identical(color, colorSentinel) ? decoration?.color : color,
    image: identical(image, _decorationImageSentinel) ? decoration?.image : image,
    border: identical(border, _boxBorderSentinel) ? decoration?.border : border,
    borderRadius: identical(borderRadius, _borderRadiusSentinel) ? decoration?.borderRadius : borderRadius,
    boxShadow: boxShadow ?? decoration?.boxShadow,
    gradient: identical(gradient, _gradientSentinel) ? decoration?.gradient : gradient,
    backgroundBlendMode: backgroundBlendMode != null ? backgroundBlendMode!() : decoration?.backgroundBlendMode,
    shape: shape ?? decoration?.shape ?? .rectangle,
  );
}

class _BoxDecorationValue implements BoxDecorationDelta {
  final BoxDecoration _decoration;

  const _BoxDecorationValue(this._decoration);

  @override
  BoxDecoration call(BoxDecoration? decoration) => _decoration;
}

/// A delta that applies modifications to an [IconThemeData].
sealed class IconThemeDataDelta with Delta {
  /// Creates a partial modification of an [IconThemeData].
  const factory IconThemeDataDelta.delta({
    Color? color,
    double? opacity,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    List<Shadow>? shadows,
    bool? Function()? applyTextScaling,
  }) = _IconThemeDataDelta;

  /// Creates a complete replacement of an [IconThemeData].
  const factory IconThemeDataDelta.value(IconThemeData data) = _IconThemeDataValue;

  @override
  IconThemeData call(IconThemeData? data);
}

class _IconThemeDataDelta implements IconThemeDataDelta {
  final Color? color;
  final double? opacity;
  final double? size;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final bool? Function()? applyTextScaling;

  const _IconThemeDataDelta({
    this.color = colorSentinel,
    this.opacity = .infinity,
    this.size = .infinity,
    this.fill = .infinity,
    this.weight = .infinity,
    this.grade = .infinity,
    this.opticalSize = .infinity,
    this.shadows,
    this.applyTextScaling,
  });

  @override
  IconThemeData call(IconThemeData? data) => IconThemeData(
    color: identical(color, colorSentinel) ? data?.color : color,
    opacity: identical(opacity, double.infinity) ? data?.opacity : opacity,
    size: identical(size, double.infinity) ? data?.size : size,
    fill: identical(fill, double.infinity) ? data?.fill : fill,
    weight: identical(weight, double.infinity) ? data?.weight : weight,
    grade: identical(grade, double.infinity) ? data?.grade : grade,
    opticalSize: identical(opticalSize, double.infinity) ? data?.opticalSize : opticalSize,
    shadows: shadows ?? data?.shadows,
    applyTextScaling: applyTextScaling != null ? applyTextScaling!() : data?.applyTextScaling,
  );
}

class _IconThemeDataValue implements IconThemeDataDelta {
  final IconThemeData _data;

  const _IconThemeDataValue(this._data);

  @override
  IconThemeData call(IconThemeData? data) => _data;
}

const _fontWeightSentinel = _FontWeightSentinel();
const _locale = Locale('sentinel');
const _textDecorationSentinel = _TextDecorationSentinel();

final class _FontWeightSentinel implements FontWeight {
  const _FontWeightSentinel();

  @override
  int get index => throw UnimplementedError();

  @override
  int get value => throw UnimplementedError();
}

// ignore: avoid_implementing_value_types
final class _TextDecorationSentinel implements TextDecoration {
  const _TextDecorationSentinel();

  @override
  bool contains(TextDecoration other) => throw UnimplementedError();

  // This needs to be provided: https://github.com/flutter/flutter/issues/181662
  int get maskValue => 0;
}

/// A delta that applies modifications to a [TextStyle].
sealed class TextStyleDelta with Delta {
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
    TextDecoration? decoration,
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
  final TextDecoration? decoration;
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
    this.decoration = _textDecorationSentinel,
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
    decoration: identical(decoration, _textDecorationSentinel) ? style?.decoration : decoration,
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

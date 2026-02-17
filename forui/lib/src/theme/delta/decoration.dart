import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

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
abstract class BoxDecorationDelta with Delta {
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

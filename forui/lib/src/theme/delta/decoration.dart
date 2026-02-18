import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

const _borderRadiusSentinel = _BorderRadiusSentinel();
const _boxBorderSentinel = _BoxBorderSentinel();
const _decorationImageSentinel = _DecorationImageSentinel();
const _gradientSentinel = _GradientSentinel();
const _shapeBorderSentinel = _ShapeBorderSentinel();

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

final class _ShapeBorderSentinel extends ShapeBorder {
  const _ShapeBorderSentinel();

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  ShapeBorder scale(double t) => throw UnimplementedError();
}

/// A delta that applies modifications to a [ShapeDecoration].
abstract class ShapeDecorationDelta with Delta {
  /// Creates a partial modification of a [ShapeDecoration].
  const factory ShapeDecorationDelta.delta({
    Color? color,
    DecorationImage? image,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    ShapeBorder? shape,
  }) = _ShapeDelta;

  /// Creates a complete replacement for a [ShapeDecoration].
  const factory ShapeDecorationDelta.value(ShapeDecoration decoration) = _ShapeValue;

  @override
  ShapeDecoration call(ShapeDecoration? decoration);
}

class _ShapeDelta implements ShapeDecorationDelta {
  final Color? color;
  final DecorationImage? image;
  final Gradient? gradient;
  final List<BoxShadow>? shadows;
  final ShapeBorder? shape;

  const _ShapeDelta({
    this.color = colorSentinel,
    this.image = _decorationImageSentinel,
    this.gradient = _gradientSentinel,
    this.shadows,
    this.shape = _shapeBorderSentinel,
  });

  @override
  ShapeDecoration call(ShapeDecoration? decoration) => ShapeDecoration(
    color: identical(color, colorSentinel) ? decoration?.color : color,
    image: identical(image, _decorationImageSentinel) ? decoration?.image : image,
    gradient: identical(gradient, _gradientSentinel) ? decoration?.gradient : gradient,
    shadows: shadows ?? decoration?.shadows,
    shape: identical(shape, _shapeBorderSentinel) ? decoration?.shape ?? const RoundedRectangleBorder() : shape!,
  );
}

class _ShapeValue implements ShapeDecorationDelta {
  final ShapeDecoration _decoration;

  const _ShapeValue(this._decoration);

  @override
  ShapeDecoration call(ShapeDecoration? decoration) => _decoration;
}

/// A delta that applies modifications to a [Decoration].
abstract class DecorationDelta with Delta {
  /// Creates a partial modification that always produces a [BoxDecoration].
  ///
  /// When applied to a [ShapeDecoration], coerces compatible [ShapeBorder] fields (border, borderRadius, shape) on a
  /// best-effort basis.
  ///
  /// ## Contract
  /// Throws an error if applied to a [Decoration] that is neither a [BoxDecoration] nor [ShapeDecoration].
  const factory DecorationDelta.boxDelta({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? Function()? backgroundBlendMode,
    BoxShape? shape,
  }) = _DecorationBoxDelta;

  /// Creates a partial modification that always produces a [ShapeDecoration].
  ///
  /// When applied to a [BoxDecoration], converts via [ShapeDecoration.fromBoxDecoration].
  ///
  /// ## Contract
  /// Throws an error if applied to a [Decoration] that is neither a [BoxDecoration] nor [ShapeDecoration].
  const factory DecorationDelta.shapeDelta({
    Color? color,
    DecorationImage? image,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    ShapeBorder? shape,
  }) = _DecorationShapeDelta;

  /// Creates a complete replacement for a [Decoration].
  const factory DecorationDelta.value(Decoration decoration) = _ValueDelta;

  @override
  Decoration call(Decoration? decoration);
}

class _DecorationBoxDelta extends _BoxDelta implements DecorationDelta {
  const _DecorationBoxDelta({
    super.color,
    super.image,
    super.border,
    super.borderRadius,
    super.boxShadow,
    super.gradient,
    super.backgroundBlendMode,
    super.shape,
  });

  @override
  BoxDecoration call(covariant Decoration? decoration) => switch (decoration) {
    final BoxDecoration? decoration => super(decoration),
    final ShapeDecoration decoration => _shape(decoration),
    _ => throw UnsupportedError('DecorationDelta.boxDelta does not support ${decoration.runtimeType}.'),
  };

  BoxDecoration _shape(ShapeDecoration decoration) {
    final (BoxBorder? border, BorderRadiusGeometry? borderRadius, BoxShape shape) = switch (decoration.shape) {
      BoxBorder border => (border, null, .rectangle),
      CircleBorder(:final side) => (side == .none ? null : .fromBorderSide(side), null, .circle),
      final OutlinedBorder border => (
        border.side == .none ? null : .fromBorderSide(border.side),
        switch (border) {
          BeveledRectangleBorder(:final borderRadius) => borderRadius,
          ContinuousRectangleBorder(:final borderRadius) => borderRadius,
          RoundedRectangleBorder(:final borderRadius) => borderRadius,
          RoundedSuperellipseBorder(:final borderRadius) => borderRadius,
          _ => null,
        },
        .rectangle,
      ),
      _ => (null, null, .rectangle),
    };

    return BoxDecoration(
      color: identical(color, colorSentinel) ? decoration.color : color,
      image: identical(image, _decorationImageSentinel) ? decoration.image : image,
      border: identical(this.border, _boxBorderSentinel) ? border : this.border,
      borderRadius: identical(this.borderRadius, _borderRadiusSentinel) ? borderRadius : this.borderRadius,
      boxShadow: boxShadow ?? decoration.shadows,
      gradient: identical(gradient, _gradientSentinel) ? decoration.gradient : gradient,
      backgroundBlendMode: backgroundBlendMode?.call(),
      shape: this.shape ?? shape,
    );
  }
}

class _DecorationShapeDelta extends _ShapeDelta implements DecorationDelta {
  const _DecorationShapeDelta({super.color, super.image, super.gradient, super.shadows, super.shape});

  @override
  ShapeDecoration call(covariant Decoration? decoration) => switch (decoration) {
    final ShapeDecoration? decoration => super(decoration),
    final BoxDecoration decoration => super(.fromBoxDecoration(decoration)),
    _ => throw UnsupportedError('DecorationDelta.shapeDelta does not support ${decoration.runtimeType}.'),
  };
}

class _ValueDelta implements DecorationDelta {
  final Decoration _decoration;

  const _ValueDelta(this._decoration);

  @override
  Decoration call(Decoration? decoration) => _decoration;
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
  }) = _BoxDelta;

  /// Creates a complete replacement for a [BoxDecoration].
  const factory BoxDecorationDelta.value(BoxDecoration decoration) = _BoxValue;

  @override
  BoxDecoration call(BoxDecoration? decoration);
}

class _BoxDelta implements BoxDecorationDelta {
  final Color? color;
  final DecorationImage? image;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BlendMode? Function()? backgroundBlendMode;
  final BoxShape? shape;

  const _BoxDelta({
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

class _BoxValue implements BoxDecorationDelta {
  final BoxDecoration _decoration;

  const _BoxValue(this._decoration);

  @override
  BoxDecoration call(BoxDecoration? decoration) => _decoration;
}

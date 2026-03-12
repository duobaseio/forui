import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

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
    this.color = Sentinels.color,
    this.image = Sentinels.decorationImage,
    this.gradient = Sentinels.gradient,
    this.shadows,
    this.shape = Sentinels.shapeBorder,
  });

  @override
  ShapeDecoration call(ShapeDecoration? decoration) => ShapeDecoration(
    color: identical(color, Sentinels.color) ? decoration?.color : color,
    image: identical(image, Sentinels.decorationImage) ? decoration?.image : image,
    gradient: identical(gradient, Sentinels.gradient) ? decoration?.gradient : gradient,
    shadows: shadows ?? decoration?.shadows,
    shape: identical(shape, Sentinels.shapeBorder) ? decoration?.shape ?? const RoundedRectangleBorder() : shape!,
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
      color: identical(color, Sentinels.color) ? decoration.color : color,
      image: identical(image, Sentinels.decorationImage) ? decoration.image : image,
      border: identical(this.border, Sentinels.boxBorder) ? border : this.border,
      borderRadius: identical(this.borderRadius, Sentinels.borderRadius) ? borderRadius : this.borderRadius,
      boxShadow: boxShadow ?? decoration.shadows,
      gradient: identical(gradient, Sentinels.gradient) ? decoration.gradient : gradient,
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
    this.color = Sentinels.color,
    this.image = Sentinels.decorationImage,
    this.border = Sentinels.boxBorder,
    this.borderRadius = Sentinels.borderRadius,
    this.boxShadow,
    this.gradient = Sentinels.gradient,
    this.backgroundBlendMode,
    this.shape,
  });

  @override
  BoxDecoration call(BoxDecoration? decoration) => BoxDecoration(
    color: identical(color, Sentinels.color) ? decoration?.color : color,
    image: identical(image, Sentinels.decorationImage) ? decoration?.image : image,
    border: identical(border, Sentinels.boxBorder) ? decoration?.border : border,
    borderRadius: identical(borderRadius, Sentinels.borderRadius) ? decoration?.borderRadius : borderRadius,
    boxShadow: boxShadow ?? decoration?.boxShadow,
    gradient: identical(gradient, Sentinels.gradient) ? decoration?.gradient : gradient,
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

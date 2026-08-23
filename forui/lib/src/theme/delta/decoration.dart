import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

/// A delta that applies modifications to a [ShapeDecoration].
abstract class ShapeDecorationDelta with Delta {
  /// Creates a partial modification of a [ShapeDecoration].
  const factory delta({
    Color? color,
    DecorationImage? image,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    ShapeBorder? shape,
  }) = _ShapeDelta;

  /// Creates a complete replacement for a [ShapeDecoration].
  const factory value(ShapeDecoration decoration) = _ShapeValue;

  @override
  ShapeDecoration call(ShapeDecoration? decoration);
}

class const _ShapeDelta({
  final Color? color = Sentinels.color,
  final DecorationImage? image = Sentinels.decorationImage,
  final Gradient? gradient = Sentinels.gradient,
  final List<BoxShadow>? shadows,
  final ShapeBorder? shape = Sentinels.shapeBorder,
}) implements ShapeDecorationDelta {
  @override
  ShapeDecoration call(ShapeDecoration? decoration) => ShapeDecoration(
    color: identical(color, Sentinels.color) ? decoration?.color : color,
    image: identical(image, Sentinels.decorationImage) ? decoration?.image : image,
    gradient: identical(gradient, Sentinels.gradient) ? decoration?.gradient : gradient,
    shadows: shadows ?? decoration?.shadows,
    shape: identical(shape, Sentinels.shapeBorder) ? decoration?.shape ?? const RoundedRectangleBorder() : shape!,
  );
}

class const _ShapeValue(final ShapeDecoration _decoration) implements ShapeDecorationDelta {
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
  const factory boxDelta({
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
  const factory shapeDelta({
    Color? color,
    DecorationImage? image,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    ShapeBorder? shape,
  }) = _DecorationShapeDelta;

  /// Creates a complete replacement for a [Decoration].
  const factory value(Decoration decoration) = _ValueDelta;

  @override
  Decoration call(Decoration? decoration);
}

class const _DecorationBoxDelta({
  super.color,
  super.image,
  super.border,
  super.borderRadius,
  super.boxShadow,
  super.gradient,
  super.backgroundBlendMode,
  super.shape,
}) extends _BoxDelta implements DecorationDelta {
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

class const _DecorationShapeDelta({super.color, super.image, super.gradient, super.shadows, super.shape})
    extends _ShapeDelta
    implements DecorationDelta {
  @override
  ShapeDecoration call(covariant Decoration? decoration) => switch (decoration) {
    final ShapeDecoration? decoration => super(decoration),
    final BoxDecoration decoration => super(.fromBoxDecoration(decoration)),
    _ => throw UnsupportedError('DecorationDelta.shapeDelta does not support ${decoration.runtimeType}.'),
  };
}

class const _ValueDelta(final Decoration _decoration) implements DecorationDelta {
  @override
  Decoration call(Decoration? decoration) => _decoration;
}

/// A delta that applies modifications to a [BoxDecoration].
abstract class BoxDecorationDelta with Delta {
  /// Creates a partial modification of a [BoxDecoration].
  const factory delta({
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
  const factory value(BoxDecoration decoration) = _BoxValue;

  @override
  BoxDecoration call(BoxDecoration? decoration);
}

class const _BoxDelta({
  final Color? color = Sentinels.color,
  final DecorationImage? image = Sentinels.decorationImage,
  final BoxBorder? border = Sentinels.boxBorder,
  final BorderRadiusGeometry? borderRadius = Sentinels.borderRadius,
  final List<BoxShadow>? boxShadow,
  final Gradient? gradient = Sentinels.gradient,
  final BlendMode? Function()? backgroundBlendMode,
  final BoxShape? shape,
}) implements BoxDecorationDelta {
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

class const _BoxValue(final BoxDecoration _decoration) implements BoxDecorationDelta {
  @override
  BoxDecoration call(BoxDecoration? decoration) => _decoration;
}

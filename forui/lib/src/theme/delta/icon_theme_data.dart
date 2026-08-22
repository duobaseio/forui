import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

/// A delta that applies modifications to an [IconThemeData].
abstract class IconThemeDataDelta with Delta {
  /// Creates a partial modification of an [IconThemeData].
  const factory delta({
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
  const factory value(IconThemeData data) = _IconThemeDataValue;

  @override
  IconThemeData call(IconThemeData? data);
}

class const _IconThemeDataDelta({
  final Color? color = Sentinels.color,
  final double? opacity = .infinity,
  final double? size = .infinity,
  final double? fill = .infinity,
  final double? weight = .infinity,
  final double? grade = .infinity,
  final double? opticalSize = .infinity,
  final List<Shadow>? shadows,
  final bool? Function()? applyTextScaling,
}) implements IconThemeDataDelta {
  @override
  IconThemeData call(IconThemeData? data) => IconThemeData(
    color: identical(color, Sentinels.color) ? data?.color : color,
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

class const _IconThemeDataValue(final IconThemeData _data) implements IconThemeDataDelta {
  @override
  IconThemeData call(IconThemeData? data) => _data;
}

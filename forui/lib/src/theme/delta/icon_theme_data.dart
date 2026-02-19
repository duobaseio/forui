import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

/// A delta that applies modifications to an [IconThemeData].
abstract class IconThemeDataDelta with Delta {
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

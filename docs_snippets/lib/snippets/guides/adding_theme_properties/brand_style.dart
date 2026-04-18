import 'package:flutter/material.dart';

class BrandStyle extends ThemeExtension<BrandStyle> {
  final Color color;
  final BorderRadius borderRadius;

  const BrandStyle({required this.color, required this.borderRadius});

  @override
  BrandStyle copyWith({Color? color, BorderRadius? borderRadius}) =>
      BrandStyle(color: color ?? this.color, borderRadius: borderRadius ?? this.borderRadius);

  @override
  BrandStyle lerp(BrandStyle? other, double t) {
    if (other is! BrandStyle) {
      return this;
    }

    return BrandStyle(color: .lerp(color, other.color, t)!, borderRadius: .lerp(borderRadius, other.borderRadius, t)!);
  }
}

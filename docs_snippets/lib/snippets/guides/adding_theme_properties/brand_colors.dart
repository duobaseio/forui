import 'package:flutter/material.dart';

class BrandColors extends ThemeExtension<BrandColors> {
  final Color accent;
  final Color accentForeground;

  const BrandColors({required this.accent, required this.accentForeground});

  @override
  BrandColors copyWith({Color? accent, Color? accentForeground}) =>
      BrandColors(accent: accent ?? this.accent, accentForeground: accentForeground ?? this.accentForeground);

  @override
  BrandColors lerp(BrandColors? other, double t) {
    if (other is! BrandColors) {
      return this;
    }

    return BrandColors(
      accent: .lerp(accent, other.accent, t)!,
      accentForeground: .lerp(accentForeground, other.accentForeground, t)!,
    );
  }
}

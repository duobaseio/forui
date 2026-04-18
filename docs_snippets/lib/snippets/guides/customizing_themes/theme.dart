// ignore_for_file: avoid_redundant_argument_values, always_use_package_imports, unused_import
// {@snippet}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'accordion_style.dart';

// {@highlight}
// {@endhighlight}

// {@endsnippet}

FAccordionStyle accordionStyle({required FColors colors, required FTypography typography, required FStyle style}) =>
    throw UnimplementedError();

// {@snippet}
FThemeData get neutralLight {
  // Change this to false to generate a desktop variant of the theme.
  const touch = true;

  final colors = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: const Color(0x33000000),
    background: const Color(0xFFFFFFFF),
    foreground: const Color(0xFF0A0A0A),
    primary: const Color(0xFF171717),
    primaryForeground: const Color(0xFFFAFAFA),
    secondary: const Color(0xFFF5F5F5),
    secondaryForeground: const Color(0xFF171717),
    muted: const Color(0xFFF5F5F5),
    mutedForeground: const Color(0xFF737373),
    destructive: const Color(0xFFE7000B),
    destructiveForeground: const Color(0xFFFAFAFA),
    error: const Color(0xFFE7000B),
    errorForeground: const Color(0xFFFAFAFA),
    card: const Color(0xFFFFFFFF),
    border: const Color(0xFFE5E5E5),
  );

  final typography = _typography(colors: colors, touch: touch);
  final style = _style(colors: colors, typography: typography, touch: touch);

  return FThemeData(colors: colors, typography: typography, style: style, touch: touch);
}

FTypography _typography({required FColors colors, required bool touch, String fontFamily = 'packages/forui/Inter'}) {
  assert(fontFamily.isNotEmpty, 'fontFamily ($fontFamily) should not be empty.');
  final color = colors.foreground;
  final font = fontFamily;
  if (touch) {
    return FTypography(
      fontFamily: fontFamily,
      xs3: TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
      xs2: TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
      xs: TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
      sm: TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
      md: TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
      lg: TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
      xl: TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
      xl2: TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
      xl3: TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
      xl4: TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
      xl5: TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
      xl6: TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
      xl7: TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
      xl8: TextStyle(color: color, fontFamily: font, fontSize: 108, height: 1, leadingDistribution: .even),
    );
  } else {
    return FTypography(
      fontFamily: fontFamily,
      xs3: TextStyle(color: color, fontFamily: font, fontSize: 8, height: 1, leadingDistribution: .even),
      xs2: TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
      xs: TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
      sm: TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
      md: TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
      lg: TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
      xl: TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
      xl2: TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
      xl3: TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
      xl4: TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
      xl5: TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
      xl6: TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
      xl7: TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
      xl8: TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
    );
  }
}

FStyle _style({required FColors colors, required FTypography typography, required bool touch}) {
  const borderRadius = FBorderRadius();
  return FStyle(
    formFieldStyle: .inherit(colors: colors, typography: typography, touch: touch),
    focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: borderRadius.md),
    iconStyle: IconThemeData(color: colors.foreground, size: typography.lg.fontSize),
    sizes: FSizes.inherit(touch: touch),
    tappableStyle: FTappableStyle(),
    borderRadius: const FBorderRadius(),
    borderWidth: 1,
    pagePadding: const .symmetric(vertical: 8, horizontal: 12),
    shadow: const [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 2)],
  );
}

// {@endsnippet}

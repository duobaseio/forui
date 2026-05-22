import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_colors.dart';

final colors =
    // {@snippet constructor}
    FColors(
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
      // {@highlight}
      extensions: [const BrandColors(accent: Color(0xFF6366F1), accentForeground: Color(0xFFFFFFFF))],
      // {@endhighlight}
    );
// {@endsnippet}

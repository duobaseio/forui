import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_colors.dart';

// {@snippet}
final colors = FThemes.neutral.light.touch.colors.copyWith(
  extensions: [const BrandColors(accent: Color(0xFF6366F1), accentForeground: Color(0xFFFFFFFF))],
);
// {@endsnippet}

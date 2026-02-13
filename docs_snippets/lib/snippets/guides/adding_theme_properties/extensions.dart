import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_color.dart';

final theme =
    // {@snippet constructor}
    FThemeData(
      colors: FThemes.neutral.light.colors,
      // ... other theme properties
      extensions: [const BrandColor(color: Color(0xFF6366F1))],
    );
// {@endsnippet}

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_style.dart';

final theme =
    // {@snippet constructor}
    FThemeData(
      colors: FThemes.neutral.light.touch.colors,
      // ... other theme properties
      touch: true,
      extensions: [
        const BrandStyle(color: Color(0xFF6366F1), borderRadius: .all(.circular(8))),
      ],
    );
// {@endsnippet}

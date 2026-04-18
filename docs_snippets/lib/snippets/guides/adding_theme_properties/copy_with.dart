import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_style.dart';

// {@snippet}
final theme = FThemes.neutral.light.touch.copyWith(
  extensions: [const BrandStyle(color: Color(0xFF6366F1), borderRadius: .all(.circular(8)))],
);
// {@endsnippet}

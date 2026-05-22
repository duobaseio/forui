import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_colors.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final brand = context.theme.colors.extension<BrandColors>();
  return DecoratedBox(
    decoration: BoxDecoration(
      color: brand.accent,
      border: .all(color: brand.accentForeground),
    ),
  );
}

// {@endsnippet}

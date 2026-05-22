import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/adding_theme_properties/brand_colors.dart';

// {@snippet}
extension BrandColorsExtension on FColors {
  BrandColors get brand => extension<BrandColors>();

  // Alternatively, you can create a getter to access extension fields directly.
  Color get accent => extension<BrandColors>().accent;
}

// {@endsnippet}

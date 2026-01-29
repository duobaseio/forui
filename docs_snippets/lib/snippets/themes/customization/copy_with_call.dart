
import 'package:forui/forui.dart';

final colors = FThemes.zinc.light.colors;
final typography = FThemes.zinc.light.typography;
final style = FThemes.zinc.light.style;

final a =
    // {@snippet constructor}
    // Complete replacement using .value()
    FAccordion(
      style: .value(.inherit(colors: colors, typography: typography, style: style)),
      children: const [],
    );
// {@endsnippet}

const b =
    // {@snippet constructor}
    // Short-form
    FAccordion(
      style: .delta(titlePadding: .symmetric(vertical: 20)),
      children: [],
    );
// {@endsnippet}

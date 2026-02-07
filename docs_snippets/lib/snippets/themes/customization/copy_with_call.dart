import 'package:forui/forui.dart';

final colors = FThemes.neutral.light.colors;
final typography = FThemes.neutral.light.typography;
final style = FThemes.neutral.light.style;

final a =
    // {@snippet constructor}
    // Complete replacement by passing a style directly
    FAccordion(
      style: FAccordionStyle.inherit(colors: colors, typography: typography, style: style),
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

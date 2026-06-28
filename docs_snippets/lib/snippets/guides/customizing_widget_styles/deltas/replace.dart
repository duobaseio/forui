import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

late BuildContext context;

final accordion =
    // {@snippet constructor}
    FAccordion(
      // Replace the entire style with a new one based on the neutral theme.
      style: FAccordionStyle.inherit(
        colors: FTheme.neutral.light.touch.colors,
        typography: FTheme.neutral.light.touch.typography,
        style: FTheme.neutral.light.touch.style,
        touch: true,
      ),
      children: const [],
    );
// {@endsnippet}

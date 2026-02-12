import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

late BuildContext context;

final accordion =
    // {@snippet constructor}
    FAccordion(
      // Replace the entire style with a new one based on the green theme.
      style: FAccordionStyle.inherit(
        colors: FThemes.green.light.colors,
        typography: FThemes.green.light.typography,
        style: FThemes.green.light.style,
      ),
      children: const [],
    );
// {@endsnippet}

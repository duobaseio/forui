import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

late BuildContext context;

final accordion =
    // {@snippet constructor}
    FAccordion(
      // Replace the entire style with a new one based on the green theme.
      style: FAccordionStyle.inherit(
        colors: FColors.zinc.light.withPrimary(FPrimaryColors.green.light),
        typography: FThemeData(touch: true, colors: FColors.zinc.light.withPrimary(FPrimaryColors.green.light)).typography,
        style: FThemeData(touch: true, colors: FColors.zinc.light.withPrimary(FPrimaryColors.green.light)).style,
        touch: true,
      ),
      children: const [],
    );
// {@endsnippet}

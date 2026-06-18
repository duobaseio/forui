import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final typography = FThemes.neutral.light.touch.typography;
  return FTheme(
    data: FThemeData(
      colors: FThemes.neutral.light.touch.colors,
      // {@highlight}
      typography: typography
          .copyWith(body: typography.body.copyWith(xs: const TextStyle(fontSize: 12, height: 1)))
          .scale(sizeScalar: 0.8),
      // {@endhighlight}
      touch: true,
    ),
    child: const FScaffold(child: Placeholder()),
  );
}

// {@endsnippet}

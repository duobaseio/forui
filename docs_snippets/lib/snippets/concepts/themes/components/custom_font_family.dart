import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FThemeData(
    colors: FColors.neutral.light,
    // {@highlight}
    typography: FThemeData(touch: true, colors: FColors.neutral.light).typography
        .copyWith(xs: const TextStyle(fontSize: 12, height: 1))
        .scale(sizeScalar: 0.8),
    // {@endhighlight}
    touch: true,
  ),
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

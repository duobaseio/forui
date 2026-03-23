import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  // {@highlight}
  data: FThemeData(touch: true, colors: FColors.neutral.light), // or FThemeData(touch: true, colors: FColors.neutral.dark)
  // {@endhighlight}
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

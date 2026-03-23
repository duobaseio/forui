import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FThemeData(touch: true, colors: FColors.neutral.light), // or FThemeData(touch: false, colors: FColors.neutral.light)
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

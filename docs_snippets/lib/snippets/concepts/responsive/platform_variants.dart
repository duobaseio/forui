import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FThemes.neutral.light.touch, // or FThemes.neutral.light.desktop
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

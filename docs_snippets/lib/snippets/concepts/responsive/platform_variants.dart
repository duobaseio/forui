import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FTheme.neutral.light.touch, // or FTheme.neutral.light.desktop
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  // {@highlight}
  data: FTheme.neutral.light.touch, // or FTheme.neutral.dark.touch
  // {@endhighlight}
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

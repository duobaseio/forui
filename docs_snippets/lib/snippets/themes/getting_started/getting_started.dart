import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  // {@highlight}
  data: FThemes.neutral.light, // or FThemes.neutral.dark
  // {@endhighlight}
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

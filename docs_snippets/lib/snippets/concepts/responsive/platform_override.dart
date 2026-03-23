import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FThemeData(touch: false, colors: FColors.neutral.light),
  // {@highlight}
  platform: FPlatformVariant.iOS, // overrides the detected platform
  // {@endhighlight}
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FThemes.neutral.light.desktop,
  // {@highlight}
  platform: FPlatformVariant.iOS, // overrides the detected platform
  // {@endhighlight}
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}

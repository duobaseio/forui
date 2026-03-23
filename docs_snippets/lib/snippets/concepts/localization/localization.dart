import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final app =
    // {@snippet constructor}
    MaterialApp(
      // {@highlight}
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      // {@endhighlight}
      builder: (context, child) => FTheme(data: FThemeData(touch: true, colors: FColors.neutral.light), child: child!),
      home: const FScaffold(child: Placeholder()),
    );
// {@endsnippet}

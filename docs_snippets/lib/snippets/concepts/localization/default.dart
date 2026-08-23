import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

final app =
    // {@snippet constructor}
    MaterialApp(
      localizationsDelegates: const [
        // {@highlight}
        FLocalizations.delegate, // Add this line
        // {@endhighlight}
      ],
      supportedLocales: const [
        // {@highlight}
        // Add locales supported by your application here.
        // {@endhighlight}
      ],
      builder: (context, child) => FTheme(data: FTheme.neutral.light.touch, child: child!),
      home: const FScaffold(child: Placeholder()),
    );
// {@endsnippet}

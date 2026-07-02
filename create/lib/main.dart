import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

void main() {
  if (kDebugMode) {
    MarionetteBinding.ensureInitialized();
  }
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FTheme.neutral.light.desktop;

    return MaterialApp(
      title: 'Forui Create',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, child) => FTheme(data: theme, child: child!),
      home: FScaffold(
        // TODO: replace this placeholder with the theme builder UI.
        child: Center(
          child: FButton(mainAxisSize: .min, onPress: () {}, child: const Text('Placeholder')),
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Autocomplete, Badge, Dialog, TextField, Tooltip;

import 'package:forui/forui.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

import 'widgets/text_field.dart';

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
    final theme = FThemes.zinc.light.desktop;

    return MaterialApp(
      title: 'Forui Widget Spotlight',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, child) => FTheme(
        data: theme,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      home: const FScaffold(child: TextField()),
    );
  }
}

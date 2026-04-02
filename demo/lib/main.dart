import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'widgets/pagination.dart';

void main() {
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
        child: FToaster(
          child: FTooltipGroup(
            child: child!,
          ),
        ),
      ),
      home: const FScaffold(
        child: Pagination(),
      ),
    );
  }
}

import 'package:flutter/material.dart' hide Autocomplete, Badge, Tooltip;
import 'package:forui/forui.dart';

import 'widgets/badge.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc.light.desktop.copyWith(
      badgeStyles: FVariantsDelta.delta([
        FVariantOperation.all(
          FBadgeStyleDelta.delta(
            contentStyle: FBadgeContentStyleDelta.delta(
              padding: const EdgeInsetsGeometryDelta.scale(4),
              labelTextStyle: const TextStyleDelta.delta(fontSize: 48),
            ),
          ),
        ),
      ]),
    );

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
        child: Badge(),
      ),
    );
  }
}

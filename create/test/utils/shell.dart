import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A [MaterialApp] configured like the application shell in main.dart.
Widget shell({required Widget child}) {
  final theme = FTheme.neutral.light.desktop;
  return MaterialApp(
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    theme: theme.toApproximateMaterialTheme(),
    builder: (_, navigator) => FTheme(data: theme, child: navigator!),
    home: child,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

import 'package:forui/forui.dart';
import 'package:forui_example/sandbox.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  enableFlutterDriverExtension();

  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();

  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc.light;

    return MaterialApp(
      locale: const Locale('en', 'US'),
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: theme.toApproximateMaterialTheme(),
      builder: (context, child) => FTheme(
        data: theme,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Sandbox()),
      ),
    );
  }
}

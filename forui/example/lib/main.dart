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

List<Widget> _pages = [
  const Text('Home'),
  const Text('Categories'),
  const Text('Search'),
  const Text('Settings'),
  const Sandbox(),
];

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with SingleTickerProviderStateMixin {
  int index = 4;
  bool dark = false;

  FThemeData get _theme => dark ? FThemes.zinc.dark : FThemes.zinc.light;

  void toggleTheme() => setState(() => dark = !dark);

  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en', 'US'),
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    theme: _theme.toApproximateMaterialTheme(),
    builder: (context, child) => FTheme(
      data: _theme,
      child: FToaster(child: FTooltipGroup(child: child!)),
    ),
    home: Builder(
      builder: (context) {
        return FScaffold(
          header: FHeader(
            title: const Text('Example'),
            suffixes: [FHeaderAction(icon: Icon(dark ? FIcons.sun : FIcons.moon), onPress: toggleTheme)],
          ),
          footer: FBottomNavigationBar(
            index: index,
            onChange: (index) => setState(() => this.index = index),
            children: const [
              FBottomNavigationBarItem(icon: Icon(FIcons.house)),
              FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid)),
              FBottomNavigationBarItem(icon: Icon(FIcons.search)),
              FBottomNavigationBarItem(icon: Icon(FIcons.settings)),
              FBottomNavigationBarItem(icon: Icon(FIcons.castle)),
            ],
          ),
          child: _pages[index],
        );
      },
    ),
  );
}

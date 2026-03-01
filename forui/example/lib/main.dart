import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui_example/sandbox.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
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
  Brightness brightness = .light;
  FPlatformVariant platform = (defaultTargetPlatform == .iOS || defaultTargetPlatform == .android) ? .iOS : .macOS;

  @override
  Widget build(BuildContext context) {
    final brightnessTheme = brightness == .light ? FThemes.zinc.light : FThemes.zinc.dark;
    final theme = platform.desktop ? brightnessTheme.desktop : brightnessTheme.touch;

    return MaterialApp(
      locale: const Locale('en', 'US'),
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: theme.toApproximateMaterialTheme(),
      builder: (context, child) => FTheme(
        data: theme,
        platform: platform,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
      home: Builder(
        builder: (context) {
          return FScaffold(
            header: FHeader(
              title: const Text('Example'),
              suffixes: [
                FHeaderAction(
                  icon: Icon(platform.desktop ? FIcons.smartphone : FIcons.monitor),
                  onPress: togglePlatform,
                ),
                FHeaderAction(icon: Icon(brightness == .dark ? FIcons.sun : FIcons.moon), onPress: toggleTheme),
                FHeaderAction(icon: const Icon(FIcons.mousePointerClick), onPress: toggleWidgetInspector),
              ],
            ),
            footer: FBottomNavigationBar(
              index: index,
              onChange: (index) => setState(() => this.index = index),
              children: const [
                FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
                FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Grid')),
                FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('Search')),
                FBottomNavigationBarItem(icon: Icon(FIcons.settings), label: Text('Settings')),
                FBottomNavigationBarItem(icon: Icon(FIcons.castle), label: Text('Sandbox')),
              ],
            ),
            child: _pages[index],
          );
        },
      ),
    );
  }

  void togglePlatform() => setState(() => platform = platform.desktop ? .iOS : .macOS);

  void toggleTheme() => setState(() => brightness = brightness == .light ? .dark : .light);

  void toggleWidgetInspector() => setState(() {
    final binding = WidgetsBinding.instance;
    binding.debugShowWidgetInspectorOverride = !binding.debugShowWidgetInspectorOverride;
  });
}

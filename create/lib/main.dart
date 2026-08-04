import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

import 'preview.dart';
import 'selection.dart';
import 'settings.dart';
import 'sidebar/sidebar.dart';
import 'top_bar.dart';

Future<void> main() async {
  usePathUrlStrategy();

  if (kDebugMode) {
    MarionetteBinding.ensureInitialized();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }

  runApp(Application(settings: await Settings.load()));
}

class Application extends StatefulWidget {
  final Settings settings;

  const Application({this.settings = const .none(), super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late ThemeMode _mode = widget.settings.themeMode;

  /// The URL is the source of truth for the selection.
  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          Selection selection;
          try {
            selection = Selection.decode(state.uri.queryParameters['preset']);
          } on FormatException {
            selection = Selection.decode();
          }
          return CreatePage(selection: selection);
        },
      ),
    ],
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Forui Create',
    debugShowCheckedModeBanner: false,
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    theme: FTheme.neutral.light.desktop.toApproximateMaterialTheme(),
    darkTheme: FTheme.neutral.dark.desktop.toApproximateMaterialTheme(),
    themeMode: _mode,
    routerConfig: _router,
    builder: (context, child) {
      final dark = switch (_mode) {
        ThemeMode.light => false,
        ThemeMode.dark => true,
        ThemeMode.system => MediaQuery.platformBrightnessOf(context) == Brightness.dark,
      };
      return _ThemeModeScope(
        mode: _mode,
        onChanged: _change,
        child: FTheme(data: dark ? FTheme.neutral.dark.desktop : FTheme.neutral.light.desktop, child: child!),
      );
    },
  );

  void _change(ThemeMode mode) {
    widget.settings.themeMode = mode;
    setState(() => _mode = mode);
  }
}

class _ThemeModeScope extends InheritedWidget {
  static _ThemeModeScope of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_ThemeModeScope>()!;

  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;

  const _ThemeModeScope({required this.mode, required this.onChanged, required super.child});

  @override
  bool updateShouldNotify(_ThemeModeScope old) => old.mode != mode;
}

class CreatePage extends StatelessWidget {
  final Selection selection;

  const CreatePage({required this.selection, super.key});

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < context.theme.breakpoints.md;
    final scope = _ThemeModeScope.of(context);
    return SelectionArea(
      child: FScaffold(
        childPad: false,
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            TopBar(onMenu: compact ? () => _openSidebar(context) : null),
            Expanded(
              child: compact
                  ? Preview(selection: selection)
                  : Row(
                      crossAxisAlignment: .stretch,
                      children: [
                        Sidebar(
                          selection: selection,
                          mode: scope.mode,
                          onChanged: (selection) => _change(context, selection),
                          onModeChanged: scope.onChanged,
                        ),
                        Expanded(child: Preview(selection: selection)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSidebar(BuildContext context) {
    final scope = _ThemeModeScope.of(context);
    showFSheet<void>(
      context: context,
      side: .ltr,
      mainAxisMaxRatio: null,
      builder: (_) => _SheetSidebar(
        selection: selection,
        mode: scope.mode,
        onChanged: (selection) => _change(context, selection),
        onModeChanged: scope.onChanged,
      ),
    );
  }

  void _change(BuildContext context, Selection selection) =>
      context.replace(Uri(path: '/', queryParameters: {'preset': selection.encode()}).toString());
}

class _SheetSidebar extends StatefulWidget {
  final Selection selection;
  final ThemeMode mode;
  final ValueChanged<Selection> onChanged;
  final ValueChanged<ThemeMode> onModeChanged;

  const _SheetSidebar({
    required this.selection,
    required this.mode,
    required this.onChanged,
    required this.onModeChanged,
  });

  @override
  State<_SheetSidebar> createState() => _SheetSidebarState();
}

class _SheetSidebarState extends State<_SheetSidebar> {
  late Selection _selection = widget.selection;
  late ThemeMode _mode = widget.mode;

  @override
  Widget build(BuildContext context) => Sidebar(
    selection: _selection,
    mode: _mode,
    padding: const .all(12),
    onChanged: (selection) {
      setState(() => _selection = selection);
      widget.onChanged(selection);
    },
    onModeChanged: (mode) {
      setState(() => _mode = mode);
      widget.onModeChanged(mode);
    },
  );
}

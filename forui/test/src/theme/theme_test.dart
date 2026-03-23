import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

final _darkTouch = FThemeData(touch: true, colors: FColors.neutral.dark);
final _lightTouch = FThemeData(touch: true, colors: FColors.neutral.light);

class Foo extends StatelessWidget {
  final Widget child;

  const Foo({required this.child, super.key});

  @override
  Widget build(BuildContext context) =>
      FBasicTheme(data: _darkTouch, textDirection: .ltr, child: child);
}

void main() {
  group('FTheme', () {
    testWidgets('passed in platform is respected', (tester) async {
      await tester.pumpWidget(
        FTheme(
          data: _darkTouch,
          platform: .macOS,
          child: Builder(builder: (context) => Text('${context.platformVariant}', textDirection: .ltr)),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('${FPlatformVariant.macOS}'), findsOneWidget);
    });
  });

  group('FBasicTheme', () {
    testWidgets('passed in platform is respected', (tester) async {
      await tester.pumpWidget(
        FBasicTheme(
          data: _darkTouch,
          platform: .macOS,
          textDirection: .ltr,
          child: Builder(builder: (context) => Text('${context.theme == _darkTouch}')),
        ),
      );

      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('ThemeData is visible in child widgets', (tester) async {
      await tester.pumpWidget(
        Foo(child: Builder(builder: (context) => Text('${context.theme == _darkTouch}'))),
      );

      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('Changes to ThemeData is propagated to children widgets', (tester) async {
      const key = ValueKey('dependent');

      await tester.pumpWidget(
        FBasicTheme(
          data: _lightTouch,
          textDirection: .ltr,
          child: Builder(builder: (context) => Text(context.theme.toString(), key: key)),
        ),
      );
      final initial = tester.widget<Text>(find.byKey(key)).data;

      await tester.pumpWidget(
        FBasicTheme(
          data: _darkTouch,
          textDirection: .ltr,
          child: Builder(builder: (context) => Text(context.theme.toString(), key: key)),
        ),
      );
      final updated = tester.widget<Text>(find.byKey(key)).data;

      expect(initial, isNot(updated));
    });

    testWidgets('no ThemeData in ancestor', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: .ltr,
          child: Builder(builder: (context) => Text('${context.theme == _darkTouch}')),
        ),
      );

      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('inherit TextDirection from parent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FBasicTheme(data: _darkTouch, child: const Text('')),
        ),
      );

      expect(tester.takeException(), null);
    });
  });
}

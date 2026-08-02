import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/shifted_sheet.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('tap on barrier dismisses', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: Builder(
          builder: (context) => FButton.icon(
            child: const Icon(FLucideIcons.chevronRight),
            onPress: () => showFSheet(
              context: context,
              side: .btt,
              builder: (context) => Container(
                height: .infinity,
                width: .infinity,
                color: context.theme.colors.background,
                child: const Center(child: Text('sheet')),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FButton));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('sheet'), findsOne);

    await tester.tapAt(const Offset(100, 100));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('sheet'), findsNothing);
  });

  for (final (label, features) in [
    ('reduced motion', const FakeAccessibilityFeatures(reduceMotion: true)),
    ('disabled motion', const FakeAccessibilityFeatures(disableAnimations: true)),
  ]) {
    testWidgets('drag to dismiss completes the slide under $label', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = features;
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: .btt,
                builder: (context) => Container(
                  height: .infinity,
                  width: .infinity,
                  color: context.theme.colors.background,
                  child: const Center(child: Text('sheet')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(tester.widget<ShiftedSheet>(find.byType(ShiftedSheet)).value, 1.0);

      // Release a drag that dismisses the sheet, then rebuild the first frame of the settle. The old code snapped
      // value back to 1 here; the fix keeps it mid-flight.
      await tester.drag(find.text('sheet'), const Offset(0, 300));
      await tester.pump();

      // The user's gesture keeps sliding off (value below rest, fully opaque) instead of snapping back and fading.
      expect(tester.widget<ShiftedSheet>(find.byType(ShiftedSheet)).value, lessThan(1.0));
      expect(
        tester.widget<Opacity>(find.ancestor(of: find.text('sheet'), matching: find.byType(Opacity)).first).opacity,
        1.0,
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsNothing);
    });
  }

  for (final (side, offset) in [
    (FLayout.btt, const Offset(0, 300)),
    (FLayout.ttb, const Offset(0, -300)),
    (FLayout.ltr, const Offset(-300, 0)),
    (FLayout.rtl, const Offset(300, 0)),
  ]) {
    testWidgets('drag to dismiss - $side', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: side,
                builder: (context) => Container(
                  height: .infinity,
                  width: .infinity,
                  color: context.theme.colors.background,
                  child: const Center(child: Text('sheet')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);

      await tester.drag(find.text('sheet'), offset);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsNothing);
    });

    testWidgets('drag to dismiss on non-draggable - $side', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: side,
                draggable: false,
                builder: (context) => Container(
                  height: .infinity,
                  width: .infinity,
                  color: context.theme.colors.background,
                  child: const Center(child: Text('sheet')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);

      await tester.drag(find.text('sheet'), offset);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);
    });
  }

  group('scope liveness', () {
    testWidgets('content observes theme changes while open', (tester) async {
      FThemeData? seen;
      Widget app(FThemeData theme) => TestScaffold.app(
        theme: theme,
        child: Builder(
          builder: (context) => FButton(
            onPress: () => showFSheet(
              context: context,
              side: .btt,
              builder: (context) {
                seen = context.theme;
                return const Text('sheet');
              },
            ),
            child: const Text('button'),
          ),
        ),
      );

      await tester.pumpWidget(app(FTheme.neutral.light.touch));
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      expect(seen, FTheme.neutral.light.touch);

      await tester.pumpWidget(app(FTheme.neutral.dark.touch));
      await tester.pumpAndSettle();

      expect(seen, FTheme.neutral.dark.touch);
    });

    testWidgets('content observes nested theme below the navigator', (tester) async {
      FThemeData? seen;
      Widget app(FThemeData nested) => TestScaffold.app(
        child: FTheme(
          data: nested,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFSheet(
                context: context,
                side: .btt,
                builder: (context) {
                  seen = context.theme;
                  return const Text('sheet');
                },
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.pumpWidget(app(TestScaffold.greenOverride));
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      expect(seen, TestScaffold.greenOverride);

      await tester.pumpWidget(app(TestScaffold.blueOverride));
      await tester.pumpAndSettle();

      expect(seen, TestScaffold.blueOverride);
    });
  });
}

@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FTabs(
          style: TestScaffold.blueScreen.tabsStyle,
          children: const [
            FTabEntry(label: Text('Account'), child: SizedBox()),
            FTabEntry(label: Text('Settings'), child: SizedBox()),
          ],
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('default - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTabs(
            children: [
              FTabEntry(
                label: const Text('Account'),
                child: Container(color: Colors.blue, height: 100),
              ),
              FTabEntry(
                label: const Text('Password'),
                child: Container(color: Colors.red, height: 100),
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tabs/${theme.name}.png'));
    });

    testWidgets('tall label - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTabs(
            children: [
              FTabEntry(
                label: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('Account'), Text('& Security'), Text('& Settings')],
                ),
                child: Container(color: Colors.blue, height: 100),
              ),
              FTabEntry(
                label: const Text('Password'),
                child: Container(color: Colors.red, height: 100),
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tabs/${theme.name}-tall-label.png'));
    });

    testWidgets('scrollable - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTabs(
            scrollable: true,
            children: [for (var i = 0; i < 10; i++) FTabEntry(label: Text('$i'), child: Text('Tab $i'))],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tabs/${theme.name}-scrollable.png'));
    });

    testWidgets('focus - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTabs(
            children: [
              FTabEntry(
                label: const Text('Account'),
                child: Container(color: Colors.blue, height: 100),
              ),
              FTabEntry(
                label: const Text('Password'),
                child: Container(color: Colors.red, height: 100),
              ),
            ],
          ),
        ),
      );

      Focus.of(tester.element(find.text('Account').first)).requestFocus();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tabs/${theme.name}-focused.png'));
    });

    testWidgets('expands - ${theme.name}', experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(), (
      tester,
    ) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: SizedBox(
            height: 400,
            child: FTabs(
              expands: true,
              children: [
                FTabEntry(
                  label: const Text('Account'),
                  child: Container(color: Colors.blue, height: 100),
                ),
                FTabEntry(
                  label: const Text('Password'),
                  child: Container(color: Colors.red, height: 100),
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tabs/${theme.name}-expand.png'));
      await tester.pumpAndSettle();
    });
  }

  group('accessibility', () {
    // With expanding content, the tapped tab's panel cross-slides into view under full motion (the yellow foo panel
    // slides out as the blue bar panel slides in), and swaps instantly under reduced and disabled motion.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(), (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(300, 200)));

        Widget build() => TestScaffold.app(
          child: SizedBox(
            width: 260,
            height: 150,
            child: FTabs(
              expands: true,
              children: const [
                FTabEntry(
                  label: Text('foo'),
                  child: ColoredBox(
                    color: Colors.yellow,
                    child: Center(child: Text('foo panel')),
                  ),
                ),
                FTabEntry(
                  label: Text('bar'),
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Center(child: Text('bar panel')),
                  ),
                ),
              ],
            ),
          ),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        await tester.tap(find.text('bar'));
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 400));

        await expectLater(sheet.collate(5), matchesGoldenFile('tabs/motion-$name.png'));
      });
    }
  });
}

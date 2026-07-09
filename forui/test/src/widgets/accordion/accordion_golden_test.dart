@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FAccordion(
          style: TestScaffold.blueScreen.accordionStyle,
          children: const [FAccordionItem(title: Text('Title'), child: SizedBox())],
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FAccordion(
            children: [
              FAccordionItem(
                initiallyExpanded: true,
                title: Text('Title'),
                child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/shown.png'));
    });

    testWidgets('shown - desktop', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          platform: .macOS,
          child: const FAccordion(
            children: [
              FAccordionItem(
                initiallyExpanded: true,
                title: Text('Title'),
                child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/shown-desktop.png'));
    });

    testWidgets('focused', (tester) async {
      FocusManager.instance.highlightStrategy = .alwaysTraditional;
      addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FAccordion(
            children: [
              FAccordionItem(
                initiallyExpanded: true,
                autofocus: true,
                title: Text('Title'),
                child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
              ),
              FAccordionItem(
                title: Text('Title'),
                child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/focused.png'));
    });

    testWidgets('hidden', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FAccordion(
            children: [
              FAccordionItem(
                initiallyExpanded: true,
                title: Text('Title'),
                child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/hidden.png'));
    });
  }

  group('accessibility', () {
    // The reveal (and its chevron) has no fade to keep, so it animates open under full motion but snaps open instantly
    // under both reduced and disabled motion. The frame strip shows the content growing vs. appearing at full height.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(300, 180)));

        Widget build() => TestScaffold.app(
          child: const FAccordion(
            children: [
              FAccordionItem(
                title: Text('Title'),
                child: SizedBox(height: 60, child: ColoredBox(color: Colors.yellow)),
              ),
            ],
          ),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        await tester.tap(find.text('Title'));
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 300));

        await expectLater(sheet.collate(5), matchesGoldenFile('accordion/motion-$name.png'));

        await tester.pump(const Duration(seconds: 1)); // Drain the tappable's pending gesture timer.
      });
    }
  });
}

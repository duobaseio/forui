@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} hidden ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTooltip(
            tipBuilder: (context, _) => const Text('Lorem'),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/${theme.name}-hidden.png'));
    });

    testWidgets('${theme.name} shown on touch devices', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTooltip(
            tipBuilder: (context, _) => const Text('Lorem'),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(ColoredBox).first));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/${theme.name}-shown.png'));
    });

    testWidgets('${theme.name} glassmorphic ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: Column(
            mainAxisSize: .min,
            spacing: 5,
            children: [
              const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              FTooltip(
                style: .delta(
                  backgroundFilter: .blur(sigmaX: 5, sigmaY: 5),
                  decoration: .value(
                    BoxDecoration(
                      color: theme.data.colors.background.withValues(alpha: 0.5),
                      borderRadius: theme.data.style.borderRadius.md,
                      border: .all(width: theme.data.style.borderWidth, color: theme.data.colors.border),
                    ),
                  ),
                ),
                tipBuilder: (context, _) => const Text('Lorem'),
                child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
              ),
            ],
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(ColoredBox).first));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/${theme.name}-glassmorphic.png'));
    });
  }

  group('accessibility', () {
    // The tip scales up and fades in under full motion, drops the scale to a plain fade under reduced motion, and
    // appears instantly (fully opaque, no scale) under disabled motion.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final controller = autoDispose(FTooltipController(vsync: tester));
        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(240, 200)));

        Widget build() => TestScaffold.app(
          child: FTooltip(
            control: .managed(controller: controller),
            tipBuilder: (_, _) => const Text('Tooltip'),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 60)),
          ),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        unawaited(controller.show());
        // Pump past the entrance so the controller's ticker stops before the tree is disposed.
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 300));

        await expectLater(sheet.collate(5), matchesGoldenFile('tooltip/motion-$name.png'));
      });
    }
  });
}

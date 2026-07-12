@Tags(['golden'])
library;

import 'dart:async';
import 'dart:ui';

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
          child: FPopover(
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/hidden-${theme.name}.png'));
    });

    testWidgets('${theme.name} shown on touch device', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          platform: .android,
          child: FPopover(
            control: const .managed(initial: true),
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-touch-device-${theme.name}.png'));
    });

    testWidgets('${theme.name} shown on non-touch device', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          platform: .macOS,
          child: FPopover(
            control: const .managed(initial: true),
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('popover/shown-non-touch-device-${theme.name}.png'),
      );
    });

    testWidgets('${theme.name} with barrier', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          platform: .macOS,
          child: FPopover(
            control: const .managed(initial: true),
            style: .delta(
              barrierFilter: (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
            ),
            cutout: false,
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/barrier-${theme.name}.png'));
    });

    testWidgets('${theme.name} barrier with cutout', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            children: [
              FPopover(
                childAnchor: .topLeft,
                popoverAnchor: .bottomRight,
                control: .managed(controller: controller),
                style: .delta(
                  barrierFilter: (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
                ),
                popoverBuilder: (context, _) =>
                    const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                child: const Text('Click me'),
              ),
              const Text('Outside of the popover'),
            ],
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/barrier-cutout-${theme.name}.png'));
    });

    testWidgets('${theme.name} barrier with custom circle cutout', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            children: [
              FPopover(
                childAnchor: .topLeft,
                popoverAnchor: .bottomRight,
                control: .managed(controller: controller),
                style: .delta(
                  barrierFilter: (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
                ),
                cutoutBuilder: (path, bounds) => path.addOval(bounds),
                popoverBuilder: (context, _) =>
                    const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                child: const Text('Click me'),
              ),
              const Text('Outside of the popover'),
            ],
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('popover/barrier-cutout-circle-${theme.name}.png'),
      );
    });

    testWidgets('${theme.name} glassmorphic', (tester) async {
      final controller = autoDispose(FPopoverController(shown: true, vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              FButton(onPress: controller.toggle, child: const Text('Toggle Popover')),
              FPopover(
                control: .managed(controller: controller),
                style: .delta(
                  backgroundFilter: (v) => .blur(sigmaX: v * 5, sigmaY: v * 5),
                  decoration: .value(
                    BoxDecoration(
                      color: theme.data.colors.background.withValues(alpha: 0.5),
                      borderRadius: theme.data.style.borderRadius.md,
                      border: .all(width: theme.data.style.borderWidth, color: theme.data.colors.border),
                    ),
                  ),
                ),
                popoverBuilder: (_, _) => const SizedBox.square(dimension: 100),
                child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/glassmorphic-${theme.name}.png'));
    });
  }

  testWidgets('background filter matches the decoration', (tester) async {
    final theme = TestScaffold.themes.first.data;

    await tester.pumpWidget(
      TestScaffold.app(
        theme: theme,
        // The popover is centered over the dark bar so the frosted blur is visible through the translucent tint.
        child: FPopover(
          control: const .managed(initial: true),
          popoverAnchor: .center,
          childAnchor: .center,
          constraints: const FPortalConstraints(minWidth: 300),
          style: .delta(
            backgroundFilter: (v) => .blur(sigmaX: v * 8, sigmaY: v * 8),
            decoration: .value(
              BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: theme.style.borderRadius.md,
                border: .all(color: Colors.white.withValues(alpha: 0.5)),
              ),
            ),
          ),
          popoverBuilder: (_, _) => const SizedBox.square(dimension: 120),
          child: const ColoredBox(color: Colors.black, child: SizedBox(width: 500, height: 80)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/background-filter.png'));
  });

  for (final clip in [Clip.none, Clip.antiAlias]) {
    testWidgets('clip ${clip.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: const .managed(initial: true),
            popoverClipBehavior: clip,
            popoverBuilder: (context, _) => const Column(
              mainAxisSize: .min,
              children: [
                SizedBox(width: 200, height: 30, child: ColoredBox(color: Colors.red)),
                SizedBox(width: 200, height: 30),
              ],
            ),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/clip-${clip.name}.png'));
    });
  }

  group('accessibility', () {
    // The popover scales up and fades in under full motion, drops the scale to a plain fade under reduced motion, and
    // appears instantly (fully opaque, no scale) under disabled motion.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final controller = autoDispose(FPopoverController(vsync: tester));
        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(240, 280)));

        Widget build() => TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox.square(dimension: 80),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 60)),
          ),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        unawaited(controller.show());
        // Pump past the entrance so the controller's ticker stops before the tree is disposed.
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 300));

        await expectLater(sheet.collate(5), matchesGoldenFile('popover/motion-$name.png'));
      });
    }
  });
}

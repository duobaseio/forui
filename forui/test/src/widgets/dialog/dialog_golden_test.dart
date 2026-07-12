@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  final theme = FTheme.neutral.light.touch;

  Widget content(BuildContext context, FDialogStyle style) => Padding(
    padding: const .all(16),
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        DefaultTextStyle.merge(style: style.titleTextStyle, child: const Text('Are you absolutely sure?')),
        const SizedBox(height: 8),
        DefaultTextStyle.merge(style: style.bodyTextStyle, child: const Text('This action cannot be undone.')),
      ],
    ),
  );

  group('showFDialog', () {
    testWidgets('default', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          alignment: .topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                context: context,
                builder: (context, _, animation) => FDialog(animation: animation, builder: content),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('dialog/show/default.png'));
    });

    testWidgets('blurred barrier', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          alignment: .topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                routeStyle: .delta(
                  barrierFilter: () =>
                      (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
                ),
                context: context,
                builder: (context, _, animation) => FDialog(animation: animation, builder: content),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('dialog/show/blurred.png'));
    });

    testWidgets('glassmorphic', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                style: .delta(
                  backgroundFilter: (v) => .blur(sigmaX: v * 5, sigmaY: v * 5),
                  decoration: .value(
                    BoxDecoration(
                      borderRadius: theme.style.borderRadius.md,
                      color: theme.colors.background.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                context: context,
                builder: (context, style, animation) => FDialog(style: style, animation: animation, builder: content),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('dialog/show/glassmorphic.png'));
    });
  });

  group('FDialog', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FDialog(style: TestScaffold.blueScreen.dialogStyle, builder: content),
        ),
      );

      await expectBlueScreen();
    });

    for (final clip in [Clip.none, Clip.antiAlias]) {
      testWidgets('clip ${clip.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FDialog(
              clipBehavior: clip,
              builder: (context, style) =>
                  const ColoredBox(color: Colors.red, child: SizedBox(width: 200, height: 100)),
            ),
          ),
        );

        await expectLater(find.byType(FDialog), matchesGoldenFile('dialog/clip-${clip.name}.png'));
      });
    }

    testWidgets('raw content', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme,
          child: FDialog(builder: (context, style) => const SizedBox(width: 50, height: 50)),
        ),
      );

      await expectLater(find.byType(FDialog), matchesGoldenFile('dialog/raw-content.png'));
    });
  });

  group('accessibility', () {
    // The entrance scales up and fades in under full motion, drops the scale to a plain fade under reduced motion, and
    // appears instantly (fully opaque, no scale) under disabled motion.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final controller = autoDispose(
          AnimationController(vsync: const TestVSync(), duration: const Duration(milliseconds: 250)),
        );
        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(360, 260)));

        Widget build() => TestScaffold.app(
          theme: theme,
          child: FDialog(animation: controller, builder: content),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        unawaited(controller.forward());
        // Pump past the controller's duration so its ticker stops before the tree is disposed.
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 300));

        await expectLater(sheet.collate(5), matchesGoldenFile('dialog/motion-$name.png'));
      });
    }
  });
}

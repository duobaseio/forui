@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('resizeToAvoidBottomInset', () {
    testWidgets('shifts up', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(viewInsets: .only(bottom: 100)),
          child: TestScaffold.app(
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
                    child: const Center(child: Text('Sheet')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/modal/bottom-inset.png'));
    });

    testWidgets('does not overflow', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(viewInsets: .only(bottom: 1000)),
          child: TestScaffold.app(
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
                    child: const Center(child: Text('Sheet')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/modal/bottom-inset-overflow.png'));
    });
  });

  for (final side in FLayout.values) {
    testWidgets('default - $side', (tester) async {
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
                  child: const Center(child: Text('Sheet')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/modal/default-$side.png'));
    });

    testWidgets('constrained - $side', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: side,
                constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
                builder: (context) => Container(
                  height: .infinity,
                  width: .infinity,
                  color: context.theme.colors.background,
                  child: const Center(child: Text('Sheet')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/modal/constrained-$side.png'));
    });

    testWidgets('scrollable - $side', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: side,
                mainAxisMaxRatio: null,
                builder: (context) => Container(
                  height: .infinity,
                  width: .infinity,
                  color: context.theme.colors.background,
                  child: ListView.builder(
                    scrollDirection: side.vertical ? .vertical : .horizontal,
                    itemBuilder: (context, index) => Padding(padding: const .all(8.0), child: Text('Tile $index')),
                    itemCount: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/modal/scrollable-$side.png'));
    });
  }

  group('accessibility', () {
    // The sheet slides up under full motion, cross-fades in place (snapped to its resting position, opacity fading)
    // under reduced motion, and appears instantly (in place, fully opaque) under disabled motion.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(240, 240)));

        Widget build() => TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: .btt,
                builder: (context) => Container(
                  height: 120,
                  width: .infinity,
                  color: Colors.blue,
                  child: const Center(child: Text('sheet')),
                ),
              ),
            ),
          ),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        await tester.tap(find.byType(FButton));
        await tester.pump(); // Start the entrance.
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 300));

        await expectLater(sheet.collate(5), matchesGoldenFile('sheet/modal/motion-$name.png'));

        // Unmount to dispose the sheet route.
        await tester.pumpWidget(TestScaffold(child: const SizedBox()));
        await tester.pumpAndSettle();
      });
    }
  });
}

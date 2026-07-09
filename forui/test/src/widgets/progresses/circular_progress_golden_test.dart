@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(child: FCircularProgress(style: TestScaffold.blueScreen.circularProgressStyles.md)),
    );

    await expectBlueScreen();
  });

  for (final (:data, :name) in TestScaffold.themes) {
    testWidgets('FCircularProgress - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpFrames(
        sheet.record(TestScaffold.app(theme: data, child: const FCircularProgress())),
        const Duration(milliseconds: 1000),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/circular/$name.png'));
    });
  }

  for (final (name, size) in [
    ('xs', FCircularProgressSizeVariant.xs),
    ('sm', FCircularProgressSizeVariant.sm),
    ('md', FCircularProgressSizeVariant.md),
    ('lg', FCircularProgressSizeVariant.lg),
    ('xl', FCircularProgressSizeVariant.xl),
  ]) {
    testWidgets('FCircularProgress - $name', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: FCircularProgress(size: size)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('progresses/circular/size-$name.png'));
    });
  }

  testWidgets('inherit style', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FInheritedCircularProgressStyle(
          style: FCircularProgressStyle(iconStyle: const IconThemeData(color: Colors.red, size: 40)),
          child: const FCircularProgress(),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('progresses/circular/inherit-style.png'));
  });

  group('accessibility', () {
    // A spinner is an essential loading indicator: it keeps spinning under reduced motion and only freezes when
    // animations are disabled. The frame strip shows the icon rotating vs. holding still.
    for (final (name, features) in [
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

        await tester.pumpFrames(
          sheet.record(TestScaffold.app(child: const FCircularProgress())),
          const Duration(milliseconds: 1000),
        );

        await expectLater(sheet.collate(10), matchesGoldenFile('progresses/circular/motion-$name.png'));
      });
    }
  });
}

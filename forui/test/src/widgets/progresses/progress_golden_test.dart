@Tags(['golden'])
library;

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(TestScaffold.blue(child: FProgress(style: TestScaffold.blueScreen.progressStyle)));

    await expectBlueScreen();
  });

  for (final (:data, :name) in TestScaffold.themes) {
    testWidgets('FProgress - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpFrames(
        sheet.record(TestScaffold.app(theme: data, child: const FProgress())),
        const Duration(milliseconds: 1660),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/progress/$name.png'));
    });
  }

  group('accessibility', () {
    // An indeterminate bar is an essential loading indicator: it keeps sliding under reduced motion and freezes into a
    // static partial fill (never a full fill, which would read as complete) when animations are disabled.
    for (final (name, features) in [
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

        await tester.pumpFrames(
          sheet.record(TestScaffold.app(child: const FProgress())),
          const Duration(milliseconds: 1660),
        );

        await expectLater(sheet.collate(10), matchesGoldenFile('progresses/progress/motion-$name.png'));
      });
    }
  });
}

@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FDeterminateProgress(style: TestScaffold.blueScreen.determinateProgressStyle, value: 0.4),
      ),
    );

    await expectBlueScreen();
  });

  for (final (:data, :name) in TestScaffold.themes) {
    testWidgets('forward - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpFrames(
        sheet.record(TestScaffold.app(theme: data, child: const FDeterminateProgress(value: 0.5))),
        const Duration(milliseconds: 1100),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/determinate/forward-$name.png'));
    });

    testWidgets('backward - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpWidget(
        sheet.record(
          TestScaffold.app(
            theme: data,
            child: const FDeterminateProgress(value: 0.7, key: ValueKey('test')),
          ),
          recording: false,
        ),
      );
      await tester.pumpAndSettle();
      await tester.pumpFrames(
        sheet.record(
          TestScaffold.app(
            theme: data,
            child: const FDeterminateProgress(value: 0.2, key: ValueKey('test')),
          ),
        ),
        const Duration(milliseconds: 1100),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/determinate/backward-$name.png'));
    });
  }

  group('accessibility', () {
    // A determinate bar is an essential indicator: it still grows toward its value under reduced motion, and snaps
    // straight to the value with no grow when animations are disabled.
    for (final (name, features) in [
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

        await tester.pumpFrames(
          sheet.record(TestScaffold.app(child: const FDeterminateProgress(value: 0.5))),
          const Duration(milliseconds: 1100),
        );

        await expectLater(sheet.collate(10), matchesGoldenFile('progresses/determinate/motion-$name.png'));
      });
    }
  });
}

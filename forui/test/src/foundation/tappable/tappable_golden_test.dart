@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  testWidgets('bounce animates after being re-parented', (tester) async {
    final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));
    final key = GlobalKey();

    Widget build({required bool wrapped, bool recording = true}) {
      final tappable = FTappable(
        key: key,
        style: .delta(
          motion: .delta(bounceTween: const FImmutableTween(begin: 1.0, end: 0.8), bounceFloor: () => null),
        ),
        onPress: () {},
        child: const ColoredBox(color: Color(0xFF000000), child: SizedBox.square(dimension: 80)),
      );

      return sheet.record(
        TestScaffold(
          // Stops the sheet's per-frame repaint from reaching the bounce so that only the bounce's own repaints show.
          child: RepaintBoundary(child: wrapped ? Padding(padding: .zero, child: tappable) : tappable),
        ),
        recording: recording,
      );
    }

    await tester.pumpWidget(build(wrapped: false, recording: false));
    await tester.pumpWidget(build(wrapped: true, recording: false));

    final gesture = await tester.startGesture(tester.getCenter(find.byKey(key)));
    await tester.pumpFrames(build(wrapped: true), const Duration(milliseconds: 150));
    await gesture.up();
    await tester.pumpFrames(build(wrapped: true), const Duration(milliseconds: 150));

    await expectLater(sheet.collate(6), matchesGoldenFile('tappable/bounce-reparented-animation.png'));
  });
}

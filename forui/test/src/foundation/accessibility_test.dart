import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FAccessibility', () {
    const data = FAccessibility(
      accessibleNavigation: false,
      motion: .full,
      deterministicCursor: false,
      focusHighlight: false,
    );

    test('copyWith replaces only the given fields', () {
      final copy = data.copyWith(motion: .disabled);

      expect(copy.motion, FAccessibilityMotion.disabled);
      expect(copy.accessibleNavigation, false);
      expect(copy.deterministicCursor, false);
      expect(copy.focusHighlight, false);
    });

    test('equality', () {
      expect(data, data.copyWith());
      expect(data == data.copyWith(focusHighlight: true), false);
    });
  });

  group('FAccessibilityScope', () {
    for (final (disableAnimations, reduceMotion, expected) in [
      (false, false, FAccessibilityMotion.full),
      (false, true, FAccessibilityMotion.reduced),
      (true, false, FAccessibilityMotion.disabled),
      (true, true, FAccessibilityMotion.disabled),
    ]) {
      testWidgets('motion when disableAnimations=$disableAnimations, reduceMotion=$reduceMotion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = FakeAccessibilityFeatures(
          disableAnimations: disableAnimations,
          reduceMotion: reduceMotion,
        );
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        late FAccessibilityMotion motion;
        await tester.pumpWidget(
          FAccessibilityScope(
            child: Builder(
              builder: (context) {
                motion = FAccessibilityScope.motionOf(context);
                return const SizedBox();
              },
            ),
          ),
        );

        expect(motion, expected);
      });
    }

    testWidgets('observes the platform and rebuilds on change', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures();
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      late FAccessibilityMotion motion;
      await tester.pumpWidget(
        FAccessibilityScope(
          child: Builder(
            builder: (context) {
              motion = FAccessibilityScope.motionOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(motion, FAccessibilityMotion.full);

      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      await tester.pump();
      expect(motion, FAccessibilityMotion.disabled);
    });

    testWidgets('observes the focus highlight mode', (tester) async {
      FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTouch;
      addTearDown(() => FocusManager.instance.highlightStrategy = FocusHighlightStrategy.automatic);

      late bool highlight;
      await tester.pumpWidget(
        FAccessibilityScope(
          child: Builder(
            builder: (context) {
              highlight = FAccessibilityScope.focusHighlightOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(highlight, false);

      FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
      await tester.pump();
      expect(highlight, true);
    });

    testWidgets('data override reflects and ignores the platform', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      late FAccessibilityMotion motion;
      await tester.pumpWidget(
        FAccessibilityScope(
          data: const FAccessibility(
            accessibleNavigation: false,
            motion: .reduced,
            deterministicCursor: false,
            focusHighlight: false,
          ),
          child: Builder(
            builder: (context) {
              motion = FAccessibilityScope.motionOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(motion, FAccessibilityMotion.reduced);

      // A platform change is ignored while the override is active.
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures();
      await tester.pump();
      expect(motion, FAccessibilityMotion.reduced);
    });

    testWidgets('per-aspect accessors rebuild independently', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures();
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      var motionBuilds = 0;
      var cursorBuilds = 0;

      await tester.pumpWidget(
        FAccessibilityScope(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    FAccessibilityScope.motionOf(context);
                    motionBuilds++;
                    return const SizedBox();
                  },
                ),
                Builder(
                  builder: (context) {
                    FAccessibilityScope.deterministicCursorOf(context);
                    cursorBuilds++;
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      );
      expect(motionBuilds, 1);
      expect(cursorBuilds, 1);

      // Changing only deterministicCursor rebuilds the cursor dependent, not the motion dependent.
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        deterministicCursor: true,
      );
      await tester.pump();
      expect(motionBuilds, 1);
      expect(cursorBuilds, 2);

      // Changing only motion rebuilds the motion dependent, not the cursor dependent.
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        deterministicCursor: true,
        reduceMotion: true,
      );
      await tester.pump();
      expect(motionBuilds, 2);
      expect(cursorBuilds, 2);
    });
  });
}

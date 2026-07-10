import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('forwards focus to label', (tester) async {
    FocusManager.instance.highlightStrategy = .alwaysTraditional;
    addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

    final focus = autoDispose(FocusNode());
    bool focused() => tester
        .widget<FLabel>(find.ancestor(of: find.text('Label'), matching: find.byType(FLabel)))
        .variants
        .contains(FFormFieldVariant.focused);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FRadio(focusNode: focus, label: const Text('Label')),
      ),
    );
    expect(focused(), false);

    focus.requestFocus();

    await tester.pumpAndSettle();

    expect(focused(), true);
  });

  group('accessibility', () {
    testWidgets('collapses durations to zero when animations are disabled', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      await tester.pumpWidget(TestScaffold.app(child: const FRadio(value: true)));

      final containers = find.descendant(of: find.byType(FRadio), matching: find.byType(AnimatedContainer));
      expect(containers, findsExactly(2));
      for (final container in tester.widgetList<AnimatedContainer>(containers)) {
        expect(container.duration, Duration.zero);
      }

      final size = tester.widget<AnimatedSize>(
        find.descendant(of: find.byType(FRadio), matching: find.byType(AnimatedSize)),
      );
      expect(size.duration, Duration.zero);
      expect(size.reverseDuration, Duration.zero);
    });

    testWidgets('keeps durations when only reduce motion is set', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(reduceMotion: true);
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      await tester.pumpWidget(TestScaffold.app(child: const FRadio(value: true)));

      const motion = FRadioMotion();
      final containers = find.descendant(of: find.byType(FRadio), matching: find.byType(AnimatedContainer));
      expect(containers, findsExactly(2));
      for (final container in tester.widgetList<AnimatedContainer>(containers)) {
        expect(container.duration, motion.transitionDuration);
      }

      final size = tester.widget<AnimatedSize>(
        find.descendant(of: find.byType(FRadio), matching: find.byType(AnimatedSize)),
      );
      expect(size.duration, motion.selectDuration);
      expect(size.reverseDuration, motion.unselectDuration);
    });

    for (final value in [true, false]) {
      testWidgets('announces radio role with checked state - $value', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FRadio(value: value, semanticsLabel: 'radio'),
          ),
        );

        expect(
          tester.getSemantics(find.bySemanticsLabel('radio')),
          isSemantics(hasCheckedState: true, isChecked: value, isInMutuallyExclusiveGroup: true, isButton: false),
        );
      });
    }
  });
}

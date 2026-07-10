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
        child: FCheckbox(focusNode: focus, label: const Text('Label')),
      ),
    );
    expect(focused(), false);

    focus.requestFocus();

    await tester.pumpAndSettle();

    expect(focused(), true);
  });

  group('accessibility', () {
    testWidgets('collapses switcher durations to zero when animations are disabled', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(
        disableAnimations: true,
      );
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      await tester.pumpWidget(TestScaffold.app(child: const FCheckbox(value: true)));

      final switcher = tester.widget<AnimatedSwitcher>(
        find.descendant(of: find.byType(FCheckbox), matching: find.byType(AnimatedSwitcher)),
      );
      expect(switcher.duration, Duration.zero);
      expect(switcher.reverseDuration, Duration.zero);
    });

    testWidgets('keeps switcher durations when only reduce motion is set', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(reduceMotion: true);
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

      await tester.pumpWidget(TestScaffold.app(child: const FCheckbox(value: true)));

      final switcher = tester.widget<AnimatedSwitcher>(
        find.descendant(of: find.byType(FCheckbox), matching: find.byType(AnimatedSwitcher)),
      );
      // Reduce motion keeps the cross-fade (a fade is not spatial), so its durations are not collapsed.
      expect(switcher.duration == Duration.zero, false);
      expect(switcher.reverseDuration == Duration.zero, false);
    });

    for (final value in [true, false]) {
      testWidgets('announces checkbox role with checked state - $value', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FCheckbox(value: value, semanticsLabel: 'checkbox')));

        expect(
          tester.getSemantics(find.bySemanticsLabel('checkbox')),
          isSemantics(hasCheckedState: true, isChecked: value, isButton: false),
        );
      });
    }
  });
}

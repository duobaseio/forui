import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  testWidgets('press', (tester) async {
    var press = 0;
    var longPress = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSidebarItem(label: const Text('Item'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.tap(find.text('Item'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 1);
    expect(longPress, 0);
  });

  testWidgets('long press', (tester) async {
    var press = 0;
    var longPress = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSidebarItem(label: const Text('Item'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.longPress(find.text('Item'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 1);
  });

  group('design system', skip: !Platform.isMacOS, () {
    const key = ValueKey('sidebar-item');

    for (final (theme, name) in [(FTheme.neutral.light.desktop, 'desktop'), (FTheme.neutral.light.touch, 'touch')]) {
      final height = theme.style.sizes.item;

      testWidgets('$name sidebar item has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FSidebar(
              children: const [FSidebarItem(label: Text('Item'), key: key)],
            ),
          ),
        );

        expect(tester.getSize(find.byKey(key)).height, closeTo(height, 0.001));
      });
    }
  });

  group('accessibility', () {
    testWidgets('collapsible item exposes expanded state that flips on toggle', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSidebar(
            children: const [
              FSidebarItem(
                label: Text('Parent'),
                children: [FSidebarItem(label: Text('Child'))],
              ),
            ],
          ),
        ),
      );

      expect(tester.getSemantics(find.text('Parent')), isSemantics(hasExpandedState: true, isExpanded: false));

      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      expect(tester.getSemantics(find.text('Parent')), isSemantics(hasExpandedState: true, isExpanded: true));
    });

    testWidgets('leaf item has no expanded state', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSidebar(
            children: [FSidebarItem(label: const Text('Leaf'), onPress: () {})],
          ),
        ),
      );

      expect(tester.getSemantics(find.text('Leaf')), isSemantics(hasExpandedState: false));
    });

    for (final (motion, disableAnimations) in [
      (FAccessibilityMotion.all, false),
      (FAccessibilityMotion.all, true),
      (FAccessibilityMotion.reduced, false),
      (FAccessibilityMotion.reduced, true),
    ]) {
      testWidgets('reveals children over its expand duration - $motion, disableAnimations: $disableAnimations', (
        tester,
      ) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = FakeAccessibilityFeatures(
          disableAnimations: disableAnimations,
        );
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        await tester.pumpWidget(
          TestScaffold.app(
            accessibility: FAccessibility(accessibleNavigation: false, motion: motion, focusHighlight: false),
            child: FSidebar(
              children: const [
                FSidebarItem(
                  label: Text('Parent'),
                  children: [FSidebarItem(label: Text('Child'))],
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.text('Parent'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // The reveal (all) and fade (all & reduced) follow FAccessibility.motion, not the platform's
        // disableAnimations.
        final reveal = tester.widget<FCollapsible>(find.byType(FCollapsible)).value;
        final fade = find.ancestor(of: find.text('Child'), matching: find.byType(FadeTransition)).first;
        expect(
          (reveal, tester.widget<FadeTransition>(fade).opacity.value),
          (motion == .all ? Curves.easeOutCubic.transform(0.5) : 1.0, Curves.easeIn.transform(0.5)),
        );

        await tester.pumpAndSettle();
      });
    }
  });
}

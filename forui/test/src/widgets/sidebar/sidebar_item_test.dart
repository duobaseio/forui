import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

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
  });
}

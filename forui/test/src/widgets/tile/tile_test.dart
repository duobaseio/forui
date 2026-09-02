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
        child: FTile(title: const Text('Bluetooth'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.tap(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 1);
    expect(longPress, 0);
  });

  testWidgets('disabled press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          enabled: false,
          title: const Text('Bluetooth'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.tap(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(title: const Text('Lorem'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.longPress(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 1);
  });

  testWidgets('disabled long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          enabled: false,
          title: const Text('Lorem'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.longPress(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('child hit test', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          title: const Text('Bluetooth'),
          details: FButton(onPress: () => count++, child: const Text('child')),
        ),
      ),
    );

    await tester.tap(find.text('child'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(count, 1);
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (variant, name) in [(FItemVariant.primary, 'normal'), (FItemVariant.destructive, 'destructive')]) {
      testWidgets('touch $name tile has consistent height', (tester) async {
        final theme = FTheme.neutral.light.touch;
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FTile(key: const Key('tile'), variant: variant, title: const Text('Tile'), onPress: () {}),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('tile'))).height, closeTo(theme.style.sizes.tile, 0.001));
      });
    }
  });

  group('accessibility', () {
    testWidgets('group node is named by the visible label and description', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTileGroup(
            label: const Text('Settings'),
            description: const Text('Device options'),
            children: [FTile(title: const Text('Bluetooth'), onPress: () {})],
          ),
        ),
      );

      final group = tester.getSemantics(find.bySemanticsLabel('Settings'));
      expect(group, isSemantics(label: 'Settings', hint: 'Device options'));

      var ancestor = tester.getSemantics(find.bySemanticsLabel('Bluetooth')).parent;
      while (ancestor != null && ancestor != group) {
        ancestor = ancestor.parent;
      }
      expect(ancestor, group);

      semantics.dispose();
    });

    testWidgets('semanticsLabel names a separate group node', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTileGroup(
            label: const Text('Settings'),
            semanticsLabel: 'Settings group',
            children: [FTile(title: const Text('Bluetooth'), onPress: () {})],
          ),
        ),
      );

      final group = tester.getSemantics(find.bySemanticsLabel('Settings group'));
      expect(group.parent, tester.getSemantics(find.bySemanticsLabel('Settings')));

      semantics.dispose();
    });
  });
}

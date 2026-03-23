import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;

  setUp(() {
    controller = FSelectController<String>();
  });

  tearDown(() {
    controller.dispose();
  });

  group('FSelectSection', () {
    testWidgets('focus skips title on desktop', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            control: .managed(controller: controller),
            children: [
              .richSection(
                label: const Text('1st'),
                children: [const .item(title: Text('A'), value: 'A')],
              ),
              .richSection(
                label: const Text('2nd'),
                children: [const .item(title: Text('B'), value: 'B')],
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(find.text('B'), findsOne);
      expect(controller.value, 'B');
    });
  });

  group('FSelectItem', () {
    testWidgets('focus changes on desktop', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            control: .managed(controller: controller),
            children: [
              .item(title: const Text('A'), value: 'A'),
              .item(title: const Text('B'), value: 'B'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(find.text('B'), findsOne);
      expect(controller.value, 'B');
    });
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName) in [
      (FThemeData(touch: false, colors: FColors.neutral.light), 'desktop'),
      (FThemeData(touch: true, colors: FColors.neutral.light), 'touch'),
    ]) {
      final itemStyle = theme.selectStyle.contentStyle.sectionStyle.itemStyle;
      final height = theme.style.sizes.item;

      testWidgets('$themeName select item has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FItem(key: const Key('item'), style: itemStyle, title: const Text('Item'), onPress: () {}),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('item'))).height, closeTo(height, 0.001));
      });

      testWidgets('$themeName raw select item has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FItem.raw(key: const Key('raw-item'), style: itemStyle, onPress: () {}, child: const Text('Item')),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('raw-item'))).height, closeTo(height, 0.001));
      });
    }
  });
}

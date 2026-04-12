import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const fruits = [
  'Apple',
  'Banana',
  'Blueberry',
  'Grapes',
  'Lemon',
  'Mango',
  'Kiwi',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Plum',
  'Raspberry',
  'Strawberry',
  'Watermelon',
];

class _Fruit {
  final int id;
  final String name;

  const _Fruit(this.id, this.name);

  @override
  String toString() => 'Fruit($id, $name)';
}

void main() {
  const key = ValueKey('autocomplete');

  late FAutocompleteController<String> controller;
  late FPopoverController popoverController;

  setUp(() {
    controller = FAutocompleteController<String>();
    popoverController = FPopoverController(vsync: const TestVSync());
  });

  tearDown(() {
    controller.dispose();
    popoverController.dispose();
  });

  group('lifted', () {
    testWidgets('lifted', (tester) async {
      var value = TextEditingValue.empty;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FAutocomplete(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              items: fruits,
            ),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('showing popover does not cause error', (tester) async {
      var value = TextEditingValue.empty;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FAutocomplete(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              items: fruits,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(EditableText));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(EditableText), ' ');
      await tester.pumpAndSettle();

      expect(tester.takeException(), null);
    });
  });

  group('managed', () {
    testWidgets('onChange callback called', (tester) async {
      TextEditingValue? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      expect(changedValue?.text, 'app');
    });
  });

  group('generic items', () {
    const genericFruits = [_Fruit(1, 'Apple'), _Fruit(2, 'Banana')];
    const duplicateNamedFruits = [_Fruit(1, 'Apple'), _Fruit(2, 'Apple'), _Fruit(3, 'Banana')];

    testWidgets('uses displayStringForOption for filtering and selection', (tester) async {
      _Fruit? selected;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete<_Fruit>(
            key: key,
            items: genericFruits,
            displayStringForOption: (fruit) => fruit.name,
            onSelect: (fruit) => selected = fruit,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      expect(selected, genericFruits.first);
      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('selects the tapped duplicate item', (tester) async {
      _Fruit? selected;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete<_Fruit>(
            key: key,
            items: duplicateNamedFruits,
            displayStringForOption: (fruit) => fruit.name,
            contentBuilder: (context, query, values) => [
              for (final fruit in values)
                FAutocompleteItem.item(value: fruit.name, data: fruit, title: Text('${fruit.name} #${fruit.id}')),
            ],
            onSelect: (fruit) => selected = fruit,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple #2'));
      await tester.pumpAndSettle();

      expect(selected, duplicateNamedFruits[1]);
      expect(find.text('Apple'), findsOneWidget);
    });
  });

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, items: fruits, focusNode: focus),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('typeahead not shown when unfocused', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(
            key: key,
            control: .managed(controller: controller),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'App');
      await tester.pumpAndSettle();

      expect(controller.current, isNotNull);

      focus.unfocus();
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);
      final span = controller.buildTextSpan(context: tester.element(find.byType(EditableText)), withComposing: false);
      expect(span.toPlainText(), 'App');
    });

    testWidgets('typeahead not shown when disabled but focused', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(
            key: key,
            control: .managed(controller: controller),
            enabled: false,
            items: fruits,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      controller.text = 'App';
      await tester.pumpAndSettle();

      final span = controller.buildTextSpan(context: tester.element(find.byType(EditableText)), withComposing: false);
      expect(span.toPlainText(), 'App');
    });

    testWidgets('tab to focus', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(
            key: key,
            popoverControl: .managed(controller: popoverController),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      expect(focus.hasFocus, false);
      expect(popoverController.status.isForwardOrCompleted, false);

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
      expect(popoverController.status.isForwardOrCompleted, true);
    });

    testWidgets('tab when completion available completes text', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete(
                key: key,
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, false);
      expect(autocompleteFocus.hasFocus, true);
      expect(buttonFocus.hasFocus, false);
      expect(find.text('Banana'), findsOne);
    });

    testWidgets('tab when no completion available shifts focus', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete(
                key: key,
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zebra');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, false);
      expect(autocompleteFocus.hasFocus, false);
      expect(buttonFocus.hasFocus, true);
    });
  });

  group('right arrow completion', () {
    testWidgets('right arrow does nothing', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete(
                key: key,
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, true);
      expect(autocompleteFocus.hasFocus, true);
      expect(buttonFocus.hasFocus, false);
      expect(find.text('b'), findsOne);
    });

    testWidgets('right arrow when completion available completes text', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete(
                key: key,
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                rightArrowToComplete: true,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, false);
      expect(autocompleteFocus.hasFocus, true);
      expect(buttonFocus.hasFocus, false);
      expect(find.text('Banana'), findsOne);
    });
  });

  for (final (platform, retain) in [(TargetPlatform.macOS, true), (TargetPlatform.iOS, false)]) {
    group('retainFocus on $platform', () {
      testWidgets('default behavior', (tester) async {
        debugDefaultTargetPlatformOverride = platform;
        final focus = autoDispose(FocusNode());
        await tester.pumpWidget(
          TestScaffold.app(
            child: FAutocomplete(
              key: key,
              control: .managed(controller: controller),
              popoverControl: .managed(controller: popoverController),
              focusNode: focus,
              items: fruits,
            ),
          ),
        );

        await tester.enterText(find.byKey(key), 'app');
        await tester.pumpAndSettle();

        expect(popoverController.status.isForwardOrCompleted, true);
        expect(focus.hasFocus, true);

        await tester.tap(find.text('Apple'));
        await tester.pumpAndSettle();

        expect(controller.text, 'Apple');
        expect(popoverController.status.isForwardOrCompleted, false);
        expect(focus.hasFocus, retain);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('retains focus', (tester) async {
        debugDefaultTargetPlatformOverride = platform;
        final focus = autoDispose(FocusNode());
        await tester.pumpWidget(
          TestScaffold.app(
            child: FAutocomplete(
              key: key,
              control: .managed(controller: controller),
              popoverControl: .managed(controller: popoverController),
              focusNode: focus,
              retainFocus: true,
              items: fruits,
            ),
          ),
        );

        await tester.enterText(find.byKey(key), 'app');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Apple'));
        await tester.pumpAndSettle();

        expect(controller.text, 'Apple');
        expect(popoverController.status.isForwardOrCompleted, false);
        expect(focus.hasFocus, true);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('does not retain focus', (tester) async {
        debugDefaultTargetPlatformOverride = platform;
        final focus = autoDispose(FocusNode());
        await tester.pumpWidget(
          TestScaffold.app(
            child: FAutocomplete(
              key: key,
              control: .managed(controller: controller),
              popoverControl: .managed(controller: popoverController),
              focusNode: focus,
              retainFocus: false,
              items: fruits,
            ),
          ),
        );

        await tester.enterText(find.byKey(key), 'app');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Apple'));
        await tester.pumpAndSettle();

        expect(controller.text, 'Apple');
        expect(popoverController.status.isForwardOrCompleted, false);
        expect(focus.hasFocus, false);

        debugDefaultTargetPlatformOverride = null;
      });
    });
  }

  testWidgets('enter closes popover', (tester) async {
    final focus = autoDispose(FocusNode());
    await tester.pumpWidget(
      TestScaffold.app(
        child: FAutocomplete(
          key: key,
          control: .managed(controller: controller),
          popoverControl: .managed(controller: popoverController),
          focusNode: focus,
          items: fruits,
        ),
      ),
    );

    await tester.enterText(find.byKey(key), 'app');
    await tester.pumpAndSettle();

    expect(popoverController.status.isForwardOrCompleted, true);
    expect(find.text('Apple'), findsOne);

    await tester.testTextInput.receiveAction(.done);
    await tester.pumpAndSettle();

    expect(focus.hasFocus, false);
    expect(popoverController.status.isForwardOrCompleted, false);
  });

  for (final platform in [TargetPlatform.macOS, TargetPlatform.iOS]) {
    group('keyboard navigation on $platform', () {
      testWidgets('arrow key navigation & selection', (tester) async {
        debugDefaultTargetPlatformOverride = platform;

        final focus = autoDispose(FocusNode());
        await tester.pumpWidget(
          TestScaffold.app(
            child: FAutocomplete(
              key: key,
              control: .managed(controller: controller),
              popoverControl: .managed(controller: popoverController),
              focusNode: focus,
              items: fruits,
            ),
          ),
        );

        await tester.enterText(find.byKey(key), 'app');
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(.arrowDown);
        await tester.pumpAndSettle();

        expect(find.text('app'), findsNothing);
        expect(find.text('Apple'), findsNWidgets(2));

        await tester.sendKeyEvent(.enter);
        await tester.pumpAndSettle();

        expect(focus.hasFocus, true);
        expect(controller.selection, const TextSelection.collapsed(offset: 5));
        expect(popoverController.status.isForwardOrCompleted, false);
        expect(find.text('app'), findsNothing);
        expect(find.text('Apple'), findsOne);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('arrow key navigation and escape', (tester) async {
        debugDefaultTargetPlatformOverride = platform;

        final focus = autoDispose(FocusNode());
        await tester.pumpWidget(
          TestScaffold.app(
            child: FAutocomplete(
              key: key,
              control: .managed(controller: controller),
              popoverControl: .managed(controller: popoverController),
              focusNode: focus,
              items: fruits,
            ),
          ),
        );

        await tester.enterText(find.byKey(key), 'app');
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(.arrowDown);
        await tester.pumpAndSettle();

        expect(find.text('app'), findsNothing);
        expect(find.text('Apple'), findsNWidgets(2));

        await tester.sendKeyEvent(.escape);
        await tester.pumpAndSettle();

        expect(focus.hasFocus, true);
        expect(controller.selection, const TextSelection.collapsed(offset: 3));
        expect(popoverController.status.isForwardOrCompleted, false);
        expect(find.text('app'), findsOne);
        expect(find.text('Apple'), findsNothing);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('arrow key navigation and tap outside', (tester) async {
        debugDefaultTargetPlatformOverride = platform;

        final focus = autoDispose(FocusNode());
        await tester.pumpWidget(
          TestScaffold.app(
            child: FAutocomplete(
              key: key,
              popoverControl: .managed(controller: popoverController),
              focusNode: focus,
              items: fruits,
            ),
          ),
        );

        await tester.enterText(find.byKey(key), 'app');
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(.arrowDown);
        await tester.pumpAndSettle();

        expect(find.text('app'), findsNothing);
        expect(find.text('Apple'), findsNWidgets(2));

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();

        expect(focus.hasFocus, true);
        expect(popoverController.status.isForwardOrCompleted, false);
        expect(find.text('app'), findsOne);
        expect(find.text('Apple'), findsNothing);

        debugDefaultTargetPlatformOverride = null;
      });
    });
  }

  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName) in [
      (FThemes.neutral.light.desktop, 'desktop'),
      (FThemes.neutral.light.touch, 'touch'),
    ]) {
      final itemStyle = theme.autocompleteStyle.contentStyle.sectionStyle.itemStyle;
      final height = theme.style.sizes.item;

      testWidgets('$themeName autocomplete item has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FItem(key: const Key('item'), style: itemStyle, title: const Text('Item'), onPress: () {}),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('item'))).height, closeTo(height, 0.001));
      });

      testWidgets('$themeName raw autocomplete item has consistent height ($height)', (tester) async {
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

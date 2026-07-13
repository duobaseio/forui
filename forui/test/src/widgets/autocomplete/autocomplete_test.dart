import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

void main() {
  const key = ValueKey('autocomplete');

  late FAutocompleteController controller;
  late FPopoverController popoverController;

  setUp(() {
    controller = FAutocompleteController();
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
            builder: (context, setState) => FAutocomplete.text(
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
            builder: (context, setState) => FAutocomplete.text(
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
          child: FAutocomplete.text(
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

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(key: key, items: fruits, focusNode: focus),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('typeahead not shown when unfocused', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
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
          child: FAutocomplete.text(
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
          child: FAutocomplete.text(
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
              FAutocomplete.text(
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
              FAutocomplete.text(
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

    testWidgets('TextInputAction.next does not select suggestion when popover is open', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete.text(
                key: key,
                control: .managed(controller: controller),
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                textInputAction: TextInputAction.next,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);

      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pumpAndSettle();

      expect(controller.text, '');
      expect(popoverController.status.isForwardOrCompleted, false);
      expect(autocompleteFocus.hasFocus, false);
      expect(buttonFocus.hasFocus, true);
    });

    testWidgets('tab between popover items navigates within popover', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete.text(
                key: key,
                control: .managed(controller: controller),
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();
      expect(controller.text, 'Apple');

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(controller.text, 'Banana');
      expect(popoverController.status.isForwardOrCompleted, true);
      expect(buttonFocus.hasFocus, false);
    });

    testWidgets('TextInputAction.next does not commit completion with typed prefix', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete.text(
                key: key,
                control: .managed(controller: controller),
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                textInputAction: TextInputAction.next,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pumpAndSettle();

      expect(controller.text, 'b');
      expect(popoverController.status.isForwardOrCompleted, false);
      expect(buttonFocus.hasFocus, true);
    });

    testWidgets('tab from empty field with popover open closes popover and moves focus', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete.text(
                key: key,
                control: .managed(controller: controller),
                popoverControl: .managed(controller: popoverController),
                focusNode: autocompleteFocus,
                items: fruits,
              ),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(controller.text, '');
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
              FAutocomplete.text(
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
              FAutocomplete.text(
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
            child: FAutocomplete.text(
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
            child: FAutocomplete.text(
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
            child: FAutocomplete.text(
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

  group('onChange', () {
    testWidgets('onChange callback called when suggestion is tapped', (tester) async {
      TextEditingValue? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      expect(changedValue?.text, 'Apple');
    });

    testWidgets('onChange callback called when tab completes inline suggestion', (tester) async {
      TextEditingValue? changedValue;
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(controller.text, 'Apple');
      expect(changedValue?.text, 'Apple');
    });

    testWidgets('onChange callback called when arrow-key navigation previews a suggestion', (tester) async {
      TextEditingValue? changedValue;
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();

      expect(controller.text, 'Apple');
      expect(changedValue?.text, 'Apple');
    });

    testWidgets('onChange callback called when popover dismiss restores prior text', (tester) async {
      final changes = <String>[];
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changes.add(value.text)),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();
      expect(controller.text, 'Apple');

      await tester.sendKeyEvent(.escape);
      await tester.pumpAndSettle();

      expect(controller.text, 'app');
      expect(changes.last, 'app');
      expect(changes.where((c) => c == 'app').length, 2);
    });
  });

  testWidgets('enter closes popover', (tester) async {
    final focus = autoDispose(FocusNode());
    await tester.pumpWidget(
      TestScaffold.app(
        child: FAutocomplete.text(
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
            child: FAutocomplete.text(
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
            child: FAutocomplete.text(
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
            child: FAutocomplete.text(
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

  group('contentEmptyBuilder', () {
    testWidgets('default shows popover with localized message when results are empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            popoverControl: .managed(controller: popoverController),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zzz');
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, true);
      expect(find.text(FDefaultLocalizations().autocompleteNoResults), findsOne);
    });

    testWidgets('null hides popover when results are empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            popoverControl: .managed(controller: popoverController),
            items: fruits,
            contentEmptyBuilder: null,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zzz');
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, false);
    });

    testWidgets('null reshows popover when results become non-empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            popoverControl: .managed(controller: popoverController),
            items: fruits,
            contentEmptyBuilder: null,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zzz');
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, false);

      await tester.enterText(find.byKey(key), 'App');
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);
    });

    testWidgets('non-null shows popover when results are empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            popoverControl: .managed(controller: popoverController),
            items: fruits,
            contentEmptyBuilder: (_, _) => const Text('no results'),
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zzz');
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, true);
      expect(find.text('no results'), findsOne);
    });

    testWidgets('null hides popover after async resolution to empty', (tester) async {
      final completer = Completer<Iterable<String>>();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.textBuilder(
            key: key,
            popoverControl: .managed(controller: popoverController),
            filter: (_) => completer.future,
            contentBuilder: (_, _, values) => [for (final v in values) .item(value: v)],
            contentLoadingBuilder: (_, _) => const Text('loading'),
            contentEmptyBuilder: null,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);
      expect(find.text('loading'), findsOne);

      completer.complete(const <String>[]);
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, false);
    });
  });

  group('contentLoadingBuilder', () {
    testWidgets('default shows popover with spinner during async load', (tester) async {
      final completer = Completer<Iterable<String>>();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.textBuilder(
            key: key,
            popoverControl: .managed(controller: popoverController),
            filter: (_) => completer.future,
            contentBuilder: (_, _, values) => [for (final v in values) .item(value: v)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      // Don't pumpAndSettle — the spinner loops forever. Pump enough to run the show animation.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(popoverController.status.isForwardOrCompleted, true);
      expect(find.byType(FCircularProgress), findsOne);

      // Resolve the future so the spinner stops before teardown.
      completer.complete(const <String>[]);
      await tester.pumpAndSettle();
    });

    testWidgets('null hides popover during async load', (tester) async {
      final completer = Completer<Iterable<String>>();
      addTearDown(() {
        if (!completer.isCompleted) {
          completer.complete(const <String>[]);
        }
      });

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.textBuilder(
            key: key,
            popoverControl: .managed(controller: popoverController),
            filter: (_) => completer.future,
            contentBuilder: (_, _, values) => [for (final v in values) .item(value: v)],
            contentLoadingBuilder: null,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, false);
    });

    testWidgets('async resolution after unfocus does not re-show popover', (tester) async {
      final completer = Completer<Iterable<String>>();
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.textBuilder(
            key: key,
            popoverControl: .managed(controller: popoverController),
            focusNode: focus,
            filter: (_) => completer.future,
            contentBuilder: (_, _, values) => [for (final v in values) .item(value: v)],
            contentLoadingBuilder: (_, _) => const Text('loading'),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);

      focus.unfocus();
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, false);

      completer.complete(fruits);
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, false);
    });
  });

  group('contentErrorBuilder', () {
    testWidgets('default keeps popover shown on async failure', (tester) async {
      final completer = Completer<Iterable<String>>();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.textBuilder(
            key: key,
            popoverControl: .managed(controller: popoverController),
            filter: (_) => completer.future,
            contentBuilder: (_, _, values) => [for (final v in values) .item(value: v)],
            contentLoadingBuilder: (_, _) => const Text('loading'),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      completer.completeError('boom', .current);
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, true);
    });

    testWidgets('null hides popover on async failure', (tester) async {
      final completer = Completer<Iterable<String>>();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.textBuilder(
            key: key,
            popoverControl: .managed(controller: popoverController),
            filter: (_) => completer.future,
            contentBuilder: (_, _, values) => [for (final v in values) .item(value: v)],
            contentLoadingBuilder: (_, _) => const Text('loading'),
            contentErrorBuilder: null,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(popoverController.status.isForwardOrCompleted, true);

      completer.completeError('boom', StackTrace.current);
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, false);
    });
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName) in [
      (FTheme.neutral.light.desktop, 'desktop'),
      (FTheme.neutral.light.touch, 'touch'),
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

  group('onItemPress', () {
    testWidgets('called with correct value when item is tapped', (tester) async {
      String? pressed;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            onItemPress: (value) => pressed = value,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      expect(pressed, 'Apple');
    });

    testWidgets('not called on tab completion', (tester) async {
      String? pressed;
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            focusNode: focus,
            onItemPress: (value) => pressed = value,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(controller.text, 'Apple');
      expect(pressed, null);
    });
  });

  group('accessibility', () {
    List<String> captureAnnouncements(WidgetTester tester) {
      final announcements = <String>[];
      tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(SystemChannels.accessibility, (
        message,
      ) async {
        final map = message! as Map<Object?, Object?>;
        if (map['type'] == 'announce') {
          announcements.add((map['data']! as Map<Object?, Object?>)['message']! as String);
        }
        return null;
      });
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(
          SystemChannels.accessibility,
          null,
        ),
      );
      return announcements;
    }

    testWidgets('field advertises a collapsed combobox state when the popover is closed', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            items: fruits,
          ),
        ),
      );

      expect(tester.getSemantics(find.byType(EditableText)), isSemantics(hasExpandedState: true, isExpanded: false));

      semantics.dispose();
    });

    testWidgets('field advertises an expanded state when suggestions are shown', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      expect(popoverController.status.isForwardOrCompleted, true);
      expect(tester.getSemantics(find.byType(EditableText)), isSemantics(hasExpandedState: true, isExpanded: true));

      semantics.dispose();
    });

    testWidgets('announces the result count when suggestions appear', (tester) async {
      final announcements = captureAnnouncements(tester);
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      expect(announcements, contains('2 results available'));
    });

    testWidgets('announces no matches when the query has no results', (tester) async {
      final announcements = captureAnnouncements(tester);
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zzz');
      await tester.pumpAndSettle();

      expect(announcements, contains('No matches found.'));
    });

    testWidgets('exposes the inline completion as a semantics hint', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      expect(tester.getSemantics(find.byType(EditableText)), isSemantics(hint: 'Suggestion: Apple'));

      semantics.dispose();
    });

    testWidgets('arrow down navigates through the suggestions', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();
      expect(controller.text, 'Banana');

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();
      expect(controller.text, 'Blueberry');
    });

    testWidgets('arrow up from the first suggestion returns focus to the field', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete.text(
            key: key,
            control: .managed(controller: controller),
            popoverControl: .managed(controller: popoverController),
            focusNode: focus,
            items: fruits,
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();
      expect(focus.hasFocus, false);

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      expect(focus.hasFocus, true);
    });
  });
}

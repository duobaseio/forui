import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  for (final (description, field) in [
    ('input only', () => FDateField.input(key: key)),
    ('input & calendar', () => FDateField(key: key)),
  ]) {
    for (final (index, (locale, placeholder)) in const [
      (null, 'MM/DD/YYYY'), // M/d/y
      (Locale('en', 'SG'), 'DD/MM/YYYY'), // dd/MM/y
      (Locale('hr'), 'DD. MM. YYYY.'),
      (Locale('bg'), 'DD.MM.YYYY г.'),
    ].indexed) {
      testWidgets('placeholder - $description - $index', (tester) async {
        await tester.pumpWidget(TestScaffold.app(locale: locale, child: field()));

        expect(find.text(placeholder), findsOneWidget);
      });
    }

    group('managed', () {
      testWidgets('called when value changes', (tester) async {
        DateTime? changed;
        final controller = autoDispose(FDateSelectionController.single());

        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: FDateField.input(
              selectionControl: .managedSingle(controller: controller, onChange: (v) => changed = v),
            ),
          ),
        );

        controller.value = .utc(2025, 1, 15);
        await tester.pump();

        expect(changed, DateTime.utc(2025, 1, 15));
      });

      testWidgets('onChange called when clearing via clear button', (tester) async {
        final values = <DateTime?>[];

        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: FDateField.input(
              key: key,
              clearable: true,
              selectionControl: .managedSingle(onChange: values.add),
            ),
          ),
        );

        await tester.enterText(find.byKey(key), '15/01/2025');
        await tester.pumpAndSettle();

        expect(values, [DateTime.utc(2025, 1, 15)]);

        await tester.tap(find.bySemanticsLabel('Clear'));
        await tester.pumpAndSettle();

        expect(values, [DateTime.utc(2025, 1, 15), null]);
      });
    });

    group('external controller', () {
      testWidgets('interaction works', (tester) async {
        final controller = autoDispose(FDateSelectionController.single());

        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: FDateField.input(
              key: key,
              selectionControl: .managedSingle(controller: controller),
            ),
          ),
        );

        await tester.enterText(find.byKey(key), '15/01/2025');
        await tester.pumpAndSettle();

        expect(controller.value, DateTime.utc(2025, 1, 15));
      });
    });

    testWidgets('arrow key adjustment - $description', (tester) async {
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field()));

      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      expect(find.text('01/12/2001'), findsOneWidget);
    });
  }

  group('validator', () {
    for (final (description, field) in [
      ('input only', () => FDateField.input(key: key)),
      ('input & calendar', () => FDateField(key: key)),
    ]) {
      testWidgets('placeholder - $description', (tester) async {
        debugDefaultTargetPlatformOverride = .macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field()));

        await tester.tapAt(tester.getTopLeft(find.byKey(key)));
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(.backspace);
        await tester.pumpAndSettle();

        await tester.tapAt(tester.getBottomRight(find.byType(TestScaffold)));
        await tester.pumpAndSettle();

        expect(find.text('Invalid date.'), findsNothing);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('partial date - $description', (tester) async {
        debugDefaultTargetPlatformOverride = .macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field()));

        await tester.enterText(find.byKey(key), '28/MM/YYYY');
        await tester.pumpAndSettle();

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();

        expect(find.text('Invalid date.'), findsOneWidget);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('partial date - hr locale - $description', (tester) async {
        debugDefaultTargetPlatformOverride = .macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('hr'), child: field()));

        await tester.enterText(find.byKey(key), '28. MM. YYYY');
        await tester.pumpAndSettle();

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();

        expect(find.text('Nevažeći datum.'), findsOneWidget);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('full date - $description', (tester) async {
        debugDefaultTargetPlatformOverride = .macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field()));

        await tester.enterText(find.byKey(key), '14/01/2025');
        await tester.pumpAndSettle();

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();

        expect(find.text('Invalid date.'), findsNothing);

        debugDefaultTargetPlatformOverride = null;
      });
    }

    for (final (description, field) in [
      (
        'input only',
        (FDateSelectionController<DateTime?> controller) => FDateField.input(
          selectionControl: .managedSingle(controller: controller),
          validator: (date) => date == .utc(1984) ? 'Custom error.' : null,
          key: key,
        ),
      ),
      (
        'input & calendar',
        (FDateSelectionController<DateTime?> controller) => FDateField(
          selectionControl: .managedSingle(controller: controller),
          validator: (date) => date == .utc(1984) ? 'Custom error.' : null,
          key: key,
        ),
      ),
    ]) {
      testWidgets('custom invalid date - $description', (tester) async {
        debugDefaultTargetPlatformOverride = .macOS;

        final controller = autoDispose(FDateSelectionController.single());

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field(controller)));

        await tester.enterText(find.byKey(key), '01/01/1984');
        await tester.pumpAndSettle();

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();

        expect(find.text('Custom error.'), findsOneWidget);

        debugDefaultTargetPlatformOverride = null;
      });
    }
  });

  for (final (description, field, expected) in [
    ('input only', () => FDateField.input(key: key), 0),
    ('input & calendar', () => FDateField(key: key), 0),
    ('input only, clearable', () => FDateField.input(key: key, clearable: true), 1),
    ('input & calendar, clearable', () => FDateField(key: key, clearable: true), 1),
  ]) {
    testWidgets(description, (tester) async {
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field()));

      expect(find.bySemanticsLabel('Clear'), findsNothing);

      await tester.enterText(find.byKey(key), '14/01/2025');
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Clear'), findsExactly(expected));
    });
  }

  testWidgets('enter closes popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField(key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsOne);

    await tester.sendKeyEvent(.enter);
    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsNothing);
  });

  group('accessibility', () {
    testWidgets('empty segmented field announces an empty value, not the placeholder', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(TestScaffold.app(child: FDateField.input(label: const Text('Date of birth'))));

      // The placeholder is still painted for sighted users.
      expect(find.text('MM/DD/YYYY'), findsOneWidget);

      // But it is not announced as the entered value: the field reads as empty.
      expect(tester.getSemantics(find.text('MM/DD/YYYY')), isSemantics(isTextField: true, value: ''));

      semantics.dispose();
    });

    testWidgets('filled segmented field announces the entered value', (tester) async {
      final semantics = tester.ensureSemantics();
      final controller = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.input(
            selectionControl: .managedSingle(controller: controller),
            label: const Text('Date'),
          ),
        ),
      );

      controller.value = DateTime.utc(2025, 1, 15);
      await tester.pump();

      final shown = tester.widget<EditableText>(find.byType(EditableText)).controller.text;
      expect(shown, isNot('MM/DD/YYYY'));
      expect(tester.getSemantics(find.byType(EditableText)), isSemantics(isTextField: true, value: shown));

      semantics.dispose();
    });

    testWidgets('trigger advertises a collapsed state when the calendar is closed', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(TestScaffold.app(child: FDateField(key: key)));

      expect(tester.getSemantics(find.byType(EditableText)), isSemantics(hasExpandedState: true, isExpanded: false));

      semantics.dispose();
    });

    testWidgets('trigger advertises an expanded state when the calendar is open', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(TestScaffold.app(child: FDateField(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(tester.getSemantics(find.byType(EditableText)), isSemantics(hasExpandedState: true, isExpanded: true));

      semantics.dispose();
    });

    testWidgets('escape dismisses the calendar while focus is in the combined field', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: FDateField(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(find.byType(FCalendar), findsOne);

      await tester.sendKeyEvent(.escape);
      await tester.pumpAndSettle();
      expect(find.byType(FCalendar), findsNothing);
    });

    testWidgets('escape is not consumed by the combined field when the calendar is closed', (tester) async {
      final focus = autoDispose(FocusNode());
      var escaped = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: CallbackShortcuts(
            bindings: {const SingleActivator(.escape): () => escaped = true},
            child: FDateField(key: key, focusNode: focus),
          ),
        ),
      );

      focus.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(.escape);
      await tester.pump();

      expect(escaped, true);
    });
  });
}

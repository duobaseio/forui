// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import '../../locale_scaffold.dart';
import '../../test_scaffold.dart';

void main() {
  const key = Key('field');

  setUpAll(initializeDateFormatting);

  group('external controller', () {
    testWidgets('text input interaction works', (tester) async {
      final selection = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(controller: selection),
          ),
        ),
      );

      await tester.enterText(find.byKey(key), '15/01/2025');
      await tester.pumpAndSettle();

      expect(selection.value, DateTime.utc(2025, 1, 15));
    });

    testWidgets('calendar interaction works', (tester) async {
      final selection = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(controller: selection),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime.utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(selection.value, DateTime.utc(2025, 1, 15));
    });

    testWidgets('arrow adjustment changes the focused segment', (tester) async {
      final selection = autoDispose(FDateSelectionController.single(initial: DateTime.utc(2025, 1, 15)));

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(controller: selection),
          ),
        ),
      );

      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();

      expect(find.text('16/01/2025'), findsOneWidget);
    });

    testWidgets('adjustment does not produce full date from placeholder', (tester) async {
      final selection = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(controller: selection),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();

      expect(selection.value, null);
    });

    testWidgets('adjustment produces partial date from placeholder', (tester) async {
      final selection = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(controller: selection),
          ),
        ),
      );

      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();

      expect(find.text('01/MM/YYYY'), findsOneWidget);
    });
  });

  group('managed', () {
    testWidgets('called when value changes', (tester) async {
      DateTime? changed;
      final selection = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            selectionControl: .managedSingle(controller: selection, onChange: (v) => changed = v),
          ),
        ),
      );

      selection.value = DateTime.utc(2025, 1, 15);
      await tester.pump();

      expect(changed, DateTime.utc(2025, 1, 15));
    });
  });

  for (final (index, (date, start, end, expected)) in [
    ('01/01/1899', null, null, 'January 2025'),
    ('01/01/1949', DateTime.utc(1950), null, 'January 2025'),
    ('01/01/1951', DateTime.utc(1950), null, 'January 1951'),
    ('01/01/2101', null, null, 'January 2025'),
    ('01/01/2051', null, DateTime.utc(2050), 'January 2025'),
    ('01/01/2049', null, DateTime.utc(2050), 'January 2049'),
  ].indexed) {
    testWidgets('initial month - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            calendar: FDateFieldGridCalendarProperties(
              control: FGridCalendarControl(start: start, end: end, today: DateTime.utc(2025, 1, 15)),
            ),
          ),
        ),
      );

      await tester.enterText(find.byKey(key), date);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(find.text(expected), findsOneWidget);
    });
  }

  testWidgets('unselect', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField(
          key: key,
          calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime.utc(2025, 1, 15))),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15/01/2025'), findsOneWidget);

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();

    expect(find.text('15/01/2025'), findsNothing);
  });

  group('locale', () {
    testWidgets('input only - change locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: LocaleScaffold(child: FDateField.input(key: key)),
        ),
      );
      expect(find.text('MM/DD/YYYY'), findsOneWidget);
      expect(find.text('YYYY. MM. DD.'), findsNothing);

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('MM/DD/YYYY'), findsNothing);
      expect(find.text('YYYY. MM. DD.'), findsOneWidget);
    });

    testWidgets('calendar only - change locale', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: FDateField.calendar())));
      expect(find.text('Pick a date'), findsOneWidget);
      expect(find.text('날짜 선택'), findsNothing);

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Pick a date'), findsNothing);
      expect(find.text('날짜 선택'), findsOneWidget);
    });

    for (final (name, field) in [
      ('calendar only', (FocusNode focus) => FDateField.calendar(focusNode: focus)),
      ('input only', (FocusNode focus) => FDateField.input(focusNode: focus)),
      ('both', (FocusNode focus) => FDateField(focusNode: focus)),
    ]) {
      group(name, () {
        testWidgets('update focus', (tester) async {
          final first = autoDispose(FocusNode());

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(first))));

          expect(first.hasListeners, true);

          final second = autoDispose(FocusNode());

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(second))));

          expect(first.hasListeners, false);
          expect(second.hasListeners, true);
        });

        testWidgets('dispose focus', (tester) async {
          final first = autoDispose(FocusNode());

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(first))));
          expect(first.hasListeners, true);

          await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
          expect(first.hasListeners, false);
        });
      });
    }
  });
}

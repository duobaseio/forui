import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  for (final (index, (locale, placeholder)) in const [
    (null, 'Pick a date'),
    (Locale('en', 'SG'), 'Pick a date'),
    (Locale('hr'), 'Odaberite datum'),
  ].indexed) {
    testWidgets('placeholder - $index', (tester) async {
      await tester.pumpWidget(TestScaffold.app(locale: locale, child: FDateField.calendar()));

      expect(find.text(placeholder), findsOneWidget);
    });
  }

  for (final (index, (locale, day, date)) in const [
    (null, '15', 'Jan 15, 2025'), // M/d/y
    (Locale('en', 'SG'), '15', '15 Jan 2025'), // dd/MM/y
    (Locale('hr'), '15.', '15. sij 2025.'),
  ].indexed) {
    testWidgets('formatted date - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: FDateField.calendar(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text(day));
      await tester.pumpAndSettle();

      expect(find.text(date), findsOneWidget);
    });
  }

  group('managed', () {
    testWidgets('called when value changes', (tester) async {
      DateTime? changed;
      final controller = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField.calendar(
            selectionControl: .managedSingle(controller: controller, onChange: (v) => changed = v),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      controller.value = DateTime.utc(2025, 1, 15);
      await tester.pump();

      expect(changed, DateTime.utc(2025, 1, 15));
    });
  });

  group('external controller', () {
    testWidgets('interaction works', (tester) async {
      final controller = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField.calendar(
            key: key,
            selectionControl: .managedSingle(controller: controller),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(controller.value, DateTime.utc(2025, 1, 15));
    });
  });

  group('lifted', () {
    testWidgets('displays external value', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField.calendar(
            selectionControl: .liftedSingle(value: DateTime.utc(2025, 1, 15), onChange: (_) {}),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      expect(find.text('15 Jan 2025'), findsOneWidget);
    });

    testWidgets('tapping a day drives external state and updates the field', (tester) async {
      DateTime? selected;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField.calendar(
              key: key,
              selectionControl: .liftedSingle(value: selected, onChange: (date) => setState(() => selected = date)),
              calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(selected, DateTime.utc(2025, 1, 15));
      expect(find.text('15 Jan 2025'), findsOneWidget);
    });

    testWidgets('external value change updates the field', (tester) async {
      DateTime? selected;
      late StateSetter set;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) {
              set = setState;
              return FDateField.calendar(
                selectionControl: .liftedSingle(value: selected, onChange: (date) => setState(() => selected = date)),
                calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
              );
            },
          ),
        ),
      );

      expect(find.text('Pick a date'), findsOneWidget);

      set(() => selected = DateTime.utc(2025, 1, 20));
      await tester.pumpAndSettle();

      expect(find.text('20 Jan 2025'), findsOneWidget);
    });
  });

  testWidgets('validator', (tester) async {
    debugDefaultTargetPlatformOverride = .macOS;

    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField.calendar(
          validator: (date) => date == DateTime.utc(2025, 1, 16) ? 'Custom error.' : null,
          key: key,
          calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('16'));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(500, 500));
    await tester.pumpAndSettle();

    expect(find.text('Custom error.'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('unselect', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField.calendar(
          key: key,
          calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15 Jan 2025'), findsOneWidget);

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();

    expect(find.text('15 Jan 2025'), findsNothing);
  });

  testWidgets('custom format', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField.calendar(
          key: key,
          format: (_, date, _) => DateFormat.yMMMMd('en_SG').format(date),
          calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15 January 2025'), findsOneWidget);
  });

  testWidgets('holding & releasing on date field does not cause calendar to disappear & reappear', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FDateField.calendar(
          key: key,
          calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    final gesture = await tester.startGesture(tester.getCenter(find.byKey(key)), kind: .mouse);
    await tester.pumpAndSettle();

    expect(find.text('15'), findsOneWidget);

    await gesture.up();
    await tester.pumpAndSettle();

    expect(find.text('15'), findsNothing);
  });

  group('clearable', () {
    testWidgets('no clear icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('shows clear icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(
            key: key,
            clearable: true,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );
      expect(find.bySemanticsLabel('Clear'), findsNothing);

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.bySemanticsLabel('Clear'), findsOne);
    });

    testWidgets('clearing resets controller value', (tester) async {
      final controller = autoDispose(FDateSelectionController.single());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField.calendar(
            key: key,
            clearable: true,
            selectionControl: .managedSingle(controller: controller),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(controller.value, DateTime.utc(2025, 1, 15));
      expect(find.bySemanticsLabel('Clear'), findsOne);

      await tester.tap(find.bySemanticsLabel('Clear'));
      await tester.pumpAndSettle();

      expect(controller.value, null);
      expect(find.bySemanticsLabel('Clear'), findsNothing);
      expect(find.text('Pick a date'), findsOneWidget);
    });
  });

  group('focus', () {
    testWidgets('tap on text-field should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('escape should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.escape);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('tap outside unfocuses on Android/iOS', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);
    });

    testWidgets('tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = .macOS;

      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(500, 500));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}

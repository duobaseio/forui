import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import '../../test_scaffold.dart';

void main() {
  // The wheel's state transitions (setMonthYear / toggleMonthYearPicker) are programmatic with no deterministic UI
  // gesture, so tests that drive or read them pass their own controller. The widget does not own a provided controller
  // (it only removes its listener), so autoDispose owns it here.
  FWheelCalendarController controller({DateTime? start, DateTime? today, DateTime? initial, DateTime? end}) =>
      autoDispose(
        FWheelCalendarController(
          start: start ?? .utc(2023, 2, 8),
          today: today ?? .utc(2024, 7, 14),
          initial: initial ?? .utc(2024, 7, 14),
          end: end ?? .utc(2025, 8, 10),
        ),
      );

  Widget calendar({
    required FDateSelectionControl selectionControl,
    FWheelCalendarController? controller,
    FutureOr<void> Function(DateTime)? onDayPress,
    FutureOr<void> Function(DateTime)? onDayLongPress,
  }) => TestScaffold.app(
    child: FCalendar.wheel(
      selectionControl: selectionControl,
      control: controller == null
          ? FWheelCalendarControl(start: .utc(2023, 2, 8), today: .utc(2024, 7, 14), end: .utc(2025, 8, 10))
          : FWheelCalendarControl(controller: controller),
      onDayPress: onDayPress,
      onDayLongPress: onDayLongPress,
    ),
  );

  Finder day(String text) => find.descendant(of: find.byType(DayPicker), matching: find.text(text));

  group('switching', () {
    testWidgets('initial state shows the day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle()));

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.byType(FPicker), findsNothing);
      expect(find.text('July 2024'), findsOneWidget);
      expect(day('15'), findsOneWidget);
    });

    testWidgets('tapping the header shows the month-year wheel', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();

      expect(find.byType(FPicker), findsOneWidget);
      expect(find.byType(DayPicker), findsNothing);
      expect(find.text('July 2024'), findsOneWidget); // header label unchanged
    });

    testWidgets('tapping the header again returns to the day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.byType(FPicker), findsNothing);
    });

    testWidgets('the wheel view has no navigation buttons', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();

      expect(find.byType(FButton), findsNothing);
    });
  });

  group('wheel', () {
    testWidgets('setMonthYear updates the month shown by the day grid on toggle back', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.toggleMonthYearPicker();
      await tester.pumpAndSettle();
      expect(c.monthYear, true);

      c.setMonthYear(9, 2024);
      await tester.pumpAndSettle();
      expect(c.currentMonth, DateTime.utc(2024, 9));

      c.toggleMonthYearPicker();
      await tester.pumpAndSettle();
      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.text('September 2024'), findsOneWidget);
    });

    testWidgets('setMonthYear updates the year', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.toggleMonthYearPicker();
      await tester.pumpAndSettle();
      c.setMonthYear(7, 2025);
      await tester.pumpAndSettle();
      expect(c.currentMonth, DateTime.utc(2025, 7));

      c.toggleMonthYearPicker();
      await tester.pumpAndSettle();
      expect(find.text('July 2025'), findsOneWidget);
    });

    testWidgets('setMonthYear clamps an out-of-range selection to the bounds', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.toggleMonthYearPicker();
      await tester.pumpAndSettle();
      c.setMonthYear(12, 2030); // past end (.utc(2025, 8, 10))
      await tester.pumpAndSettle();

      expect(c.currentMonth, DateTime.utc(2025, 8));
    });

    testWidgets('setMonthYear is a no-op when the wheel is not shown', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.setMonthYear(9, 2024); // wheel not shown
      await tester.pumpAndSettle();

      expect(c.currentMonth, DateTime.utc(2024, 7));
      expect(find.byType(DayPicker), findsOneWidget);
    });

    testWidgets('dragging the month wheel changes the current month', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.toggleMonthYearPicker();
      await tester.pumpAndSettle();

      // Drag the month wheel up to scroll to a later month.
      await tester.drag(find.text('Jul'), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(c.currentMonth.isAfter(DateTime.utc(2024, 7)), true);
    });
  });

  group('jumpToDayPicker / animateToDayPicker', () {
    for (final (motion, move) in <(String, Future<void> Function(FWheelCalendarController))>[
      ('jumpToDayPicker', (c) async => c.jumpToDayPicker(DateTime.utc(2024, 9))),
      ('animateToDayPicker', (c) => c.animateToDayPicker(DateTime.utc(2024, 9))),
    ]) {
      testWidgets('$motion moves the mounted day grid to another month', (tester) async {
        final c = controller();
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

        expect(find.text('July 2024'), findsOneWidget);

        // Fire-and-forget: awaiting animateToDayPicker deadlocks since pumpAndSettle drives the animation.
        unawaited(move(c));
        await tester.pumpAndSettle();

        expect(tester.takeException(), null);
        expect(find.byType(DayPicker), findsOneWidget);
        expect(find.text('September 2024'), findsOneWidget);
        expect(c.currentMonth, DateTime.utc(2024, 9));
      });

      testWidgets('$motion from the month-year wheel returns to the day grid on that month', (tester) async {
        final c = controller();
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

        c.toggleMonthYearPicker();
        await tester.pumpAndSettle();
        expect(c.monthYear, true);

        unawaited(move(c));
        await tester.pumpAndSettle();

        expect(c.monthYear, false);
        expect(find.byType(DayPicker), findsOneWidget);
        expect(find.byType(FPicker), findsNothing);
        expect(find.text('September 2024'), findsOneWidget);
        expect(c.currentMonth, DateTime.utc(2024, 9));
      });
    }

    testWidgets('jumpToDayPicker(null) keeps the current month', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.jumpToDayPicker();
      await tester.pumpAndSettle();

      expect(find.text('July 2024'), findsOneWidget);
      expect(c.currentMonth, DateTime.utc(2024, 7));
    });

    testWidgets('jumpToDayPicker clamps an out-of-range month to the bounds', (tester) async {
      final c = controller();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), controller: c));

      c.jumpToDayPicker(DateTime.utc(2030, 12)); // past end (.utc(2025, 8, 10))
      await tester.pumpAndSettle();

      expect(c.currentMonth, DateTime.utc(2025, 8));
      expect(find.text('August 2025'), findsOneWidget);
    });
  });

  group('boundary', () {
    testWidgets('the day grid still gates exact days within the partially-in-range start month', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(onChange: (date) => selected = date),
          controller: controller(start: .utc(2024, 7, 15), today: .utc(2024, 7, 20), initial: .utc(2024, 7, 20)),
        ),
      );

      // 10 Jul is before the start (15 Jul) so it stays disabled.
      await tester.tap(day('10'));
      await tester.pumpAndSettle();
      expect(selected, null);

      // 20 Jul is in range so it is selectable.
      await tester.tap(day('20'));
      await tester.pumpAndSettle();
      expect(selected, DateTime.utc(2024, 7, 20));
    });
  });

  group('navigation', () {
    testWidgets('the previous button navigates to the previous month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle()));

      await tester.tap(find.byType(FButton).first);
      await tester.pumpAndSettle();

      expect(find.text('June 2024'), findsOneWidget);
    });

    testWidgets('the next button navigates to the next month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle()));

      await tester.tap(find.byType(FButton).last);
      await tester.pumpAndSettle();

      expect(find.text('August 2024'), findsOneWidget);
    });
  });

  group('selection', () {
    testWidgets('managedSingle selects and toggles off a tapped day', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(onChange: (date) => selected = date)));

      await tester.tap(day('15'));
      await tester.pumpAndSettle();
      expect(selected, DateTime.utc(2024, 7, 15));

      await tester.tap(day('15'));
      await tester.pumpAndSettle();
      expect(selected, null);
    });

    testWidgets('managedMulti accumulates tapped days', (tester) async {
      Set<DateTime>? selected;
      await tester.pumpWidget(calendar(selectionControl: .managedMulti(onChange: (dates) => selected = dates)));

      await tester.tap(day('15'));
      await tester.pumpAndSettle();
      await tester.tap(day('20'));
      await tester.pumpAndSettle();

      expect(selected, {DateTime.utc(2024, 7, 15), DateTime.utc(2024, 7, 20)});
    });

    testWidgets('managedRange selects a range from two tapped days', (tester) async {
      (DateTime, DateTime)? selected;
      await tester.pumpWidget(calendar(selectionControl: .managedRange(onChange: (range) => selected = range)));

      await tester.tap(day('15'));
      await tester.pumpAndSettle();
      await tester.tap(day('20'));
      await tester.pumpAndSettle();

      expect(selected, (DateTime.utc(2024, 7, 15), DateTime.utc(2024, 7, 20)));
    });

    testWidgets('lifted calls select with the tapped day', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FCalendar.wheel(
              selectionControl: .liftedSingle(value: selected, onChange: (date) => setState(() => selected = date)),
              control: FWheelCalendarControl(start: .utc(2023, 2, 8), today: .utc(2024, 7, 14), end: .utc(2025, 8, 10)),
            ),
          ),
        ),
      );

      await tester.tap(day('15'));
      await tester.pumpAndSettle();

      expect(selected, DateTime.utc(2024, 7, 15));
    });

    testWidgets('none does not select a tapped day', (tester) async {
      var pressed = false;
      await tester.pumpWidget(calendar(selectionControl: .none(), onDayPress: (_) => pressed = true));

      await tester.tap(day('15'));
      await tester.pumpAndSettle();

      expect(pressed, true);
      expect(find.byType(DayPicker), findsOneWidget);
    });
  });

  group('callbacks', () {
    testWidgets('onDayPress fires before selection and selection awaits it', (tester) async {
      final completer = Completer<void>();
      final order = <String>[];
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(onChange: (_) => order.add('select')),
          onDayPress: (_) {
            order.add('press');
            return completer.future;
          },
        ),
      );

      await tester.tap(day('15'));
      await tester.pump();
      expect(order, ['press']);

      completer.complete();
      await tester.pumpAndSettle();
      expect(order, ['press', 'select']);
    });

    testWidgets('onDayLongPress fires and does not select', (tester) async {
      DateTime? longPressed;
      var selected = false;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(onChange: (_) => selected = true),
          onDayLongPress: (date) => longPressed = date,
        ),
      );

      await tester.longPress(day('15'));
      await tester.pumpAndSettle();

      expect(longPressed, DateTime.utc(2024, 7, 15));
      expect(selected, false);
    });
  });
}

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import 'package:forui/src/widgets/calendar/month/month_picker.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';
import '../../test_scaffold.dart';

void main() {
  FGridCalendarControl control({
    bool Function(DateTime)? selectable,
    DateTime? start,
    DateTime? today,
    DateTime? initial,
    DateTime? end,
  }) => FGridCalendarControl(
    selectable: selectable,
    start: start ?? .utc(2023, 2, 8),
    today: today ?? .utc(2024, 7, 14),
    initial: initial ?? .utc(2024, 7, 14),
    end: end ?? .utc(2025, 8, 10),
  );

  Widget calendar({
    required FDateSelectionControl selectionControl,
    FGridCalendarControl? control,
    FCalendarHeaderBuilder<FGridCalendarController> headerBuilder = FCalendar.defaultHeaderBuilder,
    FCalendarFooterBuilder<FGridCalendarController> footerBuilder = FCalendar.defaultFooterBuilder,
    FutureOr<void> Function(DateTime)? onDayPress,
    FutureOr<void> Function(DateTime)? onDayLongPress,
  }) => TestScaffold.app(
    child: FCalendar.grid(
      selectionControl: selectionControl,
      control:
          control ?? FGridCalendarControl(start: .utc(2023, 2, 8), today: .utc(2024, 7, 14), end: .utc(2025, 8, 10)),
      headerBuilder: headerBuilder,
      footerBuilder: footerBuilder,
      onDayPress: onDayPress,
      onDayLongPress: onDayLongPress,
    ),
  );

  group('switching', () {
    testWidgets('initial state shows the day grid for the initial month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.text('July 2024'), findsOneWidget);
      expect(find.descendant(of: find.byType(DayPicker), matching: find.text('15')), findsOneWidget);
    });

    testWidgets('tapping the header cycles the day grid to the month grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();

      expect(find.byType(MonthPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(MonthPicker), matching: find.text('Jul')), findsOneWidget);
      expect(find.descendant(of: find.byType(Header), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('tapping the header cycles the month grid to the year grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await tester.pumpAndSettle();

      expect(find.byType(YearPicker), findsOneWidget);
      expect(find.text('2020 — 2029'), findsOneWidget);
      expect(find.descendant(of: find.byType(YearPicker), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('tapping the header cycles the year grid back to the day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2020 — 2029'));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.text('July 2024'), findsOneWidget);
    });
  });

  group('picking', () {
    testWidgets('picking a month navigates to the day grid for that month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text('Sep')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.text('September 2024'), findsOneWidget);
    });

    testWidgets('picking the current month returns to the same day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text('Jul')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.text('July 2024'), findsOneWidget);
    });

    testWidgets('picking a year navigates to the month grid for that year', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2025')));
      await tester.pumpAndSettle();

      expect(find.byType(MonthPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(Header), matching: find.text('2025')), findsOneWidget);
    });

    testWidgets('picking a year then a month navigates to that day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2025')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text('Mar')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.text('March 2025'), findsOneWidget);
    });

    testWidgets('an out-of-range month is not selectable and does not navigate', (tester) async {
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(),
          control: control(start: .utc(2024, 3), end: .utc(2024, 10)),
        ),
      );

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text('Jan')));
      await tester.pumpAndSettle();

      expect(find.byType(MonthPicker), findsOneWidget);
      expect(find.text('January 2024'), findsNothing);
    });

    testWidgets('an out-of-range year is not selectable and does not navigate', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2027')));
      await tester.pumpAndSettle();

      expect(find.byType(YearPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(Header), matching: find.text('2027')), findsNothing);
    });
  });

  group('boundary', () {
    // start (15 Jul) and end (10 Sep) both fall mid-month, so the start month (Jul) and end month (Sep) are
    // only partially in range. August is shown initially so the month grid lands on 2024.
    FGridCalendarControl monthControl() =>
        control(start: .utc(2024, 7, 15), today: .utc(2024, 8, 1), initial: .utc(2024, 8, 1), end: .utc(2024, 9, 10));

    // start (15 Jul 2024) and end (10 Mar 2026) both fall mid-year, so the start year (2024) and end year
    // (2026) are only partially in range. January 2025 is shown initially so the year grid lands on 2020-2029.
    FGridCalendarControl yearControl() =>
        control(start: .utc(2024, 7, 15), today: .utc(2025), initial: .utc(2025), end: .utc(2026, 3, 10));

    for (final (month, header) in [('Jul', 'July 2024'), ('Sep', 'September 2024')]) {
      testWidgets('the partially-in-range $month month stays selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: monthControl()));

        await tester.tap(find.text('August 2024'));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text(month)));
        await tester.pumpAndSettle();

        expect(find.byType(DayPicker), findsOneWidget);
        expect(find.text(header), findsOneWidget);
      });
    }

    for (final month in ['Jun', 'Oct']) {
      testWidgets('the fully out-of-range $month month is not selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: monthControl()));

        await tester.tap(find.text('August 2024'));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text(month)));
        await tester.pumpAndSettle();

        expect(find.byType(MonthPicker), findsOneWidget);
      });
    }

    for (final year in ['2024', '2026']) {
      testWidgets('the partially-in-range year $year stays selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: yearControl()));

        await tester.tap(find.text('January 2025'));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2025')));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text(year)));
        await tester.pumpAndSettle();

        expect(find.byType(MonthPicker), findsOneWidget);
        expect(find.descendant(of: find.byType(Header), matching: find.text(year)), findsOneWidget);
      });
    }

    for (final year in ['2023', '2027']) {
      testWidgets('the fully out-of-range year $year is not selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: yearControl()));

        await tester.tap(find.text('January 2025'));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2025')));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text(year)));
        await tester.pumpAndSettle();

        expect(find.byType(YearPicker), findsOneWidget);
      });
    }

    testWidgets('the day grid still gates exact days within the partially-in-range start month', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(onChange: (date) => selected = date),
          // No initial: the current month is seeded from today (20 Jul), keeping it >= the mid-month start. Passing
          // initial would truncate to 1 Jul, which falls before the 15 Jul start.
          control: FGridCalendarControl(start: .utc(2024, 7, 15), today: .utc(2024, 7, 20), end: .utc(2025, 8, 10)),
        ),
      );

      // 10 Jul is before the start (15 Jul) so it stays disabled.
      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('10')));
      await tester.pumpAndSettle();
      expect(selected, null);

      // 20 Jul is in range so it is selectable.
      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('20')));
      await tester.pumpAndSettle();
      expect(selected, DateTime.utc(2024, 7, 20));
    });
  });

  group('navigation', () {
    testWidgets('the previous button navigates to the previous month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.byType(FButton).first);
      await tester.pumpAndSettle();

      expect(find.text('June 2024'), findsOneWidget);
    });

    testWidgets('the next button navigates to the next month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.byType(FButton).last);
      await tester.pumpAndSettle();

      expect(find.text('August 2024'), findsOneWidget);
    });
  });

  group('jumpTo*/animateTo* while the target grid is mounted', () {
    // A footer button that invokes [action] on the live controller.
    FCalendarFooterBuilder<FGridCalendarController> footer(void Function(FGridCalendarController) action) =>
        (context, controller, _) => GestureDetector(
          key: const ValueKey('go'),
          behavior: HitTestBehavior.opaque,
          onTap: () => action(controller),
          child: const SizedBox(width: 40, height: 40),
        );

    group('day grid', () {
      for (final (motion, move) in <(String, void Function(FGridCalendarController))>[
        ('jumpToDayPicker', (c) => c.jumpToDayPicker(DateTime.utc(2024, 9))),
        ('animateToDayPicker', (c) => c.animateToDayPicker(DateTime.utc(2024, 9))),
      ]) {
        testWidgets('$motion moves the mounted day grid to another month', (tester) async {
          await tester.pumpWidget(
            calendar(selectionControl: .managedSingle(), control: control(), footerBuilder: footer(move)),
          );

          expect(find.text('July 2024'), findsOneWidget);

          await tester.tap(find.byKey(const ValueKey('go')));
          await tester.pumpAndSettle();

          expect(tester.takeException(), null);
          expect(find.byType(DayPicker), findsOneWidget);
          expect(find.text('September 2024'), findsOneWidget);
        });
      }
    });

    group('month grid', () {
      for (final (motion, move) in <(String, void Function(FGridCalendarController))>[
        ('jumpToMonthPicker', (c) => c.jumpToMonthPicker(DateTime.utc(2025))),
        ('animateToMonthPicker', (c) => c.animateToMonthPicker(DateTime.utc(2025))),
      ]) {
        testWidgets('$motion moves the mounted month grid to another year', (tester) async {
          await tester.pumpWidget(
            calendar(selectionControl: .managedSingle(), control: control(), footerBuilder: footer(move)),
          );

          await tester.tap(find.text('July 2024')); // day grid -> month grid (2024)
          await tester.pumpAndSettle();
          expect(find.descendant(of: find.byType(Header), matching: find.text('2024')), findsOneWidget);

          await tester.tap(find.byKey(const ValueKey('go')));
          await tester.pumpAndSettle();

          expect(tester.takeException(), null);
          expect(find.byType(MonthPicker), findsOneWidget);
          expect(find.descendant(of: find.byType(Header), matching: find.text('2025')), findsOneWidget);
        });
      }
    });

    group('year grid', () {
      for (final (motion, move) in <(String, void Function(FGridCalendarController))>[
        ('jumpToYearPicker', (c) => c.jumpToYearPicker(DateTime.utc(2055))),
        ('animateToYearPicker', (c) => c.animateToYearPicker(DateTime.utc(2055))),
      ]) {
        testWidgets('$motion moves the mounted year grid to another decade', (tester) async {
          await tester.pumpWidget(
            calendar(
              selectionControl: .managedSingle(),
              control: control(start: .utc(2000), end: .utc(2099, 12, 31)),
              footerBuilder: footer(move),
            ),
          );

          await tester.tap(find.text('July 2024')); // day grid -> month grid
          await tester.pumpAndSettle();
          await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024'))); // -> year grid
          await tester.pumpAndSettle();
          expect(find.descendant(of: find.byType(YearPicker), matching: find.text('2024')), findsOneWidget);

          await tester.tap(find.byKey(const ValueKey('go')));
          await tester.pumpAndSettle();

          expect(tester.takeException(), null);
          expect(find.byType(YearPicker), findsOneWidget);
          expect(find.descendant(of: find.byType(YearPicker), matching: find.text('2055')), findsOneWidget);
        });
      }
    });
  });

  group('selection', () {
    testWidgets('managedSingle selects and toggles off a tapped day', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(onChange: (date) => selected = date),
          control: control(),
        ),
      );

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();
      expect(selected, DateTime.utc(2024, 7, 15));

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();
      expect(selected, null);
    });

    testWidgets('managedMulti accumulates tapped days', (tester) async {
      Set<DateTime>? selected;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedMulti(onChange: (dates) => selected = dates),
          control: control(),
        ),
      );

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();
      expect(selected, {DateTime.utc(2024, 7, 15)});

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('20')));
      await tester.pumpAndSettle();
      expect(selected, {DateTime.utc(2024, 7, 15), DateTime.utc(2024, 7, 20)});
    });

    testWidgets('managedRange selects a range from two tapped days', (tester) async {
      (DateTime, DateTime)? selected;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedRange(onChange: (range) => selected = range),
          control: control(),
        ),
      );

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();
      expect(selected, (DateTime.utc(2024, 7, 15), DateTime.utc(2024, 7, 15)));

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('20')));
      await tester.pumpAndSettle();
      expect(selected, (DateTime.utc(2024, 7, 15), DateTime.utc(2024, 7, 20)));
    });

    testWidgets('lifted calls select with the tapped day', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FCalendar.grid(
              selectionControl: .liftedSingle(value: selected, onChange: (date) => setState(() => selected = date)),
              control: control(),
            ),
          ),
        ),
      );

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();

      expect(selected, DateTime.utc(2024, 7, 15));
    });

    testWidgets('none does not select a tapped day', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        calendar(selectionControl: .none(), control: control(), onDayPress: (_) => pressed = true),
      );

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();

      // The tap path still runs (proven by onDayPress), but selection is a no-op and nothing throws.
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
          control: control(),
          onDayPress: (_) {
            order.add('press');
            return completer.future;
          },
        ),
      );

      await tester.tap(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pump();
      expect(order, ['press']); // selection is deferred until onDayPress completes

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
          control: control(),
          onDayLongPress: (date) => longPressed = date,
        ),
      );

      await tester.longPress(find.descendant(of: find.byType(DayPicker), matching: find.text('15')));
      await tester.pumpAndSettle();

      expect(longPressed, DateTime.utc(2024, 7, 15));
      expect(selected, false);
    });
  });

  group('accessibility', () {
    Finder day(String number) => find.descendant(of: find.byType(DayPicker), matching: find.text(number));

    testWidgets('day cell exposes its selected state', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      expect(tester.getSemantics(day('15')), isSemantics(hasSelectedState: true, isSelected: false));

      await tester.tap(day('15'));
      await tester.pumpAndSettle();

      expect(tester.getSemantics(day('15')), isSemantics(hasSelectedState: true, isSelected: true));
      expect(tester.getSemantics(day('16')), isSemantics(hasSelectedState: true, isSelected: false));

      semantics.dispose();
    });

    testWidgets('day cell label includes the weekday and today status', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      // control()'s today is 2024-07-14, a Sunday.
      expect(tester.getSemantics(day('14')), isSemantics(label: 'Sunday, July 14, 2024, Today'));
      expect(tester.getSemantics(day('15')), isSemantics(label: 'Monday, July 15, 2024'));

      semantics.dispose();
    });
  });
}

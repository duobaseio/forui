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
  FGridSplitCalendarControl control({
    bool Function(DateTime)? selectable,
    DateTime? start,
    DateTime? today,
    DateTime? initial,
    DateTime? end,
  }) => FGridSplitCalendarControl(
    selectable: selectable,
    start: start ?? .utc(2023, 2, 8),
    today: today ?? .utc(2024, 7, 14),
    initial: initial ?? .utc(2024, 7, 14),
    end: end ?? .utc(2025, 8, 10),
  );

  Widget calendar({
    required FDateSelectionControl selectionControl,
    FGridSplitCalendarControl? control,
    FCalendarHeaderBuilder<FGridSplitCalendarController> headerBuilder = FCalendar.defaultHeaderBuilder,
    FCalendarFooterBuilder<FGridSplitCalendarController> footerBuilder = FCalendar.defaultFooterBuilder,
    FutureOr<void> Function(DateTime)? onDayPress,
    FutureOr<void> Function(DateTime)? onDayLongPress,
  }) => TestScaffold.app(
    child: FCalendar.splitGrid(
      selectionControl: selectionControl,
      control:
          control ??
          FGridSplitCalendarControl(start: .utc(2023, 2, 8), today: .utc(2024, 7, 14), end: .utc(2025, 8, 10)),
      headerBuilder: headerBuilder,
      footerBuilder: footerBuilder,
      onDayPress: onDayPress,
      onDayLongPress: onDayLongPress,
    ),
  );

  group('switching', () {
    testWidgets('initial state shows the day grid with the split header', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      expect(find.byType(SplitHeader), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(DayPicker), matching: find.text('15')), findsOneWidget);
    });

    testWidgets('tapping the month target shows the month grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();

      expect(find.byType(MonthPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(MonthPicker), matching: find.text('Jul')), findsOneWidget);
    });

    testWidgets('tapping the month target again returns to the day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();

      // The original month and year are shown again.
      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('tapping the year target shows the year grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();

      expect(find.byType(YearPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(YearPicker), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('tapping the year target again returns to the day grid', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();

      // The original month and year are shown again.
      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('the month and year targets toggle independently', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      // From the month grid, tapping the year target crosses over to the year grid (both targets live in every view).
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();
      expect(find.byType(MonthPicker), findsOneWidget);

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();
      expect(find.byType(YearPicker), findsOneWidget);
    });
  });

  group('picking', () {
    testWidgets('picking a month navigates to the day grid for that month in the same year', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text('Mar')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('March')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('picking a year navigates to the day grid keeping the current month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2025')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      // The month is preserved.
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2025')), findsOneWidget);
    });
  });

  group('boundary', () {
    // start (15 Jul) and end (10 Sep) both fall mid-month, so the start month (Jul) and end month (Sep) are
    // only partially in range. August is shown initially so the single-year month grid lands on 2024.
    FGridSplitCalendarControl monthControl() =>
        control(start: .utc(2024, 7, 15), today: .utc(2024, 8, 1), initial: .utc(2024, 8, 1), end: .utc(2024, 9, 10));

    // start (15 Jul 2024) and end (10 Mar 2026) both fall mid-year, so the start year (2024) and end year
    // (2026) are only partially in range. January 2025 is shown initially so the year grid lands on 2020-2029.
    FGridSplitCalendarControl yearControl() =>
        control(start: .utc(2024, 7, 15), today: .utc(2025), initial: .utc(2025), end: .utc(2026, 3, 10));

    for (final (abbreviation, month) in [('Jul', 'July'), ('Sep', 'September')]) {
      testWidgets('the partially-in-range $month month stays selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: monthControl()));

        await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('August')));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text(abbreviation)));
        await tester.pumpAndSettle();

        expect(find.byType(DayPicker), findsOneWidget);
        expect(find.descendant(of: find.byType(SplitHeader), matching: find.text(month)), findsOneWidget);
        expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
      });
    }

    for (final month in ['Jun', 'Oct']) {
      testWidgets('the fully out-of-range $month month is not selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: monthControl()));

        await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('August')));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(MonthPicker), matching: find.text(month)));
        await tester.pumpAndSettle();

        expect(find.byType(MonthPicker), findsOneWidget);
      });
    }

    for (final year in ['2024', '2026']) {
      testWidgets('the partially-in-range year $year stays selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: yearControl()));

        await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2025')));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text(year)));
        await tester.pumpAndSettle();

        // The partial-boundary year is selectable, so it navigates to the day grid for that year. (The kept month
        // is clamped into range, so it is not asserted here; month preservation is covered by the picking group.)
        expect(find.byType(DayPicker), findsOneWidget);
        expect(find.descendant(of: find.byType(SplitHeader), matching: find.text(year)), findsOneWidget);
      });
    }

    for (final year in ['2023', '2027']) {
      testWidgets('the fully out-of-range year $year is not selectable', (tester) async {
        await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: yearControl()));

        await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2025')));
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text(year)));
        await tester.pumpAndSettle();

        expect(find.byType(YearPicker), findsOneWidget);
      });
    }

    testWidgets('picking a year clamps the kept month up to the start month when it falls before start', (
      tester,
    ) async {
      // The current month is January (2025). January 2024 is before the 15 Jul 2024 start, so picking 2024 clamps the
      // day grid up to the start month (July 2024) instead of keeping January.
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: yearControl()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2025')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2024')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      // Clamped to the start month, not January.
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('picking a year keeps the current month when it stays in range', (tester) async {
      // The current month is January; January 2026 is within range (end is 10 Mar 2026), so the month is preserved.
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: yearControl()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2025')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2026')));
      await tester.pumpAndSettle();

      expect(find.byType(DayPicker), findsOneWidget);
      // The month is preserved.
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('January')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2026')), findsOneWidget);
    });

    testWidgets('the day grid still gates exact days within the partially-in-range start month', (tester) async {
      DateTime? selected;
      await tester.pumpWidget(
        calendar(
          selectionControl: .managedSingle(onChange: (date) => selected = date),
          // No initial: the current month is seeded from today (20 Jul), keeping it >= the mid-month start. Passing
          // initial would truncate to 1 Jul, which falls before the 15 Jul start.
          control: FGridSplitCalendarControl(
            start: .utc(2024, 7, 15),
            today: .utc(2024, 7, 20),
            end: .utc(2025, 8, 10),
          ),
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

      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('June')), findsOneWidget);
      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')), findsOneWidget);
    });

    testWidgets('the next button navigates to the next month', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.byType(FButton).last);
      await tester.pumpAndSettle();

      expect(find.descendant(of: find.byType(SplitHeader), matching: find.text('August')), findsOneWidget);
    });

    testWidgets('the month grid has no navigation buttons', (tester) async {
      await tester.pumpWidget(calendar(selectionControl: .managedSingle(), control: control()));

      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();

      expect(find.descendant(of: find.byType(SplitHeader), matching: find.byType(FButton)), findsNothing);
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
            builder: (context, setState) => FCalendar.splitGrid(
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
}

import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/calendar/calendar_controller.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCalendarController', () {
    test('truncates start, today and end to the date', () {
      final controller = autoDispose(
        FGridCalendarController(
          start: .utc(2023, 2, 8, 5, 30),
          today: .utc(2024, 7, 14, 12),
          end: .utc(2025, 8, 10, 23, 59),
        ),
      );

      expect(controller.start, DateTime.utc(2023, 2, 8));
      expect(controller.today, DateTime.utc(2024, 7, 14));
      expect(controller.end, DateTime.utc(2025, 8, 10));
    });

    test('normalizes currentMonth to the first of the initial month', () {
      final controller = autoDispose(FGridCalendarController(initial: .utc(2024, 7, 15), today: .utc(2024, 7, 1)));
      expect(controller.currentMonth, DateTime.utc(2024, 7));
    });

    test("currentMonth defaults to today's month when initial is null", () {
      final controller = autoDispose(FGridCalendarController(today: .utc(2024, 7, 14)));
      expect(controller.currentMonth, DateTime.utc(2024, 7));
    });

    test('start and end default to 1900 and 2100', () {
      final controller = autoDispose(FGridCalendarController(today: .utc(2024)));
      expect(controller.start, DateTime.utc(1900));
      expect(controller.end, DateTime.utc(2100));
    });

    test('throws when today is before start', () {
      expect(
        () => FGridCalendarController(start: .utc(2024, 2), today: .utc(2024), end: .utc(2024, 12)),
        throwsA(isA<FlutterError>()),
      );
    });

    test('throws when today is after end', () {
      expect(
        () => FGridCalendarController(start: .utc(2024), today: .utc(2025), end: .utc(2024, 12)),
        throwsA(isA<FlutterError>()),
      );
    });

    test('throws when the initial month is out of range', () {
      expect(
        () => FGridCalendarController(
          start: .utc(2024, 3),
          today: .utc(2024, 6),
          initial: .utc(2024),
          end: .utc(2024, 12),
        ),
        throwsA(isA<FlutterError>()),
      );
    });

    test('allows a mid-month start to show its own month', () {
      // start is 15 Jul; an initial in the same month (1 Jul) is allowed at month granularity.
      final controller = autoDispose(
        FGridCalendarController(
          start: .utc(2024, 7, 15),
          today: .utc(2024, 7, 20),
          initial: .utc(2024, 7),
          end: .utc(2024, 12),
        ),
      );
      expect(controller.currentMonth, DateTime.utc(2024, 7));
    });

    test('composes the selectable predicates at the right granularity', () {
      final controller = autoDispose(
        FGridCalendarController(start: .utc(2024, 7, 15), today: .utc(2024, 8), end: .utc(2024, 9, 10)),
      );

      // The day grid gates exact days.
      expect(controller.day.selectable(.utc(2024, 7, 14)), false);
      expect(controller.day.selectable(.utc(2024, 7, 15)), true);

      // The month grid uses month granularity, so the partial start and end months stay selectable.
      expect(controller.month.selectable(.utc(2024, 6)), false);
      expect(controller.month.selectable(.utc(2024, 7)), true);
      expect(controller.month.selectable(.utc(2024, 9)), true);
      expect(controller.month.selectable(.utc(2024, 10)), false);

      // The year grid uses year granularity.
      expect(controller.year.selectable(.utc(2023)), false);
      expect(controller.year.selectable(.utc(2024)), true);
    });
  });

  group('grid navigation', () {
    FGridCalendarController controller() => autoDispose(
      FGridCalendarController(
        start: .utc(2023, 2, 8),
        today: .utc(2024, 7, 14),
        initial: .utc(2024, 7, 14),
        end: .utc(2025, 8, 10),
      ),
    );

    test('starts on the day grid', () {
      expect(controller().type, FCalendarPickerGridType.day);
    });

    test('jumpToMonthPicker shows the month grid for the current year', () {
      final c = controller()..jumpToMonthPicker();
      expect(c.type, FCalendarPickerGridType.month);
      expect(c.month.current, DateTime.utc(2024)); // the month grid pages by year
    });

    test('jumpToYearPicker shows the year grid', () {
      final c = controller()..jumpToYearPicker();
      expect(c.type, FCalendarPickerGridType.year);
      expect(c.year.current, DateTime.utc(2020)); // the year grid pages by decade
    });

    test('jumpToDayPicker(date) shows the day grid for that month and updates currentMonth', () {
      final c = controller()
        ..jumpToMonthPicker()
        ..jumpToDayPicker(.utc(2024, 9, 20));

      expect(c.type, FCalendarPickerGridType.day);
      expect(c.day.current, DateTime.utc(2024, 9));
      expect(c.currentMonth, DateTime.utc(2024, 9));
    });

    test('jumpToDayPicker clamps a date before start to the start month', () {
      final c = controller()..jumpToDayPicker(.utc(2020));
      expect(c.day.current, DateTime.utc(2023, 2)); // start is 8 Feb 2023
      expect(c.currentMonth, DateTime.utc(2023, 2));
    });

    test('jumpToDayPicker clamps a date after end to the end month', () {
      final c = controller()..jumpToDayPicker(.utc(2030));
      expect(c.day.current, DateTime.utc(2025, 8)); // end is 10 Aug 2025
      expect(c.currentMonth, DateTime.utc(2025, 8));
    });
  });

  group('FGridCalendarController.cycle', () {
    FGridCalendarController controller() => autoDispose(
      FGridCalendarController(
        start: .utc(2023, 2, 8),
        today: .utc(2024, 7, 14),
        initial: .utc(2024, 7, 14),
        end: .utc(2025, 8, 10),
      ),
    );

    test('cycles day -> month -> year -> day', () {
      final c = controller();
      expect(c.type, FCalendarPickerGridType.day);

      c.cycle();
      expect(c.type, FCalendarPickerGridType.month);

      c.cycle();
      expect(c.type, FCalendarPickerGridType.year);

      c.cycle();
      expect(c.type, FCalendarPickerGridType.day);
    });
  });

  group('FGridSplitCalendarController', () {
    FGridSplitCalendarController controller() => autoDispose(
      FGridSplitCalendarController(
        start: .utc(2023, 2, 8),
        today: .utc(2024, 7, 14),
        initial: .utc(2024, 7, 14),
        end: .utc(2025, 8, 10),
      ),
    );

    test('toggleMonthPicker toggles between the day and month grids', () {
      final c = controller()..toggleMonthPicker();
      expect(c.type, FCalendarPickerGridType.month);

      c.toggleMonthPicker();
      expect(c.type, FCalendarPickerGridType.day);
    });

    test('toggleYearPicker toggles between the day and year grids', () {
      final c = controller()..toggleYearPicker();
      expect(c.type, FCalendarPickerGridType.year);

      c.toggleYearPicker();
      expect(c.type, FCalendarPickerGridType.day);
    });

    test('toggleMonthPicker from the year grid switches to the month grid', () {
      final c = controller()
        ..toggleYearPicker()
        ..toggleMonthPicker();
      expect(c.type, FCalendarPickerGridType.month);
    });

    test('the targets toggle independently', () {
      final c = controller()
        ..toggleMonthPicker()
        ..toggleYearPicker();
      expect(c.type, FCalendarPickerGridType.year);
    });
  });

  group('FWheelCalendarController', () {
    FWheelCalendarController controller() => autoDispose(
      FWheelCalendarController(
        start: .utc(2023, 2, 8),
        today: .utc(2024, 7, 14),
        initial: .utc(2024, 7, 14),
        end: .utc(2025, 8, 10),
      ),
    );

    test('starts on the day grid', () {
      expect(controller().monthYear, false);
    });

    test('toggleMonthYearPicker shows the wheel then returns to the day grid', () {
      final c = controller()..toggleMonthYearPicker();
      expect(c.monthYear, true);

      c.toggleMonthYearPicker();
      expect(c.monthYear, false);
    });

    test('setMonthYear updates currentMonth while the wheel is shown', () {
      final c = controller()
        ..toggleMonthYearPicker()
        ..setMonthYear(9, 2024);
      expect(c.currentMonth, DateTime.utc(2024, 9));
    });

    test('setMonthYear clamps below the start month', () {
      final c = controller()
        ..toggleMonthYearPicker()
        ..setMonthYear(1, 2020);
      expect(c.currentMonth, DateTime.utc(2023, 2)); // start month is Feb 2023
    });

    test('setMonthYear clamps above the end month', () {
      final c = controller()
        ..toggleMonthYearPicker()
        ..setMonthYear(12, 2030);
      expect(c.currentMonth, DateTime.utc(2025, 8)); // end month is Aug 2025
    });

    test('setMonthYear is a no-op while the wheel is not shown', () {
      final c = controller()..setMonthYear(9, 2024);
      expect(c.currentMonth, DateTime.utc(2024, 7)); // unchanged
    });

    test('setMonthYear to the current month does not notify', () {
      final c = controller()..toggleMonthYearPicker();
      var notifications = 0;
      c
        ..addListener(() => notifications++)
        ..setMonthYear(7, 2024); // already the current month
      expect(notifications, 0);
    });

    test('toggling back to the day grid reattaches to the chosen month', () {
      final c = controller()
        ..toggleMonthYearPicker()
        ..setMonthYear(9, 2024)
        ..toggleMonthYearPicker();

      expect(c.monthYear, false);
      expect(c.day.current, DateTime.utc(2024, 9));
    });
  });

  group('notifications', () {
    test('cycle notifies listeners', () {
      final c = autoDispose(FGridCalendarController(today: .utc(2024, 7, 14)));
      var notifications = 0;
      c
        ..addListener(() => notifications++)
        ..cycle();
      expect(notifications, 1);
    });

    test('toggleMonthPicker notifies listeners', () {
      final c = autoDispose(FGridSplitCalendarController(today: .utc(2024, 7, 14)));
      var notifications = 0;
      c
        ..addListener(() => notifications++)
        ..toggleMonthPicker();
      expect(notifications, 1);
    });

    test('setMonthYear notifies listeners when the month changes', () {
      final c = autoDispose(FWheelCalendarController(today: .utc(2024, 7, 14)))..toggleMonthYearPicker();
      var notifications = 0;
      c
        ..addListener(() => notifications++)
        ..setMonthYear(9, 2024);
      expect(notifications, 1);
    });
  });
}

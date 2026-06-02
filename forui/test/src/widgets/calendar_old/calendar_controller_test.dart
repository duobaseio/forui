import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FCalendarOldController.date(...)', () {
    test(
      'constructor converts date time',
      () => expect(FCalendarOldController.date(initial: DateTime(2024, 11, 30, 12)).value, DateTime.utc(2024, 11, 30)),
    );

    test('selectable(...)', () {
      FCalendarOldController.date(
        selectable: (date) {
          expect(date, DateTime.utc(2024));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime(2024, 5, 4, 3), true), (DateTime(2024, 5, 5, 3), false)]) {
      test('selected(...) contains date', () {
        final controller = FCalendarOldController.date(initial: DateTime(2024, 5, 4));
        expect(controller.selected(date), expected);
      });
    }

    for (final (toggleable, initial, date, expected) in [
      (true, null, DateTime(2024), DateTime.utc(2024)),
      (true, null, DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2024), null),
      (false, null, DateTime(2024), DateTime.utc(2024)),
      (false, DateTime(2024), DateTime(2024), DateTime.utc(2024)),
    ]) {
      test('select(...)', () {
        final controller = FCalendarOldController.date(initial: initial, toggleable: toggleable)..select(date);
        expect(controller.value, expected);
      });
    }

    for (final (toggleable, initial, date, expected) in [
      (true, null, DateTime(2024), DateTime.utc(2024)),
      (true, null, DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime.utc(2024), null),
      (false, null, DateTime(2024), DateTime.utc(2024)),
      (false, null, null, null),
      (false, DateTime(2024), null, null),
      (false, DateTime(2024), DateTime(2024), DateTime.utc(2024)),
    ]) {
      test('value setter', () {
        final controller = FCalendarOldController.date(initial: initial, toggleable: toggleable)..value = date;
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarOldController.date(...) no auto-convert', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarOldController.date(initial: .now(), truncateAndStripTimezone: false),
        throwsAssertionError,
      ),
    );

    test('selectable(...)', () {
      FCalendarOldController.date(
        truncateAndStripTimezone: false,
        selectable: (date) {
          expect(date, DateTime(2024, 1, 1, 1));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime.utc(2024, 5, 4), true), (DateTime.utc(2024, 5, 5), false)]) {
      test('selected(...) contains date', () {
        final controller = FCalendarOldController.date(initial: DateTime.utc(2024, 5, 4), truncateAndStripTimezone: false);
        expect(controller.selected(date), expected);
      });
    }

    for (final (toggleable, initial, date, expected) in [
      (true, null, DateTime.utc(2024), DateTime.utc(2024)),
      (true, null, DateTime.utc(2025), DateTime.utc(2025)),
      (true, DateTime.utc(2024), DateTime.utc(2025), DateTime.utc(2025)),
      (true, DateTime.utc(2024), DateTime.utc(2024), null),
      (false, null, DateTime.utc(2024), DateTime.utc(2024)),
      (false, DateTime.utc(2024), DateTime.utc(2024), DateTime.utc(2024)),
    ]) {
      test('select(...)', () {
        final controller = FCalendarOldController.date(
          initial: initial,
          truncateAndStripTimezone: false,
          toggleable: toggleable,
        )..select(date);
        expect(controller.value, expected);
      });
    }

    for (final (toggleable, initial, date, expected) in [
      (true, null, DateTime.utc(2024), DateTime.utc(2024)),
      (true, null, DateTime.utc(2025), DateTime.utc(2025)),
      (true, DateTime.utc(2024), DateTime.utc(2025), DateTime.utc(2025)),
      (true, DateTime.utc(2024), DateTime.utc(2024), null),
      (false, null, DateTime.utc(2024), DateTime.utc(2024)),
      (false, null, null, null),
      (false, DateTime.utc(2024), null, null),
      (false, DateTime.utc(2024), DateTime.utc(2024), DateTime.utc(2024)),
    ]) {
      test('value setter', () {
        final controller = FCalendarOldController.date(
          initial: initial,
          truncateAndStripTimezone: false,
          toggleable: toggleable,
        )..value = date;
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarOldController.dates(...)', () {
    test(
      'constructor converts date time',
      () =>
          expect(FCalendarOldController.dates(initial: {DateTime(2024, 11, 30, 12)}).value, {DateTime.utc(2024, 11, 30)}),
    );

    test('selectable(...)', () {
      FCalendarOldController.dates(
        selectable: (date) {
          expect(date, DateTime.utc(2024));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime(2024), true), (DateTime(2025), false)]) {
      test('selected(...)', () {
        final controller = FCalendarOldController.dates(initial: {.utc(2024)});
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime(2024)}, DateTime(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime(2024)}, DateTime(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('select(...)', () {
        final controller = FCalendarOldController.dates(initial: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    test('value', () {
      final controller = FCalendarOldController.dates()..value = {DateTime(2024, 11, 30, 12)};
      expect(controller.value, {DateTime.utc(2024, 11, 30)});
    });
  });

  group('FCalendarOldController.dates(...) no auto-convert', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarOldController.dates(initial: {.now()}, truncateAndStripTimezone: false),
        throwsAssertionError,
      ),
    );

    test('selectable(...)', () {
      FCalendarOldController.dates(
        truncateAndStripTimezone: false,
        selectable: (date) {
          expect(date, DateTime(2024, 1, 1, 1));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime.utc(2024), true), (DateTime.utc(2025), false)]) {
      test('selected(...)', () {
        final controller = FCalendarOldController.dates(initial: {.utc(2024)}, truncateAndStripTimezone: false);
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime.utc(2024)}, DateTime.utc(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime.utc(2024)}, DateTime.utc(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('select(...)', () {
        final controller = FCalendarOldController.dates(initial: initial, truncateAndStripTimezone: false)..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarOldController.range(...)', () {
    test(
      'constructor converts date time',
      () => expect(FCalendarOldController.range(initial: (DateTime(2024, 11, 30, 12), DateTime(2024, 12, 12, 12))).value, (
        DateTime.utc(2024, 11, 30),
        DateTime.utc(2024, 12, 12),
      )),
    );

    test('selectable(...)', () {
      FCalendarOldController.range(
        selectable: (date) {
          expect(date, DateTime.utc(2024));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (initial, date, expected) in [
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2024), true),
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2025), true),
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2023), false),
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2026), false),
      (null, DateTime.utc(2023), false),
    ]) {
      test('selected(...)', () {
        final controller = FCalendarOldController.range(initial: initial);
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ((DateTime(2024), DateTime(2025)), DateTime(2024), null),
      ((DateTime(2024), DateTime(2025)), DateTime(2025), null),
      ((DateTime(2024), DateTime(2025)), DateTime(2023), (DateTime.utc(2023), DateTime.utc(2025))),
      ((DateTime(2024), DateTime(2025)), DateTime(2026), (DateTime.utc(2024), DateTime.utc(2026))),
      ((DateTime(2024), DateTime(2027)), DateTime(2025), (DateTime.utc(2024), DateTime.utc(2025))),
      (null, DateTime(2023), (DateTime.utc(2023), DateTime.utc(2023))),
    ]) {
      test('select(...)', () {
        final controller = FCalendarOldController.range(initial: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    test('value', () {
      final controller = FCalendarOldController.range()..value = (DateTime(2024, 11, 30, 12), DateTime(2024, 12, 12, 12));
      expect(controller.value, (DateTime.utc(2024, 11, 30), DateTime.utc(2024, 12, 12)));
    });
  });

  group('FCalendarOldController.range(...) no auto-convert', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarOldController.range(initial: (DateTime(2025), DateTime(2024)), truncateAndStripTimezone: false),
        throwsAssertionError,
      ),
    );

    for (final (initial, date, expected) in [
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2024), true),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2025), true),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2023), false),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2026), false),
      (null, DateTime.utc(2023), false),
    ]) {
      test('selected(...)', () {
        final controller = FCalendarOldController.range(initial: initial, truncateAndStripTimezone: false);
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2024), null),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2025), null),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2023), (DateTime.utc(2023), DateTime.utc(2025))),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2026), (DateTime.utc(2024), DateTime.utc(2026))),
      ((DateTime.utc(2024), DateTime.utc(2027)), DateTime.utc(2025), (DateTime.utc(2024), DateTime.utc(2025))),
      (null, DateTime.utc(2023), (DateTime.utc(2023), DateTime.utc(2023))),
    ]) {
      test('select(...)', () {
        final controller = FCalendarOldController.range(initial: initial, truncateAndStripTimezone: false)..select(date);
        expect(controller.value, expected);
      });
    }
  });
}

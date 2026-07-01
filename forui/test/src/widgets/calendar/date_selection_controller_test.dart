import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/calendar/date_selection_controller.dart';

void main() {
  group('FDateSelectionController.single(...)', () {
    test(
      'constructor converts date time',
      () => expect(
        FDateSelectionController.single(initial: DateTime(2024, 11, 30, 12)).value,
        DateTime.utc(2024, 11, 30),
      ),
    );

    for (final (date, expected) in [
      (DateTime(2024, 5, 4), true),
      (DateTime(2024, 5, 4, 3), true), // truncates the time component
      (DateTime(2024, 5, 5), false),
      (DateTime(2024, 5, 5, 3), false),
    ]) {
      test('contains($date)', () {
        final controller = FDateSelectionController.single(initial: DateTime(2024, 5, 4));
        expect(controller.contains(date), expected);
      });
    }

    for (final (toggleable, initial, date, expected) in [
      (true, null, DateTime(2024), DateTime.utc(2024)),
      (true, null, DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2024), null), // toggles off
      (true, DateTime(2024), DateTime(2024, 1, 1, 5), null), // truncates then toggles off
      (false, null, DateTime(2024), DateTime.utc(2024)),
      (false, DateTime(2024), DateTime(2024), DateTime.utc(2024)), // not toggleable, stays selected
    ]) {
      test('select($date) toggleable=$toggleable initial=$initial', () {
        final controller = FDateSelectionController.single(initial: initial, toggleable: toggleable)..select(date);
        expect(controller.value, expected);
      });
    }

    for (final (toggleable, initial, date, expected) in [
      (true, null, DateTime(2024), DateTime.utc(2024)),
      (true, null, DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime.utc(2024), null), // toggles off
      (true, DateTime(2024), DateTime(2024, 11, 30, 12), DateTime.utc(2024, 11, 30)), // different day, truncates
      (false, null, DateTime(2024), DateTime.utc(2024)),
      (false, null, null, null),
      (false, DateTime(2024), null, null),
      (false, DateTime(2024), DateTime(2024), DateTime.utc(2024)),
      (false, DateTime(2024), DateTime(2024, 11, 30, 12), DateTime.utc(2024, 11, 30)), // not toggleable, truncates
    ]) {
      test('value setter toggleable=$toggleable initial=$initial value=$date', () {
        final controller = FDateSelectionController.single(initial: initial, toggleable: toggleable)..value = date;
        expect(controller.value, expected);
      });
    }
  });

  group('FDateSelectionController.multi(...)', () {
    for (final (initial, expected) in [
      ({DateTime(2024, 11, 30, 12)}, {DateTime.utc(2024, 11, 30)}), // truncates the time component
      ({DateTime(2024, 5, 4), DateTime(2024, 5, 4, 23)}, {DateTime.utc(2024, 5, 4)}), // collapses to the same day
      (<DateTime>{}, <DateTime>{}),
    ]) {
      test('constructor converts $initial', () {
        expect(FDateSelectionController.multi(initial: initial).value, expected);
      });
    }

    for (final (date, expected) in [
      (DateTime(2024), true),
      (DateTime(2024, 1, 1, 9), true), // truncates the time component
      (DateTime(2025), false),
    ]) {
      test('contains($date)', () {
        final controller = FDateSelectionController.multi(initial: {.utc(2024)});
        expect(controller.contains(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}), // adds to empty
      ({DateTime(2024)}, DateTime(2025), {DateTime.utc(2024), DateTime.utc(2025)}), // adds another
      ({DateTime(2024)}, DateTime(2024), <DateTime>{}), // toggles off the only date
      ({DateTime(2024), DateTime(2025)}, DateTime(2024), {DateTime.utc(2025)}), // toggles off one, keeps the rest
      ({DateTime(2024)}, DateTime(2024, 1, 1, 9), <DateTime>{}), // truncates then toggles off
    ]) {
      test('select($date) initial=$initial', () {
        final controller = FDateSelectionController.multi(initial: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    for (final (initial, value, expected) in [
      (<DateTime>{}, {DateTime(2024, 11, 30, 12)}, {DateTime.utc(2024, 11, 30)}), // truncates
      ({DateTime(2024)}, {DateTime(2025), DateTime(2026)}, {DateTime.utc(2025), DateTime.utc(2026)}), // replaces
      ({DateTime(2024)}, <DateTime>{}, <DateTime>{}), // clears
      (<DateTime>{}, {DateTime(2024), DateTime(2024, 1, 1, 5)}, {DateTime.utc(2024)}), // collapses to the same day
    ]) {
      test('value setter initial=$initial value=$value', () {
        final controller = FDateSelectionController.multi(initial: initial)..value = value;
        expect(controller.value, expected);
      });
    }
  });

  group('FDateSelectionController.range(...)', () {
    test(
      'constructor converts date time',
      () => expect(
        FDateSelectionController.range(initial: (DateTime(2024, 11, 30, 12), DateTime(2024, 12, 12, 12))).value,
        (DateTime.utc(2024, 11, 30), DateTime.utc(2024, 12, 12)),
      ),
    );

    test(
      'constructor allows equal start and end',
      () => expect(FDateSelectionController.range(initial: (DateTime(2024), DateTime(2024))).value, (
        DateTime.utc(2024),
        DateTime.utc(2024),
      )),
    );

    test(
      'constructor throws error when end before start',
      () =>
          expect(() => FDateSelectionController.range(initial: (DateTime(2025), DateTime(2024))), throwsAssertionError),
    );

    for (final (initial, date, expected) in [
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2024), true), // start, inclusive
      ((DateTime(2024), DateTime(2025)), DateTime(2024, 1, 1, 15), true), // start, truncates the time component
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2024, 6), true), // inside
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2025), true), // end, inclusive
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2023), false), // before
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2026), false), // after
      (null, DateTime.utc(2023), false),
    ]) {
      test('contains($date) initial=$initial', () {
        final controller = FDateSelectionController.range(initial: initial);
        expect(controller.contains(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      (null, DateTime(2023), (DateTime.utc(2023), DateTime.utc(2023))), // starts a single-day range
      ((DateTime(2024), DateTime(2025)), DateTime(2024), null), // tapping the start clears
      ((DateTime(2024), DateTime(2025)), DateTime(2025), null), // tapping the end clears
      ((DateTime(2024), DateTime(2025)), DateTime(2023), (DateTime.utc(2023), DateTime.utc(2025))), // extends before
      ((DateTime(2024), DateTime(2025)), DateTime(2026), (DateTime.utc(2024), DateTime.utc(2026))), // extends after
      ((DateTime(2024), DateTime(2027)), DateTime(2025), (DateTime.utc(2024), DateTime.utc(2025))), // shrinks the end
      (
        (DateTime(2024), DateTime(2025)),
        DateTime(2024, 6, 1, 8),
        (DateTime.utc(2024), DateTime.utc(2024, 6)),
      ), // truncates
    ]) {
      test('select($date) initial=$initial', () {
        final controller = FDateSelectionController.range(initial: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    for (final (initial, value, expected) in [
      (
        null,
        (DateTime(2024, 11, 30, 12), DateTime(2024, 12, 12, 12)),
        (DateTime.utc(2024, 11, 30), DateTime.utc(2024, 12, 12)),
      ), // truncates
      ((DateTime(2024), DateTime(2025)), null, null), // clears
    ]) {
      test('value setter initial=$initial value=$value', () {
        final controller = FDateSelectionController.range(initial: initial)..value = value;
        expect(controller.value, expected);
      });
    }
  });

  group('FDateSelectionControl.liftedSingle(...)', () {
    for (final (date, expected) in [
      (DateTime(2024, 5, 4), true),
      (DateTime(2024, 5, 4, 3), true), // truncates the time component
      (DateTime(2024, 5, 5), false),
    ]) {
      test('contains($date)', () {
        final controller = FDateSelectionControl.liftedSingle(
          value: DateTime(2024, 5, 4),
          onChange: (_) {},
        ).create(() {});
        expect(controller.contains(date), expected);
      });
    }

    for (final (toggleable, value, date, expected) in [
      (true, null, DateTime(2024), DateTime.utc(2024)),
      (true, DateTime(2024), DateTime(2025), DateTime.utc(2025)),
      (true, DateTime(2024), DateTime(2024), null), // toggles off
      (true, DateTime(2024), DateTime(2024, 1, 1, 5), null), // truncates then toggles off
      (false, DateTime(2024), DateTime(2024), DateTime.utc(2024)), // not toggleable, stays selected
    ]) {
      test('select($date) forwards to onChange toggleable=$toggleable value=$value', () {
        final changes = <DateTime?>[];
        FDateSelectionControl.liftedSingle(
          value: value,
          onChange: changes.add,
          toggleable: toggleable,
        ).create(() {}).select(date);
        expect(changes.single, expected);
      });
    }

    for (final (value, set, expected) in [
      (null, DateTime(2024, 11, 30, 12), DateTime.utc(2024, 11, 30)), // truncates
      (DateTime(2024), null, null), // clears
    ]) {
      test('value setter forwards to onChange value=$value set=$set', () {
        final changes = <DateTime?>[];
        FDateSelectionControl.liftedSingle(value: value, onChange: changes.add).create(() {}).value = set;
        expect(changes.single, expected);
      });
    }
  });

  group('FDateSelectionControl.liftedMulti(...)', () {
    for (final (date, expected) in [
      (DateTime(2024), true),
      (DateTime(2024, 1, 1, 9), true), // truncates the time component
      (DateTime(2025), false),
    ]) {
      test('contains($date)', () {
        final controller = FDateSelectionControl.liftedMulti(value: {.utc(2024)}, onChange: (_) {}).create(() {});
        expect(controller.contains(date), expected);
      });
    }

    for (final (value, date, expected) in [
      (<DateTime>{}, DateTime(2024), {DateTime.utc(2024)}), // adds to empty
      ({DateTime(2024)}, DateTime(2025), {DateTime.utc(2024), DateTime.utc(2025)}), // adds another
      ({DateTime(2024)}, DateTime(2024), <DateTime>{}), // toggles off
      ({DateTime(2024)}, DateTime(2024, 1, 1, 9), <DateTime>{}), // truncates then toggles off
    ]) {
      test('select($date) forwards to onChange value=$value', () {
        final changes = <Set<DateTime>>[];
        FDateSelectionControl.liftedMulti(value: value, onChange: changes.add).create(() {}).select(date);
        expect(changes.single, expected);
      });
    }

    test('value setter truncates and forwards to onChange', () {
      final changes = <Set<DateTime>>[];
      FDateSelectionControl.liftedMulti(value: {}, onChange: changes.add).create(() {}).value = {
        DateTime(2024, 11, 30, 12),
      };
      expect(changes.single, {DateTime.utc(2024, 11, 30)});
    });
  });

  group('FDateSelectionControl.liftedRange(...)', () {
    for (final (value, date, expected) in [
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2024), true), // start, inclusive
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2024, 6), true), // inside
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2023), false), // before
      (null, DateTime.utc(2023), false),
    ]) {
      test('contains($date) value=$value', () {
        final controller = FDateSelectionControl.liftedRange(value: value, onChange: (_) {}).create(() {});
        expect(controller.contains(date), expected);
      });
    }

    for (final (value, date, expected) in [
      (null, DateTime(2023), (DateTime.utc(2023), DateTime.utc(2023))), // starts a single-day range
      ((DateTime(2024), DateTime(2025)), DateTime(2024), null), // tapping the start clears
      ((DateTime(2024), DateTime(2025)), DateTime(2023), (DateTime.utc(2023), DateTime.utc(2025))), // extends before
      ((DateTime(2024), DateTime(2025)), DateTime(2026), (DateTime.utc(2024), DateTime.utc(2026))), // extends after
    ]) {
      test('select($date) forwards to onChange value=$value', () {
        final changes = <(DateTime, DateTime)?>[];
        FDateSelectionControl.liftedRange(value: value, onChange: changes.add).create(() {}).select(date);
        expect(changes.single, expected);
      });
    }

    test('value setter truncates and forwards to onChange', () {
      final changes = <(DateTime, DateTime)?>[];
      FDateSelectionControl.liftedRange(value: null, onChange: changes.add).create(() {}).value = (
        DateTime(2024, 11, 30, 12),
        DateTime(2024, 12, 12, 12),
      );
      expect(changes.single, (DateTime.utc(2024, 11, 30), DateTime.utc(2024, 12, 12)));
    });
  });
}

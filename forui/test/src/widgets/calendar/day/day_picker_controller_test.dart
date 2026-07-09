import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import '../../../test_scaffold.dart';

FCalendarDayPickerController _controller({
  DateTime? start,
  DateTime? end,
  DateTime? initial,
  bool Function(DateTime)? selectable,
}) => autoDispose(
  FCalendarDayPickerController(
    start: start ?? .utc(2024),
    end: end ?? .utc(2024, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: initial ?? .utc(2024, 6, 15),
  ),
);

Widget _harness(
  FCalendarDayPickerController controller, {
  DateTime? today,
  bool Function(DateTime)? selected,
  ValueChanged<DateTime>? onPress,
  ValueChanged<DateTime>? onLongPress,
  int? firstDayOfWeek,
}) => TestScaffold.app(
  child: Builder(
    builder: (context) => DayPicker(
      controller: controller,
      style: context.theme.calendarStyle.dayPickerStyle.copyWith(
        firstDayOfWeek: firstDayOfWeek == null ? null : () => firstDayOfWeek,
      ),
      localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
      today: today ?? .utc(2024, 6, 15),
      selected: selected ?? (_) => false,
      scrollPhysics: null,
      scrollCacheExtent: null,
      scrollBehavior: null,
      fixedWeeks: true,
      onPress: onPress ?? (_) {},
      onLongPress: onLongPress ?? (_) {},
      builder: FCalendar.defaultDayBuilder,
    ),
  ),
);

void main() {
  group('constructor', () {
    test('seeds month from initial and focused defaults to null', () {
      final controller = _controller(initial: .utc(2024, 6, 15));

      expect(controller.current, DateTime.utc(2024, 6));
      expect(controller.focused, null);
    });

    test('asserts start is UTC', () {
      expect(
        () => FCalendarDayPickerController(
          start: DateTime(2024),
          end: .utc(2024, 12, 31),
          selectable: (_) => true,
          initial: .utc(2024, 6, 15),
        ),
        throwsAssertionError,
      );
    });

    test('asserts end is UTC', () {
      expect(
        () => FCalendarDayPickerController(
          start: .utc(2024),
          end: DateTime(2024, 12, 31),
          selectable: (_) => true,
          initial: .utc(2024, 6, 15),
        ),
        throwsAssertionError,
      );
    });

    test('asserts start is before or equal to end', () {
      expect(
        () => FCalendarDayPickerController(
          start: .utc(2024, 12, 31),
          end: .utc(2024),
          selectable: (_) => true,
          initial: .utc(2024, 6, 15),
        ),
        throwsAssertionError,
      );
    });

    test('asserts initial is within range', () {
      expect(
        () => FCalendarDayPickerController(
          start: .utc(2024),
          end: .utc(2024, 12, 31),
          selectable: (_) => true,
          initial: .utc(2025),
        ),
        throwsA(isA<FlutterError>()),
      );
    });
  });

  group('move', () {
    for (final (TraversalDirection direction, TextDirection textDirection, expected) in [
      (.right, .ltr, 16),
      (.left, .ltr, 14),
      (.right, .rtl, 14),
      (.left, .rtl, 16),
      (.down, .ltr, 22),
      (.up, .ltr, 8),
    ]) {
      test('$direction $textDirection within month', () async {
        final controller = _controller(initial: .utc(2024, 6, 15));
        await controller.focus(.utc(2024, 6, 15));

        await controller.move(direction, textDirection);

        expect(controller.focused, DateTime.utc(2024, 6, expected));
      });
    }

    test('skips unselectable days', () async {
      final controller = _controller(selectable: (date) => date.day.isEven);
      await controller.focus(.utc(2024, 6, 16));

      await controller.move(.right, .ltr);

      expect(controller.focused, DateTime.utc(2024, 6, 18));
    });

    test('does nothing when clamped against the range', () async {
      final controller = _controller(start: .utc(2024, 6, 15), end: .utc(2024, 6, 15), initial: .utc(2024, 6, 15));
      await controller.focus(.utc(2024, 6, 15));

      await controller.move(.right, .ltr);

      expect(controller.focused, DateTime.utc(2024, 6, 15));
    });

    testWidgets('across a month boundary pages and updates focus', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller));

      await controller.focus(.utc(2024, 6, 30));
      unawaited(controller.move(.right, .ltr));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2024, 7));
      expect(controller.focused, DateTime.utc(2024, 7));
    });

    testWidgets('arrow keys move focus', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6, 15));

      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6, 16));
    });
  });

  group('page and row navigation', () {
    testWidgets('PageDown pages to the next month keeping the day', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6, 15));

      await tester.sendKeyEvent(.pageDown);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2024, 7));
      expect(controller.focused, DateTime.utc(2024, 7, 15));
    });

    testWidgets('PageUp pages to the previous month keeping the day', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.pageUp);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2024, 5));
      expect(controller.focused, DateTime.utc(2024, 5, 15));
    });

    testWidgets('Shift+PageDown pages to the next year', (tester) async {
      final controller = _controller(start: .utc(2022), end: .utc(2026, 12, 31), initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyDownEvent(.shiftLeft);
      await tester.sendKeyEvent(.pageDown);
      await tester.sendKeyUpEvent(.shiftLeft);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2025, 6));
      expect(controller.focused, DateTime.utc(2025, 6, 15));
    });

    testWidgets('Shift+PageUp pages to the previous year', (tester) async {
      final controller = _controller(start: .utc(2022), end: .utc(2026, 12, 31), initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyDownEvent(.shiftLeft);
      await tester.sendKeyEvent(.pageUp);
      await tester.sendKeyUpEvent(.shiftLeft);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2023, 6));
      expect(controller.focused, DateTime.utc(2023, 6, 15));
    });

    testWidgets('PageUp is clamped at the first page', (tester) async {
      final controller = _controller(start: .utc(2024, 6), end: .utc(2024, 12, 31), initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.pageUp);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2024, 6));
      expect(controller.focused, DateTime.utc(2024, 6, 15));
    });

    testWidgets('Home and End move focus to the week edges (Monday start)', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15), firstDayOfWeek: DateTime.monday));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      // 2024-06-15 is a Saturday; the Monday-start week is Jun 10 (Mon) .. Jun 16 (Sun).
      await tester.sendKeyEvent(.home);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6, 10));

      await tester.sendKeyEvent(.end);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6, 16));
    });

    testWidgets('Home moves focus to the week start (Sunday start)', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15), firstDayOfWeek: DateTime.sunday));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      // With a Sunday-start week, Saturday Jun 15 is the last cell; its week is Jun 9 (Sun) .. Jun 15 (Sat).
      await tester.sendKeyEvent(.home);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6, 9));
    });

    testWidgets('Home clamps to the first day of the month on the leading week', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6, 15), firstDayOfWeek: DateTime.monday));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      // Focus the 1st, whose Monday-start week begins in May; Home must stay within June.
      unawaited(controller.focus(.utc(2024, 6)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.home);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6));
    });
  });

  group('focus', () {
    test('no-op when already focused', () async {
      final controller = _controller();
      await controller.focus(.utc(2024, 6, 10));

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(.utc(2024, 6, 10));

      expect(controller.focused, DateTime.utc(2024, 6, 10));
      expect(count, 0);
    });

    test('clears focus and notifies', () async {
      final controller = _controller();
      await controller.focus(.utc(2024, 6, 10));

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(null);

      expect(controller.focused, null);
      expect(count, 1);
    });

    test('focuses a date in the current month and notifies', () async {
      final controller = _controller();

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(.utc(2024, 6, 10));

      expect(controller.focused, DateTime.utc(2024, 6, 10));
      expect(count, 1);
    });

    test('asserts the date is within range', () async {
      final controller = _controller();
      await expectLater(controller.focus(.utc(2025)), throwsA(isA<FlutterError>()));
    });

    testWidgets('focuses a date off the current page and animates to its month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.focus(.utc(2024, 8, 20)));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2024, 8));
      expect(controller.focused, DateTime.utc(2024, 8, 20));
    });
  });

  group('next', () {
    test('does nothing at the end month', () async {
      final controller = _controller(initial: .utc(2024, 12, 15));

      var count = 0;
      controller.addListener(() => count++);
      await controller.next();

      expect(controller.current, DateTime.utc(2024, 12));
      expect(count, 0);
    });

    testWidgets('advances the month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.next());
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2024, 7));
    });
  });

  group('previous', () {
    test('does nothing at the start month', () async {
      final controller = _controller(initial: .utc(2024));

      var count = 0;
      controller.addListener(() => count++);
      await controller.previous();

      expect(controller.current, DateTime.utc(2024));
      expect(count, 0);
    });

    testWidgets('goes back a month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.previous());
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2024, 5));
    });
  });

  group('animateTo', () {
    test('asserts the date is within range', () {
      final controller = _controller();
      expect(() => controller.animateTo(.utc(2025)), throwsA(isA<FlutterError>()));
    });

    testWidgets('animates to the date month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.animateTo(.utc(2024, 9, 10)));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2024, 9));
    });

    testWidgets('superseding animation keeps the latest start/end', (tester) async {
      final controller = _controller(initial: .utc(2024, 2, 15));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.animateTo(.utc(2024, 6, 10), duration: const Duration(milliseconds: 300)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      // Supersede the first animation before it settles; its completion must not clear the new one's start/end.
      unawaited(controller.animateTo(.utc(2024, 9, 10), duration: const Duration(milliseconds: 300)));
      await tester.pump();

      expect(controller.animation?.$2, controller.from(.utc(2024, 9)));

      await tester.pumpAndSettle();
      expect(controller.animation, null);
      expect(controller.current, DateTime.utc(2024, 9));
    });
  });

  group('jumpTo', () {
    test('asserts the date is within range', () {
      final controller = _controller();
      expect(() => controller.jumpTo(.utc(2025)), throwsA(isA<FlutterError>()));
    });

    testWidgets('jumps to the date month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6, 15));
      await tester.pumpWidget(_harness(controller));

      controller.jumpTo(.utc(2024, 3, 5));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2024, 3));
    });
  });

  group('pages', () {
    for (final (start, end, expected) in [
      (DateTime.utc(2024), DateTime.utc(2024, 12, 31), 12),
      (DateTime.utc(2024), DateTime.utc(2024, 1, 31), 1),
      (DateTime.utc(2024), DateTime.utc(2025, 6, 30), 18),
      (DateTime.utc(2023, 11), DateTime.utc(2024, 2, 15), 4),
    ]) {
      test('$start to $end', () {
        final controller = _controller(start: start, end: end, initial: start);
        expect(controller.pages, expected);
      });
    }
  });

  group('hasPrevious', () {
    for (final (start, end, initial, expected) in [
      (DateTime.utc(2024), DateTime.utc(2024, 12, 31), DateTime.utc(2024), false),
      (DateTime.utc(2024), DateTime.utc(2024, 12, 31), DateTime.utc(2024, 6, 15), true),
      (DateTime.utc(2024, 6), DateTime.utc(2024, 6, 30), DateTime.utc(2024, 6, 15), false),
    ]) {
      test('initial $initial', () {
        final controller = _controller(start: start, end: end, initial: initial);
        expect(controller.hasPrevious, expected);
      });
    }
  });

  group('hasNext', () {
    for (final (start, end, initial, expected) in [
      (DateTime.utc(2024), DateTime.utc(2024, 12, 31), DateTime.utc(2024, 12, 15), false),
      (DateTime.utc(2024), DateTime.utc(2024, 12, 31), DateTime.utc(2024, 6, 15), true),
      (DateTime.utc(2024, 6), DateTime.utc(2024, 6, 30), DateTime.utc(2024, 6, 15), false),
    ]) {
      test('initial $initial', () {
        final controller = _controller(start: start, end: end, initial: initial);
        expect(controller.hasNext, expected);
      });
    }
  });

  group('onPageChange', () {
    testWidgets('swiping updates the month and notifies', (tester) async {
      var count = 0;
      final controller = _controller(initial: .utc(2024, 6, 15))..addListener(() => count++);
      await tester.pumpWidget(_harness(controller));

      await tester.drag(find.byType(PageView), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(controller.current.isAfter(.utc(2024, 6)), true);
      expect(count, greaterThan(0));
    });

    test('re-homes focus into the new month', () async {
      final controller = _controller(initial: .utc(2024, 5, 15));
      await controller.focus(.utc(2024, 5, 31));

      controller.onPageChange(controller.from(.utc(2024, 6)));

      expect(controller.current, DateTime.utc(2024, 6));
      expect(controller.focused, DateTime.utc(2024, 6));
    });

    test('no-op when the page resolves to the current month', () {
      var count = 0;
      final controller = _controller(initial: .utc(2024, 6, 15))..addListener(() => count++);

      controller.onPageChange(controller.from(.utc(2024, 6)));

      expect(controller.current, DateTime.utc(2024, 6));
      expect(count, 0);
    });
  });

  group('focusable', () {
    test('returns the preferred day when selectable', () {
      final controller = _controller();
      expect(controller.focusable(.utc(2024, 6), .utc(2024, 6, 15)), DateTime.utc(2024, 6, 15));
    });

    test('falls back to the first selectable day when the preferred day is out of range', () {
      final controller = _controller();
      expect(controller.focusable(.utc(2024, 2), .utc(2024, 1, 31)), DateTime.utc(2024, 2));
    });

    test('falls back to the first selectable day when the preferred day is unselectable', () {
      final controller = _controller(selectable: (date) => date.day.isEven);
      expect(controller.focusable(.utc(2024, 6), .utc(2024, 6, 15)), DateTime.utc(2024, 6, 2));
    });

    test('returns null when no day is selectable', () {
      final controller = _controller(selectable: (_) => false);
      expect(controller.focusable(.utc(2024, 6), .utc(2024, 6, 15)), null);
    });
  });

  group('from / to', () {
    test('round-trips month and page index across a year boundary', () {
      final controller = _controller(start: .utc(2024), end: .utc(2025, 12, 31), initial: .utc(2024));

      expect(controller.from(.utc(2024)), 0);
      expect(controller.from(.utc(2024, 12)), 11);
      expect(controller.from(.utc(2025, 3)), 14);

      expect(controller.to(0), DateTime.utc(2024));
      expect(controller.to(11), DateTime.utc(2024, 12));
      expect(controller.to(14), DateTime.utc(2025, 3));
    });
  });
}

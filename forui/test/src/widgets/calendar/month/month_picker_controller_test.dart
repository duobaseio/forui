import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:forui/src/widgets/calendar/month/month_picker.dart';
import '../../../test_scaffold.dart';

FCalendarMonthPickerController _controller({
  DateTime? start,
  DateTime? end,
  DateTime? initial,
  bool Function(DateTime)? selectable,
}) => autoDispose(
  FCalendarMonthPickerController(
    start: start ?? .utc(2020),
    end: end ?? .utc(2027, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: initial ?? .utc(2024, 6),
  ),
);

Widget _harness(FCalendarMonthPickerController controller, {DateTime? today, ValueChanged<DateTime>? onPress}) =>
    TestScaffold.app(
      child: Builder(
        builder: (context) => MonthPicker(
          controller: controller,
          style: context.theme.calendarStyle.monthPickerStyle,
          localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
          today: today ?? .utc(2024, 6),
          scrollPhysics: null,
          scrollCacheExtent: null,
          scrollBehavior: null,
          onPress: onPress ?? (_) {},
          builder: FCalendar.defaultMonthBuilder,
        ),
      ),
    );

void main() {
  group('constructor', () {
    test('seeds year from initial and focused defaults to null', () {
      final controller = _controller(initial: .utc(2024, 6));

      expect(controller.current, DateTime.utc(2024));
      expect(controller.focused, null);
    });

    test('asserts start is UTC', () {
      expect(
        () => FCalendarMonthPickerController(
          start: DateTime(2020),
          end: .utc(2027, 12, 31),
          selectable: (_) => true,
          initial: .utc(2024, 6),
        ),
        throwsAssertionError,
      );
    });

    test('asserts end is UTC', () {
      expect(
        () => FCalendarMonthPickerController(
          start: .utc(2020),
          end: DateTime(2027, 12, 31),
          selectable: (_) => true,
          initial: .utc(2024, 6),
        ),
        throwsAssertionError,
      );
    });

    test('asserts start is before or equal to end', () {
      expect(
        () => FCalendarMonthPickerController(
          start: .utc(2027, 12, 31),
          end: .utc(2020),
          selectable: (_) => true,
          initial: .utc(2024, 6),
        ),
        throwsAssertionError,
      );
    });

    test('asserts initial is within range', () {
      expect(
        () => FCalendarMonthPickerController(
          start: .utc(2020),
          end: .utc(2027, 12, 31),
          selectable: (_) => true,
          initial: .utc(2030),
        ),
        throwsA(isA<FlutterError>()),
      );
    });
  });

  group('move', () {
    for (final (TraversalDirection direction, TextDirection textDirection, expected) in [
      (.right, .ltr, 7),
      (.left, .ltr, 5),
      (.right, .rtl, 5),
      (.left, .rtl, 7),
      (.down, .ltr, 9),
      (.up, .ltr, 3),
    ]) {
      test('$direction $textDirection within year', () async {
        final controller = _controller(initial: .utc(2024, 6));
        await controller.focus(.utc(2024, 6));

        await controller.move(direction, textDirection);

        expect(controller.focused, DateTime.utc(2024, expected));
      });
    }

    test('skips unselectable months', () async {
      final controller = _controller(selectable: (date) => date.month.isEven);
      await controller.focus(.utc(2024, 6));

      await controller.move(.right, .ltr);

      expect(controller.focused, DateTime.utc(2024, 8));
    });

    test('does nothing when clamped against the range', () async {
      final controller = _controller(start: .utc(2024, 6), end: .utc(2024, 6, 30), initial: .utc(2024, 6));
      await controller.focus(.utc(2024, 6));

      await controller.move(.right, .ltr);

      expect(controller.focused, DateTime.utc(2024, 6));
    });

    testWidgets('across a year boundary pages and updates focus', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller));

      await controller.focus(.utc(2024, 12));
      unawaited(controller.move(.right, .ltr));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2025));
      expect(controller.focused, DateTime.utc(2025));
    });

    testWidgets('arrow keys move focus', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6));

      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 7));
    });
  });

  group('page and row navigation', () {
    testWidgets('PageDown pages to the next year keeping the month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6));

      await tester.sendKeyEvent(.pageDown);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2025));
      expect(controller.focused, DateTime.utc(2025, 6));
    });

    testWidgets('PageUp pages to the previous year keeping the month', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.pageUp);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2023));
      expect(controller.focused, DateTime.utc(2023, 6));
    });

    testWidgets('Shift+PageDown pages to the next decade', (tester) async {
      final controller = _controller(start: .utc(2010), end: .utc(2039, 12, 31), initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyDownEvent(.shiftLeft);
      await tester.sendKeyEvent(.pageDown);
      await tester.sendKeyUpEvent(.shiftLeft);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2034));
      expect(controller.focused, DateTime.utc(2034, 6));
    });

    testWidgets('PageDown is clamped at the last page', (tester) async {
      final controller = _controller(start: .utc(2020), end: .utc(2024, 12, 31), initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.pageDown);
      await tester.pumpAndSettle();
      expect(controller.current, DateTime.utc(2024));
      expect(controller.focused, DateTime.utc(2024, 6));
    });

    testWidgets('Home and End move focus to the row edges', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller, today: .utc(2024, 6)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      // June is the third cell of its 3-column row [Apr, May, Jun].
      expect(controller.focused, DateTime.utc(2024, 6));

      await tester.sendKeyEvent(.home);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 4));

      await tester.sendKeyEvent(.end);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024, 6));
    });
  });

  group('focus', () {
    test('no-op when already focused', () async {
      final controller = _controller();
      await controller.focus(.utc(2024, 4));

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(.utc(2024, 4));

      expect(controller.focused, DateTime.utc(2024, 4));
      expect(count, 0);
    });

    test('clears focus and notifies', () async {
      final controller = _controller();
      await controller.focus(.utc(2024, 4));

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(null);

      expect(controller.focused, null);
      expect(count, 1);
    });

    test('focuses a month in the current year and notifies', () async {
      final controller = _controller();

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(.utc(2024, 3));

      expect(controller.focused, DateTime.utc(2024, 3));
      expect(count, 1);
    });

    test('asserts the date is within range', () async {
      final controller = _controller();
      await expectLater(controller.focus(.utc(2030)), throwsA(isA<FlutterError>()));
    });

    testWidgets('focuses a month off the current page and animates to its year', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.focus(.utc(2026, 8)));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2026));
      expect(controller.focused, DateTime.utc(2026, 8));
    });
  });

  group('next', () {
    test('does nothing at the end year', () async {
      final controller = _controller(initial: .utc(2027, 6));

      var count = 0;
      controller.addListener(() => count++);
      await controller.next();

      expect(controller.current, DateTime.utc(2027));
      expect(count, 0);
    });

    testWidgets('advances the year', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.next());
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2025));
    });
  });

  group('previous', () {
    test('does nothing at the start year', () async {
      final controller = _controller(initial: .utc(2020));

      var count = 0;
      controller.addListener(() => count++);
      await controller.previous();

      expect(controller.current, DateTime.utc(2020));
      expect(count, 0);
    });

    testWidgets('goes back a year', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.previous());
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2023));
    });
  });

  group('animateTo', () {
    test('asserts the date is within range', () {
      final controller = _controller();
      expect(() => controller.animateTo(.utc(2030)), throwsA(isA<FlutterError>()));
    });

    testWidgets('animates to the date year', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.animateTo(.utc(2026, 9)));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2026));
    });
  });

  group('jumpTo', () {
    test('asserts the date is within range', () {
      final controller = _controller();
      expect(() => controller.jumpTo(.utc(2030)), throwsA(isA<FlutterError>()));
    });

    testWidgets('jumps to the date year', (tester) async {
      final controller = _controller(initial: .utc(2024, 6));
      await tester.pumpWidget(_harness(controller));

      controller.jumpTo(.utc(2022, 3));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2022));
    });
  });

  group('pages', () {
    for (final (start, end, expected) in [
      (DateTime.utc(2024), DateTime.utc(2024, 12, 31), 1),
      (DateTime.utc(2024), DateTime.utc(2027, 12, 31), 4),
      (DateTime.utc(2023, 11), DateTime.utc(2024, 2, 15), 2),
    ]) {
      test('$start to $end', () {
        final controller = _controller(start: start, end: end, initial: start);
        expect(controller.pages, expected);
      });
    }
  });

  group('hasPrevious', () {
    for (final (start, end, initial, expected) in [
      (DateTime.utc(2024), DateTime.utc(2027, 12, 31), DateTime.utc(2024), false),
      (DateTime.utc(2024), DateTime.utc(2027, 12, 31), DateTime.utc(2026, 6), true),
      (DateTime.utc(2024, 6), DateTime.utc(2024, 12, 31), DateTime.utc(2024, 6), false),
    ]) {
      test('initial $initial', () {
        final controller = _controller(start: start, end: end, initial: initial);
        expect(controller.hasPrevious, expected);
      });
    }
  });

  group('hasNext', () {
    for (final (start, end, initial, expected) in [
      (DateTime.utc(2024), DateTime.utc(2027, 12, 31), DateTime.utc(2027, 6), false),
      (DateTime.utc(2024), DateTime.utc(2027, 12, 31), DateTime.utc(2025, 6), true),
      (DateTime.utc(2024, 6), DateTime.utc(2024, 12, 31), DateTime.utc(2024, 6), false),
    ]) {
      test('initial $initial', () {
        final controller = _controller(start: start, end: end, initial: initial);
        expect(controller.hasNext, expected);
      });
    }
  });

  group('onPageChange', () {
    testWidgets('swiping updates the year and notifies', (tester) async {
      var count = 0;
      final controller = _controller(initial: .utc(2024, 6))..addListener(() => count++);
      await tester.pumpWidget(_harness(controller));

      await tester.drag(find.byType(PageView), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(controller.current.isAfter(.utc(2024)), true);
      expect(count, greaterThan(0));
    });

    test('re-homes focus into the new year', () async {
      final controller = _controller(initial: .utc(2024, 6));
      await controller.focus(.utc(2024, 11));

      controller.onPageChange(controller.from(.utc(2025)));

      expect(controller.current, DateTime.utc(2025));
      expect(controller.focused, DateTime.utc(2025, 11));
    });

    test('no-op when the page resolves to the current year', () {
      var count = 0;
      final controller = _controller(initial: .utc(2024, 6))..addListener(() => count++);

      controller.onPageChange(controller.from(.utc(2024)));

      expect(controller.current, DateTime.utc(2024));
      expect(count, 0);
    });
  });

  group('focusable', () {
    test('returns the preferred month when selectable', () {
      final controller = _controller();
      expect(controller.focusable(.utc(2024), .utc(2024, 6)), DateTime.utc(2024, 6));
    });

    test('falls back to the first selectable month when the preferred month is unselectable', () {
      final controller = _controller(selectable: (date) => date.month.isEven);
      expect(controller.focusable(.utc(2024), .utc(2024, 5)), DateTime.utc(2024, 2));
    });

    test('returns null when no month is selectable', () {
      final controller = _controller(selectable: (_) => false);
      expect(controller.focusable(.utc(2024), .utc(2024, 6)), null);
    });
  });

  group('from / to', () {
    test('round-trips year and page index', () {
      final controller = _controller(start: .utc(2020), end: .utc(2027, 12, 31), initial: .utc(2020));

      expect(controller.from(.utc(2020)), 0);
      expect(controller.from(.utc(2024)), 4);
      expect(controller.from(.utc(2027)), 7);

      expect(controller.to(0), DateTime.utc(2020));
      expect(controller.to(4), DateTime.utc(2024));
      expect(controller.to(7), DateTime.utc(2027));
    });
  });

  group('accessibility', () {
    testWidgets('month tile label includes the year', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(_harness(_controller(initial: .utc(2024, 6))));

      expect(find.bySemanticsLabel('January 2024'), findsOneWidget);
      expect(find.bySemanticsLabel('June 2024'), findsOneWidget);

      semantics.dispose();
    });
  });
}

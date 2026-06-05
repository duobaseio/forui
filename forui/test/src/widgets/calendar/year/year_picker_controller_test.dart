import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/calendar.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';
import '../../../test_scaffold.dart';

FCalendarYearPickerController _controller({
  DateTime? start,
  DateTime? end,
  DateTime? initial,
  bool Function(DateTime)? selectable,
}) => autoDispose(
  FCalendarYearPickerController(
    start: start ?? .utc(2000),
    end: end ?? .utc(2049, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: initial ?? .utc(2024),
  ),
);

Widget _harness(
  FCalendarYearPickerController controller, {
  DateTime? today,
  ValueChanged<DateTime>? onPress,
}) => TestScaffold.app(
  child: Builder(
    builder: (context) {
      final theme = context.theme;
      return YearPicker(
        controller: controller,
        style: .inherit(colors: theme.colors, typography: theme.typography, style: theme.style),
        localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
        today: today ?? .utc(2024),
        onPress: onPress ?? (_) {},
        builder: FCalendar.defaultYearBuilder,
      );
    },
  ),
);

void main() {
  group('constructor', () {
    test('seeds current from the initial decade and focused defaults to null', () {
      final controller = _controller(initial: .utc(2024));

      expect(controller.current, DateTime.utc(2020));
      expect(controller.focused, null);
    });

    test('seeds current to the decade start even when start is mid-decade', () {
      final controller = _controller(start: .utc(2024), end: .utc(2049, 12, 31), initial: .utc(2024));

      expect(controller.current, DateTime.utc(2020));
    });

    test('asserts start is UTC', () {
      expect(
        () => FCalendarYearPickerController(
          start: DateTime(2000),
          end: .utc(2049, 12, 31),
          selectable: (_) => true,
          initial: .utc(2024),
        ),
        throwsAssertionError,
      );
    });

    test('asserts end is UTC', () {
      expect(
        () => FCalendarYearPickerController(
          start: .utc(2000),
          end: DateTime(2049, 12, 31),
          selectable: (_) => true,
          initial: .utc(2024),
        ),
        throwsAssertionError,
      );
    });

    test('asserts start is before or equal to end', () {
      expect(
        () => FCalendarYearPickerController(
          start: .utc(2049, 12, 31),
          end: .utc(2000),
          selectable: (_) => true,
          initial: .utc(2024),
        ),
        throwsAssertionError,
      );
    });

    test('asserts initial is within range', () {
      expect(
        () => FCalendarYearPickerController(
          start: .utc(2000),
          end: .utc(2049, 12, 31),
          selectable: (_) => true,
          initial: .utc(2055),
        ),
        throwsA(isA<FlutterError>()),
      );
    });
  });

  group('move', () {
    for (final (TraversalDirection direction, TextDirection textDirection, expected) in [
      (.right, .ltr, 2025),
      (.left, .ltr, 2023),
      (.right, .rtl, 2023),
      (.left, .rtl, 2025),
      (.down, .ltr, 2027),
      (.up, .ltr, 2021),
    ]) {
      test('$direction $textDirection within decade', () async {
        final controller = _controller(initial: .utc(2024));
        await controller.focus(.utc(2024));

        await controller.move(direction, textDirection);

        expect(controller.focused, DateTime.utc(expected));
      });
    }

    test('skips unselectable years', () async {
      final controller = _controller(selectable: (date) => date.year.isEven);
      await controller.focus(.utc(2024));

      await controller.move(.right, .ltr);

      expect(controller.focused, DateTime.utc(2026));
    });

    test('does nothing when clamped against the range', () async {
      final controller = _controller(start: .utc(2024), end: .utc(2024, 12, 31), initial: .utc(2024));
      await controller.focus(.utc(2024));

      await controller.move(.right, .ltr);

      expect(controller.focused, DateTime.utc(2024));
    });

    testWidgets('across a decade boundary pages and updates focus', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller));

      await controller.focus(.utc(2029));
      unawaited(controller.move(.right, .ltr));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2030));
      expect(controller.focused, DateTime.utc(2030));
    });

    testWidgets('arrow keys move focus', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller, today: .utc(2024)));

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2024));

      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();
      expect(controller.focused, DateTime.utc(2025));
    });
  });

  group('focus', () {
    test('no-op when already focused', () async {
      final controller = _controller();
      await controller.focus(.utc(2023));

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(.utc(2023));

      expect(controller.focused, DateTime.utc(2023));
      expect(count, 0);
    });

    test('clears focus and notifies', () async {
      final controller = _controller();
      await controller.focus(.utc(2023));

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(null);

      expect(controller.focused, null);
      expect(count, 1);
    });

    test('focuses a year in the current decade and notifies', () async {
      final controller = _controller();

      var count = 0;
      controller.addListener(() => count++);
      await controller.focus(.utc(2023));

      expect(controller.focused, DateTime.utc(2023));
      expect(count, 1);
    });

    test('asserts the date is within range', () async {
      final controller = _controller();
      await expectLater(controller.focus(.utc(2055)), throwsA(isA<FlutterError>()));
    });

    testWidgets('focuses a year off the current page and animates to its decade', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.focus(.utc(2045)));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2040));
      expect(controller.focused, DateTime.utc(2045));
    });
  });

  group('next', () {
    test('does nothing at the end decade', () async {
      final controller = _controller(initial: .utc(2045));

      var count = 0;
      controller.addListener(() => count++);
      await controller.next();

      expect(controller.current, DateTime.utc(2040));
      expect(count, 0);
    });

    testWidgets('advances the decade', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.next());
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2030));
    });
  });

  group('previous', () {
    test('does nothing at the start decade', () async {
      final controller = _controller(initial: .utc(2005));

      var count = 0;
      controller.addListener(() => count++);
      await controller.previous();

      expect(controller.current, DateTime.utc(2000));
      expect(count, 0);
    });

    testWidgets('goes back a decade', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.previous());
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2010));
    });
  });

  group('animateTo', () {
    test('asserts the date is within range', () {
      final controller = _controller();
      expect(() => controller.animateTo(.utc(2055)), throwsA(isA<FlutterError>()));
    });

    testWidgets('animates to the date decade', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller));

      unawaited(controller.animateTo(.utc(2045)));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2040));
    });
  });

  group('jumpTo', () {
    test('asserts the date is within range', () {
      final controller = _controller();
      expect(() => controller.jumpTo(.utc(2055)), throwsA(isA<FlutterError>()));
    });

    testWidgets('jumps to the date decade', (tester) async {
      final controller = _controller(initial: .utc(2024));
      await tester.pumpWidget(_harness(controller));

      controller.jumpTo(.utc(2015));
      await tester.pumpAndSettle();

      expect(controller.current, DateTime.utc(2010));
    });
  });

  group('pages', () {
    for (final (start, end, expected) in [
      (DateTime.utc(2020), DateTime.utc(2029, 12, 31), 1),
      (DateTime.utc(2000), DateTime.utc(2049, 12, 31), 5),
      (DateTime.utc(2018), DateTime.utc(2021, 12, 31), 2),
    ]) {
      test('$start to $end', () {
        final controller = _controller(start: start, end: end, initial: start);
        expect(controller.pages, expected);
      });
    }
  });

  group('hasPrevious', () {
    for (final (start, end, initial, expected) in [
      (DateTime.utc(2000), DateTime.utc(2049, 12, 31), DateTime.utc(2000), false),
      (DateTime.utc(2000), DateTime.utc(2049, 12, 31), DateTime.utc(2024), true),
      (DateTime.utc(2020), DateTime.utc(2029, 12, 31), DateTime.utc(2024), false),
    ]) {
      test('initial $initial', () {
        final controller = _controller(start: start, end: end, initial: initial);
        expect(controller.hasPrevious, expected);
      });
    }
  });

  group('hasNext', () {
    for (final (start, end, initial, expected) in [
      (DateTime.utc(2000), DateTime.utc(2049, 12, 31), DateTime.utc(2045), false),
      (DateTime.utc(2000), DateTime.utc(2049, 12, 31), DateTime.utc(2024), true),
      (DateTime.utc(2020), DateTime.utc(2029, 12, 31), DateTime.utc(2024), false),
    ]) {
      test('initial $initial', () {
        final controller = _controller(start: start, end: end, initial: initial);
        expect(controller.hasNext, expected);
      });
    }
  });

  group('onPageChange', () {
    testWidgets('swiping updates the decade and notifies', (tester) async {
      var count = 0;
      final controller = _controller(initial: .utc(2024))..addListener(() => count++);
      await tester.pumpWidget(_harness(controller));

      await tester.drag(find.byType(PageView), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(controller.current.isAfter(.utc(2020)), true);
      expect(count, greaterThan(0));
    });

    test('re-homes focus into the new decade', () async {
      final controller = _controller(initial: .utc(2024));
      await controller.focus(.utc(2027));

      controller.onPageChange(controller.from(.utc(2035)));

      expect(controller.current, DateTime.utc(2030));
      expect(controller.focused, DateTime.utc(2030));
    });

    test('no-op when the page resolves to the current decade', () {
      var count = 0;
      final controller = _controller(initial: .utc(2024))..addListener(() => count++);

      controller.onPageChange(controller.from(.utc(2024)));

      expect(controller.current, DateTime.utc(2020));
      expect(count, 0);
    });
  });

  group('focusable', () {
    test('returns the preferred year when selectable', () {
      final controller = _controller();
      expect(controller.focusable(.utc(2020), .utc(2024)), DateTime.utc(2024));
    });

    test('falls back to the first selectable year when the preferred year is unselectable', () {
      final controller = _controller(selectable: (date) => date.year.isEven);
      expect(controller.focusable(.utc(2020), .utc(2025)), DateTime.utc(2020));
    });

    test('returns null when no year is selectable', () {
      final controller = _controller(selectable: (_) => false);
      expect(controller.focusable(.utc(2020), .utc(2024)), null);
    });
  });

  group('from / to', () {
    test('round-trips decade and page index', () {
      final controller = _controller(start: .utc(2000), end: .utc(2049, 12, 31), initial: .utc(2000));

      expect(controller.from(.utc(2000)), 0);
      expect(controller.from(.utc(2024)), 2);
      expect(controller.from(.utc(2049)), 4);

      expect(controller.to(0), DateTime.utc(2000));
      expect(controller.to(2), DateTime.utc(2020));
      expect(controller.to(4), DateTime.utc(2040));
    });
  });
}

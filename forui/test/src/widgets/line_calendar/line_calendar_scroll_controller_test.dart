import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  // Use a fixed date range so offset math is deterministic.
  final start = DateTime.utc(2024);
  final end = DateTime.utc(2025);
  final today = DateTime.utc(2024, 11, 28);
  // The widget's full constraint width in the TestScaffold; the calendar fills the available width.
  // We pump with a SizedBox so we know the viewport.
  const viewport = 400.0;

  Future<({double itemExtent, double viewport})> pumpCalendar(
    WidgetTester tester, {
    FLineCalendarScrollController? controller,
    AlignmentDirectional initialAlignment = .center,
    DateTime? initialDate,
  }) async {
    await tester.pumpWidget(
      TestScaffold(
        padded: false,
        child: SizedBox(
          width: viewport,
          child: FLineCalendar(
            scrollControl: controller == null
                ? .managed(
                    start: start,
                    end: end,
                    today: today,
                    initialAlignment: initialAlignment,
                    initialDate: initialDate,
                  )
                : .managed(controller: controller),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final list = tester.widget<ListView>(find.byType(ListView));
    return (itemExtent: list.itemExtent!, viewport: viewport);
  }

  double expectedOffset({
    required DateTime start,
    required DateTime target,
    required double itemExtent,
    required double viewport,
    required AlignmentDirectional alignment,
    required double maxScrollExtent,
  }) {
    final raw = target.difference(start).inDays * itemExtent;
    final unclamped = switch (alignment.start) {
      -1 => raw,
      1 => raw - viewport + itemExtent,
      _ => raw - (viewport - itemExtent) / 2,
    };
    return unclamped.clamp(0.0, maxScrollExtent);
  }

  group('FLineCalendarScrollController', () {
    testWidgets('throws assertion when used before being attached', (tester) async {
      final controller = autoDispose(FLineCalendarScrollController());
      expect(() => controller.jumpToDate(today), throwsA(isA<AssertionError>()));
    });

    for (final (alignment, name) in [
      (AlignmentDirectional.centerStart, 'start'),
      (AlignmentDirectional.center, 'center'),
      (AlignmentDirectional.centerEnd, 'end'),
    ]) {
      testWidgets('jumpToDate aligns $name', (tester) async {
        final controller = autoDispose(FLineCalendarScrollController(start: start, end: end, today: today));
        final dims = await pumpCalendar(tester, controller: controller);

        final target = DateTime.utc(2024, 6, 15);
        controller.jumpToDate(target, alignment: alignment);
        await tester.pump();

        final expected = expectedOffset(
          start: start,
          target: target,
          itemExtent: dims.itemExtent,
          viewport: dims.viewport,
          alignment: alignment,
          maxScrollExtent: controller.position.maxScrollExtent,
        );
        expect(controller.position.pixels, expected);
      });

      testWidgets('animateToDate aligns $name', (tester) async {
        final controller = autoDispose(FLineCalendarScrollController(start: start, end: end, today: today));
        final dims = await pumpCalendar(tester, controller: controller);

        final target = DateTime.utc(2024, 8);
        unawaited(
          controller.animateToDate(
            target,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            alignment: alignment,
          ),
        );
        await tester.pumpAndSettle();

        final expected = expectedOffset(
          start: start,
          target: target,
          itemExtent: dims.itemExtent,
          viewport: dims.viewport,
          alignment: alignment,
          maxScrollExtent: controller.position.maxScrollExtent,
        );
        expect(controller.position.pixels, expected);
      });
    }

    testWidgets('jumpToDate clamps below minScrollExtent', (tester) async {
      final controller = autoDispose(FLineCalendarScrollController(start: start, end: end, today: today));
      await pumpCalendar(tester, controller: controller);

      controller.jumpToDate(start);
      await tester.pump();
      expect(controller.position.pixels, controller.position.minScrollExtent);
    });

    testWidgets('initialDate honored when no user controller', (tester) async {
      final dims = await pumpCalendar(tester, initialDate: DateTime.utc(2024, 7, 4));

      final list = tester.widget<ListView>(find.byType(ListView));
      final controller = list.controller!;

      final expected = expectedOffset(
        start: start,
        target: DateTime.utc(2024, 7, 4),
        itemExtent: dims.itemExtent,
        viewport: dims.viewport,
        alignment: AlignmentDirectional.center,
        maxScrollExtent: controller.position.maxScrollExtent,
      );
      expect(controller.position.pixels, expected);
    });

    testWidgets('swapping controller updates start', (tester) async {
      final first = autoDispose(FLineCalendarScrollController(start: start, end: end, today: today));

      await tester.pumpWidget(
        TestScaffold(
          padded: false,
          child: SizedBox(
            width: viewport,
            child: FLineCalendar(scrollControl: .managed(controller: first)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final newStart = DateTime.utc(2024, 6);
      final second = autoDispose(FLineCalendarScrollController(start: newStart, end: end, today: today));
      await tester.pumpWidget(
        TestScaffold(
          padded: false,
          child: SizedBox(
            width: viewport,
            child: FLineCalendar(scrollControl: .managed(controller: second)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final list = tester.widget<ListView>(find.byType(ListView));
      final itemExtent = list.itemExtent!;

      final target = DateTime.utc(2024, 7);
      second.jumpToDate(target, alignment: .centerStart);
      await tester.pump();

      // Offset should be measured from the NEW start.
      final expected = (target.difference(newStart).inDays * itemExtent).clamp(
        second.position.minScrollExtent,
        second.position.maxScrollExtent,
      );
      expect(second.position.pixels, expected);
    });
  });
}

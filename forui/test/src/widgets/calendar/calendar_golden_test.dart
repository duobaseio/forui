@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

// Sunday-start months spanning 4, 5 and 6 weeks: Feb 2026 (4 weeks, 28 days from Sunday), May 2026 (6 weeks, 31 days
// from Friday) and Jun 2026 (5 weeks, 30 days from Monday).
const _months = [(2026, 2), (2026, 5), (2026, 6)];
const _size = Size(3360, 1560);

List<FGridCalendarController> _gridControllers() => [
  for (final (year, month) in _months)
    autoDispose(
      FGridCalendarController(
        start: .utc(2020),
        today: .utc(year, month, 15),
        initial: .utc(year, month),
        end: .utc(2030),
      ),
    ),
];

List<FWheelCalendarController> _wheelControllers() => [
  for (final (year, month) in _months)
    autoDispose(
      FWheelCalendarController(
        start: .utc(2020),
        today: .utc(year, month, 15),
        initial: .utc(year, month),
        end: .utc(2030),
      ),
    ),
];

void main() {
  Future<void> expectGolden(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(find.byType(TestScaffold), matchesGoldenFile('calendar/calendar/$name.png'));
  }

  testWidgets('day grid weeks', (tester) async {
    tester.view.physicalSize = _size;
    addTearDown(tester.view.resetPhysicalSize);

    final controllers = _gridControllers();
    await tester.pumpWidget(
      TestScaffold.app(
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            for (final controller in controllers)
              Padding(
                padding: const .symmetric(horizontal: 8),
                child: FCalendar.grid(
                  selectionControl: .managedSingle(),
                  control: FGridCalendarControl(controller: controller),
                ),
              ),
          ],
        ),
      ),
    );

    await expectGolden(tester, 'day-grid-weeks');
  });

  testWidgets('month grid weeks', (tester) async {
    tester.view.physicalSize = _size;
    addTearDown(tester.view.resetPhysicalSize);

    final controllers = _gridControllers();
    await tester.pumpWidget(
      TestScaffold.app(
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            for (final controller in controllers)
              Padding(
                padding: const .symmetric(horizontal: 8),
                child: FCalendar.grid(
                  selectionControl: .managedSingle(),
                  control: FGridCalendarControl(controller: controller),
                ),
              ),
          ],
        ),
      ),
    );

    for (final controller in controllers) {
      controller.jumpToMonthPicker();
    }

    await expectGolden(tester, 'month-grid-weeks');
  });

  testWidgets('year grid weeks', (tester) async {
    tester.view.physicalSize = _size;
    addTearDown(tester.view.resetPhysicalSize);

    final controllers = _gridControllers();
    await tester.pumpWidget(
      TestScaffold.app(
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            for (final controller in controllers)
              Padding(
                padding: const .symmetric(horizontal: 8),
                child: FCalendar.grid(
                  selectionControl: .managedSingle(),
                  control: FGridCalendarControl(controller: controller),
                ),
              ),
          ],
        ),
      ),
    );
    for (final controller in controllers) {
      controller.jumpToYearPicker();
    }

    await expectGolden(tester, 'year-grid-weeks');
  });

  testWidgets('wheel weeks', (tester) async {
    tester.view.physicalSize = _size;
    addTearDown(tester.view.resetPhysicalSize);

    final controllers = _wheelControllers();
    await tester.pumpWidget(
      TestScaffold.app(
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            for (final controller in controllers)
              Padding(
                padding: const .symmetric(horizontal: 8),
                child: FCalendar.wheel(
                  selectionControl: .managedSingle(),
                  control: FWheelCalendarControl(controller: controller),
                ),
              ),
          ],
        ),
      ),
    );

    for (final controller in controllers) {
      controller.toggleMonthYearPicker();
    }

    await expectGolden(tester, 'wheel-weeks');
  });

  FGridCalendarController animationController() => autoDispose(
    FGridCalendarController(start: .utc(2020), today: .utc(2026, 2, 15), initial: .utc(2026, 2), end: .utc(2030)),
  );

  Widget animationHarness(AnimationSheetBuilder sheet, FGridCalendarController controller) => sheet.record(
    TestScaffold(
      alignment: .topCenter,
      child: FCalendar.grid(
        selectionControl: .managedSingle(),
        control: FGridCalendarControl(controller: controller),
      ),
    ),
  );

  testWidgets('day grid scroll animation', (tester) async {
    final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(380, 480)));
    final controller = animationController();

    final widget = animationHarness(sheet, controller);
    await tester.pumpWidget(widget);

    await tester.fling(find.byType(FCalendar), const Offset(-150, 0), 1000);
    await tester.pumpFrames(widget, const Duration(milliseconds: 400), const Duration(milliseconds: 40));

    await expectLater(sheet.collate(5), matchesGoldenFile('calendar/calendar/day-grid-scroll-animation.png'));
  });

  testWidgets('day grid programmatic animation', (tester) async {
    final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(380, 480)));
    final controller = animationController();

    final widget = animationHarness(sheet, controller);
    await tester.pumpWidget(widget);

    unawaited(controller.animateToDayPicker(.utc(2026, 6), const Duration(milliseconds: 600)));
    await tester.pumpFrames(widget, const Duration(milliseconds: 650), const Duration(milliseconds: 50));

    await expectLater(sheet.collate(5), matchesGoldenFile('calendar/calendar/day-grid-programmatic-animation.png'));
  });

  group('accessibility', () {
    // Month-page navigation slides under full motion and jumps instantly under reduced and disabled motion. The page
    // transition is a pure spatial slide with no fade fallback, so reduced drops it entirely, same as disabled.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(380, 480)));
        final controller = animationController();

        final widget = animationHarness(sheet, controller);
        await tester.pumpWidget(widget);

        unawaited(controller.animateToDayPicker(.utc(2026, 6), const Duration(milliseconds: 600)));
        await tester.pumpFrames(widget, const Duration(milliseconds: 650), const Duration(milliseconds: 50));

        await expectLater(sheet.collate(5), matchesGoldenFile('calendar/calendar/motion-$name.png'));
      });
    }
  });
}

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFDateSelectionController', (tester) async {
    late FDateSelectionController<DateTime?> controller;

    await tester.pumpWidget(
      MaterialApp(
        builder: (_, child) => FTheme(data: FTheme.neutral.light.touch, child: child!),
        home: HookBuilder(
          builder: (context) {
            controller = useFDateSelectionController();
            return FCalendar.grid(
              control: FGridCalendarControl(start: DateTime.utc(1900), end: DateTime.utc(2100)),
              selectionControl: .managedSingle(controller: controller),
            );
          },
        ),
      ),
    );

    controller.value = DateTime.utc(2000);

    await tester.pumpAndSettle();

    expect(controller.contains(DateTime.utc(2000)), true);
  });

  testWidgets('useFDatesSelectionController', (tester) async {
    late FDateSelectionController<Set<DateTime>> controller;

    await tester.pumpWidget(
      MaterialApp(
        builder: (_, child) => FTheme(data: FTheme.neutral.light.touch, child: child!),
        home: HookBuilder(
          builder: (context) {
            controller = useFDatesSelectionController();
            return FCalendar.grid(
              control: FGridCalendarControl(start: DateTime.utc(1900), end: DateTime.utc(2100)),
              selectionControl: .managedMulti(controller: controller),
            );
          },
        ),
      ),
    );

    controller.value = {DateTime.utc(2000)};

    await tester.pumpAndSettle();

    expect(controller.contains(DateTime.utc(2000)), true);
  });

  testWidgets('useFRangeSelectionController', (tester) async {
    late FDateSelectionController<(DateTime, DateTime)?> controller;

    await tester.pumpWidget(
      MaterialApp(
        builder: (_, child) => FTheme(data: FTheme.neutral.light.touch, child: child!),
        home: HookBuilder(
          builder: (context) {
            controller = useFRangeSelectionController();
            return FCalendar.grid(
              control: FGridCalendarControl(start: DateTime.utc(1900), end: DateTime.utc(2100)),
              selectionControl: .managedRange(controller: controller),
            );
          },
        ),
      ),
    );

    controller.value = (DateTime.utc(2000), DateTime.utc(2000, 1, 2));

    await tester.pumpAndSettle();

    expect(controller.contains(DateTime.utc(2000)), true);
  });
}

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFGridCalendarController', (tester) async {
    late FGridCalendarController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFGridCalendarController(start: DateTime.utc(1900), end: DateTime.utc(2100));
            return FCalendar.grid(
              control: FGridCalendarControl(controller: controller),
              selectionControl: .managedSingle(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsOneWidget);
    expect(controller.type, FCalendarPickerGridType.day);
  });

  testWidgets('useFGridSplitCalendarController', (tester) async {
    late FGridSplitCalendarController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFGridSplitCalendarController(start: DateTime.utc(1900), end: DateTime.utc(2100));
            return FCalendar.splitGrid(
              control: FGridSplitCalendarControl(controller: controller),
              selectionControl: .managedSingle(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsOneWidget);
    expect(controller.type, FCalendarPickerGridType.day);
  });

  testWidgets('useFWheelCalendarController', (tester) async {
    late FWheelCalendarController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFWheelCalendarController(start: DateTime.utc(1900), end: DateTime.utc(2100));
            return FCalendar.wheel(
              control: FWheelCalendarControl(controller: controller),
              selectionControl: .managedSingle(),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsOneWidget);
    expect(controller.monthYear, false);
  });
}

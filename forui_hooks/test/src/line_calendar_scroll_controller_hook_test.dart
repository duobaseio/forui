import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFLineCalendarScrollController', (tester) async {
    late FLineCalendarScrollController controller;

    await tester.pumpWidget(
      MaterialApp(
        builder: (_, child) => FTheme(data: FTheme.neutral.light.touch, child: child!),
        home: HookBuilder(
          builder: (context) {
            controller = useFLineCalendarScrollController(
              start: DateTime.utc(2024),
              end: DateTime.utc(2026),
              today: DateTime.utc(2025, 6, 15),
            );
            return SizedBox(
              width: 400,
              child: FLineCalendar(scrollControl: .managed(controller: controller)),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    controller.jumpToDate(DateTime.utc(2025, 6, 15));
    await tester.pumpAndSettle();
  });
}

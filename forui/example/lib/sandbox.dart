import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) => FScaffold(
    child: Center(
      child: FCalendar.grid(
        control: FGridCalendarControl(
          start: DateTime.utc(2000),
          today: DateTime.utc(2026, 7, 15),
          end: DateTime.utc(2030),
        ),
        selectionControl: .managedOpenRange(),
      ),
    ),
  );
}

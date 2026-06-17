import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class CalendarPage extends Example {
  CalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2040)),
    selectionControl: .managedSingle(),
  );
}

@RoutePage()
class FixedWeeksCalendarPage extends Example {
  FixedWeeksCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(
      start: DateTime.utc(2000),
      today: DateTime.utc(2026, 2, 15),
      initial: DateTime.utc(2026, 2, 15),
      end: DateTime.utc(2030),
    ),
    selectionControl: .managedSingle(),
    // {@highlight}
    fixedWeeks: true,
    // {@endhighlight}
  );
}

@RoutePage()
class DateCalendarPage extends Example {
  DateCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2040)),
    // {@highlight}
    selectionControl: .managedSingle(),
    // {@endhighlight}
  );
}

@RoutePage()
class SplitGridCalendarPage extends Example {
  SplitGridCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.splitGrid(
    // {@highlight}
    control: FGridSplitCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2040)),
    selectionControl: .managedSingle(),
    // {@endhighlight}
  );
}

@RoutePage()
class WheelCalendarPage extends Example {
  WheelCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.wheel(
    // {@highlight}
    control: FWheelCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2040)),
    // {@endhighlight}
    selectionControl: .managedSingle(),
  );
}

@RoutePage()
class DatesCalendarPage extends Example {
  DatesCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(start: DateTime.utc(2000), today: DateTime.utc(2026, 7, 15), end: DateTime.utc(2030)),
    // {@highlight}
    selectionControl: .managedMulti(initial: {DateTime.utc(2026, 7, 17), DateTime.utc(2026, 7, 20)}),
    // {@endhighlight}
  );
}

@RoutePage()
class RangeCalendarPage extends Example {
  RangeCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(start: DateTime.utc(2000), today: DateTime.utc(2026, 7, 15), end: DateTime.utc(2030)),
    // {@highlight}
    selectionControl: .managedRange(initial: (DateTime.utc(2026, 7, 17), DateTime.utc(2026, 7, 20))),
    // {@endhighlight}
  );
}

@RoutePage()
class NoneCalendarPage extends Example {
  NoneCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2030)),
    // {@highlight}
    selectionControl: .none(),
    // {@endhighlight}
  );
}

@RoutePage()
class UnselectableCalendarPage extends Example {
  UnselectableCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(
      // {@highlight}
      selectable: (date) => !{DateTime.utc(2026, 7, 18), DateTime.utc(2026, 7, 19)}.contains(date),
      // {@endhighlight}
      start: DateTime.utc(2000),
      today: DateTime.utc(2026, 7, 15),
      end: DateTime.utc(2030),
    ),
    selectionControl: .managedMulti(initial: {DateTime.utc(2026, 7, 17), DateTime.utc(2026, 7, 20)}),
  );
}

@RoutePage()
class FooterCalendarPage extends Example {
  FooterCalendarPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 24);

  @override
  Widget example(BuildContext _) => FCalendar.grid(
    control: FGridCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2030)),
    selectionControl: .managedSingle(),
    // {@highlight}
    footerBuilder: (context, controller, selectionController) => Padding(
      padding: const .only(top: 8),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        alignment: .center,
        children: [
          for (final (label, date) in [
            ('Today', controller.today),
            ('In a week', controller.today.add(const Duration(days: 7))),
            ('In a month', controller.today.add(const Duration(days: 30))),
          ])
            FButton(
              variant: .outline,
              size: .sm,
              mainAxisSize: .min,
              onPress: () async {
                selectionController.select(date);
                await controller.animateToDayPicker(date);
              },
              child: Text(label),
            ),
        ],
      ),
    ),
    // {@endhighlight}
  );
}

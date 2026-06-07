/// {@category Widgets}
///
/// A calendar.
///
/// See https://forui.dev/docs/widgets/data/calendar for working examples.
library forui.widgets.calendar;

export '../src/widgets/calendar/calendar.dart';
export '../src/widgets/calendar/calendar_controller.dart' hide InternalFCalendarControl;
export '../src/widgets/calendar/day/day.dart' hide Day;
export '../src/widgets/calendar/day/day_picker.dart' hide DayPicker;
export '../src/widgets/calendar/header.dart' hide Header, SplitHeader;
export '../src/widgets/calendar/month/month.dart' hide Month;
export '../src/widgets/calendar/month/month_picker.dart' hide MonthPicker;
export '../src/widgets/calendar/date_selection_controller.dart'
    hide InternalFDateSelectionControl, ProxyController;
export '../src/widgets/calendar/year/year.dart' hide Year;
export '../src/widgets/calendar/year/year_picker.dart' hide YearPicker;

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/calendar/grid.dart';

part 'calendar_control.dart';

part 'calendar_controller.control.dart';

bool _daySelectable(DateTime start, DateTime date, DateTime end) => !date.isBefore(start) && !date.isAfter(end);

bool _monthSelectable(DateTime start, DateTime date, DateTime end) =>
    !date.isBefore(.utc(start.year, start.month)) && !date.isAfter(.utc(end.year, end.month));

bool _yearSelectable(DateTime start, DateTime date, DateTime end) => start.year <= date.year && date.year <= end.year;

DateTime _clamp(DateTime start, DateTime date, DateTime end) =>
    date.isBefore(start) ? start : (date.isAfter(end) ? end : date);

DateTime _truncate(DateTime date) => .utc(date.year, date.month, date.day);

/// The calendar grid type.
enum FCalendarPickerGridType {
  /// The day grid.
  day,

  /// The month grid.
  month,

  /// The year grid.
  year,
}

/// A controller for a [FCalendar].
///
/// [DateTime]s outside the [start] and [end] dates are unselectable.
///
/// See:
/// * [FDateSelectionController] for controlling date selection.
sealed class FCalendarController extends FChangeNotifier {
  /// The default selectable predicate that always returns true.
  static bool defaultSelectable(DateTime date) => true;

  /// The start date, inclusive. Defaults to `DateTime.utc(1900)`.
  final DateTime start;

  /// Today's date. Defaults to [DateTime.now].
  final DateTime today;

  /// The end date, inclusive. Defaults to `DateTime.utc(2100)`.
  final DateTime end;

  final bool Function(DateTime) _selectable;
  late DateTime _month;

  /// Creates a [FCalendarController].
  FCalendarController({
    this._selectable = defaultSelectable,
    DateTime? start,
    DateTime? today,
    DateTime? initial,
    DateTime? end,
  }) : start = _truncate(start ?? .utc(1900)),
       today = _truncate(today ?? .now()),
       end = _truncate(end ?? .utc(2100)) {
    // [currentMonth] is a normalized first-of-month, so it is checked at month granularity: a mid-month/mid-year start
    // (e.g. Jul 15) still permits showing its own month (Jul 1). The day grid gates individual days via selectable.
    _currentMonth = .utc((initial ?? this.today).year, (initial ?? this.today).month);
    assert(debugCheckInclusiveDateRange(this.start, this.today, this.end));
    assert(GridController.debugCheckInclusiveMonthRange(this.start, _currentMonth, this.end));
  }

  /// The current year and month that the day picker shows.
  DateTime get currentMonth => _month;

  DateTime get _currentMonth => _month;

  set _currentMonth(DateTime value) {
    assert(
      value.isUtc && value == .utc(value.year, value.month),
      '_currentMonth must be a UTC first-of-month, but was $value.',
    );
    _month = value;
  }
}

abstract class _GridCalendarController extends FCalendarController {
  /// The day picker controller.
  late final FCalendarDayPickerController day;

  /// The month picker controller.
  late final FCalendarMonthPickerController month;

  /// The year picker controller.
  late final FCalendarYearPickerController year;

  FCalendarPickerGridType _type = .day;

  _GridCalendarController({super.selectable, super.start, super.today, super.initial, super.end}) {
    day =
        FCalendarDayPickerController(
          start: start,
          end: end,
          initial: _currentMonth,
          selectable: (date) => _daySelectable(start, date, end) && _selectable(date),
        )..addListener(() {
          if (_type == .day) {
            _currentMonth = day.current;
          }
          notifyListeners();
        });
    month = FCalendarMonthPickerController(
      start: start,
      end: end,
      initial: _currentMonth,
      selectable: (date) => _monthSelectable(start, date, end) && _selectable(date),
    )..addListener(notifyListeners);
    year = FCalendarYearPickerController(
      start: start,
      end: end,
      initial: _currentMonth,
      selectable: (date) => _yearSelectable(start, date, end) && _selectable(date),
    )..addListener(notifyListeners);
  }

  /// Shows the day picker on the given [date]'s month, or the current month if [date] is null.
  ///
  /// If the day picker is already shown, its grid animates to the month; otherwise it is shown immediately.
  Future<void> animateToDayPicker([
    DateTime? date,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  ]) async {
    final target = _clamp(start, switch (date) {
      null => _currentMonth,
      final m => .utc(m.year, m.month),
    }, end);

    if (day.controller.hasClients) {
      await day.animateTo(target, duration: duration, curve: curve);
    } else {
      _reattach(day, .day, target);
    }
  }

  /// Shows the day picker on the given [date]'s month, or the current month if [date] is null.
  void jumpToDayPicker([DateTime? date]) {
    final target = _clamp(start, switch (date) {
      null => _currentMonth,
      final m => .utc(m.year, m.month),
    }, end);

    if (day.controller.hasClients) {
      day.jumpTo(target);
    } else {
      _reattach(day, .day, target);
    }
  }

  /// Shows the month picker for the given [date]'s year, or the current year if [date] is null.
  ///
  /// If the month picker is already shown, its grid animates to the year; otherwise it is shown immediately.
  Future<void> animateToMonthPicker([
    DateTime? date,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  ]) async {
    final target = _clamp(start, switch (date) {
      null => _currentMonth,
      final m => .utc(m.year, m.month),
    }, end);

    if (month.controller.hasClients) {
      await month.animateTo(target, duration: duration, curve: curve);
    } else {
      _reattach(month, .month, target);
    }
  }

  /// Shows the month picker for the given [date]'s year, or the current year if [date] is null.
  void jumpToMonthPicker([DateTime? date]) {
    final target = _clamp(start, switch (date) {
      null => _currentMonth,
      final m => .utc(m.year, m.month),
    }, end);

    if (month.controller.hasClients) {
      month.jumpTo(target);
    } else {
      _reattach(month, .month, target);
    }
  }

  /// Shows the year picker for the given [date]'s year, or the current year if [date] is null.
  ///
  /// If the year picker is already shown, its grid animates to the decade; otherwise it is shown immediately.
  Future<void> animateToYearPicker([
    DateTime? date,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  ]) async {
    final target = _clamp(start, switch (date) {
      null => _currentMonth,
      final m => .utc(m.year, m.month),
    }, end);

    if (year.controller.hasClients) {
      await year.animateTo(target, duration: duration, curve: curve);
    } else {
      _reattach(year, .year, target);
    }
  }

  /// Shows the year picker for the given [date]'s year, or the current year if [date] is null.
  void jumpToYearPicker([DateTime? date]) {
    final target = _clamp(start, switch (date) {
      null => _currentMonth,
      final m => .utc(m.year, m.month),
    }, end);

    if (year.controller.hasClients) {
      year.jumpTo(target);
    } else {
      _reattach(year, .year, target);
    }
  }

  void _reattach(GridController controller, FCalendarPickerGridType type, DateTime target) {
    controller.reattach(target);
    if (type == .day) {
      _currentMonth = controller.current;
    }
    _type = type;
    notifyListeners();
  }

  /// The currently shown grid's type.
  FCalendarPickerGridType get type => _type;

  @override
  void dispose() {
    year.dispose();
    month.dispose();
    day.dispose();
    super.dispose();
  }
}

/// A controller for a [FCalendar] that cycles through day/month/year grid pickers.
class FGridCalendarController extends _GridCalendarController {
  /// Creates a [FGridCalendarController].
  FGridCalendarController({super.selectable, super.start, super.today, super.initial, super.end});

  /// Advances the inline grid to show the next picker in the cycle.
  void cycle() {
    switch (type) {
      case .day:
        jumpToMonthPicker();
      case .month:
        jumpToYearPicker(month.current);
      case .year:
        jumpToDayPicker();
    }
  }
}

/// A controller for a [FCalendar] with a split header whose month and year grid pickers are independently togglable.
class FGridSplitCalendarController extends _GridCalendarController {
  /// Creates a [FGridSplitCalendarController].
  FGridSplitCalendarController({super.selectable, super.start, super.today, super.initial, super.end});

  /// Shows the month picker if not currently shown, and the day picker otherwise.
  void toggleMonthPicker() => type == .month ? jumpToDayPicker() : jumpToMonthPicker();

  /// Shows the year picker if not currently shown, and the day picker otherwise.
  void toggleYearPicker() => type == .year ? jumpToDayPicker() : jumpToYearPicker();
}

/// A controller for a [FCalendar] that toggles between a day grid picker and a month-year wheel picker.
class FWheelCalendarController extends FCalendarController {
  /// The day picker controller.
  late final FCalendarDayPickerController day;
  bool _wheel = false;

  /// Creates a [FWheelCalendarController].
  FWheelCalendarController({super.selectable, super.start, super.today, super.initial, super.end}) {
    day =
        FCalendarDayPickerController(
          start: start,
          end: end,
          initial: _currentMonth,
          selectable: (date) => _daySelectable(start, date, end) && _selectable(date),
        )..addListener(() {
          if (!_wheel) {
            _currentMonth = day.current;
          }
          notifyListeners();
        });
  }

  /// Shows the month-year wheel if the day grid is shown, and the day grid otherwise.
  void toggleMonthYearPicker() {
    if (_wheel) {
      day.reattach(_currentMonth);
      _wheel = false;
    } else {
      _wheel = true;
    }
    notifyListeners();
  }

  /// Sets the month-year wheel picker's selected [month] and [year], and updates [currentMonth]. Does nothing if the
  /// month-year wheel picker.
  void setMonthYear(int month, int year) {
    if (!_wheel) {
      return;
    }

    final next = _clamp(.utc(start.year, start.month), .utc(year, month), .utc(end.year, end.month));
    if (next != _currentMonth) {
      _currentMonth = next;
      notifyListeners();
    }
  }

  /// Whether the month-year wheel picker is currently shown.
  bool get monthYear => _wheel;

  @override
  void dispose() {
    day.dispose();
    super.dispose();
  }
}

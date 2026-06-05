import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/calendar/grid.dart';

bool _daySelectable(DateTime start, DateTime date, DateTime end) => !date.isBefore(start) && !date.isAfter(end);

bool _monthSelectable(DateTime start, DateTime date, DateTime end) =>
    !date.isBefore(.utc(start.year, start.month)) && !date.isAfter(.utc(end.year, end.month));

bool _yearSelectable(DateTime start, DateTime date, DateTime end) => start.year <= date.year && date.year <= end.year;

DateTime _clamp(DateTime start, DateTime date, DateTime end) =>
    date.isBefore(start) ? start : (date.isAfter(end) ? end : date);

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
abstract class FCalendarController extends FChangeNotifier {
  /// The default selectable predicate that always returns true.
  static bool defaultSelectable(DateTime date) => true;

  /// The start date, inclusive.
  final DateTime start;

  /// The end date, inclusive.
  final DateTime end;

  /// Today's date.
  final DateTime today;

  final bool Function(DateTime) _selectable;
  late DateTime _current;

  /// Creates a [FCalendarController].
  FCalendarController({
    required DateTime start,
    required DateTime end,
    required DateTime today,
    this._selectable = defaultSelectable,
    DateTime? initial,
  }) : start = .utc(start.year, start.month, start.day),
       end = .utc(end.year, end.month, end.day),
       today = .utc(today.year, today.month, today.day) {
    _current = initial == null ? today : .utc(initial.year, initial.month);
    assert(debugCheckInclusiveDateRange(start, today, end));
    assert(debugCheckInclusiveDateRange(start, _current, end));
  }
}

abstract class _GridCalendarController extends FCalendarController {
  /// The day picker controller.
  late final FCalendarDayPickerController day;

  /// The month picker controller.
  late final FCalendarMonthPickerController month;

  /// The year picker controller.
  late final FCalendarYearPickerController year;

  _GridCalendarController({required super.start, required super.end, required super.today}) {
    day = FCalendarDayPickerController(
      start: start,
      end: end,
      initial: _current,
      selectable: (date) => _daySelectable(start, date, end) && _selectable(date),
    );
    month = FCalendarMonthPickerController(
      start: start,
      end: end,
      initial: _current,
      selectable: (date) => _monthSelectable(start, date, end) && _selectable(date),
    );
    year = FCalendarYearPickerController(
      start: start,
      end: end,
      initial: _current,
      selectable: (date) => _yearSelectable(start, date, end) && _selectable(date),
    );
  }

  @override
  void dispose() {
    year.dispose();
    month.dispose();
    day.dispose();
    super.dispose();
  }
}

/// A controller for an inline [FCalendar] that cycles through day/month/year views in the same grid space.
class FInlineCalendarController extends _GridCalendarController {
  FCalendarPickerGridType _type = .day;

  /// Creates a [FInlineCalendarController].
  FInlineCalendarController({required super.start, required super.end, required super.today}) {
    day.addListener(() {
      if (_type == .day) {
        _current = day.current;
      }
      notifyListeners();
    });
    month.addListener(notifyListeners);
    year.addListener(notifyListeners);
  }

  /// Advances the inline grid to show the next picker in the cycle.
  void cycle() {
    switch (_type) {
      case .day:
        showMonthPicker();
      case .month:
        showYearPicker(month.current);
      case .year:
        showDayPicker();
    }
  }

  /// Shows the day picker for the given [month], or the current month if [month] is null.
  void showDayPicker([DateTime? date]) {
    day.reattach(
      _clamp(start, switch (date) {
        null => _current,
        final m => DateTime.utc(m.year, m.month),
      }, end),
    );
    _current = day.current;
    _type = .day;
    notifyListeners();
  }

  /// Shows the month picker for the given [date]'s year, or the current year if [date] is null.
  void showMonthPicker([DateTime? date]) {
    month.reattach(
      _clamp(start, switch (date) {
        null => _current,
        final m => DateTime.utc(m.year, m.month),
      }, end),
    );
    _type = .month;
    notifyListeners();
  }

  /// Shows the year picker for the given [date]'s year, or the current year if [date] is null.
  void showYearPicker([DateTime? date]) {
    year.reattach(
      _clamp(start, switch (date) {
        null => _current,
        final m => DateTime.utc(m.year, m.month),
      }, end),
    );
    _type = .year;
    notifyListeners();
  }

  /// The currently shown grid's type.
  FCalendarPickerGridType get type => _type;
}

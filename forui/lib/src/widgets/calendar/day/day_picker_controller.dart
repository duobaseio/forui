import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

/// Controls a calendar's day picker.
class FCalendarDayPickerController extends FChangeNotifier {
  /// The start date, inclusive.
  final DateTime start;

  /// The end date, inclusive.
  final DateTime end;

  /// Returns whether a date can be focused.
  final bool Function(DateTime) selectable;

  final PageController _page;
  DateTime? _focused;
  DateTime _month;

  /// Creates a [FCalendarDayPickerController].
  FCalendarDayPickerController({
    required this.start,
    required this.end,
    required this.selectable,
    required DateTime initial,
    this._focused,
  }) : assert(start.isUtc, 'start must be in UTC'),
       assert(end.isUtc, 'end must be in UTC'),
       assert(start.isBefore(end) || start.isAtSameMomentAs(end), 'start must be before or equal to end'),
       assert(debugCheckInclusiveDateRange(start, initial, end)),
       _page = PageController(initialPage: (initial.year - start.year) * 12 + (initial.month - start.month)),
       _month = .utc(initial.year, initial.month);

  /// Moves focus by a day (horizontal) or a week (vertical) in [direction], skipping unselectable days and paging
  /// across months. Does nothing if no selectable day exists in that direction within [start] and [end].
  Future<void> move(
    TraversalDirection direction,
    TextDirection textDirection, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) async {
    final step = switch ((direction, textDirection)) {
      (.left, .ltr) || (.right, .rtl) => -1,
      (.right, .ltr) || (.left, .rtl) => 1,
      (.up, _) => -7,
      (.down, _) => 7,
    };

    var next = (_focused ?? _month).plus(days: step);
    while (!next.isBefore(start) && !next.isAfter(end)) {
      if (selectable(next)) {
        await focus(next, duration: duration, curve: curve);
        return;
      }
      next = next.plus(days: step);
    }
  }

  /// Focuses on [date], animating to its month if it is off the current page, or unfocuses if [date] is null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [date] is not within `[start, end]`.
  Future<void> focus(
    DateTime? date, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) async {
    if (date == _focused) {
      return;
    }

    _focused = date;
    if (date == null || from(date) == from(_month)) {
      notifyListeners();
      return;
    }

    await animateTo(date, duration: duration, curve: curve);
  }

  /// Animates the displayed month to the next month. Does nothing if [hasNext] is false.
  Future<void> next({Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.ease}) async {
    if (hasNext) {
      await animateTo(.utc(_month.year, _month.month + 1), duration: duration, curve: curve);
    }
  }

  /// Animates the displayed month to the previous month. Does nothing if [hasPrevious] is false.
  Future<void> previous({Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.ease}) async {
    if (hasPrevious) {
      await animateTo(.utc(_month.year, _month.month - 1), duration: duration, curve: curve);
    }
  }

  /// Animates the displayed month to the given [date]'s month.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [date] is not within `[start, end]`.
  Future<void> animateTo(
    DateTime date, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.ease,
  }) {
    assert(debugCheckInclusiveDateRange(start, date, end));
    return _page.animateToPage(from(date), duration: duration, curve: curve);
  }

  /// Jumps the displayed month to the given [date]'s month.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [date] is not within `[start, end]`.
  void jumpTo(DateTime date) {
    assert(debugCheckInclusiveDateRange(start, date, end));
    _page.jumpToPage(from(date));
  }

  /// The currently focused date, or null if nothing is focused.
  DateTime? get focused => _focused;

  /// The currently displayed month.
  DateTime get month => _month;

  /// The number of months between [start] and [end], inclusive.
  int get length => from(end) + 1;

  /// Whether the previous month can be displayed.
  bool get hasPrevious => start.truncate(to: DateUnit.months).isBefore(_month);

  /// Whether the next month can be displayed.
  bool get hasNext => _month.isBefore(end.truncate(to: DateUnit.months));

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }
}

@internal
extension InternalFCalendarDayPickerController on FCalendarDayPickerController {
  void onPageChange(int page) {
    final month = to(page);
    if (month == _month) {
      return;
    }

    _month = month;
    if (_focused case final focused? when focused.year != month.year || focused.month != month.month) {
      _focused = findFocused(month, focused.day); // Update keyboard focus into the new month.
    }

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    notifyListeners();
  }

  /// The selectable day in [month] to focus: [preferredDay] if it exists and is selectable, otherwise the first
  /// selectable day. Returns null if no day in [month] is selectable.
  DateTime? findFocused(DateTime month, int preferredDay) {
    final last = month.lastDayOfMonth;
    if (preferredDay <= last.day) {
      final preferred = DateTime.utc(month.year, month.month, preferredDay);
      if (selectable(preferred)) {
        return preferred;
      }
    }

    for (var day = month; !day.isAfter(last); day = day.plus(days: 1)) {
      if (selectable(day)) {
        return day;
      }
    }

    return null;
  }

  int from(DateTime date) => (date.year - start.year) * 12 + (date.month - start.month);

  DateTime to(int page) => .utc(start.year, start.month + page);

  PageController get page => _page;
}

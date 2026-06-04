import 'package:flutter/foundation.dart';

import 'package:sugar/sugar.dart';

part 'date_selection_control.dart';

part 'date_selection_controller.control.dart';

DateTime _truncate(DateTime date) => .utc(date.year, date.month, date.day);

/// A controller that controls date selection.
///
/// All returned [DateTime]s are in UTC timezone with no time component. Given [DateTime]s are truncated and converted to
/// dates in UTC timezone.
///
/// This class should be extended to customize date selection. By default, the following controllers are provided:
/// * [FDateSelectionController.single] for selecting a single date.
/// * [FDateSelectionController.multi] for selecting multiple dates.
/// * [FDateSelectionController.range] for selecting a single range.
abstract class FDateSelectionController<T> extends ValueNotifier<T> {
  /// Creates a [FDateSelectionController] that allows only a single date to be selected, with the given initially
  /// selected date.
  ///
  /// [toggleable] determines whether the controller should unselect a date if it is already selected. Defaults to true.
  static FDateSelectionController<DateTime?> single({DateTime? initial, bool toggleable = true}) =>
      _SingleController(initial: initial, toggleable: toggleable);

  /// Creates a [FDateSelectionController] that allows multiple dates to be selected, with the given initial selected
  /// dates.
  static FDateSelectionController<Set<DateTime>> multi({Set<DateTime> initial = const {}}) =>
      _MultiController(initial: initial);

  /// Creates a [FDateSelectionController] that allows a single range to be selected, with the given initial range.
  ///
  /// Both the start and end dates of the range are inclusive.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the end date is less than start date.
  static FDateSelectionController<(DateTime, DateTime)?> range({(DateTime, DateTime)? initial}) =>
      _RangeController(initial: initial);

  /// Creates a [FDateSelectionController] with the given initial [value].
  FDateSelectionController(super._value);

  /// Returns true if the given [date] is selected.
  bool selected(DateTime date);

  /// Selects the given [date].
  void select(DateTime date);
}

@internal
class ProxyController extends FDateSelectionController<Object?> {
  bool Function(DateTime) _selected;
  ValueChanged<DateTime> _select;

  ProxyController({required this._selected, required this._select}) : super(0);

  void update({required bool Function(DateTime) selected, required ValueChanged<DateTime> select}) {
    _selected = selected;
    _select = select;
    notifyListeners();
  }

  @override
  bool selected(DateTime date) => _selected(date);

  @override
  void select(DateTime date) => _select(date);
}

// The single date controller.
class _SingleController extends FDateSelectionController<DateTime?> {
  final bool toggleable;

  _SingleController({required DateTime? initial, required this.toggleable})
    : super(initial == null ? null : _truncate(initial));

  @override
  bool selected(DateTime date) => value == _truncate(date);

  @override
  void select(DateTime date) {
    date = _truncate(date);
    super.value = (toggleable && value == date) ? null : date;
  }

  @override
  set value(DateTime? value) {
    if (toggleable && super.value == value) {
      super.value = null;
    } else {
      super.value = value == null ? null : _truncate(value);
    }
  }
}

// The multiple dates controller.
final class _MultiController extends FDateSelectionController<Set<DateTime>> {
  _MultiController({Set<DateTime> initial = const {}}) : super(initial.map(_truncate).toSet());

  @override
  bool selected(DateTime date) => value.contains(_truncate(date));

  @override
  void select(DateTime date) {
    final copy = {...value};
    super.value = copy..toggle(_truncate(date));
  }

  @override
  set value(Set<DateTime> value) => super.value = value.map(_truncate).toSet();
}

// The range controller.
final class _RangeController extends FDateSelectionController<(DateTime, DateTime)?> {
  _RangeController({(DateTime, DateTime)? initial})
    : super(initial == null ? null : (_truncate(initial.$1), _truncate(initial.$2))) {
    final range = value;
    assert(
      range == null || (range.$1.isBefore(range.$2) || range.$1.isAtSameMomentAs(range.$2)),
      'start (${range.$1}) must be <= end (${range.$2})',
    );
  }

  @override
  bool selected(DateTime date) {
    if (value case (final first, final last)) {
      final current = _truncate(date);
      return !current.isBefore(first) && !current.isAfter(last);
    }

    return false;
  }

  @override
  void select(DateTime date) {
    date = _truncate(date);
    switch (value) {
      case null:
        super.value = (date, date);

      case (final first, final last) when date == first || date == last:
        super.value = null;

      case (final first, final last) when date.isBefore(first):
        super.value = (date, last);

      case (final first, _):
        super.value = (first, date);
    }
  }

  @override
  set value((DateTime, DateTime)? value) =>
      super.value = value == null ? null : (_truncate(value.$1), _truncate(value.$2));
}

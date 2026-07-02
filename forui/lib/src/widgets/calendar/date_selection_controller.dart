import 'package:flutter/foundation.dart';

import 'package:sugar/sugar.dart';

part 'date_selection_control.dart';

part 'date_selection_controller.control.dart';

DateTime? _selectSingle(DateTime? current, DateTime date, bool toggleable) {
  date = _truncate(date);
  return (toggleable && current == date) ? null : date;
}

Set<DateTime> _selectMulti(Set<DateTime> current, DateTime date) => {...current}..toggle(_truncate(date));

(DateTime, DateTime)? _selectRange((DateTime, DateTime)? current, DateTime date) {
  date = _truncate(date);
  return switch (current) {
    null => (date, date),
    (final first, final last) when date == first || date == last => null,
    (final first, final last) when date.isBefore(first) => (date, last),
    (final first, _) => (first, date),
  };
}

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
  bool contains(DateTime date);

  /// Selects the given [date].
  void select(DateTime date);
}

// The lifted single date controller.
class _LiftedSingleController extends FDateSelectionController<DateTime?> {
  ValueChanged<DateTime?> _onChange;
  bool _toggleable;

  _LiftedSingleController({required DateTime? value, required this._onChange, required this._toggleable})
    : super(value == null ? null : _truncate(value));

  void update({required DateTime? value, required ValueChanged<DateTime?> onChange, required bool toggleable}) {
    _onChange = onChange;
    _toggleable = toggleable;
    super.value = value == null ? null : _truncate(value);
  }

  @override
  bool contains(DateTime date) => value == _truncate(date);

  @override
  void select(DateTime date) => _onChange(_selectSingle(value, date, _toggleable));

  @override
  set value(DateTime? value) {
    final next = value == null ? null : _truncate(value);
    if (super.value != next) {
      _onChange(next);
    }
  }
}

// The lifted multiple dates controller.
class _LiftedMultiController extends FDateSelectionController<Set<DateTime>> {
  ValueChanged<Set<DateTime>> _onChange;

  _LiftedMultiController({required Set<DateTime> value, required this._onChange}) : super(value.map(_truncate).toSet());

  void update({required Set<DateTime> value, required ValueChanged<Set<DateTime>> onChange}) {
    _onChange = onChange;
    super.value = value.map(_truncate).toSet();
  }

  @override
  bool contains(DateTime date) => value.contains(_truncate(date));

  @override
  void select(DateTime date) => _onChange(_selectMulti(value, date));

  @override
  set value(Set<DateTime> value) {
    final next = value.map(_truncate).toSet();
    if (!setEquals(super.value, next)) {
      _onChange(next);
    }
  }
}

// The lifted range controller.
class _LiftedRangeController extends FDateSelectionController<(DateTime, DateTime)?> {
  ValueChanged<(DateTime, DateTime)?> _onChange;

  _LiftedRangeController({required (DateTime, DateTime)? value, required this._onChange})
    : super(value == null ? null : (_truncate(value.$1), _truncate(value.$2)));

  void update({required (DateTime, DateTime)? value, required ValueChanged<(DateTime, DateTime)?> onChange}) {
    _onChange = onChange;
    super.value = value == null ? null : (_truncate(value.$1), _truncate(value.$2));
  }

  @override
  bool contains(DateTime date) {
    if (value case (final first, final last)) {
      final current = _truncate(date);
      return !current.isBefore(first) && !current.isAfter(last);
    }

    return false;
  }

  @override
  void select(DateTime date) => _onChange(_selectRange(value, date));

  @override
  set value((DateTime, DateTime)? value) {
    final next = value == null ? null : (_truncate(value.$1), _truncate(value.$2));
    if (super.value != next) {
      _onChange(next);
    }
  }
}

// The display-only controller used by [FDateSelectionControl.none]. Nothing is ever selected.
class _NoneController extends FDateSelectionController<Object?> {
  _NoneController() : super(null);

  @override
  bool contains(DateTime date) => false;

  @override
  void select(DateTime date) {}
}

// The single date controller.
class _SingleController extends FDateSelectionController<DateTime?> {
  final bool toggleable;

  _SingleController({required DateTime? initial, required this.toggleable})
    : super(initial == null ? null : _truncate(initial));

  @override
  bool contains(DateTime date) => value == _truncate(date);

  @override
  void select(DateTime date) => super.value = _selectSingle(value, date, toggleable);

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
  bool contains(DateTime date) => value.contains(_truncate(date));

  @override
  void select(DateTime date) => super.value = _selectMulti(value, date);

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
  bool contains(DateTime date) {
    if (value case (final first, final last)) {
      final current = _truncate(date);
      return !current.isBefore(first) && !current.isAfter(last);
    }

    return false;
  }

  @override
  void select(DateTime date) => super.value = _selectRange(value, date);

  @override
  set value((DateTime, DateTime)? value) =>
      super.value = value == null ? null : (_truncate(value.$1), _truncate(value.$2));
}

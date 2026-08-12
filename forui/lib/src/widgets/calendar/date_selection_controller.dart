import 'package:flutter/foundation.dart';

import 'package:sugar/sugar.dart';

part 'date_selection_control.dart';

part 'date_selection_controller.control.dart';

DateTime? _selectSingle(DateTime? current, DateTime date, bool toggleable) {
  date = date._truncate();
  return (toggleable && current == date) ? null : date;
}

Set<DateTime> _selectMulti(Set<DateTime> current, DateTime date) => {...current}..toggle(date._truncate());

(DateTime, DateTime)? _selectRange((DateTime, DateTime)? current, DateTime date) {
  date = date._truncate();
  return switch (current) {
    null => (date, date),
    (final first, final last) when date == first || date == last => null,
    (final first, final last) when date.isBefore(first) => (date, last),
    (final first, _) => (first, date),
  };
}

(DateTime?, DateTime?) _selectOpenRange((DateTime?, DateTime?) current, DateTime date, bool startFirst) {
  date = date._truncate();
  return switch (current) {
    (final start?, null) when date.isBefore(start) => (date, null),
    (final start?, null) => (start, date),
    (null, final end?) when end.isBefore(date) => (null, date),
    (null, final end?) => (date, end),
    _ when startFirst => (date, null),
    _ => (null, date),
  };
}

/// A controller that controls date selection.
///
/// All returned [DateTime]s are in UTC timezone with no time component. Given [DateTime]s are truncated and converted to
/// dates in UTC timezone.
///
/// This class should be extended to customize date selection. By default, the following controllers are provided:
/// * [FDateSelectionController.single] for selecting a single date.
/// * [FDateSelectionController.multi] for selecting multiple dates.
/// * [FDateSelectionController.range] for selecting a single, always complete range.
/// * [FDateSelectionController.openRange] for selecting a single, open-bound range.
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
  /// Both the start and end dates of the range are inclusive. Unlike [openRange], selecting the first date returns a
  /// complete range, `(first date, first date)`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the end date is less than start date.
  ///
  /// See:
  /// * [openRange] for partial range selection.
  static FDateSelectionController<(DateTime, DateTime)?> range({(DateTime, DateTime)? initial}) =>
      _RangeController(initial: initial);

  /// Creates a [FDateSelectionController] that allows a range with an open bound to be selected, with the given initial
  /// range.
  ///
  /// Both the start and end dates of the range are inclusive. Unlike [range], selecting the first date returns an
  /// open-bound range, `(first date, null)`/`(null, first date)`, depending on [startFirst].
  ///
  /// [startFirst] determines whether the first selected date is the range's start or end. Defaults to true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both bounds are given and the end date is less than start date.
  ///
  /// See:
  /// * [range] for an always complete range selection.
  static FDateSelectionController<(DateTime?, DateTime?)> openRange({
    (DateTime?, DateTime?) initial = (null, null),
    bool startFirst = true,
  }) => _OpenRangeController(initial: initial, startFirst: startFirst);

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
    : super(value?._truncate());

  void update({required DateTime? value, required ValueChanged<DateTime?> onChange, required bool toggleable}) {
    _onChange = onChange;
    _toggleable = toggleable;
    super.value = value?._truncate();
  }

  @override
  bool contains(DateTime date) => value == date._truncate();

  @override
  void select(DateTime date) => _onChange(_selectSingle(value, date, _toggleable));

  @override
  set value(DateTime? value) {
    final next = value?._truncate();
    if (super.value != next) {
      _onChange(next);
    }
  }
}

// The lifted multiple dates controller.
class _LiftedMultiController extends FDateSelectionController<Set<DateTime>> {
  ValueChanged<Set<DateTime>> _onChange;

  _LiftedMultiController({required Set<DateTime> value, required this._onChange})
    : super(value.map((date) => date._truncate()).toSet());

  void update({required Set<DateTime> value, required ValueChanged<Set<DateTime>> onChange}) {
    _onChange = onChange;
    super.value = value.map((date) => date._truncate()).toSet();
  }

  @override
  bool contains(DateTime date) => value.contains(date._truncate());

  @override
  void select(DateTime date) => _onChange(_selectMulti(value, date));

  @override
  set value(Set<DateTime> value) {
    final next = value.map((date) => date._truncate()).toSet();
    if (!setEquals(super.value, next)) {
      _onChange(next);
    }
  }
}

// The lifted range controller.
class _LiftedRangeController extends FDateSelectionController<(DateTime, DateTime)?> {
  ValueChanged<(DateTime, DateTime)?> _onChange;

  _LiftedRangeController({required (DateTime, DateTime)? value, required this._onChange})
    : super(value == null ? null : (value.$1._truncate(), value.$2._truncate()));

  void update({required (DateTime, DateTime)? value, required ValueChanged<(DateTime, DateTime)?> onChange}) {
    _onChange = onChange;
    super.value = value == null ? null : (value.$1._truncate(), value.$2._truncate());
  }

  @override
  bool contains(DateTime date) {
    if (value case (final first, final last)) {
      final current = date._truncate();
      return !current.isBefore(first) && !current.isAfter(last);
    }

    return false;
  }

  @override
  void select(DateTime date) => _onChange(_selectRange(value, date));

  @override
  set value((DateTime, DateTime)? value) {
    final next = value == null ? null : (value.$1._truncate(), value.$2._truncate());
    if (super.value != next) {
      _onChange(next);
    }
  }
}

// The lifted open range controller.
class _LiftedOpenRangeController extends FDateSelectionController<(DateTime?, DateTime?)> {
  ValueChanged<(DateTime?, DateTime?)> _onChange;
  bool _startFirst;

  _LiftedOpenRangeController({
    required (DateTime?, DateTime?) value,
    required this._onChange,
    required this._startFirst,
  }) : super((value.$1?._truncate(), value.$2?._truncate()));

  void update({
    required (DateTime?, DateTime?) value,
    required ValueChanged<(DateTime?, DateTime?)> onChange,
    required bool startFirst,
  }) {
    _onChange = onChange;
    _startFirst = startFirst;
    super.value = (value.$1?._truncate(), value.$2?._truncate());
  }

  @override
  bool contains(DateTime date) {
    final current = date._truncate();
    return switch (value) {
      (final start?, final end?) => !current.isBefore(start) && !current.isAfter(end),
      (final start?, _) => current == start,
      (_, final end?) => current == end,
      _ => false,
    };
  }

  @override
  void select(DateTime date) => _onChange(_selectOpenRange(value, date, _startFirst));

  @override
  set value((DateTime?, DateTime?) value) {
    final next = (value.$1?._truncate(), value.$2?._truncate());
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

  _SingleController({required DateTime? initial, required this.toggleable}) : super(initial?._truncate());

  @override
  bool contains(DateTime date) => value == date._truncate();

  @override
  void select(DateTime date) => super.value = _selectSingle(value, date, toggleable);

  @override
  set value(DateTime? value) {
    if (toggleable && super.value == value) {
      super.value = null;
    } else {
      super.value = value?._truncate();
    }
  }
}

// The multiple dates controller.
final class _MultiController extends FDateSelectionController<Set<DateTime>> {
  _MultiController({Set<DateTime> initial = const {}}) : super(initial.map((date) => date._truncate()).toSet());

  @override
  bool contains(DateTime date) => value.contains(date._truncate());

  @override
  void select(DateTime date) => super.value = _selectMulti(value, date);

  @override
  set value(Set<DateTime> value) => super.value = value.map((date) => date._truncate()).toSet();
}

// The range controller.
final class _RangeController extends FDateSelectionController<(DateTime, DateTime)?> {
  _RangeController({(DateTime, DateTime)? initial})
    : super(initial == null ? null : (initial.$1._truncate(), initial.$2._truncate())) {
    final range = value;
    assert(
      range == null || (range.$1.isBefore(range.$2) || range.$1.isAtSameMomentAs(range.$2)),
      'start (${range.$1}) must be <= end (${range.$2})',
    );
  }

  @override
  bool contains(DateTime date) {
    if (value case (final first, final last)) {
      final current = date._truncate();
      return !current.isBefore(first) && !current.isAfter(last);
    }

    return false;
  }

  @override
  void select(DateTime date) => super.value = _selectRange(value, date);

  @override
  set value((DateTime, DateTime)? value) =>
      super.value = value == null ? null : (value.$1._truncate(), value.$2._truncate());
}

// The open range controller.
final class _OpenRangeController extends FDateSelectionController<(DateTime?, DateTime?)> {
  final bool startFirst;

  _OpenRangeController({required (DateTime?, DateTime?) initial, required this.startFirst})
    : super((initial.$1?._truncate(), initial.$2?._truncate())) {
    final (start, end) = value;
    assert(start == null || end == null || !end.isBefore(start), 'start ($start) must be <= end ($end)');
  }

  @override
  bool contains(DateTime date) {
    final current = date._truncate();
    return switch (value) {
      (final start?, final end?) => !current.isBefore(start) && !current.isAfter(end),
      (final start?, _) => current == start,
      (_, final end?) => current == end,
      _ => false,
    };
  }

  @override
  void select(DateTime date) => super.value = _selectOpenRange(value, date, startFirst);

  @override
  set value((DateTime?, DateTime?) value) => super.value = (value.$1?._truncate(), value.$2?._truncate());
}

extension on DateTime {
  DateTime _truncate() => .utc(year, month, day);
}

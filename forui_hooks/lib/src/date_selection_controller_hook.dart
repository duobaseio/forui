import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

typedef _Create<T> = FDateSelectionController<T> Function(_DateSelectionControllerHook<T>);

/// Creates a [FDateSelectionController] that allows only a single date to be selected and is automatically disposed.
///
/// [toggleable] determines whether the controller should unselect a date if it is already selected. Defaults to true.
FDateSelectionController<DateTime?> useFDateSelectionController({
  DateTime? initial,
  bool toggleable = true,
  List<Object?>? keys,
}) => use(
  _DateSelectionControllerHook<DateTime?>(
    value: initial,
    toggleable: toggleable,
    debugLabel: 'useFDateSelectionController',
    create: (hook) => .single(initial: hook.value, toggleable: hook.toggleable),
    keys: keys,
  ),
);

/// Creates a [FDateSelectionController] that allows multiple dates to be selected and is automatically disposed.
FDateSelectionController<Set<DateTime>> useFDatesSelectionController({
  Set<DateTime> initial = const {},
  List<Object?>? keys,
}) => use(
  _DateSelectionControllerHook<Set<DateTime>>(
    value: initial,
    debugLabel: 'useFDatesSelectionController',
    create: (hook) => .multi(initial: hook.value),
    keys: keys,
  ),
);

/// Creates a [FDateSelectionController] that allows a single range to be selected and is automatically disposed.
///
/// Both the start and end dates of the range are inclusive.
///
/// ## Contract
/// Throws [AssertionError] if the end date is less than the start date.
FDateSelectionController<(DateTime, DateTime)?> useFRangeSelectionController({
  (DateTime, DateTime)? initial,
  List<Object?>? keys,
}) => use(
  _DateSelectionControllerHook<(DateTime, DateTime)?>(
    value: initial,
    debugLabel: 'useFRangeSelectionController',
    create: (hook) => .range(initial: hook.value),
    keys: keys,
  ),
);

class _DateSelectionControllerHook<T> extends Hook<FDateSelectionController<T>> {
  final T value;
  final bool toggleable;
  final String _debugLabel;
  final _Create<T> _create;

  const _DateSelectionControllerHook({
    required this.value,
    required this._debugLabel,
    required this._create,
    this.toggleable = true,
    super.keys,
  });

  @override
  _DateSelectionControllerHookState<T> createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('initialSelection', value))
      ..add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable'));
  }
}

class _DateSelectionControllerHookState<T> extends HookState<FDateSelectionController<T>, _DateSelectionControllerHook<T>> {
  late final FDateSelectionController<T> _controller;

  @override
  void initHook() {
    _controller = hook._create(hook);
  }

  @override
  FDateSelectionController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}

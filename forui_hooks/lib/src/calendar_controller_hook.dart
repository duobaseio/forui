import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

typedef _Create<C extends FCalendarController> = C Function(_CalendarControllerHook<C>);

/// Creates a [FGridCalendarController] that cycles through the day, month and year grid pickers and is automatically
/// disposed.
///
/// [selectable] determines which dates can be selected and always returns true if not given.
FGridCalendarController useFGridCalendarController({
  bool Function(DateTime)? selectable,
  DateTime? start,
  DateTime? today,
  DateTime? initial,
  DateTime? end,
  List<Object?>? keys,
}) => use(
  _CalendarControllerHook<FGridCalendarController>(
    selectable: selectable,
    start: start,
    today: today,
    initial: initial,
    end: end,
    debugLabel: 'useFGridCalendarController',
    create: (hook) => FGridCalendarController(
      selectable: hook.selectable ?? FCalendarController.defaultSelectable,
      start: hook.start,
      today: hook.today,
      initial: hook.initial,
      end: hook.end,
    ),
    keys: keys,
  ),
);

/// Creates a [FGridSplitCalendarController] whose month and year grid pickers are independently togglable and is
/// automatically disposed.
///
/// [selectable] determines which dates can be selected and always returns true if not given.
FGridSplitCalendarController useFGridSplitCalendarController({
  bool Function(DateTime)? selectable,
  DateTime? start,
  DateTime? today,
  DateTime? initial,
  DateTime? end,
  List<Object?>? keys,
}) => use(
  _CalendarControllerHook<FGridSplitCalendarController>(
    selectable: selectable,
    start: start,
    today: today,
    initial: initial,
    end: end,
    debugLabel: 'useFGridSplitCalendarController',
    create: (hook) => FGridSplitCalendarController(
      selectable: hook.selectable ?? FCalendarController.defaultSelectable,
      start: hook.start,
      today: hook.today,
      initial: hook.initial,
      end: hook.end,
    ),
    keys: keys,
  ),
);

/// Creates a [FWheelCalendarController] that toggles between a day grid picker and a month-year wheel picker and is
/// automatically disposed.
///
/// [selectable] determines which dates can be selected and always returns true if not given.
FWheelCalendarController useFWheelCalendarController({
  bool Function(DateTime)? selectable,
  DateTime? start,
  DateTime? today,
  DateTime? initial,
  DateTime? end,
  List<Object?>? keys,
}) => use(
  _CalendarControllerHook<FWheelCalendarController>(
    selectable: selectable,
    start: start,
    today: today,
    initial: initial,
    end: end,
    debugLabel: 'useFWheelCalendarController',
    create: (hook) => FWheelCalendarController(
      selectable: hook.selectable ?? FCalendarController.defaultSelectable,
      start: hook.start,
      today: hook.today,
      initial: hook.initial,
      end: hook.end,
    ),
    keys: keys,
  ),
);

class _CalendarControllerHook<C extends FCalendarController> extends Hook<C> {
  final bool Function(DateTime)? selectable;
  final DateTime? start;
  final DateTime? today;
  final DateTime? initial;
  final DateTime? end;
  final String _debugLabel;
  final _Create<C> _create;

  const _CalendarControllerHook({
    required this.selectable,
    required this.start,
    required this.today,
    required this.initial,
    required this.end,
    required this._debugLabel,
    required this._create,
    super.keys,
  });

  @override
  _CalendarControllerHookState<C> createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('initial', initial))
      ..add(DiagnosticsProperty('end', end));
  }
}

class _CalendarControllerHookState<C extends FCalendarController>
    extends HookState<C, _CalendarControllerHook<C>> {
  late final C _controller;

  @override
  void initHook() {
    _controller = hook._create(hook);
  }

  @override
  C build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}

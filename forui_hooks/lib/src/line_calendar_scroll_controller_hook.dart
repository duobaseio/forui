import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FLineCalendarScrollController] that is automatically disposed.
FLineCalendarScrollController useFLineCalendarScrollController({
  DateTime? start,
  DateTime? end,
  DateTime? today,
  DateTime? initialDate,
  AlignmentDirectional initialAlignment = .center,
  bool keepScrollOffset = true,
  String? debugLabel,
  List<Object?>? keys,
}) => use(
  _LineCalendarScrollControllerHook(
    start: start,
    end: end,
    today: today,
    initialDate: initialDate,
    initialAlignment: initialAlignment,
    keepScrollOffset: keepScrollOffset,
    debugLabel: debugLabel,
    keys: keys,
  ),
);

class _LineCalendarScrollControllerHook extends Hook<FLineCalendarScrollController> {
  final DateTime? start;
  final DateTime? end;
  final DateTime? today;
  final DateTime? initialDate;
  final AlignmentDirectional initialAlignment;
  final bool keepScrollOffset;
  final String? debugLabel;

  const _LineCalendarScrollControllerHook({
    required this.start,
    required this.end,
    required this.today,
    required this.initialDate,
    required this.initialAlignment,
    required this.keepScrollOffset,
    required this.debugLabel,
    super.keys,
  });

  @override
  _LineCalendarScrollControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('initialDate', initialDate))
      ..add(DiagnosticsProperty('initialAlignment', initialAlignment))
      ..add(FlagProperty('keepScrollOffset', value: keepScrollOffset, ifTrue: 'keepScrollOffset'))
      ..add(StringProperty('debugLabel', debugLabel));
  }
}

class _LineCalendarScrollControllerHookState
    extends HookState<FLineCalendarScrollController, _LineCalendarScrollControllerHook> {
  late final _controller = FLineCalendarScrollController(
    start: hook.start,
    end: hook.end,
    today: hook.today,
    initialDate: hook.initialDate,
    initialAlignment: hook.initialAlignment,
    keepScrollOffset: hook.keepScrollOffset,
    debugLabel: hook.debugLabel,
  );

  @override
  FLineCalendarScrollController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFLineCalendarScrollController';
}

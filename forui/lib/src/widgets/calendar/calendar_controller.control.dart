// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'calendar_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFCalendarControl<T> on FCalendarControl<T> {
  FCalendarController<T> create(VoidCallback callback) => createController()..addListener(callback);

  (FCalendarController<T>, bool) update(
    FCalendarControl<T> old,
    FCalendarController<T> controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FCalendarController<T> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FCalendarControlMixin<T> {
  /// Creates a [FCalendarController<T>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FCalendarController<T> createController();
  void _dispose(FCalendarController<T> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FCalendarController<T> _default(FCalendarControl<T> old, FCalendarController<T> controller, VoidCallback callback) =>
      controller;
}
mixin _$FCalendarManagedControlMixin<T> on Diagnosticable, FCalendarControl<T> {
  FCalendarController<T>? get controller;
  T? get initial;
  Predicate<DateTime>? get selectable;
  bool get truncateAndStripTimezone;
  ValueChanged<T>? get onChange;
  @override
  (FCalendarController<T>, bool) _update(
    FCalendarControl<T> old,
    FCalendarController<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FCalendarManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FCalendarManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FCalendarManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final FCalendarManagedControl<T> old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FCalendarController<T> controller, VoidCallback callback) {
    if (this.controller != null) {
      controller.removeListener(callback);
    } else {
      controller.dispose();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller, level: .debug))
      ..add(DiagnosticsProperty('initial', initial, level: .debug))
      ..add(DiagnosticsProperty('selectable', selectable, level: .debug))
      ..add(
        FlagProperty(
          'truncateAndStripTimezone',
          value: truncateAndStripTimezone,
          ifTrue: 'truncateAndStripTimezone',
          level: .debug,
        ),
      )
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarManagedControl<T> &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          selectable == other.selectable &&
          truncateAndStripTimezone == other.truncateAndStripTimezone &&
          onChange == other.onChange);

  @override
  int get hashCode =>
      controller.hashCode ^
      initial.hashCode ^
      selectable.hashCode ^
      truncateAndStripTimezone.hashCode ^
      onChange.hashCode;
}
mixin _$_LiftedMixin<T> on Diagnosticable, FCalendarControl<T> {
  Predicate<DateTime> get selectable;
  Predicate<DateTime> get selected;
  ValueChanged<DateTime> get select;
  @override
  (FCalendarController<T>, bool) _update(
    FCalendarControl<T> old,
    FCalendarController<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Lifted
      case FCalendarManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FCalendarManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FCalendarController<T> controller);
  @override
  void _dispose(FCalendarController<T> controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectable', selectable, level: .debug))
      ..add(DiagnosticsProperty('selected', selected, level: .debug))
      ..add(DiagnosticsProperty('select', select, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          selectable == other.selectable &&
          selected == other.selected &&
          select == other.select);

  @override
  int get hashCode => selectable.hashCode ^ selected.hashCode ^ select.hashCode;
}

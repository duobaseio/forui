// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'line_calendar_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFLineCalendarControl on FLineCalendarControl {
  FCalendarController<DateTime?> create(VoidCallback callback) => createController()..addListener(callback);

  (FCalendarController<DateTime?>, bool) update(
    FLineCalendarControl old,
    FCalendarController<DateTime?> controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FCalendarController<DateTime?> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FLineCalendarControlMixin {
  /// Creates a [FCalendarController<DateTime?>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FCalendarController<DateTime?> createController();
  void _dispose(FCalendarController<DateTime?> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FCalendarController<DateTime?> _default(
    FLineCalendarControl old,
    FCalendarController<DateTime?> controller,
    VoidCallback callback,
  ) => controller;
}
mixin _$FLineCalendarManagedControlMixin on Diagnosticable, FLineCalendarControl {
  FCalendarController<DateTime?>? get controller;
  DateTime? get initial;
  Predicate<DateTime>? get selectable;
  bool? get toggleable;
  ValueChanged<DateTime?>? get onChange;
  @override
  (FCalendarController<DateTime?>, bool) _update(
    FLineCalendarControl old,
    FCalendarController<DateTime?> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FLineCalendarManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FLineCalendarManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FLineCalendarManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FCalendarController<DateTime?> controller, VoidCallback callback) {
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
      ..add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLineCalendarManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          selectable == other.selectable &&
          toggleable == other.toggleable &&
          onChange == other.onChange);

  @override
  int get hashCode =>
      controller.hashCode ^ initial.hashCode ^ selectable.hashCode ^ toggleable.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FLineCalendarControl {
  DateTime? get date;
  ValueChanged<DateTime?> get onChange;
  Predicate<DateTime> get selectable;
  @override
  (FCalendarController<DateTime?>, bool) _update(
    FLineCalendarControl old,
    FCalendarController<DateTime?> controller,
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
      case FLineCalendarManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FLineCalendarManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FCalendarController<DateTime?> controller);
  @override
  void _dispose(FCalendarController<DateTime?> controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('date', date, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('selectable', selectable, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          onChange == other.onChange &&
          selectable == other.selectable);

  @override
  int get hashCode => date.hashCode ^ onChange.hashCode ^ selectable.hashCode;
}

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
extension InternalFCalendarControl on FCalendarControl {
  FCalendarController create(VoidCallback callback) => createController()..addListener(callback);

  (FCalendarController, bool) update(FCalendarControl old, FCalendarController controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(FCalendarController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FCalendarControlMixin {
  /// Creates a [FCalendarController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FCalendarController createController();
  void _dispose(FCalendarController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FCalendarController _default(FCalendarControl old, FCalendarController controller, VoidCallback callback) =>
      controller;
}
mixin _$FCalendarManagedControlMixin on Diagnosticable, FCalendarControl {
  FCalendarController? get controller;
  bool Function(DateTime)? get selectable;
  DateTime? get start;
  DateTime? get today;
  DateTime? get initial;
  DateTime? get end;
  @override
  (FCalendarController, bool) _update(FCalendarControl old, FCalendarController controller, VoidCallback callback) {
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

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final FCalendarManagedControl old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FCalendarController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('selectable', selectable, level: .debug))
      ..add(DiagnosticsProperty('start', start, level: .debug))
      ..add(DiagnosticsProperty('today', today, level: .debug))
      ..add(DiagnosticsProperty('initial', initial, level: .debug))
      ..add(DiagnosticsProperty('end', end, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          selectable == other.selectable &&
          start == other.start &&
          today == other.today &&
          initial == other.initial &&
          end == other.end);

  @override
  int get hashCode =>
      controller.hashCode ^ selectable.hashCode ^ start.hashCode ^ today.hashCode ^ initial.hashCode ^ end.hashCode;
}

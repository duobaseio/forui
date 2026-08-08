// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'line_calendar_scroll_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFLineCalendarScrollControl on FLineCalendarScrollControl {
  FLineCalendarScrollController create(VoidCallback callback) => createController()..addListener(callback);

  (FLineCalendarScrollController, bool) update(
    FLineCalendarScrollControl old,
    FLineCalendarScrollController controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FLineCalendarScrollController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FLineCalendarScrollControlMixin {
  /// Creates a [FLineCalendarScrollController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FLineCalendarScrollController createController();
  void _dispose(FLineCalendarScrollController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FLineCalendarScrollController _default(
    FLineCalendarScrollControl old,
    FLineCalendarScrollController controller,
    VoidCallback callback,
  ) => controller;
}
mixin _$FLineCalendarScrollManagedControlMixin on Diagnosticable, FLineCalendarScrollControl {
  FLineCalendarScrollController? get controller;
  DateTime? get start;
  DateTime? get end;
  DateTime? get today;
  DateTime? get initialDate;
  AlignmentDirectional? get initialAlignment;
  ValueChanged<double>? get onChange;
  @override
  (FLineCalendarScrollController, bool) _update(
    FLineCalendarScrollControl old,
    FLineCalendarScrollController controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FLineCalendarScrollManagedControl(controller: final old?)
          when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FLineCalendarScrollManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FLineCalendarScrollManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(FLineCalendarScrollController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('start', start, level: .debug))
      ..add(DiagnosticsProperty('end', end, level: .debug))
      ..add(DiagnosticsProperty('today', today, level: .debug))
      ..add(DiagnosticsProperty('initialDate', initialDate, level: .debug))
      ..add(DiagnosticsProperty('initialAlignment', initialAlignment, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLineCalendarScrollManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          start == other.start &&
          end == other.end &&
          today == other.today &&
          initialDate == other.initialDate &&
          initialAlignment == other.initialAlignment &&
          onChange == other.onChange);

  @override
  int get hashCode =>
      controller.hashCode ^
      start.hashCode ^
      end.hashCode ^
      today.hashCode ^
      initialDate.hashCode ^
      initialAlignment.hashCode ^
      onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FLineCalendarScrollControl {
  @override
  (FLineCalendarScrollController, bool) _update(
    FLineCalendarScrollControl old,
    FLineCalendarScrollController controller,
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
      case FLineCalendarScrollManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FLineCalendarScrollManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FLineCalendarScrollController controller);
  @override
  void _dispose(FLineCalendarScrollController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || (other is _Lifted && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

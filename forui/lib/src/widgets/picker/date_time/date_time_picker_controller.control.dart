// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'date_time_picker_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFDateTimePickerControl on FDateTimePickerControl {
  FDateTimePickerController create(
    VoidCallback callback,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) => createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback);

  (FDateTimePickerController, bool) update(
    FDateTimePickerControl old,
    FDateTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) => _update(old, controller, callback, format, dayInterval, hourInterval, minuteInterval);

  void dispose(FDateTimePickerController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FDateTimePickerControlMixin {
  /// Creates a [FDateTimePickerController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FDateTimePickerController createController(DateFormat format, int dayInterval, int hourInterval, int minuteInterval);
  void _dispose(FDateTimePickerController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FDateTimePickerController _default(
    FDateTimePickerControl old,
    FDateTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) => controller;
}
mixin _$FDateTimePickerManagedControlMixin on Diagnosticable, FDateTimePickerControl {
  FDateTimePickerController? get controller;
  DateTime? get initial;
  ValueChanged<DateTime>? get onChange;
  @override
  (FDateTimePickerController, bool) _update(
    FDateTimePickerControl old,
    FDateTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, format, dayInterval, hourInterval, minuteInterval), false);

      // External (Controller A) -> External (Controller B)
      case FDateTimePickerManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      // Internal -> External
      case FDateTimePickerManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      // External -> Internal
      case FDateTimePickerManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, format, dayInterval, hourInterval, minuteInterval), false);
    }
  }

  @override
  void _dispose(FDateTimePickerController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDateTimePickerManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FDateTimePickerControl {
  DateTime get dateTime;
  ValueChanged<DateTime> get onChange;
  Duration get duration;
  Curve get curve;
  @override
  (FDateTimePickerController, bool) _update(
    FDateTimePickerControl old,
    FDateTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, format, dayInterval, hourInterval, minuteInterval), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, format, dayInterval, hourInterval, minuteInterval);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      // External -> Lifted
      case FDateTimePickerManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      // Internal -> Lifted
      case FDateTimePickerManagedControl():
        controller.dispose();
        return (createController(format, dayInterval, hourInterval, minuteInterval)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, format, dayInterval, hourInterval, minuteInterval), false);
    }
  }

  void _updateController(
    FDateTimePickerController controller,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  );
  @override
  void _dispose(FDateTimePickerController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('dateTime', dateTime, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          dateTime == other.dateTime &&
          onChange == other.onChange &&
          duration == other.duration &&
          curve == other.curve);

  @override
  int get hashCode => dateTime.hashCode ^ onChange.hashCode ^ duration.hashCode ^ curve.hashCode;
}

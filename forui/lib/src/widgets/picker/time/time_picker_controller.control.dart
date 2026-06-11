// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'time_picker_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFTimePickerControl on FTimePickerControl {
  FTimePickerController create(VoidCallback callback, DateFormat format, int hourInterval, int minuteInterval) =>
      createController(format, hourInterval, minuteInterval)..addListener(callback);

  (FTimePickerController, bool) update(
    FTimePickerControl old,
    FTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  ) => _update(old, controller, callback, format, hourInterval, minuteInterval);

  void dispose(FTimePickerController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FTimePickerControlMixin {
  /// Creates a [FTimePickerController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FTimePickerController createController(DateFormat format, int hourInterval, int minuteInterval);
  void _dispose(FTimePickerController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FTimePickerController _default(
    FTimePickerControl old,
    FTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  ) => controller;
}
mixin _$FTimePickerManagedControlMixin on Diagnosticable, FTimePickerControl {
  FTimePickerController? get controller;
  FTime? get initial;
  ValueChanged<FTime>? get onChange;
  @override
  (FTimePickerController, bool) _update(
    FTimePickerControl old,
    FTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, format, hourInterval, minuteInterval), false);

      // External (Controller A) -> External (Controller B)
      case FTimePickerManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      // Internal -> External
      case FTimePickerManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      // External -> Internal
      case FTimePickerManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, format, hourInterval, minuteInterval), false);
    }
  }

  @override
  void _dispose(FTimePickerController controller, VoidCallback callback) {
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
      (other is FTimePickerManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FTimePickerControl {
  FTime get time;
  ValueChanged<FTime> get onChange;
  Duration get duration;
  Curve get curve;
  @override
  (FTimePickerController, bool) _update(
    FTimePickerControl old,
    FTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, format, hourInterval, minuteInterval), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, format, hourInterval, minuteInterval);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      // External -> Lifted
      case FTimePickerManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      // Internal -> Lifted
      case FTimePickerManagedControl():
        controller.dispose();
        return (createController(format, hourInterval, minuteInterval)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, format, hourInterval, minuteInterval), false);
    }
  }

  void _updateController(FTimePickerController controller, DateFormat format, int hourInterval, int minuteInterval);
  @override
  void _dispose(FTimePickerController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('time', time, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          onChange == other.onChange &&
          duration == other.duration &&
          curve == other.curve);

  @override
  int get hashCode => time.hashCode ^ onChange.hashCode ^ duration.hashCode ^ curve.hashCode;
}

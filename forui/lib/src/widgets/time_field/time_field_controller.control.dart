// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'time_field_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFTimeFieldControl on FTimeFieldControl {
  FTimeFieldController create(VoidCallback callback, bool shown) => createController(shown)..addListener(callback);

  (FTimeFieldController, bool) update(
    FTimeFieldControl old,
    FTimeFieldController controller,
    VoidCallback callback,
    bool shown,
  ) => _update(old, controller, callback, shown);

  void dispose(FTimeFieldController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FTimeFieldControlMixin {
  /// Creates a [FTimeFieldController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FTimeFieldController createController(bool shown);
  void _dispose(FTimeFieldController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FTimeFieldController _default(
    FTimeFieldControl old,
    FTimeFieldController controller,
    VoidCallback callback,
    bool shown,
  ) => controller;
}
mixin _$FTimeFieldManagedControlMixin on Diagnosticable, FTimeFieldControl {
  FTimeFieldController? get controller;
  FTime? get initial;
  FormFieldValidator<FTime>? get validator;
  ValueChanged<FTime?>? get onChange;
  @override
  (FTimeFieldController, bool) _update(
    FTimeFieldControl old,
    FTimeFieldController controller,
    VoidCallback callback,
    bool shown,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, shown), false);

      // External (Controller A) -> External (Controller B)
      case FTimeFieldManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(shown)..addListener(callback), true);

      // Internal -> External
      case FTimeFieldManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(shown)..addListener(callback), true);

      // External -> Internal
      case FTimeFieldManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(shown)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(shown)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, shown), false);
    }
  }

  @override
  void _dispose(FTimeFieldController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('validator', validator, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimeFieldManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          validator == other.validator &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ validator.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FTimeFieldControl {
  FTime? get time;
  ValueChanged<FTime?> get onChange;
  Duration get duration;
  Curve get curve;
  @override
  (FTimeFieldController, bool) _update(
    FTimeFieldControl old,
    FTimeFieldController controller,
    VoidCallback callback,
    bool shown,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, shown), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, shown);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(shown)..addListener(callback), true);

      // External -> Lifted
      case FTimeFieldManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(shown)..addListener(callback), true);

      // Internal -> Lifted
      case FTimeFieldManagedControl():
        controller.dispose();
        return (createController(shown)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, shown), false);
    }
  }

  void _updateController(FTimeFieldController controller, bool shown);
  @override
  void _dispose(FTimeFieldController controller, VoidCallback callback) {
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

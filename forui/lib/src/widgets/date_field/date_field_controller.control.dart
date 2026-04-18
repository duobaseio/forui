// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'date_field_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFDateFieldControl on FDateFieldControl {
  FDateFieldController create(VoidCallback callback, TickerProvider vsync) =>
      createController(vsync)..addListener(callback);

  (FDateFieldController, bool) update(
    FDateFieldControl old,
    FDateFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) => _update(old, controller, callback, vsync);

  void dispose(FDateFieldController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FDateFieldControlMixin {
  /// Creates a [FDateFieldController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FDateFieldController createController(TickerProvider vsync);
  void _dispose(FDateFieldController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FDateFieldController _default(
    FDateFieldControl old,
    FDateFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) => controller;
}
mixin _$FDateFieldManagedControlMixin on Diagnosticable, FDateFieldControl {
  FDateFieldController? get controller;
  DateTime? get initial;
  FormFieldValidator<DateTime>? get validator;
  ValueChanged<DateTime?>? get onChange;
  @override
  (FDateFieldController, bool) _update(
    FDateFieldControl old,
    FDateFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, vsync), false);

      // External (Controller A) -> External (Controller B)
      case FDateFieldManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Internal -> External
      case FDateFieldManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      // External -> Internal
      case FDateFieldManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, vsync), false);
    }
  }

  @override
  void _dispose(FDateFieldController controller, VoidCallback callback) {
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
      (other is FDateFieldManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          validator == other.validator &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ validator.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FDateFieldControl {
  DateTime? get date;
  ValueChanged<DateTime?> get onChange;
  FormFieldValidator<DateTime> get validator;
  @override
  (FDateFieldController, bool) _update(
    FDateFieldControl old,
    FDateFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, vsync), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, vsync);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      // External -> Lifted
      case FDateFieldManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Internal -> Lifted
      case FDateFieldManagedControl():
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, vsync), false);
    }
  }

  void _updateController(FDateFieldController controller, TickerProvider vsync);
  @override
  void _dispose(FDateFieldController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('date', date, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('validator', validator, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          onChange == other.onChange &&
          validator == other.validator);

  @override
  int get hashCode => date.hashCode ^ onChange.hashCode ^ validator.hashCode;
}

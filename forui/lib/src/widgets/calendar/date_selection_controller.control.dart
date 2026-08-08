// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'date_selection_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFDateSelectionControl<T> on FDateSelectionControl<T> {
  FDateSelectionController<T> create(VoidCallback callback) => createController()..addListener(callback);

  (FDateSelectionController<T>, bool) update(
    FDateSelectionControl<T> old,
    FDateSelectionController<T> controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FDateSelectionController<T> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FDateSelectionControlMixin<T> {
  /// Creates a [FDateSelectionController<T>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FDateSelectionController<T> createController();
  void _dispose(FDateSelectionController<T> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FDateSelectionController<T> _default(
    FDateSelectionControl<T> old,
    FDateSelectionController<T> controller,
    VoidCallback callback,
  ) => controller;
}
mixin _$FDateSelectionManagedControlMixin<T> on Diagnosticable, FDateSelectionControl<T> {
  FDateSelectionController<T>? get controller;
  T? get initial;
  ValueChanged<T>? get onChange;
  @override
  (FDateSelectionController<T>, bool) _update(
    FDateSelectionControl<T> old,
    FDateSelectionController<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FDateSelectionManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FDateSelectionManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FDateSelectionManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case FDateSelectionLiftedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final FDateSelectionManagedControl<T> old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FDateSelectionController<T> controller, VoidCallback callback) {
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
      (other is FDateSelectionManagedControl<T> &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$FDateSelectionLiftedControlMixin<T> on Diagnosticable, FDateSelectionControl<T> {
  T get value;
  ValueChanged<T> get onChange;
  @override
  (FDateSelectionController<T>, bool) _update(
    FDateSelectionControl<T> old,
    FDateSelectionController<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // Lifted (Value A) -> Lifted (Value B)
      case FDateSelectionLiftedControl() when old.runtimeType == runtimeType:
        _updateController(controller);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case FDateSelectionLiftedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Lifted
      case FDateSelectionManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FDateSelectionManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FDateSelectionController<T> controller);
  @override
  void _dispose(FDateSelectionController<T> controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDateSelectionLiftedControl<T> &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}

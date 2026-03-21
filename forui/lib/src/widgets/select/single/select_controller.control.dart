// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'select_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFSelectControl<T> on FSelectControl<T> {
  FSelectController<T> create(VoidCallback callback) => createController()..addListener(callback);

  (FSelectController<T>, bool) update(FSelectControl<T> old, FSelectController<T> controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(FSelectController<T> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FSelectControlMixin<T> {
  /// Creates a [FSelectController<T>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FSelectController<T> createController();
  void _dispose(FSelectController<T> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FSelectController<T> _default(FSelectControl<T> old, FSelectController<T> controller, VoidCallback callback) =>
      controller;
}
mixin _$FSelectManagedControlMixin<T> on Diagnosticable, FSelectControl<T> {
  FSelectController<T>? get controller;
  T? get initial;
  bool? get toggleable;
  ValueChanged<T?>? get onChange;
  @override
  (FSelectController<T>, bool) _update(FSelectControl<T> old, FSelectController<T> controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FSelectManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FSelectManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FSelectManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(FSelectController<T> controller, VoidCallback callback) {
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
      ..add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectManagedControl<T> &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          toggleable == other.toggleable &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ toggleable.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin<T> on Diagnosticable, FSelectControl<T> {
  T? get value;
  ValueChanged<T?> get onChange;
  @override
  (FSelectController<T>, bool) _update(FSelectControl<T> old, FSelectController<T> controller, VoidCallback callback) {
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
      case FSelectManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FSelectManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FSelectController<T> controller);
  @override
  void _dispose(FSelectController<T> controller, VoidCallback callback) {
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
      (other is _Lifted<T> && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}

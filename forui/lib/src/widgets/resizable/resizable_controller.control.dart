// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'resizable_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFResizableControl on FResizableControl {
  FResizableController create(VoidCallback callback) => createController()..addListener(callback);

  (FResizableController, bool) update(FResizableControl old, FResizableController controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(FResizableController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FResizableControlMixin {
  /// Creates a [FResizableController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FResizableController createController();
  void _dispose(FResizableController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FResizableController _default(FResizableControl old, FResizableController controller, VoidCallback callback) =>
      controller;
}
mixin _$FResizableManagedControlMixin on Diagnosticable, FResizableControl {
  FResizableController? get controller;
  ValueChanged<List<FResizableRegionData>>? get onResizeUpdate;
  @override
  (FResizableController, bool) _update(FResizableControl old, FResizableController controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FResizableManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FResizableManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FResizableManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final FResizableManagedControl old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FResizableController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('onResizeUpdate', onResizeUpdate, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          onResizeUpdate == other.onResizeUpdate);

  @override
  int get hashCode => controller.hashCode ^ onResizeUpdate.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FResizableControl {
  @override
  (FResizableController, bool) _update(FResizableControl old, FResizableController controller, VoidCallback callback) {
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
      case FResizableManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FResizableManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FResizableController controller);
  @override
  void _dispose(FResizableController controller, VoidCallback callback) {
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

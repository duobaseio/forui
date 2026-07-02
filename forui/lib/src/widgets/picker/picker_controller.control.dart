// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'picker_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFPickerControl on FPickerControl {
  FPickerController create(VoidCallback callback, int wheelCount) =>
      createController(wheelCount)..addListener(callback);

  (FPickerController, bool) update(
    FPickerControl old,
    FPickerController controller,
    VoidCallback callback,
    int wheelCount,
  ) => _update(old, controller, callback, wheelCount);

  void dispose(FPickerController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FPickerControlMixin {
  /// Creates a [FPickerController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FPickerController createController(int wheelCount);
  void _dispose(FPickerController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FPickerController _default(FPickerControl old, FPickerController controller, VoidCallback callback, int wheelCount) =>
      controller;
}
mixin _$FPickerManagedControlMixin on Diagnosticable, FPickerControl {
  FPickerController? get controller;
  List<int>? get initial;
  ValueChanged<List<int>>? get onChange;
  @override
  (FPickerController, bool) _update(
    FPickerControl old,
    FPickerController controller,
    VoidCallback callback,
    int wheelCount,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, wheelCount), false);

      // External (Controller A) -> External (Controller B)
      case FPickerManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(wheelCount)..addListener(callback), true);

      // Internal -> External
      case FPickerManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(wheelCount)..addListener(callback), true);

      // External -> Internal
      case FPickerManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(wheelCount)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(wheelCount)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, wheelCount), false);
    }
  }

  @override
  void _dispose(FPickerController controller, VoidCallback callback) {
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
      ..add(IterableProperty('initial', initial, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPickerManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          listEquals(initial, other.initial) &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ const ListEquality().hash(initial) ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FPickerControl {
  List<int> get indexes;
  ValueChanged<List<int>> get onChange;
  Duration get duration;
  Curve get curve;
  @override
  (FPickerController, bool) _update(
    FPickerControl old,
    FPickerController controller,
    VoidCallback callback,
    int wheelCount,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, wheelCount), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, wheelCount);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(wheelCount)..addListener(callback), true);

      // External -> Lifted
      case FPickerManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(wheelCount)..addListener(callback), true);

      // Internal -> Lifted
      case FPickerManagedControl():
        controller.dispose();
        return (createController(wheelCount)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, wheelCount), false);
    }
  }

  void _updateController(FPickerController controller, int wheelCount);
  @override
  void _dispose(FPickerController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('indexes', indexes, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          listEquals(indexes, other.indexes) &&
          onChange == other.onChange &&
          duration == other.duration &&
          curve == other.curve);

  @override
  int get hashCode => const ListEquality().hash(indexes) ^ onChange.hashCode ^ duration.hashCode ^ curve.hashCode;
}

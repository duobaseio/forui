// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'notifiers.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFMultiValueControl<T> on FMultiValueControl<T> {
  FMultiValueNotifier<T> create(VoidCallback callback) => createController()..addListener(callback);

  (FMultiValueNotifier<T>, bool) update(
    FMultiValueControl<T> old,
    FMultiValueNotifier<T> controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FMultiValueNotifier<T> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FMultiValueControlMixin<T> {
  /// Creates a [FMultiValueNotifier<T>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FMultiValueNotifier<T> createController();
  void _dispose(FMultiValueNotifier<T> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FMultiValueNotifier<T> _default(
    FMultiValueControl<T> old,
    FMultiValueNotifier<T> controller,
    VoidCallback callback,
  ) => controller;
}
mixin _$FMultiValueManagedControlMixin<T> on Diagnosticable, FMultiValueControl<T> {
  FMultiValueNotifier<T>? get controller;
  int? get min;
  int? get max;
  ValueChanged<Set<T>>? get onChange;
  @override
  (FMultiValueNotifier<T>, bool) _update(
    FMultiValueControl<T> old,
    FMultiValueNotifier<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FMultiValueManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FMultiValueManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FMultiValueManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final FMultiValueManagedControl<T> old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FMultiValueNotifier<T> controller, VoidCallback callback) {
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
      ..add(IntProperty('min', min, level: .debug))
      ..add(IntProperty('max', max, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiValueManagedControl<T> &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          min == other.min &&
          max == other.max &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ min.hashCode ^ max.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin<T> on Diagnosticable, FMultiValueControl<T> {
  Set<T> get value;
  ValueChanged<Set<T>> get onChange;
  @override
  (FMultiValueNotifier<T>, bool) _update(
    FMultiValueControl<T> old,
    FMultiValueNotifier<T> controller,
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
      case FMultiValueManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FMultiValueManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FMultiValueNotifier<T> controller);
  @override
  void _dispose(FMultiValueNotifier<T> controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('value', value, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted<T> &&
          runtimeType == other.runtimeType &&
          setEquals(value, other.value) &&
          onChange == other.onChange);

  @override
  int get hashCode => const SetEquality().hash(value) ^ onChange.hashCode;
}

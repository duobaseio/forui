// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'autocomplete_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFAutocompleteControl on FAutocompleteControl {
  FAutocompleteController create(VoidCallback callback, FutureOr<Iterable<String>> Function(String) filter) =>
      createController(filter)..addListener(callback);

  (FAutocompleteController, bool) update(
    FAutocompleteControl old,
    FAutocompleteController controller,
    VoidCallback callback,
    FutureOr<Iterable<String>> Function(String) filter,
  ) => _update(old, controller, callback, filter);

  void dispose(FAutocompleteController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FAutocompleteControlMixin {
  /// Creates a [FAutocompleteController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FAutocompleteController createController(FutureOr<Iterable<String>> Function(String) filter);
  void _dispose(FAutocompleteController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FAutocompleteController _default(
    FAutocompleteControl old,
    FAutocompleteController controller,
    VoidCallback callback,
    FutureOr<Iterable<String>> Function(String) filter,
  ) => controller;
}
mixin _$FAutocompleteManagedControlMixin on Diagnosticable, FAutocompleteControl {
  FAutocompleteController? get controller;
  TextEditingValue? get initial;
  ValueChanged<TextEditingValue>? get onChange;
  @override
  (FAutocompleteController, bool) _update(
    FAutocompleteControl old,
    FAutocompleteController controller,
    VoidCallback callback,
    FutureOr<Iterable<String>> Function(String) filter,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, filter), false);

      // External (Controller A) -> External (Controller B)
      case FAutocompleteManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(filter)..addListener(callback), true);

      // Internal -> External
      case FAutocompleteManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(filter)..addListener(callback), true);

      // External -> Internal
      case FAutocompleteManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(filter)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(filter)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, filter), false);
    }
  }

  @override
  void _dispose(FAutocompleteController controller, VoidCallback callback) {
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
      (other is FAutocompleteManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FAutocompleteControl {
  TextEditingValue get value;
  ValueChanged<TextEditingValue> get onChange;
  @override
  (FAutocompleteController, bool) _update(
    FAutocompleteControl old,
    FAutocompleteController controller,
    VoidCallback callback,
    FutureOr<Iterable<String>> Function(String) filter,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, filter), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, filter);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(filter)..addListener(callback), true);

      // External -> Lifted
      case FAutocompleteManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(filter)..addListener(callback), true);

      // Internal -> Lifted
      case FAutocompleteManagedControl():
        controller.dispose();
        return (createController(filter)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, filter), false);
    }
  }

  void _updateController(FAutocompleteController controller, FutureOr<Iterable<String>> Function(String) filter);
  @override
  void _dispose(FAutocompleteController controller, VoidCallback callback) {
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
      (other is _Lifted && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}

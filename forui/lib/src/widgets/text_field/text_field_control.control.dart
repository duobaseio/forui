// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'text_field_control.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFTextFieldControl on FTextFieldControl {
  TextEditingController create(VoidCallback callback) => createController()..addListener(callback);

  (TextEditingController, bool) update(
    FTextFieldControl old,
    TextEditingController controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(TextEditingController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FTextFieldControlMixin {
  /// Creates a [TextEditingController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  TextEditingController createController();
  void _dispose(TextEditingController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  TextEditingController _default(FTextFieldControl old, TextEditingController controller, VoidCallback callback) =>
      controller;
}
mixin _$FTextFieldManagedControlMixin on Diagnosticable, FTextFieldControl {
  TextEditingController? get controller;
  TextEditingValue? get initial;
  ValueChanged<TextEditingValue>? get onChange;
  @override
  (TextEditingController, bool) _update(
    FTextFieldControl old,
    TextEditingController controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FTextFieldManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FTextFieldManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FTextFieldManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(TextEditingController controller, VoidCallback callback) {
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
      (other is FTextFieldManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FTextFieldControl {
  TextEditingValue get value;
  ValueChanged<TextEditingValue> get onChange;
  @override
  (TextEditingController, bool) _update(
    FTextFieldControl old,
    TextEditingController controller,
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
      case FTextFieldManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FTextFieldManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(TextEditingController controller);
  @override
  void _dispose(TextEditingController controller, VoidCallback callback) {
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

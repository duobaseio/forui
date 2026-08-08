// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'obscure_text_control.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFObscureTextControl on FObscureTextControl {
  ValueNotifier<bool> create(VoidCallback callback) => createController()..addListener(callback);

  (ValueNotifier<bool>, bool) update(FObscureTextControl old, ValueNotifier<bool> controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(ValueNotifier<bool> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FObscureTextControlMixin {
  /// Creates a [ValueNotifier<bool>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  ValueNotifier<bool> createController();
  void _dispose(ValueNotifier<bool> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  ValueNotifier<bool> _default(FObscureTextControl old, ValueNotifier<bool> controller, VoidCallback callback) =>
      controller;
}
mixin _$FObscureTextManagedControlMixin on Diagnosticable, FObscureTextControl {
  ValueNotifier<bool>? get controller;
  bool? get initial;
  ValueChanged<bool>? get onChange;
  @override
  (ValueNotifier<bool>, bool) _update(FObscureTextControl old, ValueNotifier<bool> controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FObscureTextManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FObscureTextManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FObscureTextManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(ValueNotifier<bool> controller, VoidCallback callback) {
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
      ..add(FlagProperty('initial', value: initial, ifTrue: 'initial', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FObscureTextManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FObscureTextControl {
  bool get value;
  ValueChanged<bool> get onChange;
  @override
  (ValueNotifier<bool>, bool) _update(FObscureTextControl old, ValueNotifier<bool> controller, VoidCallback callback) {
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
      case FObscureTextManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FObscureTextManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(ValueNotifier<bool> controller);
  @override
  void _dispose(ValueNotifier<bool> controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('value', value: value, ifTrue: 'value', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}

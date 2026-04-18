// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'otp_field_control.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFOtpFieldControl on FOtpFieldControl {
  FOtpController create(VoidCallback callback) => createController()..addListener(callback);

  (FOtpController, bool) update(FOtpFieldControl old, FOtpController controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(FOtpController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FOtpFieldControlMixin {
  /// Creates a [FOtpController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FOtpController createController();
  void _dispose(FOtpController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FOtpController _default(FOtpFieldControl old, FOtpController controller, VoidCallback callback) => controller;
}
mixin _$FOtpFieldManagedControlMixin on Diagnosticable, FOtpFieldControl {
  FOtpController? get controller;
  TextEditingValue? get initial;
  List<Widget> get children;
  ValueChanged<TextEditingValue>? get onChange;
  @override
  (FOtpController, bool) _update(FOtpFieldControl old, FOtpController controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FOtpFieldManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FOtpFieldManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FOtpFieldManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(FOtpController controller, VoidCallback callback) {
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
      ..add(IterableProperty('children', children, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FOtpFieldManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          listEquals(children, other.children) &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ const ListEquality().hash(children) ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FOtpFieldControl {
  @override
  (FOtpController, bool) _update(FOtpFieldControl old, FOtpController controller, VoidCallback callback) {
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
      case FOtpFieldManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FOtpFieldManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FOtpController controller);
  @override
  void _dispose(FOtpController controller, VoidCallback callback) {
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

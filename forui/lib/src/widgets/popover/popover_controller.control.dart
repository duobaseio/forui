// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'popover_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFPopoverControl on FPopoverControl {
  FPopoverController create(VoidCallback callback, TickerProvider vsync) =>
      createController(vsync)..addListener(callback);

  (FPopoverController, bool) update(
    FPopoverControl old,
    FPopoverController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) => _update(old, controller, callback, vsync);

  void dispose(FPopoverController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FPopoverControlMixin {
  /// Creates a [FPopoverController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FPopoverController createController(TickerProvider vsync);
  void _dispose(FPopoverController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FPopoverController _default(
    FPopoverControl old,
    FPopoverController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) => controller;
}
mixin _$FPopoverManagedControlMixin on Diagnosticable, FPopoverControl {
  FPopoverController? get controller;
  bool? get initial;
  ValueChanged<bool>? get onChange;
  @override
  (FPopoverController, bool) _update(
    FPopoverControl old,
    FPopoverController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, vsync), false);

      // External (Controller A) -> External (Controller B)
      case FPopoverManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Internal -> External
      case FPopoverManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      // External -> Internal
      case FPopoverManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(FPopoverController controller, VoidCallback callback) {
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
      (other is FPopoverManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FPopoverControl {
  bool get shown;
  ValueChanged<bool> get onChange;
  @override
  (FPopoverController, bool) _update(
    FPopoverControl old,
    FPopoverController controller,
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
      case FPopoverManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Internal -> Lifted
      case FPopoverManagedControl():
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, vsync), false);
    }
  }

  void _updateController(FPopoverController controller, TickerProvider vsync);
  @override
  void _dispose(FPopoverController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('shown', value: shown, ifTrue: 'shown', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted && runtimeType == other.runtimeType && shown == other.shown && onChange == other.onChange);

  @override
  int get hashCode => shown.hashCode ^ onChange.hashCode;
}

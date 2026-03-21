// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'tooltip_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFTooltipControl on FTooltipControl {
  FTooltipController create(VoidCallback callback, TickerProvider vsync) =>
      createController(vsync)..addListener(callback);

  (FTooltipController, bool) update(
    FTooltipControl old,
    FTooltipController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) => _update(old, controller, callback, vsync);

  void dispose(FTooltipController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FTooltipControlMixin {
  /// Creates a [FTooltipController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FTooltipController createController(TickerProvider vsync);
  void _dispose(FTooltipController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FTooltipController _default(
    FTooltipControl old,
    FTooltipController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) => controller;
}
mixin _$FTooltipManagedControlMixin on Diagnosticable, FTooltipControl {
  FTooltipController? get controller;
  bool? get initial;
  FTooltipMotion? get motion;
  ValueChanged<bool>? get onChange;
  @override
  (FTooltipController, bool) _update(
    FTooltipControl old,
    FTooltipController controller,
    VoidCallback callback,
    TickerProvider vsync,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, vsync), false);

      // External (Controller A) -> External (Controller B)
      case FTooltipManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Internal -> External
      case FTooltipManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      // External -> Internal
      case FTooltipManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(FTooltipController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('motion', motion, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTooltipManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          motion == other.motion &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ motion.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FTooltipControl {
  bool get shown;
  ValueChanged<bool> get onChange;
  FTooltipMotion get motion;
  @override
  (FTooltipController, bool) _update(
    FTooltipControl old,
    FTooltipController controller,
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
      case FTooltipManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(vsync)..addListener(callback), true);

      // Internal -> Lifted
      case FTooltipManagedControl():
        controller.dispose();
        return (createController(vsync)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, vsync), false);
    }
  }

  void _updateController(FTooltipController controller, TickerProvider vsync);
  @override
  void _dispose(FTooltipController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('shown', value: shown, ifTrue: 'shown', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          shown == other.shown &&
          onChange == other.onChange &&
          motion == other.motion);

  @override
  int get hashCode => shown.hashCode ^ onChange.hashCode ^ motion.hashCode;
}

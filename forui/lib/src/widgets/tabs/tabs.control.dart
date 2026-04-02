// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'tabs.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFTabControl on FTabControl {
  FTabController create(VoidCallback callback, TickerProvider vsync, int length) =>
      createController(vsync, length)..addListener(callback);

  (FTabController, bool) update(
    FTabControl old,
    FTabController controller,
    VoidCallback callback,
    TickerProvider vsync,
    int length,
  ) => _update(old, controller, callback, vsync, length);

  void dispose(FTabController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FTabControlMixin {
  /// Creates a [FTabController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FTabController createController(TickerProvider vsync, int length);
  void _dispose(FTabController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FTabController _default(
    FTabControl old,
    FTabController controller,
    VoidCallback callback,
    TickerProvider vsync,
    int length,
  ) => controller;
}
mixin _$FTabManagedControlMixin on Diagnosticable, FTabControl {
  FTabController? get controller;
  int? get initial;
  FTabMotion? get motion;
  ValueChanged<int>? get onChange;
  @override
  (FTabController, bool) _update(
    FTabControl old,
    FTabController controller,
    VoidCallback callback,
    TickerProvider vsync,
    int length,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, vsync, length), false);

      // External (Controller A) -> External (Controller B)
      case FTabManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(vsync, length)..addListener(callback), true);

      // Internal -> External
      case FTabManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(vsync, length)..addListener(callback), true);

      // External -> Internal
      case FTabManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(vsync, length)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(vsync, length)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, vsync, length), false);
    }
  }

  @override
  void _dispose(FTabController controller, VoidCallback callback) {
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
      ..add(IntProperty('initial', initial, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTabManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          motion == other.motion &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ motion.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FTabControl {
  int get index;
  ValueChanged<int> get onChange;
  FTabMotion get motion;
  @override
  (FTabController, bool) _update(
    FTabControl old,
    FTabController controller,
    VoidCallback callback,
    TickerProvider vsync,
    int length,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, vsync, length), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, vsync, length);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(vsync, length)..addListener(callback), true);

      // External -> Lifted
      case FTabManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(vsync, length)..addListener(callback), true);

      // Internal -> Lifted
      case FTabManagedControl():
        controller.dispose();
        return (createController(vsync, length)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, vsync, length), false);
    }
  }

  void _updateController(FTabController controller, TickerProvider vsync, int length);
  @override
  void _dispose(FTabController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          onChange == other.onChange &&
          motion == other.motion);

  @override
  int get hashCode => index.hashCode ^ onChange.hashCode ^ motion.hashCode;
}

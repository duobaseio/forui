// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'accordion_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFAccordionControl on FAccordionControl {
  FAccordionController create(VoidCallback callback, int children) => createController(children)..addListener(callback);

  (FAccordionController, bool) update(
    FAccordionControl old,
    FAccordionController controller,
    VoidCallback callback,
    int children,
  ) => _update(old, controller, callback, children);

  void dispose(FAccordionController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FAccordionControlMixin {
  /// Creates a [FAccordionController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FAccordionController createController(int children);
  void _dispose(FAccordionController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FAccordionController _default(
    FAccordionControl old,
    FAccordionController controller,
    VoidCallback callback,
    int children,
  ) => controller;
}
mixin _$FAccordionManagedControlMixin on Diagnosticable, FAccordionControl {
  FAccordionController? get controller;
  int? get min;
  int? get max;
  ValueChanged<Set<int>>? get onChange;
  @override
  (FAccordionController, bool) _update(
    FAccordionControl old,
    FAccordionController controller,
    VoidCallback callback,
    int children,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, children), false);

      // External (Controller A) -> External (Controller B)
      case FAccordionManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(children)..addListener(callback), true);

      // Internal -> External
      case FAccordionManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      // External -> Internal
      case FAccordionManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(children)..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, children), false);
    }
  }

  @override
  void _dispose(FAccordionController controller, VoidCallback callback) {
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
      (other is FAccordionManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          min == other.min &&
          max == other.max &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ min.hashCode ^ max.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FAccordionControl {
  Predicate<int> get expanded;
  void Function(int, bool) get onChange;
  @override
  (FAccordionController, bool) _update(
    FAccordionControl old,
    FAccordionController controller,
    VoidCallback callback,
    int children,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, children), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, children);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      // External -> Lifted
      case FAccordionManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController(children)..addListener(callback), true);

      // Internal -> Lifted
      case FAccordionManagedControl():
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, children), false);
    }
  }

  void _updateController(FAccordionController controller, int children);
  @override
  void _dispose(FAccordionController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expanded', expanded, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          expanded == other.expanded &&
          onChange == other.onChange);

  @override
  int get hashCode => expanded.hashCode ^ onChange.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'overlay_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFOverlayControl on FOverlayControl {
  OverlayPortalController create() => createController();

  (OverlayPortalController, bool) update(FOverlayControl old, OverlayPortalController controller) =>
      _update(old, controller);
}

mixin _$FOverlayControlMixin {
  /// Creates a [OverlayPortalController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  OverlayPortalController createController();
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  OverlayPortalController _default(FOverlayControl old, OverlayPortalController controller) => controller;
}
mixin _$FOverlayManagedControlMixin on Diagnosticable, FOverlayControl {
  OverlayPortalController? get controller;
  bool? get initial;
  @override
  (OverlayPortalController, bool) _update(FOverlayControl old, OverlayPortalController controller) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller), false);

      // External (Controller A) -> External (Controller B)
      case FOverlayManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        return (createController(), true);

      // Internal -> External
      case FOverlayManagedControl(controller: final old) when this.controller != null && old == null:
        return (createController(), true);

      // External -> Internal
      case FOverlayManagedControl(controller: _?) when this.controller == null:
        return (createController(), true);

      // Lifted -> Managed
      case _Lifted():
        return (createController(), true);

      default:
        return (_default(old, controller), false);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller, level: .debug))
      ..add(FlagProperty('initial', value: initial, ifTrue: 'initial', level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FOverlayManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FOverlayControl {
  bool get shown;
  ValueChanged<bool> get onChange;
  @override
  (OverlayPortalController, bool) _update(FOverlayControl old, OverlayPortalController controller) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller), false);

      // Lifted (Value A) -> Lifted (Value B)
      case _Lifted() when old.runtimeType == runtimeType:
        _updateController(controller);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case _Lifted():
        return (createController(), true);

      // External -> Lifted
      case FOverlayManagedControl(controller: _?):
        return (createController(), true);

      // Internal -> Lifted
      case FOverlayManagedControl():
        return (createController(), true);

      default:
        return (_default(old, controller), false);
    }
  }

  void _updateController(OverlayPortalController controller);
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

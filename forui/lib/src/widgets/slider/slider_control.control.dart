// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'slider_control.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFSliderControl on FSliderControl {
  FSliderController create(VoidCallback callback) => createController()..addListener(callback);

  (FSliderController, bool) update(FSliderControl old, FSliderController controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(FSliderController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FSliderControlMixin {
  /// Creates a [FSliderController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FSliderController createController();
  void _dispose(FSliderController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FSliderController _default(FSliderControl old, FSliderController controller, VoidCallback callback) => controller;
}
mixin _$FSliderManagedControlMixin on Diagnosticable, FSliderControl {
  FSliderController? get controller;
  FSliderValue? get initial;
  FSliderInteraction? get interaction;
  ValueChanged<FSliderValue>? get onChange;
  @override
  (FSliderController, bool) _update(FSliderControl old, FSliderController controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FSliderManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FSliderManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FSliderManagedControl(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case _Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final FSliderManagedControl old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FSliderController controller, VoidCallback callback) {
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
      ..add(EnumProperty('interaction', interaction, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          interaction == other.interaction &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ initial.hashCode ^ interaction.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FSliderControl {
  FSliderValue get value;
  ValueChanged<FSliderValue> get onChange;
  @override
  (FSliderController, bool) _update(FSliderControl old, FSliderController controller, VoidCallback callback) {
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
      case FSliderManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FSliderManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FSliderController controller);
  @override
  void _dispose(FSliderController controller, VoidCallback callback) {
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
mixin _$_LiftedContinuousMixin on Diagnosticable, FSliderControl {
  double? get stepPercentage;
  FSliderInteraction? get interaction;
  FSliderActiveThumb? get thumb;
  FSliderValue get value;
  ValueChanged<FSliderValue> get onChange;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('stepPercentage', stepPercentage, level: .debug))
      ..add(EnumProperty('interaction', interaction, level: .debug))
      ..add(EnumProperty('thumb', thumb, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _LiftedContinuous &&
          runtimeType == other.runtimeType &&
          stepPercentage == other.stepPercentage &&
          interaction == other.interaction &&
          thumb == other.thumb &&
          value == other.value &&
          onChange == other.onChange);

  @override
  int get hashCode =>
      stepPercentage.hashCode ^ interaction.hashCode ^ thumb.hashCode ^ value.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedContinuousRangeMixin on Diagnosticable, FSliderControl {
  double? get stepPercentage;
  FSliderValue get value;
  ValueChanged<FSliderValue> get onChange;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('stepPercentage', stepPercentage, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _LiftedContinuousRange &&
          runtimeType == other.runtimeType &&
          stepPercentage == other.stepPercentage &&
          value == other.value &&
          onChange == other.onChange);

  @override
  int get hashCode => stepPercentage.hashCode ^ value.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedDiscreteMixin on Diagnosticable, FSliderControl {
  FSliderInteraction? get interaction;
  FSliderActiveThumb? get thumb;
  FSliderValue get value;
  ValueChanged<FSliderValue> get onChange;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('interaction', interaction, level: .debug))
      ..add(EnumProperty('thumb', thumb, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _LiftedDiscrete &&
          runtimeType == other.runtimeType &&
          interaction == other.interaction &&
          thumb == other.thumb &&
          value == other.value &&
          onChange == other.onChange);

  @override
  int get hashCode => interaction.hashCode ^ thumb.hashCode ^ value.hashCode ^ onChange.hashCode;
}
mixin _$_LiftedDiscreteRangeMixin on Diagnosticable, FSliderControl {
  FSliderValue get value;
  ValueChanged<FSliderValue> get onChange;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _LiftedDiscreteRange &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}

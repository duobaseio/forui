// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'pagination_controller.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFPaginationControl on FPaginationControl {
  FPaginationController create(VoidCallback callback) => createController()..addListener(callback);

  (FPaginationController, bool) update(
    FPaginationControl old,
    FPaginationController controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FPaginationController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FPaginationControlMixin {
  /// Creates a [FPaginationController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FPaginationController createController();
  void _dispose(FPaginationController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FPaginationController _default(FPaginationControl old, FPaginationController controller, VoidCallback callback) =>
      controller;
}
mixin _$FPaginationManagedControlMixin on Diagnosticable, FPaginationControl {
  FPaginationController? get controller;
  int? get initial;
  int? get pages;
  int? get siblings;
  bool? get showEdges;
  ValueChanged<int>? get onChange;
  @override
  (FPaginationController, bool) _update(
    FPaginationControl old,
    FPaginationController controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case FPaginationManagedControl(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case FPaginationManagedControl(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case FPaginationManagedControl(controller: _?) when this.controller == null:
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
  void _dispose(FPaginationController controller, VoidCallback callback) {
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
      ..add(IntProperty('pages', pages, level: .debug))
      ..add(IntProperty('siblings', siblings, level: .debug))
      ..add(FlagProperty('showEdges', value: showEdges, ifTrue: 'showEdges', level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPaginationManagedControl &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          pages == other.pages &&
          siblings == other.siblings &&
          showEdges == other.showEdges &&
          onChange == other.onChange);

  @override
  int get hashCode =>
      controller.hashCode ^
      initial.hashCode ^
      pages.hashCode ^
      siblings.hashCode ^
      showEdges.hashCode ^
      onChange.hashCode;
}
mixin _$_LiftedMixin on Diagnosticable, FPaginationControl {
  int get page;
  ValueChanged<int> get onChange;
  int get pages;
  int get siblings;
  bool get showEdges;
  @override
  (FPaginationController, bool) _update(
    FPaginationControl old,
    FPaginationController controller,
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
      case FPaginationManagedControl(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case FPaginationManagedControl():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FPaginationController controller);
  @override
  void _dispose(FPaginationController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('page', page, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug))
      ..add(IntProperty('pages', pages, level: .debug))
      ..add(IntProperty('siblings', siblings, level: .debug))
      ..add(FlagProperty('showEdges', value: showEdges, ifTrue: 'showEdges', level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Lifted &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          onChange == other.onChange &&
          pages == other.pages &&
          siblings == other.siblings &&
          showEdges == other.showEdges);

  @override
  int get hashCode => page.hashCode ^ onChange.hashCode ^ pages.hashCode ^ siblings.hashCode ^ showEdges.hashCode;
}

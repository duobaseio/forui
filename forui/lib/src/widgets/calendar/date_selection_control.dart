part of 'date_selection_controller.dart';

bool _never(DateTime _) => false;

void _ignore(DateTime _) {}

/// A [FDateSelectionControl] defines how date selection is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FDateSelectionControl<T> with Diagnosticable, _$FDateSelectionControlMixin<T> {
  /// Creates a [FDateSelectionControl] that selects nothing, intended for display-only calendars.
  static FDateSelectionControl<Object?> none() => const _Lifted(selected: _never, select: _ignore);

  /// Creates a [FDateSelectionControl] for single date selection.
  static FDateSelectionControl<DateTime?> managedSingle({
    FDateSelectionController<DateTime?>? controller,
    DateTime? initial,
    bool toggleable = true,
    ValueChanged<DateTime?>? onChange,
  }) => _Single(controller: controller, initial: initial, toggleable: toggleable, onChange: onChange);

  /// Creates a [FDateSelectionControl] for multiple dates selection.
  static FDateSelectionControl<Set<DateTime>> managedMulti({
    FDateSelectionController<Set<DateTime>>? controller,
    Set<DateTime>? initial,
    ValueChanged<Set<DateTime>>? onChange,
  }) => _Multi(controller: controller, initial: initial, onChange: onChange);

  /// Creates a [FDateSelectionControl] for range selection.
  static FDateSelectionControl<(DateTime, DateTime)?> managedRange({
    FDateSelectionController<(DateTime, DateTime)?>? controller,
    (DateTime, DateTime)? initial,
    ValueChanged<(DateTime, DateTime)?>? onChange,
  }) => _Range(controller: controller, initial: initial, onChange: onChange);

  /// Creates lifted state control.
  ///
  /// The [selected] function determines if a date is currently selected.
  /// The [select] callback is invoked when a date is selected.
  static FDateSelectionControl<Object?> lifted({
    required bool Function(DateTime) selected,
    required ValueChanged<DateTime> select,
  }) => _Lifted(selected: selected, select: select);

  const FDateSelectionControl._();

  (FDateSelectionController<T>, bool) _update(
    FDateSelectionControl<T> old,
    FDateSelectionController<T> controller,
    VoidCallback callback,
  );
}

/// A [FDateSelectionManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
abstract class FDateSelectionManagedControl<T> extends FDateSelectionControl<T>
    with _$FDateSelectionManagedControlMixin<T> {
  /// The controller.
  @override
  final FDateSelectionController<T>? controller;

  /// The initial value. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final T? initial;

  /// Called when the selected value changes.
  @override
  final ValueChanged<T>? onChange;

  /// Creates a [FDateSelectionControl].
  const FDateSelectionManagedControl({this.controller, this.initial, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Pass initial value to the controller instead.',
      ),
      super._();

  /// Calls [onChange] with the controller's value.
  void handleOnChange(FDateSelectionController<Object?> controller) => onChange?.call(controller.value as T);
}

class _Single extends FDateSelectionManagedControl<DateTime?> {
  final bool toggleable;

  const _Single({this.toggleable = true, super.controller, super.initial, super.onChange})
    : assert(
        controller == null || toggleable,
        'Cannot provide both controller and toggleable. Pass toggleable to the controller instead.',
      );

  @override
  FDateSelectionController<DateTime?> createController() =>
      controller ?? .single(initial: initial, toggleable: toggleable);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable', ifFalse: 'not toggleable'));
  }
}

class _Multi extends FDateSelectionManagedControl<Set<DateTime>> {
  const _Multi({super.controller, super.initial, super.onChange});

  @override
  FDateSelectionController<Set<DateTime>> createController() => controller ?? .multi(initial: initial ?? {});
}

class _Range extends FDateSelectionManagedControl<(DateTime, DateTime)?> {
  const _Range({super.controller, super.initial, super.onChange});

  @override
  FDateSelectionController<(DateTime, DateTime)?> createController() => controller ?? .range(initial: initial);
}

class _Lifted extends FDateSelectionControl<Object?> with _$_LiftedMixin<Object?> {
  @override
  final bool Function(DateTime) selected;
  @override
  final ValueChanged<DateTime> select;

  const _Lifted({required this.selected, required this.select}) : super._();

  @override
  FDateSelectionController<Object?> createController() => ProxyController(selected: selected, select: select);

  @override
  void _updateController(FDateSelectionController<Object?> controller) =>
      (controller as ProxyController).update(selected: selected, select: select);
}

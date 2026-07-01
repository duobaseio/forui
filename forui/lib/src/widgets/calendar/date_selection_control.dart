part of 'date_selection_controller.dart';

void _ignore(Object? _) {}

/// A [FDateSelectionControl] defines how date selection is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FDateSelectionControl<T> with Diagnosticable, _$FDateSelectionControlMixin<T> {
  /// Creates a [FDateSelectionControl] that selects nothing, intended for display-only calendars.
  static FDateSelectionControl<Object?> none() => const _None();

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

  /// Creates a lifted [FDateSelectionControl] for single date selection.
  ///
  /// The [value] is the currently selected date.
  /// [onChange] is called with the new selection when a date is selected.
  /// [toggleable] determines whether selecting the selected date unselects it. Defaults to true.
  static FDateSelectionControl<DateTime?> liftedSingle({
    required DateTime? value,
    required ValueChanged<DateTime?> onChange,
    bool toggleable = true,
  }) => _LiftedSingle(value: value, onChange: onChange, toggleable: toggleable);

  /// Creates a lifted [FDateSelectionControl] for multiple dates selection.
  ///
  /// The [value] is the currently selected dates.
  /// [onChange] is called with the new selection when a date is selected.
  static FDateSelectionControl<Set<DateTime>> liftedMulti({
    required Set<DateTime> value,
    required ValueChanged<Set<DateTime>> onChange,
  }) => _LiftedMulti(value: value, onChange: onChange);

  /// Creates a lifted [FDateSelectionControl] for range selection.
  ///
  /// The [value] is the currently selected range.
  /// [onChange] is called with the new selection when a date is selected.
  /// Both the start and end dates of the range are inclusive.
  static FDateSelectionControl<(DateTime, DateTime)?> liftedRange({
    required (DateTime, DateTime)? value,
    required ValueChanged<(DateTime, DateTime)?> onChange,
  }) => _LiftedRange(value: value, onChange: onChange);

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

/// A [FDateSelectionLiftedControl] enables a parent to own the selection state and update it via a callback.
abstract class FDateSelectionLiftedControl<T> extends FDateSelectionControl<T>
    with _$FDateSelectionLiftedControlMixin<T> {
  /// The currently selected value.
  @override
  final T value;

  /// Called with the new selection when a date is selected.
  @override
  final ValueChanged<T> onChange;

  /// Creates a [FDateSelectionLiftedControl].
  const FDateSelectionLiftedControl({required this.value, required this.onChange}) : super._();
}

class _LiftedSingle extends FDateSelectionLiftedControl<DateTime?> {
  final bool toggleable;

  const _LiftedSingle({required super.value, required super.onChange, required this.toggleable});

  @override
  FDateSelectionController<DateTime?> createController() =>
      _LiftedSingleController(value: value, onChange: onChange, toggleable: toggleable);

  @override
  void _updateController(FDateSelectionController<DateTime?> controller) =>
      (controller as _LiftedSingleController).update(value: value, onChange: onChange, toggleable: toggleable);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable', ifFalse: 'not toggleable'));
  }
}

class _LiftedMulti extends FDateSelectionLiftedControl<Set<DateTime>> {
  const _LiftedMulti({required super.value, required super.onChange});

  @override
  FDateSelectionController<Set<DateTime>> createController() =>
      _LiftedMultiController(value: value, onChange: onChange);

  @override
  void _updateController(FDateSelectionController<Set<DateTime>> controller) =>
      (controller as _LiftedMultiController).update(value: value, onChange: onChange);
}

class _LiftedRange extends FDateSelectionLiftedControl<(DateTime, DateTime)?> {
  const _LiftedRange({required super.value, required super.onChange});

  @override
  FDateSelectionController<(DateTime, DateTime)?> createController() =>
      _LiftedRangeController(value: value, onChange: onChange);

  @override
  void _updateController(FDateSelectionController<(DateTime, DateTime)?> controller) =>
      (controller as _LiftedRangeController).update(value: value, onChange: onChange);
}

class _None extends FDateSelectionLiftedControl<Object?> {
  const _None() : super(value: null, onChange: _ignore);

  @override
  FDateSelectionController<Object?> createController() => _NoneController();

  @override
  void _updateController(FDateSelectionController<Object?> controller) {}
}

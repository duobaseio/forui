part of 'calendar_controller.dart';

/// A [FCalendarControl] defines how a [FCalendar]'s navigation is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FCalendarControl with Diagnosticable, _$FCalendarControlMixin {
  const FCalendarControl._();

  (FCalendarController, bool) _update(FCalendarControl old, FCalendarController controller, VoidCallback callback);
}

/// A [FCalendarManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
sealed class FCalendarManagedControl extends FCalendarControl with _$FCalendarManagedControlMixin {
  /// The controller.
  @override
  final FCalendarController? controller;

  /// A predicate that determines if a date can be selected. Defaults to always true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [selectable] and [controller] are both provided.
  @override
  final bool Function(DateTime)? selectable;

  /// The start date, inclusive. Defaults to `DateTime.utc(1900)`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [start] and [controller] are both provided.
  @override
  final DateTime? start;

  /// Today's date. Defaults to [DateTime.now].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [today] and [controller] are both provided.
  @override
  final DateTime? today;

  /// The initial month shown. Defaults to [today].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final DateTime? initial;

  /// The end date, inclusive. Defaults to `DateTime.utc(2100)`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [end] and [controller] are both provided.
  @override
  final DateTime? end;

  /// Creates a [FCalendarManagedControl].
  const FCalendarManagedControl({this.controller, this.selectable, this.start, this.today, this.initial, this.end})
    : assert(
        controller == null || (start == null && end == null && today == null && selectable == null && initial == null),
        'Cannot provide both controller and other parameters. Pass these parameters to the controller instead.',
      ),
      super._();
}

/// A [FCalendarControl] backed by a [FGridCalendarController] that cycles through the day, month and year grid pickers.
///
/// {@macro forui.foundation.doc_templates.managed}
class FGridCalendarControl extends FCalendarManagedControl {
  /// Creates a [FGridCalendarControl].
  const FGridCalendarControl({
    FGridCalendarController? super.controller,
    super.selectable,
    super.start,
    super.today,
    super.initial,
    super.end,
  });

  @override
  FCalendarController createController() =>
      controller ??
      FGridCalendarController(
        selectable: selectable ?? FCalendarController.defaultSelectable,
        start: start,
        today: today,
        initial: initial,
        end: end,
      );
}

/// A [FCalendarControl] backed by a [FGridSplitCalendarController] whose month and year grid pickers are independently
/// togglable.
///
/// {@macro forui.foundation.doc_templates.managed}
class FGridSplitCalendarControl extends FCalendarManagedControl {
  /// Creates a [FGridSplitCalendarControl].
  const FGridSplitCalendarControl({
    FGridSplitCalendarController? super.controller,
    super.selectable,
    super.start,
    super.today,
    super.initial,
    super.end,
  });

  @override
  FCalendarController createController() =>
      controller ??
      FGridSplitCalendarController(
        selectable: selectable ?? FCalendarController.defaultSelectable,
        start: start,
        today: today,
        initial: initial,
        end: end,
      );
}

/// A [FCalendarControl] backed by a [FWheelCalendarController] that toggles between a day grid picker and a month-year
/// wheel picker.
///
/// {@macro forui.foundation.doc_templates.managed}
class FWheelCalendarControl extends FCalendarManagedControl {
  /// Creates a [FWheelCalendarControl].
  const FWheelCalendarControl({
    FWheelCalendarController? super.controller,
    super.selectable,
    super.start,
    super.today,
    super.initial,
    super.end,
  });

  @override
  FCalendarController createController() =>
      controller ??
      FWheelCalendarController(
        selectable: selectable ?? FCalendarController.defaultSelectable,
        start: start,
        today: today,
        initial: initial,
        end: end,
      );
}

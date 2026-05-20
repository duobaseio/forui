import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

part 'line_calendar_scroll_controller.control.dart';

/// A [ScrollController] that scrolls an [FLineCalendar] to a [DateTime].
///
/// Use [jumpToDate] and [animateToDate] to programmatically scroll the calendar.
/// The controller must be attached to an [FLineCalendar] via
/// [FLineCalendarScrollControl.managed] before either method is called.
class FLineCalendarScrollController extends ScrollController {
  /// The start date, inclusive. It is always in UTC and truncated to the nearest date. Defaults to `DateTime.utc(1900)`.
  final DateTime start;

  /// The end date, exclusive. It is always in UTC and truncated to the nearest date. Defaults to null.
  final DateTime? end;

  /// The current date. It is always in UTC and truncated to the nearest date. Defaults to [DateTime.now].
  final DateTime today;

  /// The initial date to which the calendar will be scrolled. It is always in UTC. Defaults to [today].
  late final DateTime initialDate;

  /// The alignment to which the initially scrolled date will be aligned. Defaults to [Alignment.center].
  final AlignmentDirectional initialAlignment;

  double _itemExtent;
  double _viewport;

  /// Creates a [FLineCalendarScrollController].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [end] <= [start].
  /// * [initialDate] < [start] or [end] <= [initialDate].
  /// * [today] < [start] or [end] <= [today].
  FLineCalendarScrollController({
    this.initialAlignment = .center,
    DateTime? start,
    DateTime? end,
    DateTime? today,
    DateTime? initialDate,
    super.keepScrollOffset = true,
    super.debugLabel,
  }) : start = (start ?? .utc(1900)).toLocalDate().toNative(),
       end = end?.toLocalDate().toNative(),
       today = (today?.toLocalDate() ?? .now()).toNative(),
       _itemExtent = 0,
       _viewport = 0,
       assert(
         start == null || end == null || start.toLocalDate() < end.toLocalDate(),
         'start ($start) must be < end ($end)',
       ),
       assert(
         initialDate == null ||
             start == null ||
             (initialDate.toLocalDate() >= start.toLocalDate() && initialDate.toLocalDate() < end!.toLocalDate()),
         'initialDate ($initialDate) must be >= start ($start)',
       ),
       assert(
         today == null ||
             start == null ||
             (today.toLocalDate() >= start.toLocalDate() && today.toLocalDate() < end!.toLocalDate()),
         'today ($today) must be >= start ($start) and < end ($end)',
       ) {
    this.initialDate = initialDate?.toLocalDate().toNative() ?? this.today;
  }

  /// Animates to [date].
  Future<void> animateToDate(
    DateTime date, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutCubic,
    AlignmentDirectional alignment = .center,
  }) => animateTo(_offset(date, alignment), duration: duration, curve: curve);

  /// Jumps to [date] without animation.
  void jumpToDate(DateTime date, {AlignmentDirectional alignment = .center}) => jumpTo(_offset(date, alignment));

  double _offset(DateTime date, AlignmentDirectional alignment) {
    final raw = date.toLocalDate().difference(start.toLocalDate()).inDays * _itemExtent;
    return switch (alignment.start) {
      -1 => raw,
      1 => raw - position.viewportDimension + _itemExtent,
      _ => raw - (position.viewportDimension - _itemExtent) / 2,
    }.clamp(position.minScrollExtent, position.maxScrollExtent);
  }

  @override
  double get initialScrollOffset {
    if (_itemExtent == 0 || _viewport == 0) {
      return 0;
    }

    final raw = initialDate.difference(start).inDays * _itemExtent;
    return switch (initialAlignment.start) {
      -1 => raw,
      1 => raw - _viewport + _itemExtent,
      _ => raw - (_viewport - _itemExtent) / 2,
    };
  }
}

@internal
extension InternalFLineCalendarScrollController on FLineCalendarScrollController {
  void initialize(double itemExtent, double viewport) {
    _itemExtent = itemExtent;
    _viewport = viewport;
  }

  double get itemExtent => _itemExtent;
}

/// A [FLineCalendarScrollControl] defines how an [FLineCalendar] is scrolled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FLineCalendarScrollControl with Diagnosticable, _$FLineCalendarScrollControlMixin {
  /// Creates a managed [FLineCalendarScrollControl].
  const factory FLineCalendarScrollControl.managed({
    FLineCalendarScrollController? controller,
    DateTime? start,
    DateTime? end,
    DateTime? today,
    DateTime? initialDate,
    AlignmentDirectional? initialAlignment,
    ValueChanged<double>? onChange,
  }) = FLineCalendarScrollManagedControl;

  const FLineCalendarScrollControl._();

  (FLineCalendarScrollController, bool) _update(
    FLineCalendarScrollControl old,
    FLineCalendarScrollController controller,
    VoidCallback callback,
  );
}

/// A [FLineCalendarScrollManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FLineCalendarScrollManagedControl extends FLineCalendarScrollControl
    with _$FLineCalendarScrollManagedControlMixin {
  /// The controller.
  @override
  final FLineCalendarScrollController? controller;

  /// The start date, inclusive. It is truncated to the nearest date. Defaults to the `DateTime.utc(1900)`.
  @override
  final DateTime? start;

  /// The end date, exclusive. It is truncated to the nearest date. Defaults to null.
  @override
  final DateTime? end;

  /// The current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  @override
  final DateTime? today;

  /// The initial date to which the calendar will be scrolled. Defaults to `today`.
  @override
  final DateTime? initialDate;

  /// The alignment to which the initially scrolled date will be aligned. Defaults to [Alignment.center].
  @override
  final AlignmentDirectional? initialAlignment;

  /// Called when the scroll offset changes.
  @override
  final ValueChanged<double>? onChange;

  /// Creates a [FLineCalendarScrollManagedControl].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [controller] is provided alongside any other parameter (except [onChange]). Pass the
  /// other parameters to the [controller] instead.
  const FLineCalendarScrollManagedControl({
    this.controller,
    this.start,
    this.end,
    this.today,
    this.initialDate,
    this.initialAlignment,
    this.onChange,
  }) : assert(
         controller == null ||
             (start == null && end == null && today == null && initialDate == null && initialAlignment == null),
         'Cannot provide both controller and other parameters. Pass these parameters to the controller instead.',
       ),
       super._();

  @override
  FLineCalendarScrollController createController() =>
      controller ??
      FLineCalendarScrollController(
        start: start,
        end: end,
        today: today,
        initialDate: initialDate,
        initialAlignment: initialAlignment ?? .center,
      );
}

class _Lifted extends FLineCalendarScrollControl with _$_LiftedMixin {
  _Lifted.lifted() : super._();

  @override
  FLineCalendarScrollController createController() => throw UnimplementedError();

  @override
  void _updateController(FLineCalendarScrollController controller) => throw UnimplementedError();
}

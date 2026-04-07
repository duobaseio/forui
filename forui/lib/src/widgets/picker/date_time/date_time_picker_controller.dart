import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';

part 'date_time_picker_controller.control.dart';

/// A [FDateTimePicker]'s controller.
final class FDateTimePickerController extends ValueNotifier<DateTime> {
  FPickerController? _picker;
  bool _mutating = false;
  DateTime? _referenceDate;
  String? _pattern;
  bool? _hours24;
  int? _dayInterval;
  int? _hourInterval;
  int? _minuteInterval;

  /// Creates a [FDateTimePickerController].
  FDateTimePickerController({DateTime? dateTime}) : super(dateTime ?? DateTime.now());

  /// Animates the controller to the given [value].
  Future<void> animateTo(
    DateTime value, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (_rawValue != value) {
      await _animateTo(value, duration, curve);
    }
  }

  Future<void> _animateTo(DateTime value, Duration duration, Curve curve) async {
    try {
      _mutating = true;
      await _picker?.animateTo(encode(value), duration: duration, curve: curve);
      // The value does not need to be explicitly set as the picker will update it via a listener.
    } finally {
      _mutating = false;
    }
  }

  @override
  set value(DateTime value) {
    if (value != _rawValue) {
      try {
        _mutating = true;
        _rawValue = value;
        _picker?.value = encode(value);
      } finally {
        _mutating = false;
      }
    }
  }

  DateTime get _rawValue => super.value;

  set _rawValue(DateTime value) => super.value = value;

  @override
  void dispose() {
    _picker?.dispose();
    super.dispose();
  }
}

@internal
extension InternalFDateTimePickerController on FDateTimePickerController {
  bool configure(DateFormat format, int dayInterval, int hourInterval, int minuteInterval) {
    // This behavior isn't ideal since changing the hour/minute interval causes an unintuitive time to be shown.
    // It is difficult to fix without FixedExtentScrollController exposing the keepOffset parameter.
    // See https://github.com/flutter/flutter/issues/162972
    final now = DateTime.now();
    _referenceDate ??= DateTime(now.year, now.month, now.day);

    final pattern = format.pattern!;
    final hours24 = !pattern.contains('a');
    if (_pattern == pattern &&
        _hours24 == hours24 &&
        _dayInterval == dayInterval &&
        _hourInterval == hourInterval &&
        _minuteInterval == minuteInterval) {
      return false;
    }

    _pattern = pattern;
    _hours24 = hours24;
    _dayInterval = dayInterval;
    _hourInterval = hourInterval;
    _minuteInterval = minuteInterval;

    _picker?.dispose();
    _picker = FPickerController(indexes: encode(value));
    _picker?.addListener(decode);
    return true;
  }

  /// Encodes the given [value] as picker wheels.
  List<int> encode(DateTime value) {
    final dateIndex = (DateTime(value.year, value.month, value.day).difference(_referenceDate!).inDays / _dayInterval!).round();
    final indexes = [dateIndex, (value.hour / _hourInterval!).round(), (value.minute / _minuteInterval!).round()];

    if (!_hours24!) {
      final period = value.hour < 12 ? 0 : 1;
      // Date is always at index 0, so period is at index 1 or appended after minute.
      _pattern!.startsWith('a') ? indexes.insert(1, period) : indexes.add(period);
    }

    return indexes;
  }

  /// Decodes the current picker wheels as a [DateTime].
  void decode() {
    final indexes = _picker!.value;
    final date = _referenceDate!.add(Duration(days: indexes[0] * _dayInterval!));

    // Time indexes are offset by +1 compared to FTimePicker (date is at index 0).
    final hourIndex = _pattern!.startsWith('a') ? 2 : 1;
    final periodIndex = _pattern!.startsWith('a') ? 1 : 3;

    var hour = (indexes[hourIndex] * _hourInterval!) % (_hours24! ? 24 : 12);
    if (!_hours24! && indexes[periodIndex].isOdd) {
      hour += 12;
    }

    _rawValue = DateTime(date.year, date.month, date.day, hour, (indexes[hourIndex + 1] * _minuteInterval!) % 60);
  }

  FPickerController? get picker => _picker;

  set picker(FPickerController? controller) => _picker = controller;

  bool get mutating => _mutating;

  bool get hours24 => _hours24!;

  int get hourInterval => _hourInterval!;

  int get dayInterval => _dayInterval!;

  int get minuteInterval => _minuteInterval!;

  DateTime get referenceDate => _referenceDate!;
}

final class _ProxyController extends FDateTimePickerController {
  DateTime _unsynced;
  ValueChanged<DateTime> _onChange;
  Duration _duration;
  Curve _curve;
  int _monotonic = 0;

  _ProxyController(this._unsynced, this._onChange, this._duration, this._curve) : super(dateTime: _unsynced);

  void update(
    DateTime newValue,
    ValueChanged<DateTime> onChange,
    Duration duration,
    Curve curve,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) {
    _onChange = onChange;
    _duration = duration;
    _curve = curve;
    final current = ++_monotonic;

    if (configure(format, dayInterval, hourInterval, minuteInterval)) {
      return;
    }

    if (super._rawValue != newValue) {
      _unsynced = newValue;
      super._rawValue = newValue;
      _scrollTo(newValue, current);
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      _scrollTo(newValue, current);
    }
  }

  @override
  set _rawValue(DateTime value) {
    final current = ++_monotonic;
    if (super._rawValue != value) {
      _unsynced = value;
      _onChange(value);
      _scrollTo(super._rawValue, current);
    }
  }

  void _scrollTo(DateTime value, int current) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (current == _monotonic) {
        _animateTo(value, _duration, _curve);
      }
    });
  }
}

/// A [FDateTimePickerControl] defines how a [FDateTimePicker] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FDateTimePickerControl with Diagnosticable, _$FDateTimePickerControlMixin {
  /// Creates a [FDateTimePickerControl].
  const factory FDateTimePickerControl.managed({
    FDateTimePickerController? controller,
    DateTime? initial,
    ValueChanged<DateTime>? onChange,
  }) = FDateTimePickerManagedControl;

  /// Creates a [FDateTimePickerControl] for controlling date time picker using lifted state.
  ///
  /// It does not prevent the user from scrolling to invalid indexes. To animate back to the provided [dateTime],
  /// consider passing in `onChange: (_) => setState(() {})`.
  ///
  /// The [dateTime] parameter contains the current selected date and time.
  /// The [onChange] callback is invoked when the user selects a date and time.
  /// The [duration] when animating to [dateTime] from an invalid/different value. Defaults to 200 milliseconds.
  /// The [curve] when animating to [dateTime] from an invalid/different value. Defaults to [Curves.easeOutCubic].
  const factory FDateTimePickerControl.lifted({
    required DateTime dateTime,
    required ValueChanged<DateTime> onChange,
    Duration duration,
    Curve curve,
  }) = _Lifted;

  const FDateTimePickerControl._();

  (FDateTimePickerController, bool) _update(
    FDateTimePickerControl old,
    FDateTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  );

  @override
  FDateTimePickerController _default(
    FDateTimePickerControl old,
    FDateTimePickerController controller,
    VoidCallback _,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) => controller..configure(format, dayInterval, hourInterval, minuteInterval);
}

/// A [FDateTimePickerManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FDateTimePickerManagedControl extends FDateTimePickerControl with Diagnosticable, _$FDateTimePickerManagedControlMixin {
  /// The controller.
  @override
  final FDateTimePickerController? controller;

  /// The initial date and time. Defaults to [DateTime.now].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final DateTime? initial;

  /// Called when the date and time changes.
  @override
  final ValueChanged<DateTime>? onChange;

  /// Creates a [FDateTimePickerControl].
  const FDateTimePickerManagedControl({this.controller, this.initial, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial date time. Pass initial date time to the controller instead.',
      ),
      super._();

  @override
  FDateTimePickerController createController(DateFormat format, int dayInterval, int hourInterval, int minuteInterval) =>
      (controller ?? .new(dateTime: initial))..configure(format, dayInterval, hourInterval, minuteInterval);
}

class _Lifted extends FDateTimePickerControl with _$_LiftedMixin {
  @override
  final DateTime dateTime;
  @override
  final ValueChanged<DateTime> onChange;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const _Lifted({
    required this.dateTime,
    required this.onChange,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
  }) : super._();

  @override
  FDateTimePickerController createController(DateFormat format, int dayInterval, int hourInterval, int minuteInterval) =>
      (_ProxyController(dateTime, onChange, duration, curve))..configure(format, dayInterval, hourInterval, minuteInterval);

  @override
  void _updateController(
    FDateTimePickerController controller,
    DateFormat format,
    int dayInterval,
    int hourInterval,
    int minuteInterval,
  ) {
    (controller as _ProxyController).update(dateTime, onChange, duration, curve, format, dayInterval, hourInterval, minuteInterval);
  }
}

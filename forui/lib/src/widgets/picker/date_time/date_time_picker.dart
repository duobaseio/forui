import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/picker/date_time/date_time_picker_controller.dart';
import 'package:forui/src/widgets/picker/date_time_picker.dart';

part 'date_time_picker.design.dart';

/// A date and time picker that allows a date and time to be selected.
///
/// Recommended for touch devices.
///
/// The date time picker supports arrow key navigation:
/// * Up/Down arrows: Increment/decrement selected value
/// * Left/Right arrows: Move between wheels
///
/// See:
/// * [FDateTimePickerController] for controlling a date time picker.
/// * [FDateTimePickerStyle] for customizing a date time picker's appearance.
class FDateTimePicker extends StatefulWidget {
  /// The default date builder for [FDateTimePicker].
  ///
  /// Returns "Today" (localized) if [date] is today, otherwise returns the formatted date.
  static Widget defaultDateBuilder(BuildContext context, DateTime date, DateFormat format) {
    final now = LocalDate.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return Text((FLocalizations.of(context) ?? FDefaultLocalizations()).dateTimePickerToday);
    }

    return Text(format.format(date));
  }

  /// The control.
  final FDateTimePickerControl control;

  /// The style. If null, the default picker style will be used.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FDateTimePickerStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create date-time-picker
  /// ```
  final FDateTimePickerStyleDelta style;

  /// True if the time picker should use the 24-hour format.
  ///
  /// Setting this to false will use the locale's default format, which may be 24-hours. Defaults to false.
  final bool hour24;

  /// The interval between days in the picker. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [dayInterval] < 1.
  final int dayInterval;

  /// The interval between hours in the picker. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [hourInterval] < 1.
  final int hourInterval;

  /// The interval between minutes in the picker. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [minuteInterval] < 1.
  final int minuteInterval;

  /// A builder that creates the date label for the date wheel.
  ///
  /// Defaults to [defaultDateBuilder], which shows "Today" for today's date and the formatted date otherwise.
  final Widget Function(BuildContext context, DateTime date, DateFormat format) dateBuilder;

  /// Creates a [FDateTimePicker] that uses a single wheel for the date.
  const FDateTimePicker({
    this.control = const .managed(),
    this.style = const .context(),
    this.hour24 = false,
    this.dayInterval = 1,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    this.dateBuilder = defaultDateBuilder,
    super.key,
  }) : assert(0 < dayInterval, 'dayInterval ($dayInterval) must be > 0'),
       assert(0 < hourInterval, 'hourInterval ($hourInterval) must be > 0'),
       assert(0 < minuteInterval, 'minuteInterval ($minuteInterval) must be > 0');

  @override
  State<FDateTimePicker> createState() => _FDateTimePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('hour24', value: hour24, ifTrue: '24-hour'))
      ..add(IntProperty('dayInterval', dayInterval))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval))
      ..add(ObjectFlagProperty.has('dateBuilder', dateBuilder));
  }
}

class _FDateTimePickerState extends State<FDateTimePicker> {
  late FDateTimePickerController _controller;
  late DateFormat _dateFormat;
  late DateFormat _timeFormat;
  late int _padding;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale();
    if (!_initialized) {
      _initialized = true;
      _controller = widget.control.create(
        _handleOnChange,
        _timeFormat,
        widget.dayInterval,
        widget.hourInterval,
        widget.minuteInterval,
      );
    } else {
      _controller.configure(_timeFormat, widget.dayInterval, widget.hourInterval, widget.minuteInterval);
    }
  }

  @override
  void didUpdateWidget(covariant FDateTimePicker old) {
    super.didUpdateWidget(old);
    _locale();
    _controller = widget.control
        .update(
          old.control,
          _controller,
          _handleOnChange,
          _timeFormat,
          widget.dayInterval,
          widget.hourInterval,
          widget.minuteInterval,
        )
        .$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _locale() {
    final locale = FLocalizations.of(context) ?? FDefaultLocalizations();
    _dateFormat = .MMMEd(locale.localeName);
    _timeFormat = widget.hour24 ? .Hm(locale.localeName) : .jm(locale.localeName);
    _padding = _timeFormat.pattern!.contains(RegExp('HH|hh')) ? 2 : 0;
  }

  void _handleOnChange() {
    if (widget.control case FDateTimePickerManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.dateTimePickerStyle);
    final start = EdgeInsetsDirectional.only(start: style.padding.start);
    final end = EdgeInsetsDirectional.only(end: style.padding.end);
    final dateWheels = [
      FPickerWheel.builder(
        flex: style.dateFlex,
        builder: (_, index) {
          final date = _controller.referenceDate.add(Duration(days: index * _controller.dayInterval));
          return Padding(padding: start, child: widget.dateBuilder(context, date, _dateFormat));
        },
      ),
    ];

    return switch ((scriptNumerals.contains(_timeFormat.locale), _timeFormat.pattern!.contains('a'))) {
      (false, true) => Western12Picker(
        controller: _controller,
        style: style,
        dateWheels: dateWheels,
        timeFormat: _timeFormat,
        padding: _padding,
        start: .zero,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        periodFlex: style.periodFlex,
        debugLabel: 'FDateTimePicker',
      ),
      (false, false) => Western24Picker(
        controller: _controller,
        style: style,
        dateWheels: dateWheels,
        timeFormat: _timeFormat,
        padding: _padding,
        start: .zero,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        debugLabel: 'FDateTimePicker',
      ),
      (true, true) => Eastern12Picker(
        controller: _controller,
        style: style,
        dateWheels: dateWheels,
        timeFormat: _timeFormat,
        padding: _padding,
        start: .zero,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        periodFlex: style.periodFlex,
        debugLabel: 'FDateTimePicker',
      ),
      (true, false) => Eastern24Picker(
        controller: _controller,
        style: style,
        dateWheels: dateWheels,
        timeFormat: _timeFormat,
        padding: _padding,
        start: .zero,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        debugLabel: 'FDateTimePicker',
      ),
    };
  }
}

/// The style of a date time picker.
class FDateTimePickerStyle extends FPickerStyle with _$FDateTimePickerStyleFunctions {
  /// The date wheel's flex factor. Defaults to 3.
  @override
  final int dateFlex;

  /// The hour wheel's flex factor. Defaults to 1.
  @override
  final int hourFlex;

  /// The minute wheel's flex factor. Defaults to 1.
  @override
  final int minuteFlex;

  /// The period (AM/PM) wheel's flex factor. Defaults to 1.
  @override
  final int periodFlex;

  /// The padding.
  @override
  final EdgeInsetsDirectional padding;

  /// Creates a [FDateTimePickerStyle].
  const FDateTimePickerStyle({
    required super.textStyle,
    required super.selectionDecoration,
    required super.focusedOutlineStyle,
    required super.hapticFeedback,
    super.diameterRatio,
    super.squeeze,
    super.magnification,
    super.overAndUnderCenterOpacity,
    super.spacing = 0,
    super.textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
    super.selectionHeightAdjustment = 5,
    this.dateFlex = 3,
    this.hourFlex = 1,
    this.minuteFlex = 1,
    this.periodFlex = 1,
    this.padding = const .only(start: 10, end: 10),
  });

  /// Creates a [FDateTimePickerStyle] that inherits its properties.
  FDateTimePickerStyle.inherit({
    required FColors colors,
    required FStyle style,
    required FTypography typography,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) : this(
         textStyle: touch
             ? typography.lg.copyWith(fontWeight: .w500, height: 1.25)
             : typography.sm.copyWith(fontWeight: .w500),
         selectionDecoration: ShapeDecoration(
           shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
           color: colors.muted,
         ),
         selectionHeightAdjustment: 5,
         spacing: 2,
         focusedOutlineStyle: style.focusedOutlineStyle,
         hapticFeedback: hapticFeedback.selectionClick,
         padding: const .only(start: 10, end: 10),
       );
}

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/picker/date_time_picker.dart';
import 'package:forui/src/widgets/picker/time/time_picker_controller.dart';

part 'time_picker.design.dart';

/// A time picker that allows a time to be selected.
///
/// Recommended for touch devices. Prefer [FTimeField] on desktop.
///
/// The time picker supports arrow key navigation:
/// * Up/Down arrows: Increment/decrement selected value
/// * Left/Right arrows: Move between wheels
///
/// See:
/// * https://forui.dev/docs/form/time-picker for working examples.
/// * [FTimePickerController] for controlling a time picker.
/// * [FTimePickerStyle] for customizing a time picker's appearance.
class FTimePicker extends StatefulWidget {
  /// The control.
  final FTimePickerControl control;

  /// The style. If null, the default picker style will be used.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FTimePickerStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create time-picker
  /// ```
  final FTimePickerStyleDelta style;

  /// True if the time picker should use the 24-hour format.
  ///
  /// Setting this to false will use the locale's default format, which may be 24-hours. Defaults to false.
  final bool hour24;

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

  /// Creates a [FTimePicker].
  const FTimePicker({
    this.control = const .managed(),
    this.style = const .context(),
    this.hour24 = false,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    super.key,
  }) : assert(0 < hourInterval, 'hourInterval ($hourInterval) must be > 0'),
       assert(0 < minuteInterval, 'minuteInterval ($minuteInterval) must be > 0');

  @override
  State<FTimePicker> createState() => _FTimePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('hour24', value: hour24, ifTrue: '24-hour'))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval));
  }
}

class _FTimePickerState extends State<FTimePicker> {
  late FTimePickerController _controller;
  late DateFormat _format;
  late int _padding;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale();
    if (!_initialized) {
      _initialized = true;
      _controller = widget.control.create(_handleOnChange, _format, widget.hourInterval, widget.minuteInterval);
    } else {
      _controller.configure(_format, widget.hourInterval, widget.minuteInterval);
    }
  }

  @override
  void didUpdateWidget(covariant FTimePicker old) {
    super.didUpdateWidget(old);
    _locale();
    _controller = widget.control
        .update(old.control, _controller, _handleOnChange, _format, widget.hourInterval, widget.minuteInterval)
        .$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _locale() {
    final locale = FLocalizations.of(context) ?? FDefaultLocalizations();
    _format = widget.hour24 ? .Hm(locale.localeName) : .jm(locale.localeName);
    _padding = _format.pattern!.contains(RegExp('HH|hh')) ? 2 : 0;
  }

  void _handleOnChange() {
    if (widget.control case FTimePickerManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.timePickerStyle);
    final start = EdgeInsetsDirectional.only(start: style.padding.start);
    final end = EdgeInsetsDirectional.only(end: style.padding.end);

    return switch ((scriptNumerals.contains(_format.locale), _format.pattern!.contains('a'))) {
      (false, true) => Western12Picker(
        controller: _controller,
        style: style,
        dateWheels: const [],
        timeFormat: _format,
        padding: _padding,
        start: start,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        periodFlex: style.periodFlex,
        debugLabel: 'FTimePicker',
      ),
      (false, false) => Western24Picker(
        controller: _controller,
        style: style,
        dateWheels: const [],
        timeFormat: _format,
        padding: _padding,
        start: start,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        debugLabel: 'FTimePicker',
      ),
      (true, true) => Eastern12Picker(
        controller: _controller,
        style: style,
        dateWheels: const [],
        timeFormat: _format,
        padding: _padding,
        start: start,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        periodFlex: style.periodFlex,
        debugLabel: 'FTimePicker',
      ),
      (true, false) => Eastern24Picker(
        controller: _controller,
        style: style,
        dateWheels: const [],
        timeFormat: _format,
        padding: _padding,
        start: start,
        end: end,
        hourInterval: _controller.hourInterval,
        minuteInterval: _controller.minuteInterval,
        hourFlex: style.hourFlex,
        minuteFlex: style.minuteFlex,
        debugLabel: 'FTimePicker',
      ),
    };
  }
}

/// The style of a time picker.
class FTimePickerStyle extends FPickerStyle with _$FTimePickerStyleFunctions {
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

  /// Creates a [FTimePickerStyle].
  const FTimePickerStyle({
    required super.textStyle,
    required super.selectionDecoration,
    required super.focusedOutlineStyle,
    required super.hapticFeedback,
    this.hourFlex = 1,
    this.minuteFlex = 1,
    this.periodFlex = 1,
    this.padding = const .only(start: 10, end: 10),
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
  });

  /// Creates a [FTimePickerStyle] that inherits its properties.
  FTimePickerStyle.inherit({
    required FColors colors,
    required FStyle style,
    required FTypography typography,
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
         hapticFeedback: style.hapticFeedback.selectionClick,
         padding: const .only(start: 10, end: 10),
       );
}

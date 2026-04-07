import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/picker/date_time/date_time_picker_controller.dart';

@internal
abstract class DateTimePicker extends StatelessWidget {
  final FDateTimePickerController controller;
  final FDateTimePickerStyle style;
  final DateFormat timeFormat;
  final DateFormat dateFormat;
  final int padding;
  final EdgeInsetsGeometry start;
  final EdgeInsetsGeometry end;
  final int dayInterval;
  final int hourInterval;
  final int minuteInterval;

  DateTimePicker._({
    required this.controller,
    required this.style,
    required this.timeFormat,
    required this.dateFormat,
    required this.padding,
    required this.dayInterval,
    required this.hourInterval,
    required this.minuteInterval,
  }) : start = .directional(start: style.padding.start),
       end = .directional(end: style.padding.end);

  factory DateTimePicker({
    required FDateTimePickerController controller,
    required FDateTimePickerStyle style,
    required DateFormat timeFormat,
    required DateFormat dateFormat,
    required int padding,
    required int dayInterval,
    required int hourInterval,
    required int minuteInterval,
  }) =>
      switch ((scriptNumerals.contains(timeFormat.locale), timeFormat.pattern!.contains('a'))) {
        (false, true) => _Western12Picker.new,
        (false, false) => _Western24Picker.new,
        (true, true) => _Eastern12Picker.new,
        (true, false) => _Eastern24Picker.new,
      }(
        controller: controller,
        style: style,
        timeFormat: timeFormat,
        dateFormat: dateFormat,
        padding: padding,
        dayInterval: dayInterval,
        hourInterval: hourInterval,
        minuteInterval: minuteInterval,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('timeFormat', timeFormat))
      ..add(DiagnosticsProperty('dateFormat', dateFormat))
      ..add(IntProperty('padding', padding))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(IntProperty('dayInterval', dayInterval))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval));
  }
}

class _HourPicker extends StatefulWidget with FPickerWheelMixin {
  final FDateTimePickerController controller;
  final String pattern;
  final Widget child;

  const _HourPicker({required this.controller, required this.pattern, required this.child});

  @override
  State<_HourPicker> createState() => _HourPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(StringProperty('pattern', pattern));
  }
}

class _HourPickerState extends State<_HourPicker> {
  int? _previous;

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollUpdateNotification>(
    onNotification: (_) {
      final picker = widget.controller.picker!;
      // +1 offset for date wheel at index 0.
      final current = picker.wheels[widget.pattern.startsWith('a') ? 2 : 1].selectedItem % 12;
      final period = picker.wheels[widget.pattern.startsWith('a') ? 1 : 3];
      final next = period.selectedItem.isEven ? 1 : 0;

      if (!widget.controller.mutating && ((_previous == 11 && current == 0) || (_previous == 0 && current == 11))) {
        // Workaround for when the picker's parent listens to changes in the picker.
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => period.animateToItem(next, duration: const Duration(milliseconds: 100), curve: Curves.easeOutCubic),
        );
      }

      _previous = current;
      return false;
    },
    child: widget.child,
  );
}

class _Western12Picker extends DateTimePicker {
  _Western12Picker({
    required super.controller,
    required super.style,
    required super.timeFormat,
    required super.dateFormat,
    required super.padding,
    required super.dayInterval,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    // Do NOT try to separate the date returned by format by whitespace. Locales may use NNBSP or have no separators.
    // ISTG if there's a locale that inserts the period in the middle of the time...
    final period = DateFormat('a', timeFormat.locale);

    // We cannot insert the padding outside the pickers because the resultant affordance might be too small.
    final (hourPadding, minutePadding, periodPadding) = switch (timeFormat.pattern!.startsWith('a')) {
      (true) => (EdgeInsets.zero, end, start),
      (false) => (start, EdgeInsets.zero, end),
    };

    final dateWheel = FPickerWheel.builder(
      flex: 2,
      builder: (_, index) {
        final date = controller.referenceDate.add(Duration(days: index * dayInterval));
        return Padding(padding: start, child: Text(dateFormat.format(date)));
      },
    );

    final periodPicker = FPickerWheel(
      children: [
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 1)))),
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 13)))),
      ],
    );

    final pickers = [
      _HourPicker(
        controller: controller,
        pattern: timeFormat.pattern!,
        child: FPickerWheel.builder(
          builder: (_, index) {
            final hour = (index * hourInterval) % 12;
            return Padding(padding: hourPadding, child: Text('${hour == 0 ? 12 : hour}'.padLeft(padding, '0')));
          },
        ),
      ),
      const Text(':'),
      FPickerWheel.builder(
        builder: (_, index) =>
            Padding(padding: minutePadding, child: Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
      ),
    ];

    timeFormat.pattern!.startsWith('a') ? pickers.insert(0, periodPicker) : pickers.add(periodPicker);

    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: 'FDateTimePicker',
      children: [dateWheel, ...pickers],
    );
  }
}

class _Western24Picker extends DateTimePicker {
  _Western24Picker({
    required super.controller,
    required super.style,
    required super.timeFormat,
    required super.dateFormat,
    required super.padding,
    required super.dayInterval,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final dateWheel = FPickerWheel.builder(
      flex: 3,
      builder: (_, index) {
        final date = controller.referenceDate.add(Duration(days: index * dayInterval));
        return Padding(padding: start, child: Text(dateFormat.format(date)));
      },
    );

    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: 'FDateTimePicker',
      children: [
        dateWheel,
        FPickerWheel.builder(
          builder: (_, index) =>
              Padding(padding: .zero, child: Text('${(index * hourInterval) % 24}'.padLeft(padding, '0'))),
        ),
        const Text(':'),
        FPickerWheel.builder(
          builder: (_, index) => Padding(padding: end, child: Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
        ),
      ],
    );
  }
}

class _Eastern12Picker extends DateTimePicker {
  _Eastern12Picker({
    required super.controller,
    required super.style,
    required super.timeFormat,
    required super.dateFormat,
    required super.padding,
    required super.dayInterval,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    // Do NOT try to separate the date returned by format by whitespace. Locales may use NNBSP or have no separators.
    // ISTG if there's a locale that inserts the period in the middle of the time...
    final period = DateFormat('a', timeFormat.locale);

    // We cannot insert the padding outside the pickers because the resultant affordance might be too small.
    final (hourPadding, minutePadding, periodPadding) = switch (timeFormat.pattern!.startsWith('a')) {
      (true) => (EdgeInsets.zero, end, start),
      (false) => (start, EdgeInsets.zero, end),
    };

    final dateWheel = FPickerWheel.builder(
      flex: 3,
      builder: (_, index) {
        final date = controller.referenceDate.add(Duration(days: index * dayInterval));
        return Padding(padding: start, child: Text(dateFormat.format(date)));
      },
    );

    final periodPicker = FPickerWheel(
      children: [
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 1)))),
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 13)))),
      ],
    );

    final pickers = [
      _HourPicker(
        controller: controller,
        pattern: timeFormat.pattern!,
        child: FPickerWheel.builder(
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 12));
            return Padding(padding: hourPadding, child: Text(time.split(':').first));
          },
        ),
      ),
      const Text(':'),
      FPickerWheel.builder(
        builder: (_, index) {
          final time = timeFormat.format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60));
          return Padding(padding: minutePadding, child: Text(time.split(':').last.split(' ').first));
        },
      ),
    ];

    timeFormat.pattern!.startsWith('a') ? pickers.insert(0, periodPicker) : pickers.add(periodPicker);

    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: 'FDateTimePicker',
      children: [dateWheel, ...pickers],
    );
  }
}

class _Eastern24Picker extends DateTimePicker {
  _Eastern24Picker({
    required super.controller,
    required super.style,
    required super.timeFormat,
    required super.dateFormat,
    required super.padding,
    required super.dayInterval,
    required super.hourInterval,
    required super.minuteInterval,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final dateWheel = FPickerWheel.builder(
      flex: 3,
      builder: (_, index) {
        final date = controller.referenceDate.add(Duration(days: index * dayInterval));
        return Padding(padding: start, child: Text(dateFormat.format(date)));
      },
    );

    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: 'FDateTimePicker',
      children: [
        dateWheel,
        FPickerWheel.builder(
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 24));
            return Padding(padding: start, child: Text(time.split(':').first));
          },
        ),
        const Text(':'),
        FPickerWheel.builder(
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, (index * minuteInterval) % minuteInterval));
            return Padding(padding: end, child: Text(time.split(':').last.split(' ').first));
          },
        ),
      ],
    );
  }
}

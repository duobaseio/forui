import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker_controller.dart';

class _HourPicker extends StatefulWidget with FPickerWheelMixin {
  final ValuePickerController controller;
  final String pattern;
  final int offset;
  final Widget child;

  const _HourPicker({required this.controller, required this.pattern, required this.offset, required this.child});

  @override
  State<_HourPicker> createState() => _HourPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(StringProperty('pattern', pattern))
      ..add(IntProperty('offset', offset));
  }
}

class _HourPickerState extends State<_HourPicker> {
  int? _previous;

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollUpdateNotification>(
    onNotification: (_) {
      final offset = widget.offset;
      final picker = widget.controller.picker!;
      final current = picker.wheels[widget.pattern.startsWith('a') ? 1 + offset : offset].selectedItem % 12;
      final period = picker.wheels[widget.pattern.startsWith('a') ? offset : 2 + offset];
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

abstract class _Picker extends StatelessWidget {
  final ValuePickerController controller;
  final FPickerStyle style;
  final List<Widget> dateWheels;
  final DateFormat timeFormat;
  final int padding;
  final EdgeInsetsGeometry start;
  final EdgeInsetsGeometry end;
  final int hourInterval;
  final int minuteInterval;
  final int hourFlex;
  final int minuteFlex;
  final String debugLabel;

  const _Picker({
    required this.controller,
    required this.style,
    required this.dateWheels,
    required this.timeFormat,
    required this.padding,
    required this.start,
    required this.end,
    required this.hourInterval,
    required this.minuteInterval,
    required this.hourFlex,
    required this.minuteFlex,
    required this.debugLabel,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('timeFormat', timeFormat))
      ..add(IntProperty('padding', padding))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval))
      ..add(IntProperty('hourFlex', hourFlex))
      ..add(IntProperty('minuteFlex', minuteFlex))
      ..add(StringProperty('debugLabel', debugLabel));
  }
}

@internal
class Western12Picker extends _Picker {
  final int periodFlex;

  const Western12Picker({
    required this.periodFlex,
    required super.controller,
    required super.style,
    required super.dateWheels,
    required super.timeFormat,
    required super.padding,
    required super.start,
    required super.end,
    required super.hourInterval,
    required super.minuteInterval,
    required super.hourFlex,
    required super.minuteFlex,
    required super.debugLabel,
    super.key,
  });

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

    final pickers = [
      ...dateWheels,
      _HourPicker(
        controller: controller,
        pattern: timeFormat.pattern!,
        offset: dateWheels.length,
        child: FPickerWheel.builder(
          flex: hourFlex,
          builder: (_, index) {
            final hour = (index * hourInterval) % 12;
            return Padding(padding: hourPadding, child: Text('${hour == 0 ? 12 : hour}'.padLeft(padding, '0')));
          },
        ),
      ),
      const Text(':'),
      FPickerWheel.builder(
        flex: minuteFlex,
        builder: (_, index) =>
            Padding(padding: minutePadding, child: Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
      ),
    ];

    final periodPicker = FPickerWheel(
      flex: periodFlex,
      children: [
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 1)))),
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 13)))),
      ],
    );
    timeFormat.pattern!.startsWith('a') ? pickers.insert(dateWheels.length, periodPicker) : pickers.add(periodPicker);

    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: debugLabel,
      children: pickers,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('periodFlex', periodFlex));
  }
}

@internal
class Western24Picker extends _Picker {
  const Western24Picker({
    required super.controller,
    required super.style,
    required super.dateWheels,
    required super.timeFormat,
    required super.padding,
    required super.start,
    required super.end,
    required super.hourInterval,
    required super.minuteInterval,
    required super.hourFlex,
    required super.minuteFlex,
    required super.debugLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FPicker(
    control: .managed(controller: controller.picker),
    style: style,
    debugLabel: debugLabel,
    children: [
      ...dateWheels,
      FPickerWheel.builder(
        flex: hourFlex,
        builder: (_, index) =>
            Padding(padding: start, child: Text('${(index * hourInterval) % 24}'.padLeft(padding, '0'))),
      ),
      const Text(':'),
      FPickerWheel.builder(
        flex: minuteFlex,
        builder: (_, index) => Padding(padding: end, child: Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
      ),
    ],
  );
}

@internal
class Eastern12Picker extends _Picker {
  final int periodFlex;

  const Eastern12Picker({
    required this.periodFlex,
    required super.controller,
    required super.style,
    required super.dateWheels,
    required super.timeFormat,
    required super.padding,
    required super.start,
    required super.end,
    required super.hourInterval,
    required super.minuteInterval,
    required super.hourFlex,
    required super.minuteFlex,
    required super.debugLabel,
    super.key,
  });

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

    final pickers = [
      ...dateWheels,
      _HourPicker(
        controller: controller,
        pattern: timeFormat.pattern!,
        offset: dateWheels.length,
        child: FPickerWheel.builder(
          flex: hourFlex,
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 12));
            return Padding(padding: hourPadding, child: Text(time.split(':').first));
          },
        ),
      ),
      const Text(':'),
      FPickerWheel.builder(
        flex: minuteFlex,
        builder: (_, index) {
          final time = timeFormat.format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60));
          return Padding(padding: minutePadding, child: Text(time.split(':').last.split(' ').first));
        },
      ),
    ];

    final periodPicker = FPickerWheel(
      flex: periodFlex,
      children: [
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 1)))),
        Padding(padding: periodPadding, child: Text(period.format(.utc(1970, 1, 1, 13)))),
      ],
    );
    timeFormat.pattern!.startsWith('a') ? pickers.insert(dateWheels.length, periodPicker) : pickers.add(periodPicker);

    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: debugLabel,
      children: pickers,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('periodFlex', periodFlex));
  }
}

@internal
class Eastern24Picker extends _Picker {
  const Eastern24Picker({
    required super.controller,
    required super.style,
    required super.dateWheels,
    required super.timeFormat,
    required super.padding,
    required super.start,
    required super.end,
    required super.hourInterval,
    required super.minuteInterval,
    required super.hourFlex,
    required super.minuteFlex,
    required super.debugLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FPicker(
    control: .managed(controller: controller.picker),
    style: style,
    debugLabel: debugLabel,
    children: [
      ...dateWheels,
      FPickerWheel.builder(
        flex: hourFlex,
        builder: (_, index) {
          final time = timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 24));
          return Padding(padding: start, child: Text(time.split(':').first));
        },
      ),
      const Text(':'),
      FPickerWheel.builder(
        flex: minuteFlex,
        builder: (_, index) {
          final time = timeFormat.format(DateTime(1970, 1, 1, (index * minuteInterval) % minuteInterval));
          return Padding(padding: end, child: Text(time.split(':').last.split(' ').first));
        },
      ),
    ],
  );
}

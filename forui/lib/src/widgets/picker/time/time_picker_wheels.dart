import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker_controller.dart';

class const _HourPicker({
  required final ValuePickerController<Object?> controller,
  required final String pattern,
  required final int offset,
  required final Widget child,
}) extends StatefulWidget with FPickerWheelMixin {
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
          (_) => picker.reduceMotion
              ? period.jumpToItem(next)
              : period.animateToItem(next, duration: const Duration(milliseconds: 100), curve: Curves.easeOutCubic),
        );
      }

      _previous = current;
      return false;
    },
    child: widget.child,
  );
}

abstract class const _Picker({
  required final ValuePickerController<Object?> controller,
  required final FPickerStyle style,
  required final List<Widget> dateWheels,
  required final DateFormat timeFormat,
  required final int padding,
  required final EdgeInsetsGeometry start,
  required final EdgeInsetsGeometry end,
  required final int hourInterval,
  required final int minuteInterval,
  required final int hourFlex,
  required final int minuteFlex,
  required final String debugLabel,
  super.key,
}) extends StatelessWidget {
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

  const new({
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
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
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
          semanticsLabel: localizations.timePickerHourSemanticsLabel,
          semanticsValueBuilder: (index) {
            final hour = (index * hourInterval) % 12;
            return '${hour == 0 ? 12 : hour}';
          },
          builder: (_, index) {
            final hour = (index * hourInterval) % 12;
            return Padding(padding: hourPadding, child: Text('${hour == 0 ? 12 : hour}'.padLeft(padding, '0')));
          },
        ),
      ),
      const ExcludeSemantics(child: Text(':')),
      FPickerWheel.builder(
        flex: minuteFlex,
        semanticsLabel: localizations.timePickerMinuteSemanticsLabel,
        semanticsValueBuilder: (index) => '${(index * minuteInterval) % 60}',
        builder: (_, index) =>
            Padding(padding: minutePadding, child: Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
      ),
    ];

    final periodPicker = FPickerWheel(
      flex: periodFlex,
      semanticsValueBuilder: (index) => period.format(.utc(1970, 1, 1, index == 0 ? 1 : 13)),
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
  const new({
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
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: debugLabel,
      children: [
        ...dateWheels,
        FPickerWheel.builder(
          flex: hourFlex,
          semanticsLabel: localizations.timePickerHourSemanticsLabel,
          semanticsValueBuilder: (index) => '${(index * hourInterval) % 24}',
          builder: (_, index) =>
              Padding(padding: start, child: Text('${(index * hourInterval) % 24}'.padLeft(padding, '0'))),
        ),
        const ExcludeSemantics(child: Text(':')),
        FPickerWheel.builder(
          flex: minuteFlex,
          semanticsLabel: localizations.timePickerMinuteSemanticsLabel,
          semanticsValueBuilder: (index) => '${(index * minuteInterval) % 60}',
          builder: (_, index) => Padding(padding: end, child: Text('${(index * minuteInterval) % 60}'.padLeft(2, '0'))),
        ),
      ],
    );
  }
}

@internal
class Eastern12Picker extends _Picker {
  final int periodFlex;

  const new({
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
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
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
          semanticsLabel: localizations.timePickerHourSemanticsLabel,
          semanticsValueBuilder: (index) =>
              timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 12)).split(':').first,
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 12));
            return Padding(padding: hourPadding, child: Text(time.split(':').first));
          },
        ),
      ),
      const ExcludeSemantics(child: Text(':')),
      FPickerWheel.builder(
        flex: minuteFlex,
        semanticsLabel: localizations.timePickerMinuteSemanticsLabel,
        semanticsValueBuilder: (index) =>
            timeFormat.format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60)).split(':').last.split(' ').first,
        builder: (_, index) {
          final time = timeFormat.format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60));
          return Padding(padding: minutePadding, child: Text(time.split(':').last.split(' ').first));
        },
      ),
    ];

    final periodPicker = FPickerWheel(
      flex: periodFlex,
      semanticsValueBuilder: (index) => period.format(.utc(1970, 1, 1, index == 0 ? 1 : 13)),
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
  const new({
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
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return FPicker(
      control: .managed(controller: controller.picker),
      style: style,
      debugLabel: debugLabel,
      children: [
        ...dateWheels,
        FPickerWheel.builder(
          flex: hourFlex,
          semanticsLabel: localizations.timePickerHourSemanticsLabel,
          semanticsValueBuilder: (index) =>
              timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 24)).split(':').first,
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, (index * hourInterval) % 24));
            return Padding(padding: start, child: Text(time.split(':').first));
          },
        ),
        const ExcludeSemantics(child: Text(':')),
        FPickerWheel.builder(
          flex: minuteFlex,
          semanticsLabel: localizations.timePickerMinuteSemanticsLabel,
          semanticsValueBuilder: (index) => timeFormat
              .format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60))
              .split(':')
              .last
              .split(' ')
              .first,
          builder: (_, index) {
            final time = timeFormat.format(DateTime(1970, 1, 1, 0, (index * minuteInterval) % 60));
            return Padding(padding: end, child: Text(time.split(':').last.split(' ').first));
          },
        ),
      ],
    );
  }
}

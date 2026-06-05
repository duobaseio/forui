import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import 'package:forui/src/widgets/calendar/month/month_picker.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';

@internal
class InlineCalendar extends StatelessWidget {
  final FInlineCalendarController controller;
  final FDateSelectionController selectionController;
  final FCalendarStyle style;
  final FLocalizations localizations;
  final double width;
  final double height;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;
  final FCalendarDayBuilder dayBuilder;
  final FCalendarMonthBuilder monthBuilder;
  final FCalendarYearBuilder yearBuilder;

  const InlineCalendar({
    required this.controller,
    required this.selectionController,
    required this.style,
    required this.localizations,
    required this.onPress,
    required this.onLongPress,
    required this.dayBuilder,
    required this.monthBuilder,
    required this.yearBuilder,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => Column(
      mainAxisSize: .min,
      children: switch (controller.type) {
        .day => [
          SizedBox(
            width: width,
            child: Header.day(
              style: style.headerStyle,
              localizations: localizations,
              monthYear: controller.day.current,
              shown: false,
              onPress: controller.cycle,
              onPrevious: controller.day.hasPrevious ? controller.day.previous : null,
              onNext: controller.day.hasNext ? controller.day.next : null,
            ),
          ),
          DayPicker(
            controller: controller.day,
            style: style.dayPickerStyle,
            localization: localizations,
            today: controller.today,
            selected: selectionController.contains,
            onPress: onPress,
            onLongPress: onLongPress,
            builder: dayBuilder,
          ),
        ],
        .month => [
          SizedBox(
            width: width,
            child: Header.month(
              style: style.headerStyle,
              localizations: localizations,
              year: controller.month.current,
              shown: false,
              onPress: controller.cycle,
              onPrevious: controller.month.hasPrevious ? controller.month.previous : null,
              onNext: controller.month.hasNext ? controller.month.next : null,
            ),
          ),
          SizedBox(
            height: height,
            child: Align(
              alignment: .topCenter,
              child: MonthPicker(
                controller: controller.month,
                style: style.monthPickerStyle,
                localization: localizations,
                paged: true,
                today: controller.today,
                onPress: controller.showDayPicker,
                builder: monthBuilder,
              ),
            ),
          ),
        ],
        .year => [
          SizedBox(
            width: width,
            child: Header.year(
              style: style.headerStyle,
              localizations: localizations,
              decade: controller.year.current,
              shown: false,
              onPress: controller.cycle,
              onPrevious: controller.year.hasPrevious ? controller.year.previous : null,
              onNext: controller.year.hasNext ? controller.year.next : null,
            ),
          ),
          SizedBox(
            height: height,
            child: Align(
              alignment: .topCenter,
              child: YearPicker(
                controller: controller.year,
                style: style.yearPickerStyle,
                localization: localizations,
                today: controller.today,
                onPress: controller.showMonthPicker,
                builder: yearBuilder,
              ),
            ),
          ),
        ],
      },
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('selectionController', selectionController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('monthBuilder', monthBuilder))
      ..add(ObjectFlagProperty.has('yearBuilder', yearBuilder))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import 'package:forui/src/widgets/calendar/month/month_picker.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';

@internal
class GridCalendar extends StatelessWidget {
  final FGridCalendarController controller;
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

  const GridCalendar({
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
          SizedBox(height: style.dayPickerStyle.headerSpacing),
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
          SizedBox(height: style.monthPickerStyle.headerSpacing),
          SizedBox(
            height: height - style.monthPickerStyle.headerSpacing,
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
          SizedBox(height: style.yearPickerStyle.headerSpacing),
          SizedBox(
            height: height - style.yearPickerStyle.headerSpacing,
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

@internal
class GridSplitCalendar extends StatelessWidget {
  final FGridSplitCalendarController controller;
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

  const GridSplitCalendar({
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
            child: SplitHeader(
              style: style.headerStyle,
              localizations: localizations,
              date: controller.day.current,
              previousSemanticsLabel: localizations.calendarPreviousMonthSemanticsLabel,
              nextSemanticsLabel: localizations.calendarNextMonthSemanticsLabel,
              month: false,
              year: false,
              onMonth: controller.toggleMonthPicker,
              onYear: controller.toggleYear,
              onPrevious: controller.day.hasPrevious ? controller.day.previous : null,
              onNext: controller.day.hasNext ? controller.day.next : null,
            ),
          ),
          SizedBox(height: style.dayPickerStyle.headerSpacing),
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
            // The month grid shows a single year; the year is changed via the year target.
            child: SplitHeader.single(
              style: style.headerStyle,
              localizations: localizations,
              date: controller.day.current,
              month: true,
              year: false,
              onMonth: controller.toggleMonthPicker,
              onYear: controller.toggleYear,
            ),
          ),
          SizedBox(height: style.monthPickerStyle.headerSpacing),
          SizedBox(
            height: height - style.monthPickerStyle.headerSpacing,
            child: Align(
              alignment: .topCenter,
              child: MonthPicker(
                controller: controller.month,
                style: style.monthPickerStyle,
                localization: localizations,
                paged: false,
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
            child: SplitHeader(
              style: style.headerStyle,
              localizations: localizations,
              date: controller.day.current,
              previousSemanticsLabel: localizations.calendarPreviousYearsSemanticsLabel,
              nextSemanticsLabel: localizations.calendarNextYearsSemanticsLabel,
              month: false,
              year: true,
              onMonth: controller.toggleMonthPicker,
              onYear: controller.toggleYear,
              onPrevious: controller.year.hasPrevious ? controller.year.previous : null,
              onNext: controller.year.hasNext ? controller.year.next : null,
            ),
          ),
          SizedBox(height: style.yearPickerStyle.headerSpacing),
          SizedBox(
            height: height - style.yearPickerStyle.headerSpacing,
            child: Align(
              alignment: .topCenter,
              child: YearPicker(
                controller: controller.year,
                style: style.yearPickerStyle,
                localization: localizations,
                today: controller.today,
                onPress: (year) => controller.showDayPicker(.utc(year.year, controller.currentMonth.month)),
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

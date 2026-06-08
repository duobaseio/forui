import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
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
  final ScrollPhysics? dayScrollPhysics;
  final ScrollCacheExtent? dayScrollCacheExtent;
  final ScrollBehavior? dayScrollBehavior;
  final ScrollPhysics? monthScrollPhysics;
  final ScrollCacheExtent? monthScrollCacheExtent;
  final ScrollBehavior? monthScrollBehavior;
  final ScrollPhysics? yearScrollPhysics;
  final ScrollCacheExtent? yearScrollCacheExtent;
  final ScrollBehavior? yearScrollBehavior;
  final ValueChanged<DateTime> onDayPress;
  final ValueChanged<DateTime> onDayLongPress;
  final FCalendarHeaderBuilder<FGridCalendarController> headerBuilder;
  final FCalendarFooterBuilder<FGridCalendarController> footerBuilder;
  final FCalendarDayBuilder dayBuilder;
  final FCalendarMonthBuilder monthBuilder;
  final FCalendarYearBuilder yearBuilder;

  const GridCalendar({
    required this.controller,
    required this.selectionController,
    required this.style,
    required this.localizations,
    required this.width,
    required this.height,
    required this.dayScrollPhysics,
    required this.dayScrollCacheExtent,
    required this.dayScrollBehavior,
    required this.monthScrollPhysics,
    required this.monthScrollCacheExtent,
    required this.monthScrollBehavior,
    required this.yearScrollPhysics,
    required this.yearScrollCacheExtent,
    required this.yearScrollBehavior,
    required this.onDayPress,
    required this.onDayLongPress,
    required this.headerBuilder,
    required this.footerBuilder,
    required this.dayBuilder,
    required this.monthBuilder,
    required this.yearBuilder,
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
            child: headerBuilder(
              context,
              controller,
              selectionController,
              Header.day(
                style: style.headerStyle,
                localizations: localizations,
                monthYear: controller.day.current,
                shown: false,
                onPress: controller.cycle,
                onPrevious: controller.day.hasPrevious ? controller.day.previous : null,
                onNext: controller.day.hasNext ? controller.day.next : null,
              ),
            ),
          ),
          SizedBox(height: style.dayPickerStyle.headerSpacing),
          DayPicker(
            controller: controller.day,
            style: style.dayPickerStyle,
            localization: localizations,
            today: controller.today,
            selected: selectionController.contains,
            scrollPhysics: dayScrollPhysics,
            scrollCacheExtent: dayScrollCacheExtent,
            scrollBehavior: dayScrollBehavior,
            onPress: onDayPress,
            onLongPress: onDayLongPress,
            builder: dayBuilder,
          ),
          footerBuilder(context, controller, selectionController),
        ],
        .month => [
          SizedBox(
            width: width,
            child: headerBuilder(
              context,
              controller,
              selectionController,
              Header.month(
                style: style.headerStyle,
                localizations: localizations,
                year: controller.month.current,
                shown: false,
                onPress: controller.cycle,
                onPrevious: controller.month.hasPrevious ? controller.month.previous : null,
                onNext: controller.month.hasNext ? controller.month.next : null,
              ),
            ),
          ),
          SizedBox(height: style.monthPickerStyle.headerSpacing),
          SizedBox(
            width: width,
            height: height - style.monthPickerStyle.headerSpacing,
            child: Align(
              alignment: .topCenter,
              child: MonthPicker(
                controller: controller.month,
                style: style.monthPickerStyle,
                localization: localizations,
                today: controller.today,
                scrollPhysics: monthScrollPhysics,
                scrollCacheExtent: monthScrollCacheExtent,
                scrollBehavior: monthScrollBehavior,
                onPress: controller.jumpToDayPicker,
                builder: monthBuilder,
              ),
            ),
          ),
          footerBuilder(context, controller, selectionController),
        ],
        .year => [
          SizedBox(
            width: width,
            child: headerBuilder(
              context,
              controller,
              selectionController,
              Header.year(
                style: style.headerStyle,
                localizations: localizations,
                decade: controller.year.current,
                shown: false,
                onPress: controller.cycle,
                onPrevious: controller.year.hasPrevious ? controller.year.previous : null,
                onNext: controller.year.hasNext ? controller.year.next : null,
              ),
            ),
          ),
          SizedBox(height: style.yearPickerStyle.headerSpacing),
          SizedBox(
            width: width,
            height: height - style.yearPickerStyle.headerSpacing,
            child: Align(
              alignment: .topCenter,
              child: YearPicker(
                controller: controller.year,
                style: style.yearPickerStyle,
                localization: localizations,
                today: controller.today,
                scrollPhysics: yearScrollPhysics,
                scrollCacheExtent: yearScrollCacheExtent,
                scrollBehavior: yearScrollBehavior,
                onPress: controller.jumpToMonthPicker,
                builder: yearBuilder,
              ),
            ),
          ),
          footerBuilder(context, controller, selectionController),
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
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height))
      ..add(DiagnosticsProperty('dayScrollPhysics', dayScrollPhysics))
      ..add(DiagnosticsProperty('dayScrollCacheExtent', dayScrollCacheExtent))
      ..add(DiagnosticsProperty('dayScrollBehavior', dayScrollBehavior))
      ..add(DiagnosticsProperty('monthScrollPhysics', monthScrollPhysics))
      ..add(DiagnosticsProperty('monthScrollCacheExtent', monthScrollCacheExtent))
      ..add(DiagnosticsProperty('monthScrollBehavior', monthScrollBehavior))
      ..add(DiagnosticsProperty('yearScrollPhysics', yearScrollPhysics))
      ..add(DiagnosticsProperty('yearScrollCacheExtent', yearScrollCacheExtent))
      ..add(DiagnosticsProperty('yearScrollBehavior', yearScrollBehavior))
      ..add(ObjectFlagProperty.has('onPress', onDayPress))
      ..add(ObjectFlagProperty.has('onLongPress', onDayLongPress))
      ..add(ObjectFlagProperty.has('headerBuilder', headerBuilder))
      ..add(ObjectFlagProperty.has('footerBuilder', footerBuilder))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('monthBuilder', monthBuilder))
      ..add(ObjectFlagProperty.has('yearBuilder', yearBuilder));
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
  final ScrollPhysics? dayScrollPhysics;
  final ScrollCacheExtent? dayScrollCacheExtent;
  final ScrollBehavior? dayScrollBehavior;
  final ScrollPhysics? yearScrollPhysics;
  final ScrollCacheExtent? yearScrollCacheExtent;
  final ScrollBehavior? yearScrollBehavior;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;
  final FCalendarHeaderBuilder<FGridSplitCalendarController> headerBuilder;
  final FCalendarFooterBuilder<FGridSplitCalendarController> footerBuilder;
  final FCalendarDayBuilder dayBuilder;
  final FCalendarMonthBuilder monthBuilder;
  final FCalendarYearBuilder yearBuilder;

  const GridSplitCalendar({
    required this.controller,
    required this.selectionController,
    required this.style,
    required this.localizations,
    required this.width,
    required this.height,
    required this.dayScrollPhysics,
    required this.dayScrollCacheExtent,
    required this.dayScrollBehavior,
    required this.yearScrollPhysics,
    required this.yearScrollCacheExtent,
    required this.yearScrollBehavior,
    required this.onPress,
    required this.onLongPress,
    required this.headerBuilder,
    required this.footerBuilder,
    required this.dayBuilder,
    required this.monthBuilder,
    required this.yearBuilder,
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
            child: headerBuilder(
              context,
              controller,
              selectionController,
              SplitHeader(
                style: style.headerStyle,
                localizations: localizations,
                date: controller.day.current,
                previousSemanticsLabel: localizations.calendarPreviousMonthSemanticsLabel,
                nextSemanticsLabel: localizations.calendarNextMonthSemanticsLabel,
                month: false,
                year: false,
                onMonth: controller.toggleMonthPicker,
                onYear: controller.toggleYearPicker,
                onPrevious: controller.day.hasPrevious ? controller.day.previous : null,
                onNext: controller.day.hasNext ? controller.day.next : null,
              ),
            ),
          ),
          SizedBox(height: style.dayPickerStyle.headerSpacing),
          DayPicker(
            controller: controller.day,
            style: style.dayPickerStyle,
            localization: localizations,
            today: controller.today,
            selected: selectionController.contains,
            scrollPhysics: dayScrollPhysics,
            scrollCacheExtent: dayScrollCacheExtent,
            scrollBehavior: dayScrollBehavior,
            onPress: onPress,
            onLongPress: onLongPress,
            builder: dayBuilder,
          ),
          footerBuilder(context, controller, selectionController),
        ],
        .month => [
          SizedBox(
            width: width,
            // The month grid shows a single year; the year is changed via the year target.
            child: headerBuilder(
              context,
              controller,
              selectionController,
              SplitHeader.single(
                style: style.headerStyle,
                localizations: localizations,
                date: controller.day.current,
                month: true,
                year: false,
                onMonth: controller.toggleMonthPicker,
                onYear: controller.toggleYearPicker,
              ),
            ),
          ),
          SizedBox(height: style.monthPickerStyle.headerSpacing),
          SizedBox(
            width: width,
            height: height - style.monthPickerStyle.headerSpacing,
            child: Align(
              alignment: .topCenter,
              child: MonthPicker.single(
                controller: controller.month,
                style: style.monthPickerStyle,
                localization: localizations,
                today: controller.today,
                onPress: controller.jumpToDayPicker,
                builder: monthBuilder,
              ),
            ),
          ),
          footerBuilder(context, controller, selectionController),
        ],
        .year => [
          SizedBox(
            width: width,
            child: headerBuilder(
              context,
              controller,
              selectionController,
              SplitHeader(
                style: style.headerStyle,
                localizations: localizations,
                date: controller.day.current,
                previousSemanticsLabel: localizations.calendarPreviousYearsSemanticsLabel,
                nextSemanticsLabel: localizations.calendarNextYearsSemanticsLabel,
                month: false,
                year: true,
                onMonth: controller.toggleMonthPicker,
                onYear: controller.toggleYearPicker,
                onPrevious: controller.year.hasPrevious ? controller.year.previous : null,
                onNext: controller.year.hasNext ? controller.year.next : null,
              ),
            ),
          ),
          SizedBox(height: style.yearPickerStyle.headerSpacing),
          SizedBox(
            width: width,
            height: height - style.yearPickerStyle.headerSpacing,
            child: Align(
              alignment: .topCenter,
              child: YearPicker(
                controller: controller.year,
                style: style.yearPickerStyle,
                localization: localizations,
                today: controller.today,
                scrollPhysics: yearScrollPhysics,
                scrollCacheExtent: yearScrollCacheExtent,
                scrollBehavior: yearScrollBehavior,
                onPress: (year) => controller.jumpToDayPicker(.utc(year.year, controller.currentMonth.month)),
                builder: yearBuilder,
              ),
            ),
          ),
          footerBuilder(context, controller, selectionController),
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
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height))
      ..add(DiagnosticsProperty('dayScrollPhysics', dayScrollPhysics))
      ..add(DiagnosticsProperty('dayScrollCacheExtent', dayScrollCacheExtent))
      ..add(DiagnosticsProperty('dayScrollBehavior', dayScrollBehavior))
      ..add(DiagnosticsProperty('yearScrollPhysics', yearScrollPhysics))
      ..add(DiagnosticsProperty('yearScrollCacheExtent', yearScrollCacheExtent))
      ..add(DiagnosticsProperty('yearScrollBehavior', yearScrollBehavior))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('headerBuilder', headerBuilder))
      ..add(ObjectFlagProperty.has('footerBuilder', footerBuilder))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('monthBuilder', monthBuilder))
      ..add(ObjectFlagProperty.has('yearBuilder', yearBuilder));
  }
}

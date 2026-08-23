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
class const GridCalendar({
  required final FGridCalendarController controller,
  required final FDateSelectionController<Object?> selectionController,
  required final FCalendarStyle style,
  required final FLocalizations localizations,
  required final double width,
  required final double height,
  required final bool fixedWeeks,
  required final ScrollPhysics? dayScrollPhysics,
  required final ScrollCacheExtent? dayScrollCacheExtent,
  required final ScrollBehavior? dayScrollBehavior,
  required final ScrollPhysics? monthScrollPhysics,
  required final ScrollCacheExtent? monthScrollCacheExtent,
  required final ScrollBehavior? monthScrollBehavior,
  required final ScrollPhysics? yearScrollPhysics,
  required final ScrollCacheExtent? yearScrollCacheExtent,
  required final ScrollBehavior? yearScrollBehavior,
  required final ValueChanged<DateTime> onDayPress,
  required final ValueChanged<DateTime> onDayLongPress,
  required final FCalendarHeaderBuilder<FGridCalendarController> headerBuilder,
  required final FCalendarFooterBuilder<FGridCalendarController> footerBuilder,
  required final FCalendarDayBuilder dayBuilder,
  required final FCalendarMonthBuilder monthBuilder,
  required final FCalendarYearBuilder yearBuilder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
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
              semanticsHint: localizations.calendarShowMonthPickerSemanticsHint,
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
          clipPadding: style.padding,
          localization: localizations,
          today: controller.today,
          selected: selectionController.contains,
          fixedWeeks: fixedWeeks,
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
              semanticsHint: localizations.calendarShowYearPickerSemanticsHint,
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
              semanticsHint: localizations.calendarShowDaysSemanticsHint,
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
      ..add(FlagProperty('fixedWeeks', value: fixedWeeks, ifTrue: 'fixedWeeks'))
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
class const GridSplitCalendar({
  required final FGridSplitCalendarController controller,
  required final FDateSelectionController<Object?> selectionController,
  required final FCalendarStyle style,
  required final FLocalizations localizations,
  required final double width,
  required final double height,
  required final bool fixedWeeks,
  required final ScrollPhysics? dayScrollPhysics,
  required final ScrollCacheExtent? dayScrollCacheExtent,
  required final ScrollBehavior? dayScrollBehavior,
  required final ScrollPhysics? yearScrollPhysics,
  required final ScrollCacheExtent? yearScrollCacheExtent,
  required final ScrollBehavior? yearScrollBehavior,
  required final ValueChanged<DateTime> onPress,
  required final ValueChanged<DateTime> onLongPress,
  required final FCalendarHeaderBuilder<FGridSplitCalendarController> headerBuilder,
  required final FCalendarFooterBuilder<FGridSplitCalendarController> footerBuilder,
  required final FCalendarDayBuilder dayBuilder,
  required final FCalendarMonthBuilder monthBuilder,
  required final FCalendarYearBuilder yearBuilder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
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
          clipPadding: style.padding,
          localization: localizations,
          today: controller.today,
          selected: selectionController.contains,
          fixedWeeks: fixedWeeks,
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
      ..add(FlagProperty('fixedWeeks', value: fixedWeeks, ifTrue: 'fixedWeeks'))
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

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/header.dart';

@internal
class const WheelCalendar({
  required final FWheelCalendarController controller,
  required final FDateSelectionController<Object?> selectionController,
  required final FCalendarStyle style,
  required final FLocalizations localizations,
  required final double width,
  required final double height,
  required final bool fixedWeeks,
  required final ScrollPhysics? dayScrollPhysics,
  required final ScrollCacheExtent? dayScrollCacheExtent,
  required final ScrollBehavior? dayScrollBehavior,
  required final bool loop,
  required final int monthFlex,
  required final int yearFlex,
  required final ValueChanged<DateTime> onDayPress,
  required final ValueChanged<DateTime> onDayLongPress,
  required final FCalendarHeaderBuilder<FWheelCalendarController> headerBuilder,
  required final FCalendarFooterBuilder<FWheelCalendarController> footerBuilder,
  required final FCalendarDayBuilder dayBuilder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: controller.monthYear
        ? [
            SizedBox(
              width: width,
              child: headerBuilder(
                context,
                controller,
                selectionController,
                Header.singleDay(
                  style: style.headerStyle,
                  localizations: localizations,
                  monthYear: controller.currentMonth,
                  semanticsHint: localizations.calendarShowMonthYearPickerSemanticsHint,
                  shown: true,
                  onPress: controller.toggleMonthYearPicker,
                ),
              ),
            ),
            SizedBox(height: style.dayPickerStyle.headerSpacing),
            SizedBox(
              width: width,
              height: height,
              child: FPicker(
                style: style.wheelPickerStyle,
                control: .lifted(
                  indexes: [controller.currentMonth.month - 1, controller.currentMonth.year - controller.start.year],
                  onChange: (indexes) => controller.setMonthYear(indexes[0] + 1, controller.start.year + indexes[1]),
                ),
                children: [
                  FPickerWheel(
                    loop: loop,
                    flex: monthFlex,
                    children: [
                      for (var month = 1; month <= 12; month++)
                        Center(child: Text(DateFormat.MMM(localizations.localeName).format(.utc(2000, month)))),
                    ],
                  ),
                  FPickerWheel(
                    flex: yearFlex,
                    children: [
                      for (var year = controller.start.year; year <= controller.end.year; year++)
                        Center(child: Text(DateFormat.y(localizations.localeName).format(.utc(year)))),
                    ],
                  ),
                ],
              ),
            ),
            footerBuilder(context, controller, selectionController),
          ]
        : [
            SizedBox(
              width: width,
              child: headerBuilder(
                context,
                controller,
                selectionController,
                Header.day(
                  style: style.headerStyle,
                  localizations: localizations,
                  monthYear: controller.currentMonth,
                  semanticsHint: localizations.calendarShowMonthYearPickerSemanticsHint,
                  shown: false,
                  onPress: controller.toggleMonthYearPicker,
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
      ..add(FlagProperty('loop', value: loop, ifTrue: 'loop'))
      ..add(IntProperty('monthFlex', monthFlex))
      ..add(IntProperty('yearFlex', yearFlex))
      ..add(ObjectFlagProperty.has('onPress', onDayPress))
      ..add(ObjectFlagProperty.has('onLongPress', onDayLongPress))
      ..add(ObjectFlagProperty.has('headerBuilder', headerBuilder))
      ..add(ObjectFlagProperty.has('footerBuilder', footerBuilder))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder));
  }
}

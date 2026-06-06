import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/header.dart';

@internal
class WheelCalendar extends StatelessWidget {
  final FWheelCalendarController controller;
  final FDateSelectionController selectionController;
  final FCalendarStyle style;
  final FLocalizations localizations;
  final double width;
  final double height;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;
  final FCalendarDayBuilder dayBuilder;

  const WheelCalendar({
    required this.controller,
    required this.selectionController,
    required this.style,
    required this.localizations,
    required this.onPress,
    required this.onLongPress,
    required this.dayBuilder,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => Column(
      mainAxisSize: .min,
      children: controller.monthYear
          ? [
              SizedBox(
                width: width,
                child: Header.singleDay(
                  style: style.headerStyle,
                  localizations: localizations,
                  monthYear: controller.currentMonth,
                  shown: true,
                  onPress: controller.toggleMonthYearPicker,
                ),
              ),
              SizedBox(height: style.dayPickerStyle.headerSpacing),
              SizedBox(
                width: width,
                height: height,
                child: FPicker(
                  control: .lifted(
                    indexes: [controller.currentMonth.month - 1, controller.currentMonth.year - controller.start.year],
                    onChange: (indexes) => controller.setMonthYear(indexes[0] + 1, controller.start.year + indexes[1]),
                  ),
                  children: [
                    FPickerWheel(
                      children: [
                        for (var month = 1; month <= 12; month++)
                          Center(child: Text(localizations.abbreviatedMonth(.utc(2000, month)))),
                      ],
                    ),
                    FPickerWheel(
                      children: [
                        for (var year = controller.start.year; year <= controller.end.year; year++)
                          Center(child: Text(localizations.year(.utc(year)))),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          : [
              SizedBox(
                width: width,
                child: Header.day(
                  style: style.headerStyle,
                  localizations: localizations,
                  monthYear: controller.currentMonth,
                  shown: false,
                  onPress: controller.toggleMonthYearPicker,
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
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height));
  }
}

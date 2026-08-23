import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';

/// The state of a line calendar item used to build a line calendar item.
typedef FLineCalendarItemData = ({FLineCalendarStyle style, DateTime date, Set<FLineCalendarItemVariant> variants});

@internal
class const Item({
  required final FDateSelectionController<DateTime?> controller,
  required final FLineCalendarStyle style,
  required final DateTime date,
  required final bool today,
  required final bool Function(DateTime) selectable,
  required final ValueWidgetBuilder<FLineCalendarItemData> builder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: controller,
    builder: (context, selected, _) {
      final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
      final label = DateFormat.yMMMMd(localizations.localeName).format(date);

      return FTappable(
        style: style.tappableStyle,
        semanticsLabel: today ? '$label, ${localizations.calendarTodaySemanticsLabel}' : label,
        selected: selected == date,
        semanticsInMutuallyExclusiveGroup: true,
        excludeSemantics: true,
        onPress: selectable(date) ? () => controller.select(date) : null,
        builder: (context, v, _) {
          final variants = {
            for (final variant in v) variant as FLineCalendarItemVariant,
            if (today) FLineCalendarItemVariant.today,
          };

          return builder(
            context,
            (style: style, date: date, variants: variants),
            Stack(
              children: [
                Positioned.fill(
                  child: ItemContent(style: style, date: date, variants: variants),
                ),
                if (today)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(color: style.todayIndicatorColor.resolve(variants), shape: .circle),
                    ),
                  ),
              ],
            ),
          );
        },
      );
    },
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('today', value: today, ifTrue: 'today'))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

@internal
class const ItemContent({
  required final FLineCalendarStyle style,
  required final DateTime date,
  required final Set<FLineCalendarItemVariant> variants,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return DecoratedBox(
      decoration: style.decoration.resolve(variants),
      child: Padding(
        padding: .symmetric(vertical: style.contentEdgeSpacing),
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: style.contentSpacing,
          children: [
            DefaultTextStyle.merge(
              style: style.weekdayTextStyle.resolve(variants),
              child: Text(localizations.shortWeekDays[date.weekday % 7]),
            ),
            DefaultTextStyle.merge(
              style: style.dateTextStyle.resolve(variants),
              child: Text(DateFormat.d(localizations.localeName).format(date)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('date', date))
      ..add(IterableProperty('variants', variants));
  }
}

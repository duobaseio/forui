import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The state of a line calendar item used to build a line calendar item.
typedef FLineCalendarItemData = ({FLineCalendarStyle style, DateTime date, bool today, Set<FTappableVariant> variants});

@internal
class Item extends StatelessWidget {
  final FCalendarController<DateTime?> controller;
  final FLineCalendarStyle style;
  final DateTime date;
  final bool today;
  final ValueWidgetBuilder<FLineCalendarItemData> builder;

  const Item({
    required this.controller,
    required this.style,
    required this.date,
    required this.today,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: controller,
    builder: (context, selected, _) => FTappable(
      style: style.tappableStyle,
      semanticsLabel: (FLocalizations.of(context) ?? FDefaultLocalizations()).fullDate(date),
      selected: selected == date,
      onPress: controller.selectable(date) ? () => controller.select(date) : null,
      builder: (context, variants, _) => builder(
        context,
        (style: style, date: date, today: today, variants: variants),
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
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('today', value: today, ifTrue: 'today'))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

@internal
class ItemContent extends StatelessWidget {
  final FLineCalendarStyle style;
  final DateTime date;
  final Set<FTappableVariant> variants;

  const ItemContent({required this.style, required this.date, required this.variants, super.key});

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
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.dateTextStyle.resolve(variants),
              child: Text(localizations.day(date)),
            ),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.weekdayTextStyle.resolve(variants),
              child: Text(localizations.shortWeekDays[date.weekday % 7]),
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
      ..add(IterableProperty('states', variants));
  }
}

import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' show DateFormat;

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:forui/src/widgets/calendar/month/month.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

part 'month_picker.design.dart';

const _columns = 3;
const _rows = 4;

@internal
class MonthPicker extends StatelessWidget {
  final FCalendarMonthPickerController controller;
  final FCalendarMonthPickerStyle style;
  final FLocalizations localization;
  final DateTime today;
  final ValueChanged<DateTime> onPress;
  final FCalendarMonthBuilder builder;
  final bool paged;

  const MonthPicker({
    required this.controller,
    required this.style,
    required this.localization,
    required this.today,
    required this.onPress,
    required this.builder,
    required this.paged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = style.monthSize;

    return SizedBox(
      width: _columns * size.width,
      height: _rows * size.height + (_rows - 1) * style.monthSpacing,
      child: GridFocusableActionDetector(
        onFocusMove: controller.move,
        onFocusChange: (focused) {
          if (!focused) {
            controller.focus(null);
            return;
          }

          if (controller.focused == null) {
            final current = controller.current;
            final preferred = today.year == current.year ? today : DateTime.utc(current.year);
            controller.focus(controller.focusable(current, preferred));
          }
        },
        child: PageView.builder(
          controller: controller.controller,
          physics: paged ? null : const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            controller.onPageChange(page);
            SemanticsService.sendAnnouncement(
              View.of(context),
              DateFormat.y(localization.localeName).format(controller.to(page)),
              Directionality.of(context),
            );
          },
          itemCount: controller.pages,
          itemBuilder: (_, page) => ListenableBuilder(
            listenable: controller,
            builder: (_, _) => _Grid(
              style: style,
              localization: localization,
              year: controller.to(page),
              today: today,
              focused: controller.focused,
              selectable: controller.selectable,
              onPress: onPress,
              builder: builder,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localization', localization))
      ..add(DiagnosticsProperty('today', today))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(FlagProperty('paged', value: paged, ifTrue: 'paged', ifFalse: 'not paged'));
  }
}

class _Grid extends StatefulWidget {
  final FCalendarMonthPickerStyle style;
  final FLocalizations localization;
  final DateTime year;
  final DateTime today;
  final DateTime? focused;
  final bool Function(DateTime) selectable;
  final ValueChanged<DateTime> onPress;
  final FCalendarMonthBuilder builder;

  _Grid({
    required this.style,
    required this.localization,
    required this.year,
    required this.today,
    required this.focused,
    required this.selectable,
    required this.onPress,
    required this.builder,
  }) : super(key: ValueKey(year));

  @override
  State createState() => _GridState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localization', localization))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _GridState extends State<_Grid> {
  final SplayTreeMap<DateTime, FocusNode> _months = SplayTreeMap();

  @override
  void initState() {
    super.initState();
    for (var month = DateTime.utc(widget.year.year), i = 0; i < 12; month = month.plus(months: 1), i++) {
      _months[month] = FocusNode(skipTraversal: true, debugLabel: '$month');
    }

    _months[widget.focused]?.requestFocus();
  }

  @override
  void didUpdateWidget(_Grid old) {
    super.didUpdateWidget(old);
    if (old.focused != widget.focused) {
      _months[widget.focused]?.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _months.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FCalendarMonthPickerStyle(:monthStyles, :monthSize, :monthSpacing) = widget.style;
    final today = widget.today.truncate(to: DateUnit.months);

    return GridView.custom(
      padding: .zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: GridDelegate(monthSize, _columns, monthSpacing),
      childrenDelegate: SliverChildListDelegate(addRepaintBoundaries: false, [
        for (final MapEntry(key: month, value: focusNode) in _months.entries)
          Month(
            styles: monthStyles,
            localizations: widget.localization,
            date: month,
            focusNode: focusNode,
            variants: {if (month == today) .today},
            onPress: widget.selectable(month) ? () => widget.onPress(month) : null,
            builder: widget.builder,
          ),
      ]),
    );
  }
}

/// Controls a calendar's month picker.
class FCalendarMonthPickerController extends GridController {
  /// Creates a [FCalendarMonthPickerController].
  FCalendarMonthPickerController({
    required super.start,
    required super.end,
    required super.selectable,
    required super.initial,
    super.focused,
  }) : super(
         columns: _columns,
         focusable: (year, date) {
           final preferred = DateTime.utc(year.year, date.month);
           if (selectable(preferred)) {
             return preferred;
           }

           for (var month = DateTime.utc(year.year); month.year == year.year; month = month.plus(months: 1)) {
             if (selectable(month)) {
               return month;
             }
           }

           return null;
         },
         step: (date, amount) => date.plus(months: amount),
         from: (date) => date.year - start.year,
         to: (page) => .utc(start.year + page),
       );
}

/// A month picker's style.
class FCalendarMonthPickerStyle with Diagnosticable, _$FCalendarMonthPickerStyleFunctions {
  /// The styles of the month tiles.
  @override
  final FCalendarMonthStyles monthStyles;

  /// The size of each month. Defaults to a width that aligns the 3-column grid with the day picker's 7-column grid.
  @override
  final Size monthSize;

  /// The vertical spacing between rows of months in the month picker. Defaults to 4.
  @override
  final double monthSpacing;

  /// Creates a [FCalendarMonthPickerStyle].
  const FCalendarMonthPickerStyle({required this.monthStyles, required this.monthSize, this.monthSpacing = 4});

  /// Creates a [FCalendarMonthPickerStyle] that inherits its properties.
  factory FCalendarMonthPickerStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) => FCalendarMonthPickerStyle(
    monthStyles: .inherit(colors: colors, typography: typography, style: style),
    monthSize: Size(DateTime.daysPerWeek * style.sizes.calendar / _columns, style.sizes.calendar),
  );
}

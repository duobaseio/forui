import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/widgets/calendar/day/day.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

@SentinelValues(FCalendarDayPickerStyle, {'startDayOfWeek': '-1'})
part 'day_picker.design.dart';

/// The maximum number of rows: 6 week-rows + 1 weekday header.
const _rows = 7;

@internal
class DayPicker extends StatelessWidget {
  final FCalendarDayPickerController controller;
  final FCalendarDayPickerStyle style;
  final FLocalizations localization;
  final DateTime today;
  final bool Function(DateTime) selected;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;
  final FCalendarDayBuilder builder;

  const DayPicker({
    required this.controller,
    required this.style,
    required this.localization,
    required this.today,
    required this.selected,
    required this.onPress,
    required this.onLongPress,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = style.daySize;

    return SizedBox(
      width: DateTime.daysPerWeek * size.width,
      height: _rows * size.height + (_rows - 1) * style.daySpacing,
      child: GridFocusableActionDetector(
        onFocusMove: controller.move,
        onFocusChange: (focused) {
          if (!focused) {
            controller.focus(null);
            return;
          }

          if (controller.focused == null) {
            final current = controller.current;
            final preferred = today.year == current.year && today.month == current.month ? today : current;
            controller.focus(controller.focusable(current, preferred));
          }
        },
        child: PageView.builder(
          controller: controller.controller,
          onPageChanged: (page) {
            controller.onPageChange(page);
            SemanticsService.sendAnnouncement(
              View.of(context),
              localization.yearMonth(controller.to(page)),
              Directionality.of(context),
            );
          },
          itemCount: controller.pages,
          itemBuilder: (_, page) => ListenableBuilder(
            listenable: controller,
            builder: (_, _) => _Grid(
              style: style,
              localization: localization,
              month: controller.to(page),
              today: today,
              focused: controller.focused,
              selectable: controller.selectable,
              selected: selected,
              onPress: onPress,
              onLongPress: onLongPress,
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
      ..add(ObjectFlagProperty.has('selected', selected))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _Grid extends StatefulWidget {
  final FCalendarDayPickerStyle style;
  final FLocalizations localization;
  final DateTime month;
  final DateTime today;
  final DateTime? focused;
  final bool Function(DateTime) selectable;
  final bool Function(DateTime) selected;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;
  final FCalendarDayBuilder builder;

  _Grid({
    required this.style,
    required this.localization,
    required this.month,
    required this.today,
    required this.focused,
    required this.selectable,
    required this.selected,
    required this.onPress,
    required this.onLongPress,
    required this.builder,
  }) : super(key: ValueKey(month));

  @override
  State createState() => _GridState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localization', localization))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('selected', selected))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _GridState extends State<_Grid> {
  final SplayTreeMap<DateTime, FocusNode> _days = SplayTreeMap();

  @override
  void initState() {
    super.initState();
    final firstDayOfMonth = widget.month.firstDayOfMonth;
    final lastDayOfMonth = widget.month.lastDayOfMonth;

    final firstDayOfWeek = widget.style.firstDayOfWeek ?? widget.localization.firstDayOfWeek;
    final lastDayOfWeek = firstDayOfWeek == DateTime.monday ? DateTime.sunday : firstDayOfWeek - 1;

    final first = firstDayOfMonth.minus(days: (firstDayOfMonth.weekday - firstDayOfWeek) % 7);
    final last = lastDayOfMonth.plus(days: (lastDayOfWeek - lastDayOfMonth.weekday) % 7);

    for (var date = first; date.isBefore(last) || date.isAtSameMomentAs(last); date = date.plus(days: 1)) {
      _days[date] = FocusNode(skipTraversal: true, debugLabel: '$date');
    }

    if (_days[widget.focused] case final focusNode?) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(_Grid old) {
    super.didUpdateWidget(old);
    if (_days[widget.focused] case final focusNode? when old.focused != widget.focused) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _days.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FCalendarDayPickerStyle(:weekdayTextStyle, :dayStyles, :daySize, :daySpacing) = widget.style;
    final firstDayOfWeek = widget.style.firstDayOfWeek ?? widget.localization.firstDayOfWeek;
    final narrowWeekdays = widget.localization.narrowWeekDays;

    // We slide a window to reduce 3n checks to n + 2 checks.
    final days = <Widget>[];
    final first = _days.firstKey()!;
    var before = widget.selected(first.minus(days: 1));
    var current = widget.selected(first);

    for (final MapEntry(key: date, value: focusNode) in _days.entries) {
      final after = widget.selected(date.plus(days: 1));
      final selectable = widget.selectable(date);

      days.add(
        Day(
          styles: dayStyles,
          localizations: widget.localization,
          date: date,
          focusNode: focusNode,
          variants: {
            if (date.month != widget.month.month) .adjacent,
            if (date == widget.today) .today,
            ?switch ((before, current, after)) {
              (false, true, false) => .single,
              (false, true, true) => .start,
              (true, true, true) => .middle,
              (true, true, false) => .end,
              _ => null,
            },
          },
          onPress: selectable ? () => widget.onPress(date) : null,
          onLongPress: selectable ? () => widget.onLongPress(date) : null,
          builder: widget.builder,
        ),
      );

      before = current;
      current = after;
    }

    return GridView.custom(
      padding: .zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: GridDelegate(daySize, DateTime.daysPerWeek, daySpacing),
      childrenDelegate: SliverChildListDelegate(addRepaintBoundaries: false, [
        for (int i = 0, j = firstDayOfWeek; i < DateTime.daysPerWeek; i++, j++)
          ExcludeSemantics(
            child: Center(child: Text(narrowWeekdays[j % DateTime.daysPerWeek], style: weekdayTextStyle)),
          ),
        ...days,
      ]),
    );
  }
}

/// Controls a calendar's day picker.
class FCalendarDayPickerController extends GridController {
  /// Creates a [FCalendarDayPickerController].
  FCalendarDayPickerController({
    required super.start,
    required super.end,
    required super.selectable,
    required super.initial,
    super.focused,
  }) : super(
    columns: 7,
    focusable: (month, date) {
      final last = month.lastDayOfMonth;
      if (date.day <= last.day) {
        final preferred = DateTime.utc(month.year, month.month, date.day);
        if (selectable(preferred)) {
          return preferred;
        }
      }

      for (var day = month; !day.isAfter(last); day = day.plus(days: 1)) {
        if (selectable(day)) {
          return day;
        }
      }

      return null;
    },
    step: (date, amount) => date.plus(days: amount),
    from: (date) => (date.year - start.year) * 12 + (date.month - start.month),
    to: (page) => .utc(start.year, start.month + page),
  );
}

/// A day picker's style.
class FCalendarDayPickerStyle with Diagnosticable, _$FCalendarDayPickerStyleFunctions {
  /// The spacing between the header and the day picker. Defaults to 0. Does nothing if there is no header.
  @override
  final double headerSpacing;

  /// The text style for the days of the weekday headers.
  @override
  final TextStyle weekdayTextStyle;

  /// The starting day of the week. Defaults to the current locale's preferred starting day.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [firstDayOfWeek] < [DateTime.monday]
  /// * [DateTime.sunday] < [firstDayOfWeek]
  @override
  final int? firstDayOfWeek;

  /// The styles of the day tiles.
  @override
  final FCalendarDayStyles dayStyles;

  /// The size of each day. Defaults to [FSizes.calendar].
  @override
  final Size daySize;

  /// The vertical spacing between days in the day picker. Defaults to 4.
  @override
  final double daySpacing;

  /// Creates a [FCalendarDayPickerStyle].
  const FCalendarDayPickerStyle({
    required this.weekdayTextStyle,
    required this.dayStyles,
    required this.daySize,
    this.headerSpacing = 0,
    this.firstDayOfWeek,
    this.daySpacing = 4,
  }) : assert(
         firstDayOfWeek == null || (DateTime.monday <= firstDayOfWeek && firstDayOfWeek <= DateTime.sunday),
         'firstDayOfWeek ($firstDayOfWeek) must be between DateTime.monday (1) and DateTime.sunday (7)',
       );

  /// Creates a [FCalendarDayPickerStyle] that inherits its properties.
  factory FCalendarDayPickerStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) => FCalendarDayPickerStyle(
    weekdayTextStyle: (touch ? typography.xs2 : typography.xs).copyWith(color: colors.mutedForeground),
    dayStyles: .inherit(colors: colors, typography: typography, style: style),
    daySize: .square(style.sizes.calendar),
  );
}

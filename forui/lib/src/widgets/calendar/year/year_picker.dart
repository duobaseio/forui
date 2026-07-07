import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/grid.dart';
import 'package:forui/src/widgets/calendar/year/year.dart';

part 'year_picker.design.dart';

const _columns = 3;
const _rows = 4;

@internal
class YearPicker extends StatelessWidget {
  final FCalendarYearPickerController controller;
  final FCalendarYearPickerStyle style;
  final FLocalizations localization;
  final DateTime today;
  final ScrollPhysics? scrollPhysics;
  final ScrollCacheExtent? scrollCacheExtent;
  final ScrollBehavior? scrollBehavior;
  final ValueChanged<DateTime> onPress;
  final FCalendarYearBuilder builder;

  const YearPicker({
    required this.controller,
    required this.style,
    required this.localization,
    required this.today,
    required this.scrollPhysics,
    required this.scrollCacheExtent,
    required this.scrollBehavior,
    required this.onPress,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = style.yearSize;

    return SizedBox(
      width: _columns * size.width,
      height: _rows * size.height + (_rows - 1) * style.yearSpacing,
      child: GridFocusableActionDetector(
        onFocusMove: controller.move,
        onFocusPage: (direction, {large = false}) => controller.page(direction * (large ? 10 : 1)),
        onFocusRowEdge: ({required end}) {
          if (controller.focused case DateTime(:final year)) {
            final decade = year - year % 10;
            final column = (year - decade) % _columns;
            // The last row of a decade holds a single year, so clamp to the decade's last year.
            final last = year - column + _columns - 1;
            controller.edge(
              .utc(year - column),
              .utc(last < decade + 9 ? last : decade + 9),
              end: end,
            );
          }
        },
        onFocusChange: (focused) {
          if (!focused) {
            controller.focus(null);
            return;
          }

          if (controller.focused == null) {
            final current = controller.current;
            final preferred = today.year - today.year % 10 == current.year ? today : current;
            controller.focus(controller.focusable(current, preferred));
          }
        },
        child: PageView.builder(
          controller: controller.controller,
          physics: scrollPhysics,
          scrollCacheExtent: scrollCacheExtent,
          scrollBehavior: scrollBehavior,
          onPageChanged: (page) {
            controller.onPageChange(page);
            final decade = controller.to(page);
            final locale = localization.localeName;
            SemanticsService.sendAnnouncement(
              View.of(context),
              '${DateFormat.y(locale).format(decade)} — ${DateFormat.y(locale).format(.utc(decade.year + 9))}',
              Directionality.of(context),
            );
          },
          itemCount: controller.pages,
          itemBuilder: (_, page) => ListenableBuilder(
            listenable: controller,
            builder: (_, _) => _Grid(
              style: style,
              localization: localization,
              decade: controller.to(page),
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
      ..add(DiagnosticsProperty('scrollPhysics', scrollPhysics))
      ..add(DiagnosticsProperty('scrollCacheExtent', scrollCacheExtent))
      ..add(DiagnosticsProperty('scrollBehavior', scrollBehavior))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _Grid extends StatefulWidget {
  final FCalendarYearPickerStyle style;
  final FLocalizations localization;
  final DateTime decade;
  final DateTime today;
  final DateTime? focused;
  final bool Function(DateTime) selectable;
  final ValueChanged<DateTime> onPress;
  final FCalendarYearBuilder builder;

  _Grid({
    required this.style,
    required this.localization,
    required this.decade,
    required this.today,
    required this.focused,
    required this.selectable,
    required this.onPress,
    required this.builder,
  }) : super(key: ValueKey(decade));

  @override
  State createState() => _GridState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localization', localization))
      ..add(DiagnosticsProperty('decade', decade))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _GridState extends State<_Grid> {
  final SplayTreeMap<DateTime, FocusNode> _years = SplayTreeMap();

  @override
  void initState() {
    super.initState();
    for (var year = DateTime.utc(widget.decade.year), i = 0; i < 10; year = year.plus(years: 1), i++) {
      _years[year] = FocusNode(skipTraversal: true, debugLabel: '$year');
    }

    _years[widget.focused]?.requestFocus();
  }

  @override
  void didUpdateWidget(_Grid old) {
    super.didUpdateWidget(old);
    if (old.focused != widget.focused) {
      _years[widget.focused]?.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _years.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FCalendarYearPickerStyle(:yearStyles, :yearSize, :yearSpacing) = widget.style;
    final today = widget.today.truncate(to: DateUnit.years);

    return GridView.custom(
      padding: .zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: GridDelegate(yearSize, _columns, yearSpacing),
      childrenDelegate: SliverChildListDelegate(addRepaintBoundaries: false, [
        for (final MapEntry(key: year, value: focusNode) in _years.entries)
          Year(
            styles: yearStyles,
            localizations: widget.localization,
            date: year,
            focusNode: focusNode,
            variants: {if (year == today) .today},
            onPress: widget.selectable(year) ? () => widget.onPress(year) : null,
            builder: widget.builder,
          ),
      ]),
    );
  }
}

/// Controls a calendar's year picker.
class FCalendarYearPickerController extends GridController {
  /// Creates a [FCalendarYearPickerController].
  FCalendarYearPickerController({
    required super.start,
    required super.end,
    required super.selectable,
    required super.initial,
    super.focused,
  }) : super(
         columns: _columns,
         focusable: (decade, date) {
           final preferred = DateTime.utc(date.year);
           if (decade.year <= preferred.year && preferred.year < decade.year + 10 && selectable(preferred)) {
             return preferred;
           }

           for (var year = decade; year.year < decade.year + 10; year = year.plus(years: 1)) {
             if (selectable(year)) {
               return year;
             }
           }

           return null;
         },
         step: (date, amount) => date.plus(years: amount),
         from: (date) => (date.year - date.year % 10 - (start.year - start.year % 10)) ~/ 10,
         to: (page) => .utc(start.year - start.year % 10 + page * 10),
       );
}

/// A year picker's style.
class FCalendarYearPickerStyle with Diagnosticable, _$FCalendarYearPickerStyleFunctions {
  /// The spacing between the header and the year picker. Defaults to 6. Does nothing if there is no header.
  @override
  final double headerSpacing;

  /// The styles of the year tiles.
  @override
  final FCalendarYearStyles yearStyles;

  /// The size of each year. Defaults to a width that aligns the 3-column grid with the day picker's 7-column grid.
  @override
  final Size yearSize;

  /// The vertical spacing between rows of years in the year picker. Defaults to 4.
  @override
  final double yearSpacing;

  /// Creates a [FCalendarYearPickerStyle].
  const FCalendarYearPickerStyle({
    required this.yearStyles,
    required this.yearSize,
    this.headerSpacing = 6,
    this.yearSpacing = 4,
  });

  /// Creates a [FCalendarYearPickerStyle] that inherits its properties.
  factory FCalendarYearPickerStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) => FCalendarYearPickerStyle(
    yearStyles: .inherit(colors: colors, typography: typography, style: style),
    yearSize: Size(DateTime.daysPerWeek * style.sizes.calendar / 3, style.sizes.calendar),
  );
}

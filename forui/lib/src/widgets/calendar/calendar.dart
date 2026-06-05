import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/date_selection_controller.dart';

part 'calendar.design.dart';

/// A calendar.
///
/// The calendar pages are designed to be navigable through swipe gestures on mobile Android, iOS & iPadOS, allowing
/// left and right swipes to transition between pages.
///
/// All [DateTime]s are in UTC timezone. A [FDateSelectionControl] is used to customize the date selection behavior.
/// [DateTime]s outside the start and end dates are unselectable.
///
/// See:
/// * https://forui.dev/docs/widgets/data/calendar for working examples.
/// * [FCalendarControl] for programatically controlling a calendar.
/// * [FDateSelectionControl] for customizing date selection behavior.
/// * [FCalendarStyle] for customizing a calendar's appearance.
class FCalendar extends StatefulWidget {
  /// The default [FCalendarDayBuilder] for a day picker.
  static Widget defaultDayBuilder(
    BuildContext context,
    FCalendarDayStyles styles,
    FLocalizations localizations,
    DateTime date,
    Set<FCalendarDayVariant> variants,
  ) {
    final style = styles.resolve(variants);
    return DecoratedBox(
      decoration: style.background,
      child: DecoratedBox(
        decoration: style.foreground,
        child: Center(child: Text(localizations.day(date), style: style.textStyle)),
      ),
    );
  }

  /// The default [FCalendarMonthBuilder] for a month picker.
  static Widget defaultMonthBuilder(
    BuildContext context,
    FCalendarMonthStyles styles,
    FLocalizations localizations,
    DateTime date,
    Set<FCalendarMonthVariant> variants,
  ) {
    final style = styles.resolve(variants);
    return DecoratedBox(
      decoration: style.decoration,
      child: Center(child: Text(localizations.abbreviatedMonth(date), style: style.textStyle)),
    );
  }

  /// The default [FCalendarYearBuilder] for a year picker.
  static Widget defaultYearBuilder(
    BuildContext context,
    FCalendarYearStyles styles,
    FLocalizations localizations,
    DateTime date,
    Set<FCalendarYearVariant> variants,
  ) {
    final style = styles.resolve(variants);
    return DecoratedBox(
      decoration: style.decoration,
      child: Center(child: Text(localizations.year(date), style: style.textStyle)),
    );
  }

  /// Defines how this calendar's date selection is controlled.
  final FDateSelectionControl selectionControl;

  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FCalendarStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create calendar
  /// ```
  final FCalendarStyleDelta style;

  /// The builder for a day in a day picker. Defaults to [defaultDayBuilder].
  final FCalendarDayBuilder dayBuilder;

  /// A callback for when a day in a day picker is pressed.
  final FutureOr<void> Function(DateTime)? onDayPress;

  /// A callback for when a date in a day picker is long pressed.
  final FutureOr<void> Function(DateTime)? onDayLongPress;

  /// Creates a [FCalendar].
  const FCalendar({
    required this.selectionControl,
    this.style = const .context(),
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.onDayPress,
    this.onDayLongPress,
    super.key,
  });

  @override
  State<FCalendar> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectionControl', selectionControl))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('onDayPress', onDayPress))
      ..add(ObjectFlagProperty.has('onDayLongPress', onDayLongPress));
  }
}

class _State extends State<FCalendar> {
  late FDateSelectionController _selectionController;

  @override
  void initState() {
    super.initState();
    _selectionController = widget.selectionControl.create(_handleOnChange);
  }

  @override
  void didUpdateWidget(covariant FCalendar old) {
    super.didUpdateWidget(old);
    _selectionController = widget.selectionControl
        .update(old.selectionControl, _selectionController, _handleOnChange)
        .$1;
  }

  @override
  void dispose() {
    widget.selectionControl.dispose(_selectionController, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.selectionControl case final FDateSelectionManagedControl control) {
      control.handleOnChange(_selectionController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.calendarStyle);

    // The month and year grids are shorter than the day grid; pad them to its height so swapping views causes no
    // layout shift, leaving the extra space below the grid.
    final width = DateTime.daysPerWeek * style.dayPickerStyle.daySize.width;
    final height = 7 * style.dayPickerStyle.daySize.height + (7 - 1) * style.dayPickerStyle.daySpacing;

    return Container(
      decoration: style.decoration,
      padding: style.padding,
      child: FocusScope(child: Placeholder()),
    );
  }
}

/// [FCalendar]'s style.
class FCalendarStyle with Diagnosticable, _$FCalendarStyleFunctions {
  /// The header's style.
  @override
  final FCalendarHeaderStyle headerStyle;

  /// The day picker's style.
  @override
  final FCalendarDayPickerStyle dayPickerStyle;

  /// The month picker's style.
  @override
  final FCalendarMonthPickerStyle monthPickerStyle;

  /// The year picker's style.
  @override
  final FCalendarYearPickerStyle yearPickerStyle;

  /// The decoration surrounding the header & picker.
  @override
  final Decoration decoration;

  /// The padding surrounding the header & picker. Defaults to `EdgeInsets.all(12)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FCalendarStyle].
  FCalendarStyle({
    required this.headerStyle,
    required this.dayPickerStyle,
    required this.monthPickerStyle,
    required this.yearPickerStyle,
    required this.decoration,
    this.padding = const .all(12),
  });

  /// Creates a [FCalendarStyle] that inherits its properties.
  factory FCalendarStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FIcons icons,
    required FStyle style,
    required bool touch,
  }) => FCalendarStyle(
    headerStyle: .inherit(colors: colors, typography: typography, icons: icons, style: style, touch: touch),
    dayPickerStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
    monthPickerStyle: .inherit(colors: colors, typography: typography, style: style),
    yearPickerStyle: .inherit(colors: colors, typography: typography, style: style),
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(
        side: BorderSide(color: colors.border, width: style.borderWidth),
        borderRadius: style.borderRadius.md,
      ),
      color: colors.card,
    ),
  );
}

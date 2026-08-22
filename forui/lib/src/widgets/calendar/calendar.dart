import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/calendar_controller.dart';
import 'package:forui/src/widgets/calendar/date_selection_controller.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/grid_calendar.dart';
import 'package:forui/src/widgets/calendar/wheel_calendar.dart';

part 'calendar.design.dart';

/// Builds a [FCalendar]'s header. The [child] is the always default header for the currently shown picker.
typedef FCalendarHeaderBuilder<C extends FCalendarController> = Widget Function(
  BuildContext context,
  C controller,
  FDateSelectionController<Object?> selectionController,
  Widget child,
);

/// Builds a [FCalendar]'s footer, shown below the picker.
typedef FCalendarFooterBuilder<C extends FCalendarController> = Widget Function(
  BuildContext context,
  C controller,
  FDateSelectionController<Object?> selectionController,
);

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
/// * [FCalendarControl] for programmatically controlling a calendar.
/// * [FDateSelectionControl] for customizing date selection behavior.
/// * [FCalendarStyle] for customizing a calendar's appearance.
class FCalendar extends StatefulWidget {
  /// The default [FCalendarHeaderBuilder] which returns the given [child] unchanged.
  static Widget defaultHeaderBuilder<C extends FCalendarController>(
    BuildContext context,
    C controller,
    FDateSelectionController<Object?> selectionController,
    Widget child,
  ) => child;

  /// The default [FCalendarFooterBuilder] which renders no footer.
  static Widget defaultFooterBuilder<C extends FCalendarController>(
    BuildContext context,
    C controller,
    FDateSelectionController<Object?> selectionController,
  ) => const SizedBox.shrink();

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
        child: Center(child: Text(DateFormat.d(localizations.localeName).format(date), style: style.textStyle)),
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
      child: Center(child: Text(DateFormat.MMM(localizations.localeName).format(date), style: style.textStyle)),
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
      child: Center(child: Text(DateFormat.y(localizations.localeName).format(date), style: style.textStyle)),
    );
  }

  /// Defines how this calendar's navigation is controlled.
  final FCalendarControl control;

  /// Defines how this calendar's date selection is controlled.
  final FDateSelectionControl<Object?> selectionControl;

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

  /// A callback for when a day in a day picker is pressed.
  final FutureOr<void> Function(DateTime)? onDayPress;

  /// A callback for when a date in a day picker is long pressed.
  final FutureOr<void> Function(DateTime)? onDayLongPress;

  /// Whether the day grid always shows 6 week-rows instead of adapting its height to the month's 4-6 weeks. Defaults
  /// to false.
  final bool fixedWeeks;

  /// Builds the inner calendar widget for the chosen variant from its resolved controller and presentation inputs.
  final Widget Function(
    BuildContext context,
    FCalendarController controller,
    FDateSelectionController<Object?> selectionController,
    FCalendarStyle style,
    FLocalizations localizations,
    double width,
    double height,
    ValueChanged<DateTime> onDayPress,
    ValueChanged<DateTime> onDayLongPress,
  )
  _builder;

  /// Creates a [FCalendar] that cycles through the day, month and year grid pickers.
  new grid({
    required FDateSelectionControl<Object?> selectionControl,
    FGridCalendarControl control = const FGridCalendarControl(),
    FCalendarStyleDelta style = const .context(),
    bool fixedWeeks = false,
    ScrollPhysics? dayScrollPhysics,
    ScrollCacheExtent? dayScrollCacheExtent,
    ScrollBehavior? dayScrollBehavior,
    ScrollPhysics? monthScrollPhysics,
    ScrollCacheExtent? monthScrollCacheExtent,
    ScrollBehavior? monthScrollBehavior,
    ScrollPhysics? yearScrollPhysics,
    ScrollCacheExtent? yearScrollCacheExtent,
    ScrollBehavior? yearScrollBehavior,
    FCalendarHeaderBuilder<FGridCalendarController> headerBuilder = defaultHeaderBuilder,
    FCalendarFooterBuilder<FGridCalendarController> footerBuilder = defaultFooterBuilder,
    FCalendarDayBuilder dayBuilder = defaultDayBuilder,
    FCalendarMonthBuilder monthBuilder = defaultMonthBuilder,
    FCalendarYearBuilder yearBuilder = defaultYearBuilder,
    FutureOr<void> Function(DateTime)? onDayPress,
    FutureOr<void> Function(DateTime)? onDayLongPress,
    Key? key,
  }) : this._(
         control: control,
         selectionControl: selectionControl,
         style: style,
         fixedWeeks: fixedWeeks,
         onDayPress: onDayPress,
         onDayLongPress: onDayLongPress,
         key: key,
         builder:
             (
               context,
               controller,
               selectionController,
               style,
               localizations,
               width,
               height,
               onDayPress,
               onDayLongPress,
             ) => GridCalendar(
               controller: controller as FGridCalendarController,
               selectionController: selectionController,
               style: style,
               localizations: localizations,
               width: width,
               height: height,
               fixedWeeks: fixedWeeks,
               dayScrollPhysics: dayScrollPhysics,
               dayScrollCacheExtent: dayScrollCacheExtent,
               dayScrollBehavior: dayScrollBehavior,
               monthScrollPhysics: monthScrollPhysics,
               monthScrollCacheExtent: monthScrollCacheExtent,
               monthScrollBehavior: monthScrollBehavior,
               yearScrollPhysics: yearScrollPhysics,
               yearScrollCacheExtent: yearScrollCacheExtent,
               yearScrollBehavior: yearScrollBehavior,
               onDayPress: onDayPress,
               onDayLongPress: onDayLongPress,
               headerBuilder: headerBuilder,
               footerBuilder: footerBuilder,
               dayBuilder: dayBuilder,
               monthBuilder: monthBuilder,
               yearBuilder: yearBuilder,
             ),
       );

  /// Creates a [FCalendar] with a split header whose month and year grid pickers are independently togglable.
  new splitGrid({
    required FDateSelectionControl<Object?> selectionControl,
    FGridSplitCalendarControl control = const FGridSplitCalendarControl(),
    FCalendarStyleDelta style = const .context(),
    bool fixedWeeks = false,
    ScrollPhysics? dayScrollPhysics,
    ScrollCacheExtent? dayScrollCacheExtent,
    ScrollBehavior? dayScrollBehavior,
    ScrollPhysics? yearScrollPhysics,
    ScrollCacheExtent? yearScrollCacheExtent,
    ScrollBehavior? yearScrollBehavior,
    FCalendarHeaderBuilder<FGridSplitCalendarController> headerBuilder = defaultHeaderBuilder,
    FCalendarFooterBuilder<FGridSplitCalendarController> footerBuilder = defaultFooterBuilder,
    FCalendarDayBuilder dayBuilder = defaultDayBuilder,
    FCalendarMonthBuilder monthBuilder = defaultMonthBuilder,
    FCalendarYearBuilder yearBuilder = defaultYearBuilder,
    FutureOr<void> Function(DateTime)? onDayPress,
    FutureOr<void> Function(DateTime)? onDayLongPress,
    Key? key,
  }) : this._(
         control: control,
         selectionControl: selectionControl,
         style: style,
         fixedWeeks: fixedWeeks,
         onDayPress: onDayPress,
         onDayLongPress: onDayLongPress,
         key: key,
         builder:
             (
               context,
               controller,
               selectionController,
               style,
               localizations,
               width,
               height,
               onDayPress,
               onDayLongPress,
             ) => GridSplitCalendar(
               controller: controller as FGridSplitCalendarController,
               selectionController: selectionController,
               style: style,
               localizations: localizations,
               width: width,
               height: height,
               fixedWeeks: fixedWeeks,
               dayScrollPhysics: dayScrollPhysics,
               dayScrollCacheExtent: dayScrollCacheExtent,
               dayScrollBehavior: dayScrollBehavior,
               yearScrollPhysics: yearScrollPhysics,
               yearScrollCacheExtent: yearScrollCacheExtent,
               yearScrollBehavior: yearScrollBehavior,
               onPress: onDayPress,
               onLongPress: onDayLongPress,
               headerBuilder: headerBuilder,
               footerBuilder: footerBuilder,
               dayBuilder: dayBuilder,
               monthBuilder: monthBuilder,
               yearBuilder: yearBuilder,
             ),
       );

  /// Creates a [FCalendar] that toggles between a day grid picker and a month-year wheel picker.
  new wheel({
    required FDateSelectionControl<Object?> selectionControl,
    FWheelCalendarControl control = const FWheelCalendarControl(),
    FCalendarStyleDelta style = const .context(),
    bool fixedWeeks = false,
    ScrollPhysics? dayScrollPhysics,
    ScrollCacheExtent? dayScrollCacheExtent,
    ScrollBehavior? dayScrollBehavior,
    bool loop = false,
    int monthFlex = 1,
    int yearFlex = 1,
    FCalendarHeaderBuilder<FWheelCalendarController> headerBuilder = defaultHeaderBuilder,
    FCalendarFooterBuilder<FWheelCalendarController> footerBuilder = defaultFooterBuilder,
    FCalendarDayBuilder dayBuilder = defaultDayBuilder,
    FutureOr<void> Function(DateTime)? onDayPress,
    FutureOr<void> Function(DateTime)? onDayLongPress,
    Key? key,
  }) : this._(
         control: control,
         selectionControl: selectionControl,
         style: style,
         fixedWeeks: fixedWeeks,
         onDayPress: onDayPress,
         onDayLongPress: onDayLongPress,
         key: key,
         builder:
             (
               context,
               controller,
               selectionController,
               style,
               localizations,
               width,
               height,
               onDayPress,
               onDayLongPress,
             ) => WheelCalendar(
               controller: controller as FWheelCalendarController,
               selectionController: selectionController,
               style: style,
               localizations: localizations,
               width: width,
               height: height,
               fixedWeeks: fixedWeeks,
               dayScrollPhysics: dayScrollPhysics,
               dayScrollCacheExtent: dayScrollCacheExtent,
               dayScrollBehavior: dayScrollBehavior,
               loop: loop,
               monthFlex: monthFlex,
               yearFlex: yearFlex,
               onDayPress: onDayPress,
               onDayLongPress: onDayLongPress,
               headerBuilder: headerBuilder,
               footerBuilder: footerBuilder,
               dayBuilder: dayBuilder,
             ),
       );

  const new _({
    required this.control,
    required this.selectionControl,
    required this._builder,
    required this.fixedWeeks,
    this.style = const .context(),
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
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('selectionControl', selectionControl))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('fixedWeeks', value: fixedWeeks, ifTrue: 'fixedWeeks'))
      ..add(ObjectFlagProperty.has('onDayPress', onDayPress))
      ..add(ObjectFlagProperty.has('onDayLongPress', onDayLongPress));
  }
}

class _State extends State<FCalendar> {
  late FCalendarController _controller;
  late FDateSelectionController<Object?> _selectionController;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange);
    _selectionController = widget.selectionControl.create(_handleOnSelectionChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.reduceMotion(reduce: context.accessibility.motion != .all);
  }

  @override
  void didUpdateWidget(covariant FCalendar old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleOnChange).$1;
    _selectionController = widget.selectionControl
        .update(old.selectionControl, _selectionController, _handleOnSelectionChange)
        .$1;
    _controller.reduceMotion(reduce: context.accessibility.motion != .all);
  }

  @override
  void dispose() {
    widget.selectionControl.dispose(_selectionController, _handleOnSelectionChange);
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {}

  void _handleOnSelectionChange() {
    if (widget.selectionControl case final FDateSelectionManagedControl<Object?> control) {
      control.handleOnChange(_selectionController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style(context.theme.calendarStyle);
    final dayPickerStyle = style.dayPickerStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    final width = DateTime.daysPerWeek * style.dayPickerStyle.daySize.width;

    return Container(
      decoration: style.decoration,
      padding: style.padding,
      child: FocusScope(
        child: ListenableBuilder(
          listenable: _selectionController,
          builder: (_, _) => ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final rows = widget.fixedWeeks
                  ? 7
                  : _controller.currentMonth.rows(dayPickerStyle.firstDayOfWeek ?? localizations.firstDayOfWeek) + 1;

              return widget._builder(
                context,
                _controller,
                _selectionController,
                style,
                localizations,
                width,
                rows * dayPickerStyle.daySize.height + (rows - 1) * dayPickerStyle.daySpacing,
                (date) async {
                  if (widget.onDayPress?.call(date) case final Future<void> future) {
                    await future;
                  }
                  _selectionController.select(date);
                },
                widget.onDayLongPress ?? (_) {},
              );
            },
          ),
        ),
      ),
    );
  }
}

/// [FCalendar]'s style.
///
/// When [FAccessibility.motion] is:
/// * [FAccessibilityMotion.reduced], only fade transitions are applied.
/// * [FAccessibilityMotion.disabled], no motion is applied.
class FCalendarStyle({
  /// The header's style.
  @override required final FCalendarHeaderStyle headerStyle,

  /// The day picker's style.
  @override required final FCalendarDayPickerStyle dayPickerStyle,

  /// The month picker's style.
  @override required final FCalendarMonthPickerStyle monthPickerStyle,

  /// The year picker's style.
  @override required final FCalendarYearPickerStyle yearPickerStyle,

  /// The wheel picker's style.
  @override required final FPickerStyle wheelPickerStyle,

  /// The decoration surrounding the header & picker.
  @override required final Decoration decoration,

  /// The padding surrounding the header & picker. Defaults to `EdgeInsets.all(12)`.
  @override final EdgeInsetsGeometry padding = const .all(12),
}) with Diagnosticable, _$FCalendarStyleFunctions {
  /// Creates a [FCalendarStyle].
  this;

  /// Creates a [FCalendarStyle] that inherits its properties.
  factory inherit({
    required FColors colors,
    required FTypography typography,
    required FIcons icons,
    required FStyle style,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) => FCalendarStyle(
    headerStyle: .inherit(colors: colors, typography: typography, icons: icons, style: style, touch: touch),
    dayPickerStyle: .inherit(colors: colors, typography: typography, style: style, touch: touch),
    monthPickerStyle: .inherit(colors: colors, typography: typography, style: style),
    yearPickerStyle: .inherit(colors: colors, typography: typography, style: style),
    wheelPickerStyle: .inherit(
      colors: colors,
      style: style,
      typography: typography,
      hapticFeedback: hapticFeedback,
      touch: touch,
    ),
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(
        side: BorderSide(color: colors.border, width: style.borderWidth),
        borderRadius: style.borderRadius.md,
      ),
      color: colors.card,
    ),
  );
}

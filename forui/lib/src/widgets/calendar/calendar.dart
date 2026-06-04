import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class FCalendar {
  /// The default [FCalendarDayBuilder].
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

  /// The default [FCalendarMonthBuilder].
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

  /// The default [FCalendarYearBuilder].
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
}

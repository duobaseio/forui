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
}

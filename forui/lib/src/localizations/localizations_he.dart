// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class FLocalizationsHe extends FLocalizations {
  FLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get barrierLabel => 'מיסוך';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'סגירת \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'לא נמצאו התאמות.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'כרטיסייה $tabIndex מתוך $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'החודש הבא';

  @override
  String get calendarNextYearSemanticsLabel => 'השנה הבאה';

  @override
  String get calendarNextYearsSemanticsLabel => 'השנים הבאות';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'החודש הקודם';

  @override
  String get calendarPreviousYearSemanticsLabel => 'השנה הקודמת';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'השנים הקודמות';

  @override
  String get calendarShowDaysSemanticsHint => 'הצגת הימים';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'הצגת בורר החודש';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'הצגת בורר החודש והשנה';

  @override
  String get calendarShowYearPickerSemanticsHint => 'הצגת בורר השנה';

  @override
  String get calendarTodaySemanticsLabel => 'היום';

  @override
  String get contextMenuSemanticsLabel => 'תפריט הקשר';

  @override
  String get dateFieldHint => 'בחירת תאריך';

  @override
  String get dateFieldInvalidDateError => 'תאריך לא חוקי.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'היום';

  @override
  String get dialogSemanticsLabel => 'תיבת דו-שיח';

  @override
  String get headerBackSemanticsLabel => 'חזרה';

  @override
  String get headerCloseSemanticsLabel => 'סגירה';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'חלון קופץ';

  @override
  String get progressSemanticsLabel => 'טוען';

  @override
  String get multiSelectHint => 'בחר פריטים';

  @override
  String get selectHint => 'בחר פריט';

  @override
  String get selectSearchHint => 'חיפוש';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'גלול למעלה';

  @override
  String get selectScrollDownSemanticsLabel => 'גלול למטה';

  @override
  String get sheetSemanticsLabel => 'גיליו ';

  @override
  String get textFieldEmailLabel => 'דוא״ל';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'סיסמה';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'הסתר סיסמה';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'הראה סיסמה';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'בחר שעה';

  @override
  String get timeFieldInvalidDateError => 'שעה לא חוקית.';
}

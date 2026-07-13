// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class FLocalizationsUr extends FLocalizations {
  FLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get barrierLabel => 'اسکریم';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName بند کریں';
  }

  @override
  String get autocompleteNoResults => 'کوئی میچ نہیں ملا.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount میں سے $tabIndex ٹیب';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'اگلا مہینہ';

  @override
  String get calendarNextYearSemanticsLabel => 'اگلا سال';

  @override
  String get calendarNextYearsSemanticsLabel => 'اگلے سال';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'پچھلا مہینہ';

  @override
  String get calendarPreviousYearSemanticsLabel => 'پچھلا سال';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'پچھلے سال';

  @override
  String get calendarShowDaysSemanticsHint => 'دن دکھائیں';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'مہینہ منتخب کنندہ دکھائیں';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'مہینہ اور سال منتخب کنندہ دکھائیں';

  @override
  String get calendarShowYearPickerSemanticsHint => 'سال منتخب کنندہ دکھائیں';

  @override
  String get calendarTodaySemanticsLabel => 'آج';

  @override
  String get contextMenuSemanticsLabel => 'سیاق و سباق مینو';

  @override
  String get dateFieldHint => 'تاریخ منتخب کریں';

  @override
  String get dateFieldInvalidDateError => 'غلط تاریخ۔';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'آج';

  @override
  String get dialogSemanticsLabel => 'ڈائلاگ';

  @override
  String get headerBackSemanticsLabel => 'پیچھے';

  @override
  String get headerCloseSemanticsLabel => 'بند کریں';

  @override
  String get paginationPreviousSemanticsLabel => 'پچھلا';

  @override
  String get paginationNextSemanticsLabel => 'اگلا';

  @override
  String get popoverSemanticsLabel => 'پاپ اوور';

  @override
  String get progressSemanticsLabel => 'لوڈ ہو رہا ہے';

  @override
  String get multiSelectHint => 'آئٹمز منتخب کریں';

  @override
  String get selectHint => 'آئٹم منتخب کریں';

  @override
  String get selectSearchHint => 'تلاش کریں';

  @override
  String get selectNoResults => 'کوئی مماثل نتائج نہیں۔';

  @override
  String get selectScrollUpSemanticsLabel => 'اوپر سکرول کریں';

  @override
  String get selectScrollDownSemanticsLabel => 'نیچے سکرول کریں';

  @override
  String get sheetSemanticsLabel => 'شیٹ';

  @override
  String get textFieldEmailLabel => 'ای میل';

  @override
  String get textFieldClearButtonSemanticsLabel => 'صاف کریں';

  @override
  String get passwordFieldLabel => 'پاس ورڈ';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'پاس ورڈ چھپائیں';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'پاس ورڈ دکھائیں';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'وقت منتخب کریں';

  @override
  String get timeFieldInvalidDateError => 'غلط وقت۔';

  @override
  String get timePickerHourSemanticsLabel => 'گھنٹہ';

  @override
  String get timePickerMinuteSemanticsLabel => 'منٹ';
}

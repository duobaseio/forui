// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class FLocalizationsFa extends FLocalizations {
  FLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get barrierLabel => 'رویه';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'بستن \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'هیچ تطبیقی یافت نشد.';

  @override
  String autocompleteResults(int count) {
    return '$count نتیجه موجود است';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'پیشنهاد: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'برگه $tabIndex از $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'ماه بعد';

  @override
  String get calendarNextYearSemanticsLabel => 'سال بعد';

  @override
  String get calendarNextYearsSemanticsLabel => 'سال‌های بعد';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'ماه قبل';

  @override
  String get calendarPreviousYearSemanticsLabel => 'سال قبل';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'سال‌های قبل';

  @override
  String get calendarShowDaysSemanticsHint => 'نمایش روزها';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'نمایش انتخابگر ماه';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'نمایش انتخابگر ماه و سال';

  @override
  String get calendarShowYearPickerSemanticsHint => 'نمایش انتخابگر سال';

  @override
  String get calendarTodaySemanticsLabel => 'امروز';

  @override
  String get contextMenuSemanticsLabel => 'منوی زمینه';

  @override
  String get dateFieldHint => 'انتخاب تاریخ';

  @override
  String get dateFieldInvalidDateError => 'تاریخ نامعتبر.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'امروز';

  @override
  String get dialogSemanticsLabel => 'کادر گفتگو';

  @override
  String get headerBackSemanticsLabel => 'برگشت';

  @override
  String get headerCloseSemanticsLabel => 'بستن';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'پاپ‌اور';

  @override
  String get progressSemanticsLabel => 'در حال بارگیری';

  @override
  String get multiSelectHint => 'انتخاب آیتم‌ها';

  @override
  String get selectHint => 'یک مورد را انتخاب کنید';

  @override
  String get selectSearchHint => 'جستجو';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'پیمایش به بالا';

  @override
  String get selectScrollDownSemanticsLabel => 'پیمایش به پایین';

  @override
  String get sheetSemanticsLabel => 'برگ';

  @override
  String get textFieldEmailLabel => 'ایمیل';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'رمز عبور';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'مخفی کردن رمز عبور';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'نمایش رمز عبور';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'یک زمان انتخاب کنید';

  @override
  String get timeFieldInvalidDateError => 'زمان نامعتبر است.';

  @override
  String get timePickerHourSemanticsLabel => 'ساعت';

  @override
  String get timePickerMinuteSemanticsLabel => 'دقیقه';
}

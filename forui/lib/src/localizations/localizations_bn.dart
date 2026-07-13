// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class FLocalizationsBn extends FLocalizations {
  FLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get barrierLabel => 'স্ক্রিম';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName বন্ধ করুন';
  }

  @override
  String get autocompleteNoResults => 'কোনো মিল পাওয়া যায়নি.';

  @override
  String autocompleteResults(int count) {
    return '$countটি ফলাফল উপলব্ধ';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'পরামর্শ: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCountটির মধ্যে $tabIndexটি ট্যাব';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'পরের মাস';

  @override
  String get calendarNextYearSemanticsLabel => 'পরবর্তী বছর';

  @override
  String get calendarNextYearsSemanticsLabel => 'পরবর্তী বছরগুলি';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'আগের মাস';

  @override
  String get calendarPreviousYearSemanticsLabel => 'পূর্ববর্তী বছর';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'পূর্ববর্তী বছরগুলি';

  @override
  String get calendarShowDaysSemanticsHint => 'দিন দেখান';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'মাস নির্বাচক দেখান';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'মাস ও বছর নির্বাচক দেখান';

  @override
  String get calendarShowYearPickerSemanticsHint => 'বছর নির্বাচক দেখান';

  @override
  String get calendarTodaySemanticsLabel => 'আজ';

  @override
  String get contextMenuSemanticsLabel => 'প্রসঙ্গ মেনু';

  @override
  String get dateFieldHint => 'তারিখ বেছে নিন';

  @override
  String get dateFieldInvalidDateError => 'অবৈধ তারিখ।';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'আজ';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'ফিরে যান';

  @override
  String get headerCloseSemanticsLabel => 'বন্ধ করুন';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'পপওভার';

  @override
  String get progressSemanticsLabel => 'লোড হচ্ছে';

  @override
  String get multiSelectHint => 'আইটেম নির্বাচন করুন';

  @override
  String get selectHint => 'একটি আইটেম নির্বাচন করুন';

  @override
  String get selectSearchHint => 'অনুসন্ধান';

  @override
  String get selectNoResults => 'কোন মিলে যাওয়া ফলাফল নেই।';

  @override
  String get selectScrollUpSemanticsLabel => 'উপরে স্ক্রোল করুন';

  @override
  String get selectScrollDownSemanticsLabel => 'নিচে স্ক্রোল করুন';

  @override
  String get sheetSemanticsLabel => 'শীট';

  @override
  String get textFieldEmailLabel => 'ইমেল';

  @override
  String get textFieldClearButtonSemanticsLabel => 'মুছুন';

  @override
  String get passwordFieldLabel => 'পাসওয়ার্ড';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'পাসওয়ার্ড লুকান';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'পাসওয়ার্ড দেখান';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'একটি সময় বেছে নিন';

  @override
  String get timeFieldInvalidDateError => 'অবৈধ সময়।';

  @override
  String get timePickerHourSemanticsLabel => 'ঘণ্টা';

  @override
  String get timePickerMinuteSemanticsLabel => 'মিনিট';
}

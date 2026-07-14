import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// The locales that use non-western digits in their date and time formatting:
/// {@template forui.localizations.scriptNumerals}
///  * Arabic (العربية)
///  * Assamese (অসমীয়া)
///  * Bengali (বাংলা)
///  * Persian/Farsi (فارسی)
///  * Marathi (मराठी)
///  * Burmese (မြန်မာ)
///  * Nepali (नेपाली)
///  * Pashto (پښتو)
///  * Tamil (தமிழ்)
/// {@endtemplate}
@internal
const scriptNumerals = ['ar', 'as', 'bn', 'fa', 'mr', 'my', 'ne', 'ps', 'ta'];

/// The locales which period is written in a script that requires composing:
/// {@template forui.localization.scriptPeriods}
///   * Amharic (አማርኛ)
///   * Kannada (ಕನ್ನಡ)
///   * Korean (한국어)
///   * Punjabi (ਪੰਜਾਬੀ)
///   * Thai (ไทย)
/// {@endtemplate}
///   * Chinese (Hong Kong) (繁體中文)
///   * Chinese (Taiwan) (繁體中文)
@internal
const scriptPeriods = ['am', 'kn', 'ko', 'pa', 'th', 'zh_HK', 'zh_TW'];

/// Localizations for date and time formatting.
extension FDateTimeLocalizations on FLocalizations {
  /// The first day of the week, in ISO 8601 style, where the first day of the week, i.e. index 1, is Monday.
  int get firstDayOfWeek => localeName == '' ? 7 : DateFormat.yMMMMd(localeName).dateSymbols.FIRSTDAYOFWEEK + 1;

  /// Short names for days of the week, starting with Sunday, e.g. 'Sun'.
  List<String> get shortWeekDays => localeName == ''
      ? const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
      : DateFormat.yMMMMd(localeName).dateSymbols.SHORTWEEKDAYS;

  /// Very short names for days of the week, starting with Sunday, e.g. 'Su'.
  List<String> get narrowWeekDays => (localeName == '' || localeName.startsWith('en'))
      ? const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
      : DateFormat.yMMMMd(localeName).dateSymbols.STANDALONENARROWWEEKDAYS;
}

/// The default localization for when no localization is provided.
class FDefaultLocalizations extends FLocalizations {
  static final _localizations = FDefaultLocalizations._();

  /// Creates a [FDefaultLocalizations].
  factory FDefaultLocalizations() => _localizations;

  FDefaultLocalizations._() : super('en_US');

  @override
  String get autocompleteNoResults => 'No matches found.';

  @override
  String autocompleteResults(int count) => count == 1 ? '1 result available' : '$count results available';

  @override
  String autocompleteSuggestion(String suggestion) => 'Suggestion: $suggestion';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) => 'Tab $tabIndex of $tabCount';

  @override
  String barrierOnTapHint(String modalRouteContentName) => 'Close $modalRouteContentName';

  @override
  String get barrierLabel => 'Barrier';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'Back';

  @override
  String get headerCloseSemanticsLabel => 'Close';

  @override
  String get calendarNextMonthSemanticsLabel => 'Next month';

  @override
  String get calendarNextYearSemanticsLabel => 'Next year';

  @override
  String get calendarNextYearsSemanticsLabel => 'Next years';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Previous month';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Previous year';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Previous years';

  @override
  String get calendarShowDaysSemanticsHint => 'Show days';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Show month picker';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Show month and year picker';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Show year picker';

  @override
  String get calendarTodaySemanticsLabel => 'Today';

  @override
  String get contextMenuSemanticsLabel => 'Context menu';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get dateTimePickerToday => 'Today';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Loading';

  @override
  String get multiSelectHint => 'Select items';

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Scroll up';

  @override
  String get selectScrollDownSemanticsLabel => 'Scroll down';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get textFieldEmailLabel => 'Email';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Hide password';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Show password';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timePickerHourSemanticsLabel => 'Hour';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minute';
}

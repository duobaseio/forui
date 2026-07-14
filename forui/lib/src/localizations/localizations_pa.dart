// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class FLocalizationsPa extends FLocalizations {
  FLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get barrierLabel => 'ਸਕ੍ਰਿਮ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName ਨੂੰ ਬੰਦ ਕਰੋ';
  }

  @override
  String get autocompleteNoResults => 'ਕੋਈ ਮੇਲ ਨਹੀਂ ਮਿਲਿਆ.';

  @override
  String autocompleteResults(int count) {
    return '$count ਨਤੀਜੇ ਉਪਲਬਧ';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'ਸੁਝਾਅ: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount ਵਿੱਚੋਂ $tabIndex ਟੈਬ';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'ਅਗਲਾ ਮਹੀਨਾ';

  @override
  String get calendarNextYearSemanticsLabel => 'ਅਗਲਾ ਸਾਲ';

  @override
  String get calendarNextYearsSemanticsLabel => 'ਅਗਲੇ ਸਾਲ';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'ਪਿਛਲਾ ਮਹੀਨਾ';

  @override
  String get calendarPreviousYearSemanticsLabel => 'ਪਿਛਲਾ ਸਾਲ';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'ਪਿਛਲੇ ਸਾਲ';

  @override
  String get calendarShowDaysSemanticsHint => 'ਦਿਨ ਦਿਖਾਓ';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'ਮਹੀਨਾ ਚੋਣਕਾਰ ਦਿਖਾਓ';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'ਮਹੀਨਾ ਅਤੇ ਸਾਲ ਚੋਣਕਾਰ ਦਿਖਾਓ';

  @override
  String get calendarShowYearPickerSemanticsHint => 'ਸਾਲ ਚੋਣਕਾਰ ਦਿਖਾਓ';

  @override
  String get calendarTodaySemanticsLabel => 'ਅੱਜ';

  @override
  String get contextMenuSemanticsLabel => 'ਸੰਦਰਭ ਮੀਨੂ';

  @override
  String get dateFieldHint => 'ਤਾਰੀਖ ਚੁਣੋ';

  @override
  String get dateFieldInvalidDateError => 'ਅਵੈਧ ਤਾਰੀਖ।';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'ਅੱਜ';

  @override
  String get dialogSemanticsLabel => 'ਵਿੰਡੋ';

  @override
  String get headerBackSemanticsLabel => 'ਪਿੱਛੇ';

  @override
  String get headerCloseSemanticsLabel => 'ਬੰਦ ਕਰੋ';

  @override
  String get paginationPreviousSemanticsLabel => 'ਪਿਛਲਾ';

  @override
  String get paginationNextSemanticsLabel => 'ਅੱਗੇ';

  @override
  String get popoverSemanticsLabel => 'ਪੌਪਓਵਰ';

  @override
  String get progressSemanticsLabel => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get multiSelectHint => 'ਆਈਟਮਾਂ ਚੁਣੋ';

  @override
  String get selectHint => 'ਇੱਕ ਆਈਟਮ ਚੁਣੋ';

  @override
  String get selectSearchHint => 'ਖੋਜ';

  @override
  String get selectNoResults => 'ਕੋਈ ਮੇਲ ਖਾਂਦੇ ਨਤੀਜੇ ਨਹੀਂ ਹਨ।';

  @override
  String get selectScrollUpSemanticsLabel => 'ਉੱਪਰ ਸਕ੍ਰੋਲ ਕਰੋ';

  @override
  String get selectScrollDownSemanticsLabel => 'ਹੇਠਾਂ ਸਕ੍ਰੋਲ ਕਰੋ';

  @override
  String get sheetSemanticsLabel => 'ਸ਼ੀਟ';

  @override
  String get textFieldEmailLabel => 'ਈਮੇਲ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'ਕਲੀਅਰ ਕਰੋ';

  @override
  String get passwordFieldLabel => 'ਪਾਸਵਰਡ';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'ਪਾਸਵਰਡ ਲੁਕਾਓ';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'ਪਾਸਵਰਡ ਦਿਖਾਓ';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ਇੱਕ ਸਮਾਂ ਚੁਣੋ';

  @override
  String get timeFieldInvalidDateError => 'ਅਵੈਧ ਸਮਾਂ।';

  @override
  String get timePickerHourSemanticsLabel => 'ਘੰਟਾ';

  @override
  String get timePickerMinuteSemanticsLabel => 'ਮਿੰਟ';
}

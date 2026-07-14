// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class FLocalizationsNe extends FLocalizations {
  FLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get barrierLabel => 'स्क्रिम';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName बन्द गर्नुहोस्';
  }

  @override
  String get autocompleteNoResults => 'कुनै मिल्दो फेला परेन.';

  @override
  String autocompleteResults(int count) {
    return '$count परिणामहरू उपलब्ध छन्';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'सुझाव: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount मध्ये $tabIndex ट्याब';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'अर्को महिना';

  @override
  String get calendarNextYearSemanticsLabel => 'अर्को वर्ष';

  @override
  String get calendarNextYearsSemanticsLabel => 'अर्का वर्षहरू';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'अघिल्लो महिना';

  @override
  String get calendarPreviousYearSemanticsLabel => 'अघिल्लो वर्ष';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'अघिल्ला वर्षहरू';

  @override
  String get calendarShowDaysSemanticsHint => 'दिनहरू देखाउनुहोस्';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'महिना चयनकर्ता देखाउनुहोस्';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'महिना र वर्ष चयनकर्ता देखाउनुहोस्';

  @override
  String get calendarShowYearPickerSemanticsHint => 'वर्ष चयनकर्ता देखाउनुहोस्';

  @override
  String get calendarTodaySemanticsLabel => 'आज';

  @override
  String get contextMenuSemanticsLabel => 'सन्दर्भ मेनु';

  @override
  String get dateFieldHint => 'मिति चयन गर्नुहोस्';

  @override
  String get dateFieldInvalidDateError => 'अमान्य मिति।';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'आज';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'पछाडि';

  @override
  String get headerCloseSemanticsLabel => 'बन्द गर्नुहोस्';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'पपओभर';

  @override
  String get progressSemanticsLabel => 'लोड हुँदै';

  @override
  String get multiSelectHint => 'वस्तुहरू चयन गर्नुहोस्';

  @override
  String get selectHint => 'वस्तु चयन गर्नुहोस्';

  @override
  String get selectSearchHint => 'खोज्नुहोस्';

  @override
  String get selectNoResults => 'कुनै मिल्दो परिणामहरू छैनन्।';

  @override
  String get selectScrollUpSemanticsLabel => 'माथि स्क्रोल गर्नुहोस्';

  @override
  String get selectScrollDownSemanticsLabel => 'तल स्क्रोल गर्नुहोस्';

  @override
  String get sheetSemanticsLabel => 'पाना';

  @override
  String get textFieldEmailLabel => 'इमेल';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'पासवर्ड';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'पासवर्ड लुकाउनुहोस्';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'पासवर्ड देखाउनुहोस्';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'समय चयन गर्नुहोस्';

  @override
  String get timeFieldInvalidDateError => 'अमान्य समय।';

  @override
  String get timePickerHourSemanticsLabel => 'घन्टा';

  @override
  String get timePickerMinuteSemanticsLabel => 'मिनेट';
}

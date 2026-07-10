// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class FLocalizationsHi extends FLocalizations {
  FLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get barrierLabel => 'स्क्रिम';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName को बंद करें';
  }

  @override
  String get autocompleteNoResults => 'कोई मिलान नहीं मिला.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount में से $tabIndex टैब';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'अगला महीना';

  @override
  String get calendarNextYearSemanticsLabel => 'अगला वर्ष';

  @override
  String get calendarNextYearsSemanticsLabel => 'अगले वर्ष';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'पिछला महीना';

  @override
  String get calendarPreviousYearSemanticsLabel => 'पिछला वर्ष';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'पिछले वर्ष';

  @override
  String get contextMenuSemanticsLabel => 'संदर्भ मेनू';

  @override
  String get dateFieldHint => 'तारीख़ चुनें';

  @override
  String get dateFieldInvalidDateError => 'अमान्य तारीख़.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'आज';

  @override
  String get dialogSemanticsLabel => 'डायलॉग';

  @override
  String get headerBackSemanticsLabel => 'वापस जाएं';

  @override
  String get headerCloseSemanticsLabel => 'बंद करें';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'पॉपओवर';

  @override
  String get progressSemanticsLabel => 'लोड हो रहा है';

  @override
  String get multiSelectHint => 'आइटम चुनें';

  @override
  String get selectHint => 'एक आइटम चुनें';

  @override
  String get selectSearchHint => 'खोजें';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ऊपर स्क्रॉल करें';

  @override
  String get selectScrollDownSemanticsLabel => 'नीचे स्क्रॉल करें';

  @override
  String get sheetSemanticsLabel => 'शीट';

  @override
  String get textFieldEmailLabel => 'ईमेल';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'पासवर्ड';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'पासवर्ड छुपाएं';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'पासवर्ड दिखाएं';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'समय चुनें';

  @override
  String get timeFieldInvalidDateError => 'अमान्य समय.';
}

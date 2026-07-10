// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class FLocalizationsMr extends FLocalizations {
  FLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get barrierLabel => 'स्क्रिम';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName बंद करा';
  }

  @override
  String get autocompleteNoResults => 'कोणतेही जुळणारे आढळले नाही.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount पैकी $tabIndex टॅब';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'पुढील महिना';

  @override
  String get calendarNextYearSemanticsLabel => 'पुढील वर्ष';

  @override
  String get calendarNextYearsSemanticsLabel => 'पुढील वर्षे';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'मागील महिना';

  @override
  String get calendarPreviousYearSemanticsLabel => 'मागील वर्ष';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'मागील वर्षे';

  @override
  String get contextMenuSemanticsLabel => 'संदर्भ मेनू';

  @override
  String get dateFieldHint => 'तारीख निवडा';

  @override
  String get dateFieldInvalidDateError => 'अवैध तारीख.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'आज';

  @override
  String get dialogSemanticsLabel => 'डायलॉग';

  @override
  String get headerBackSemanticsLabel => 'मागे जा';

  @override
  String get headerCloseSemanticsLabel => 'बंद करा';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'पॉपओव्हर';

  @override
  String get progressSemanticsLabel => 'लोड होत आहे';

  @override
  String get multiSelectHint => 'आयटम निवडा';

  @override
  String get selectHint => 'आयटम निवडा';

  @override
  String get selectSearchHint => 'शोधा';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'वर स्क्रोल करा';

  @override
  String get selectScrollDownSemanticsLabel => 'खाली स्क्रोल करा';

  @override
  String get sheetSemanticsLabel => 'शीट';

  @override
  String get textFieldEmailLabel => 'ईमेल';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'पासवर्ड';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'पासवर्ड लपवा';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'पासवर्ड दाखवा';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'वेळ निवडा';

  @override
  String get timeFieldInvalidDateError => 'अवैध वेळ.';
}

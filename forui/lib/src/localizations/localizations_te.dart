// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class FLocalizationsTe extends FLocalizations {
  FLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get barrierLabel => 'స్క్రిమ్';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName‌ను మూసివేయండి';
  }

  @override
  String get autocompleteNoResults => 'సరిపోలినవి ఏవీ కనుగొనబడలేదు.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCountలో $tabIndex ట్యాబ్';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'తదుపరి నెల';

  @override
  String get calendarNextYearSemanticsLabel => 'తదుపరి సంవత్సరం';

  @override
  String get calendarNextYearsSemanticsLabel => 'తదుపరి సంవత్సరాలు';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'మునుపటి నెల';

  @override
  String get calendarPreviousYearSemanticsLabel => 'మునుపటి సంవత్సరం';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'మునుపటి సంవత్సరాలు';

  @override
  String get calendarShowDaysSemanticsHint => 'రోజులను చూపు';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'నెల ఎంపికను చూపు';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'నెల మరియు సంవత్సర ఎంపికను చూపు';

  @override
  String get calendarShowYearPickerSemanticsHint => 'సంవత్సర ఎంపికను చూపు';

  @override
  String get calendarTodaySemanticsLabel => 'ఈ రోజు';

  @override
  String get contextMenuSemanticsLabel => 'సందర్భ మెనూ';

  @override
  String get dateFieldHint => 'తేదీని ఎంచుకోండి';

  @override
  String get dateFieldInvalidDateError => 'చెల్లని తేదీ.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'ఈ రోజు';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'వెనుకకు';

  @override
  String get headerCloseSemanticsLabel => 'మూసివేయి';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'పాప్‌ఓవర్';

  @override
  String get progressSemanticsLabel => 'లోడ్ అవుతోంది';

  @override
  String get multiSelectHint => 'అంశాలను ఎంచుకోండి';

  @override
  String get selectHint => 'ఒక అంశాన్ని ఎంచుకోండి';

  @override
  String get selectSearchHint => 'శోధించు';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'పైకి స్క్రోల్ చేయండి';

  @override
  String get selectScrollDownSemanticsLabel => 'క్రిందికి స్క్రోల్ చేయండి';

  @override
  String get sheetSemanticsLabel => 'షీట్';

  @override
  String get textFieldEmailLabel => 'ఇమెయిల్';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'పాస్‌వర్డ్';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'పాస్‌వర్డ్‌ను దాచండి';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'పాస్‌వర్డ్ చూపించు';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'సమయాన్ని ఎంచుకోండి';

  @override
  String get timeFieldInvalidDateError => 'చెల్లని సమయం.';
}

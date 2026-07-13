// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class FLocalizationsDa extends FLocalizations {
  FLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get barrierLabel => 'Dæmpeskærm';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Luk \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Ingen resultater fundet.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Fane $tabIndex af $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Næste måned';

  @override
  String get calendarNextYearSemanticsLabel => 'Næste år';

  @override
  String get calendarNextYearsSemanticsLabel => 'Næste år';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Forrige måned';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Forrige år';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Forrige år';

  @override
  String get calendarShowDaysSemanticsHint => 'Vis dage';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Vis månedsvælger';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Vis måneds- og årsvælger';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Vis årsvælger';

  @override
  String get calendarTodaySemanticsLabel => 'I dag';

  @override
  String get contextMenuSemanticsLabel => 'Kontekstmenu';

  @override
  String get dateFieldHint => 'Vælg en dato';

  @override
  String get dateFieldInvalidDateError => 'Ugyldig dato.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'I dag';

  @override
  String get dialogSemanticsLabel => 'Dialogboks';

  @override
  String get headerBackSemanticsLabel => 'Tilbage';

  @override
  String get headerCloseSemanticsLabel => 'Luk';

  @override
  String get paginationPreviousSemanticsLabel => 'Forrige';

  @override
  String get paginationNextSemanticsLabel => 'Næste';

  @override
  String get popoverSemanticsLabel => 'Pop op-vindue';

  @override
  String get progressSemanticsLabel => 'Indlæser';

  @override
  String get multiSelectHint => 'Vælg elementer';

  @override
  String get selectHint => 'Vælg et element';

  @override
  String get selectSearchHint => 'Søg';

  @override
  String get selectNoResults => 'Ingen matchende resultater.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rul op';

  @override
  String get selectScrollDownSemanticsLabel => 'Rul ned';

  @override
  String get sheetSemanticsLabel => 'Felt';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Ryd';

  @override
  String get passwordFieldLabel => 'Adgangskode';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Skjul adgangskode';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Vis adgangskode';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vælg et tidspunkt';

  @override
  String get timeFieldInvalidDateError => 'Ugyldigt tidspunkt.';

  @override
  String get timePickerHourSemanticsLabel => 'Time';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minut';
}

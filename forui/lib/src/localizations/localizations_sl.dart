// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class FLocalizationsSl extends FLocalizations {
  FLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zapiranje »\$modalRouteContentName«';
  }

  @override
  String get autocompleteNoResults => 'Ni ujemanj.';

  @override
  String autocompleteResults(int count) {
    return '$count razpoložljivih rezultatov';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Predlog: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Zavihek $tabIndex od $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Naslednji mesec';

  @override
  String get calendarNextYearSemanticsLabel => 'Naslednje leto';

  @override
  String get calendarNextYearsSemanticsLabel => 'Naslednja leta';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Prejšnji mesec';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Prejšnje leto';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Prejšnja leta';

  @override
  String get calendarShowDaysSemanticsHint => 'Pokaži dneve';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Pokaži izbirnik meseca';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Pokaži izbirnik meseca in leta';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Pokaži izbirnik leta';

  @override
  String get calendarTodaySemanticsLabel => 'Danes';

  @override
  String get contextMenuSemanticsLabel => 'Kontekstni meni';

  @override
  String get dateFieldHint => 'Izberite datum';

  @override
  String get dateFieldInvalidDateError => 'Neveljaven datum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Danes';

  @override
  String get dialogSemanticsLabel => 'Pogovorno okno';

  @override
  String get headerBackSemanticsLabel => 'Nazaj';

  @override
  String get headerCloseSemanticsLabel => 'Zapri';

  @override
  String get paginationPreviousSemanticsLabel => 'Prejšnji';

  @override
  String get paginationNextSemanticsLabel => 'Naprej';

  @override
  String get popoverSemanticsLabel => 'Pojavno okno';

  @override
  String get progressSemanticsLabel => 'Nalaganje';

  @override
  String get multiSelectHint => 'Izberi elemente';

  @override
  String get selectHint => 'Izberite element';

  @override
  String get selectSearchHint => 'Iskanje';

  @override
  String get selectNoResults => 'Ni ujemajočih se rezultatov.';

  @override
  String get selectScrollUpSemanticsLabel => 'Pomik navzgor';

  @override
  String get selectScrollDownSemanticsLabel => 'Pomik navzdol';

  @override
  String get sheetSemanticsLabel => 'Razdelek';

  @override
  String get textFieldEmailLabel => 'E-pošta';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Počisti';

  @override
  String get passwordFieldLabel => 'Geslo';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Skrij geslo';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Prikaži geslo';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Izberite čas';

  @override
  String get timeFieldInvalidDateError => 'Neveljaven čas.';

  @override
  String get timePickerHourSemanticsLabel => 'Ura';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minuta';
}

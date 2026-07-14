// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class FLocalizationsHr extends FLocalizations {
  FLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get barrierLabel => 'Rubno';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zatvori \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nisu pronađena poklapanja.';

  @override
  String autocompleteResults(int count) {
    return '$count dostupnih rezultata';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Prijedlog: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Kartica $tabIndex od $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Sljedeći mjesec';

  @override
  String get calendarNextYearSemanticsLabel => 'Sljedeća godina';

  @override
  String get calendarNextYearsSemanticsLabel => 'Sljedeće godine';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Prethodni mjesec';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Prethodna godina';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Prethodne godine';

  @override
  String get calendarShowDaysSemanticsHint => 'Prikaži dane';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Prikaži birač mjeseca';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Prikaži birač mjeseca i godine';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Prikaži birač godine';

  @override
  String get calendarTodaySemanticsLabel => 'Danas';

  @override
  String get contextMenuSemanticsLabel => 'Kontekstni izbornik';

  @override
  String get dateFieldHint => 'Odaberite datum';

  @override
  String get dateFieldInvalidDateError => 'Nevažeći datum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dateTimePickerToday => 'Danas';

  @override
  String get dialogSemanticsLabel => 'Dijalog';

  @override
  String get headerBackSemanticsLabel => 'Natrag';

  @override
  String get headerCloseSemanticsLabel => 'Zatvori';

  @override
  String get paginationPreviousSemanticsLabel => 'Prethodno';

  @override
  String get paginationNextSemanticsLabel => 'Sljedeće';

  @override
  String get popoverSemanticsLabel => 'Skočni prozor';

  @override
  String get progressSemanticsLabel => 'Učitavanje';

  @override
  String get multiSelectHint => 'Odaberite stavke';

  @override
  String get selectHint => 'Odaberite stavku';

  @override
  String get selectSearchHint => 'Pretraži';

  @override
  String get selectNoResults => 'Nema podudarajućih rezultata.';

  @override
  String get selectScrollUpSemanticsLabel => 'Pomakni prema gore';

  @override
  String get selectScrollDownSemanticsLabel => 'Pomakni prema dolje';

  @override
  String get sheetSemanticsLabel => 'tablica';

  @override
  String get textFieldEmailLabel => 'E-pošta';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Očisti';

  @override
  String get passwordFieldLabel => 'Lozinka';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Sakrij lozinku';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Prikaži lozinku';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Odaberite vrijeme';

  @override
  String get timeFieldInvalidDateError => 'Nevažeće vrijeme.';

  @override
  String get timePickerHourSemanticsLabel => 'Sat';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minuta';
}

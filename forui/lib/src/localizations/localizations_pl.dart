// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class FLocalizationsPl extends FLocalizations {
  FLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get barrierLabel => 'Siatka';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zamknij: \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nie znaleziono dopasowań.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Karta $tabIndex z $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Następny miesiąc';

  @override
  String get calendarNextYearSemanticsLabel => 'Następny rok';

  @override
  String get calendarNextYearsSemanticsLabel => 'Następne lata';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Poprzedni miesiąc';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Poprzedni rok';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Poprzednie lata';

  @override
  String get calendarShowDaysSemanticsHint => 'Pokaż dni';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Pokaż selektor miesiąca';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Pokaż selektor miesiąca i roku';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Pokaż selektor roku';

  @override
  String get calendarTodaySemanticsLabel => 'Dziś';

  @override
  String get contextMenuSemanticsLabel => 'Menu kontekstowe';

  @override
  String get dateFieldHint => 'Wybierz datę';

  @override
  String get dateFieldInvalidDateError => 'Nieprawidłowa data.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Dziś';

  @override
  String get dialogSemanticsLabel => 'Okno dialogowe';

  @override
  String get headerBackSemanticsLabel => 'Wstecz';

  @override
  String get headerCloseSemanticsLabel => 'Zamknij';

  @override
  String get paginationPreviousSemanticsLabel => 'Poprzedni';

  @override
  String get paginationNextSemanticsLabel => 'Dalej';

  @override
  String get popoverSemanticsLabel => 'Okno wyskakujące';

  @override
  String get progressSemanticsLabel => 'Ładowanie';

  @override
  String get multiSelectHint => 'Wybierz elementy';

  @override
  String get selectHint => 'Wybierz element';

  @override
  String get selectSearchHint => 'Szukaj';

  @override
  String get selectNoResults => 'Brak pasujących wyników.';

  @override
  String get selectScrollUpSemanticsLabel => 'Przewiń w górę';

  @override
  String get selectScrollDownSemanticsLabel => 'Przewiń w dół';

  @override
  String get sheetSemanticsLabel => 'Plansza';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Wyczyść';

  @override
  String get passwordFieldLabel => 'Hasło';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ukryj hasło';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Pokaż hasło';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wybierz godzinę';

  @override
  String get timeFieldInvalidDateError => 'Nieprawidłowa godzina.';
}

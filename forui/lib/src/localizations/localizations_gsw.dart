// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swiss German Alemannic Alsatian (`gsw`).
class FLocalizationsGsw extends FLocalizations {
  FLocalizationsGsw([String locale = 'gsw']) : super(locale);

  @override
  String get barrierLabel => 'Gitter';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName schließen';
  }

  @override
  String get autocompleteNoResults => 'Kei Überiistimmige gfunde.';

  @override
  String autocompleteResults(int count) {
    return '$count Ergebnisse verfügbar';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Vorschlag: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Tab $tabIndex von $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Nächste Monet';

  @override
  String get calendarNextYearSemanticsLabel => 'Nächschts Jaar';

  @override
  String get calendarNextYearsSemanticsLabel => 'Nächschti Jaar';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Letzte Monet';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Letschts Jaar';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Letschti Jaar';

  @override
  String get calendarShowDaysSemanticsHint => 'Täg aazeige';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Monatsuswahl aazeige';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Monats- und Jahresuswahl aazeige';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Jahresuswahl aazeige';

  @override
  String get calendarTodaySemanticsLabel => 'Hüt';

  @override
  String get contextMenuSemanticsLabel => 'Kontextmenü';

  @override
  String get dateFieldHint => 'Datum uswähle';

  @override
  String get dateFieldInvalidDateError => 'Ungültigs Datum.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Hüt';

  @override
  String get dialogSemanticsLabel => 'Dialogfeld';

  @override
  String get headerBackSemanticsLabel => 'Zurück';

  @override
  String get headerCloseSemanticsLabel => 'Schliessen';

  @override
  String get paginationPreviousSemanticsLabel => 'Vorig';

  @override
  String get paginationNextSemanticsLabel => 'Witer';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Ladet';

  @override
  String get multiSelectHint => 'Elemente uswähle';

  @override
  String get selectHint => 'Wähle e Element';

  @override
  String get selectSearchHint => 'Sueche';

  @override
  String get selectNoResults => 'Kei passendi Ergebnis.';

  @override
  String get selectScrollUpSemanticsLabel => 'Nach obe scrolle';

  @override
  String get selectScrollDownSemanticsLabel => 'Nach unde scrolle';

  @override
  String get sheetSemanticsLabel => 'Ansicht';

  @override
  String get textFieldEmailLabel => 'E-Mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Lösche';

  @override
  String get passwordFieldLabel => 'Passwort';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Passwort verberge';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Passwort zeige';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wähle e Zyt';

  @override
  String get timeFieldInvalidDateError => 'Ungültigi Zyt.';

  @override
  String get timePickerHourSemanticsLabel => 'Stunde';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minute';
}

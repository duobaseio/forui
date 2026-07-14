// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class FLocalizationsDe extends FLocalizations {
  FLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get barrierLabel => 'Gitter';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName schließen';
  }

  @override
  String get autocompleteNoResults => 'Keine Übereinstimmungen gefunden.';

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
  String get calendarNextMonthSemanticsLabel => 'Nächster Monat';

  @override
  String get calendarNextYearSemanticsLabel => 'Nächstes Jahr';

  @override
  String get calendarNextYearsSemanticsLabel => 'Nächste Jahre';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Vorheriger Monat';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Vorheriges Jahr';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Vorherige Jahre';

  @override
  String get calendarShowDaysSemanticsHint => 'Tage anzeigen';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Monatsauswahl anzeigen';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Monats- und Jahresauswahl anzeigen';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Jahresauswahl anzeigen';

  @override
  String get calendarTodaySemanticsLabel => 'Heute';

  @override
  String get contextMenuSemanticsLabel => 'Kontextmenü';

  @override
  String get dateFieldHint => 'Datum auswählen';

  @override
  String get dateFieldInvalidDateError => 'Ungültiges Datum.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Heute';

  @override
  String get dialogSemanticsLabel => 'Dialogfeld';

  @override
  String get headerBackSemanticsLabel => 'Zurück';

  @override
  String get headerCloseSemanticsLabel => 'Schließen';

  @override
  String get paginationPreviousSemanticsLabel => 'Zurück';

  @override
  String get paginationNextSemanticsLabel => 'Weiter';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Wird geladen';

  @override
  String get multiSelectHint => 'Elemente auswählen';

  @override
  String get selectHint => 'Wählen Sie ein Element';

  @override
  String get selectSearchHint => 'Suchen';

  @override
  String get selectNoResults => 'Keine übereinstimmenden Ergebnisse.';

  @override
  String get selectScrollUpSemanticsLabel => 'Nach oben scrollen';

  @override
  String get selectScrollDownSemanticsLabel => 'Nach unten scrollen';

  @override
  String get sheetSemanticsLabel => 'Ansicht';

  @override
  String get textFieldEmailLabel => 'E-Mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Löschen';

  @override
  String get passwordFieldLabel => 'Passwort';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Passwort ausblenden';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Passwort anzeigen';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wähle eine Uhrzeit';

  @override
  String get timeFieldInvalidDateError => 'Ungültige Uhrzeit.';

  @override
  String get timePickerHourSemanticsLabel => 'Stunde';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minute';
}

/// The translations for German, as used in Switzerland (`de_CH`).
class FLocalizationsDeCh extends FLocalizationsDe {
  FLocalizationsDeCh(): super('de_CH');

  @override
  String get autocompleteNoResults => 'Keine Übereinstimmungen gefunden.';

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
  String get calendarNextMonthSemanticsLabel => 'Nächster Monat';

  @override
  String get calendarNextYearSemanticsLabel => 'Nächstes Jahr';

  @override
  String get calendarNextYearsSemanticsLabel => 'Nächste Jahre';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Vorheriger Monat';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Vorheriges Jahr';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Vorherige Jahre';

  @override
  String get calendarShowDaysSemanticsHint => 'Tage anzeigen';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Monatsauswahl anzeigen';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Monats- und Jahresauswahl anzeigen';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Jahresauswahl anzeigen';

  @override
  String get calendarTodaySemanticsLabel => 'Heute';

  @override
  String get contextMenuSemanticsLabel => 'Kontextmenü';

  @override
  String get dateFieldHint => 'Datum auswählen';

  @override
  String get dateFieldInvalidDateError => 'Ungültiges Datum.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Heute';

  @override
  String get dialogSemanticsLabel => 'Dialogfeld';

  @override
  String get headerBackSemanticsLabel => 'Zurück';

  @override
  String get headerCloseSemanticsLabel => 'Schliessen';

  @override
  String get paginationPreviousSemanticsLabel => 'Zurück';

  @override
  String get paginationNextSemanticsLabel => 'Weiter';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Wird geladen';

  @override
  String get multiSelectHint => 'Elemente auswählen';

  @override
  String get selectHint => 'Wählen Sie ein Element';

  @override
  String get selectSearchHint => 'Suchen';

  @override
  String get selectNoResults => 'Keine übereinstimmenden Ergebnisse.';

  @override
  String get selectScrollUpSemanticsLabel => 'Nach oben scrollen';

  @override
  String get selectScrollDownSemanticsLabel => 'Nach unten scrollen';

  @override
  String get textFieldEmailLabel => 'E-Mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Löschen';

  @override
  String get passwordFieldLabel => 'Passwort';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Passwort ausblenden';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Passwort anzeigen';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wählen Sie eine Zeit';

  @override
  String get timeFieldInvalidDateError => 'Ungültige Zeit.';

  @override
  String get timePickerHourSemanticsLabel => 'Stunde';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minute';
}

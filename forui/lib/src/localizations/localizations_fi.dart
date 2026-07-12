// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class FLocalizationsFi extends FLocalizations {
  FLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get barrierLabel => 'Sermi';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Sulje \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Ei osumia löytynyt.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Välilehti $tabIndex/$tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Seuraava kuukausi';

  @override
  String get calendarNextYearSemanticsLabel => 'Seuraava vuosi';

  @override
  String get calendarNextYearsSemanticsLabel => 'Seuraavat vuodet';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Edellinen kuukausi';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Edellinen vuosi';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Edelliset vuodet';

  @override
  String get calendarShowDaysSemanticsHint => 'Näytä päivät';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Näytä kuukauden valitsin';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Näytä kuukauden ja vuoden valitsin';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Näytä vuoden valitsin';

  @override
  String get calendarTodaySemanticsLabel => 'Tänään';

  @override
  String get contextMenuSemanticsLabel => 'Kontekstivalikko';

  @override
  String get dateFieldHint => 'Valitse päivämäärä';

  @override
  String get dateFieldInvalidDateError => 'Virheellinen päivämäärä.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Tänään';

  @override
  String get dialogSemanticsLabel => 'Valintaikkuna';

  @override
  String get headerBackSemanticsLabel => 'Takaisin';

  @override
  String get headerCloseSemanticsLabel => 'Sulje';

  @override
  String get paginationPreviousSemanticsLabel => 'Edellinen';

  @override
  String get paginationNextSemanticsLabel => 'Seuraava';

  @override
  String get popoverSemanticsLabel => 'Ponnahdusikkuna';

  @override
  String get progressSemanticsLabel => 'Ladataan';

  @override
  String get multiSelectHint => 'Valitse kohteet';

  @override
  String get selectHint => 'Valitse kohde';

  @override
  String get selectSearchHint => 'Haku';

  @override
  String get selectNoResults => 'Ei vastaavia tuloksia.';

  @override
  String get selectScrollUpSemanticsLabel => 'Vieritä ylös';

  @override
  String get selectScrollDownSemanticsLabel => 'Vieritä alas';

  @override
  String get sheetSemanticsLabel => 'arkki';

  @override
  String get textFieldEmailLabel => 'Sähköposti';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Tyhjennä';

  @override
  String get passwordFieldLabel => 'Salasana';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Piilota salasana';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Näytä salasana';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Valitse aika';

  @override
  String get timeFieldInvalidDateError => 'Virheellinen aika.';
}

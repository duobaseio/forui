// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class FLocalizationsCs extends FLocalizations {
  FLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zavřít \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nebyly nalezeny žádné shody.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Následující měsíc';

  @override
  String get calendarNextYearSemanticsLabel => 'Příští rok';

  @override
  String get calendarNextYearsSemanticsLabel => 'Příští roky';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Předchozí měsíc';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Předchozí rok';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Předchozí roky';

  @override
  String get contextMenuSemanticsLabel => 'Kontextová nabídka';

  @override
  String get dateFieldHint => 'Vyberte datum';

  @override
  String get dateFieldInvalidDateError => 'Neplatné datum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Dnes';

  @override
  String get dialogSemanticsLabel => 'Dialogové okno';

  @override
  String get paginationPreviousSemanticsLabel => 'Předchozí';

  @override
  String get paginationNextSemanticsLabel => 'Další';

  @override
  String get popoverSemanticsLabel => 'Vyskakovací okno';

  @override
  String get progressSemanticsLabel => 'Načítání';

  @override
  String get multiSelectHint => 'Vyberte položky';

  @override
  String get selectHint => 'Vyberte položku';

  @override
  String get selectSearchHint => 'Hledat';

  @override
  String get selectNoResults => 'Žádné odpovídající výsledky.';

  @override
  String get selectScrollUpSemanticsLabel => 'Posunout nahoru';

  @override
  String get selectScrollDownSemanticsLabel => 'Posunout dolů';

  @override
  String get sheetSemanticsLabel => 'tabulka';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Vymazat';

  @override
  String get passwordFieldLabel => 'Heslo';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Skrýt heslo';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Zobrazit heslo';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vyberte čas';

  @override
  String get timeFieldInvalidDateError => 'Neplatný čas.';
}

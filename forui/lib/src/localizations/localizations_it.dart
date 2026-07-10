// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class FLocalizationsIt extends FLocalizations {
  FLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get barrierLabel => 'Rete';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Chiudi \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nessuna corrispondenza trovata.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Scheda $tabIndex di $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Mese successivo';

  @override
  String get calendarNextYearSemanticsLabel => 'Anno successivo';

  @override
  String get calendarNextYearsSemanticsLabel => 'Anni successivi';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mese precedente';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Anno precedente';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Anni precedenti';

  @override
  String get contextMenuSemanticsLabel => 'Menu contestuale';

  @override
  String get dateFieldHint => 'Seleziona data';

  @override
  String get dateFieldInvalidDateError => 'Data non valida.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Oggi';

  @override
  String get dialogSemanticsLabel => 'Finestra di dialogo';

  @override
  String get headerBackSemanticsLabel => 'Indietro';

  @override
  String get headerCloseSemanticsLabel => 'Chiudi';

  @override
  String get paginationPreviousSemanticsLabel => 'Precedente';

  @override
  String get paginationNextSemanticsLabel => 'Avanti';

  @override
  String get popoverSemanticsLabel => 'Finestra di sovrapposizione';

  @override
  String get progressSemanticsLabel => 'Caricamento';

  @override
  String get multiSelectHint => 'Seleziona elementi';

  @override
  String get selectHint => 'Seleziona un elemento';

  @override
  String get selectSearchHint => 'Cerca';

  @override
  String get selectNoResults => 'Nessun risultato corrispondente.';

  @override
  String get selectScrollUpSemanticsLabel => 'Scorri verso l\'alto';

  @override
  String get selectScrollDownSemanticsLabel => 'Scorri verso il basso';

  @override
  String get sheetSemanticsLabel => 'Riquadro';

  @override
  String get textFieldEmailLabel => 'Email';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Cancella';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Nascondi password';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Mostra password';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Scegli un orario';

  @override
  String get timeFieldInvalidDateError => 'Orario non valido.';
}

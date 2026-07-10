// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class FLocalizationsAf extends FLocalizations {
  FLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get barrierLabel => 'Skerm';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Maak \$modalRouteContentName toe';
  }

  @override
  String get autocompleteNoResults => 'Geen resultate gevind nie.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Oortjie $tabIndex van $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Volgende maand';

  @override
  String get calendarNextYearSemanticsLabel => 'Volgende jaar';

  @override
  String get calendarNextYearsSemanticsLabel => 'Volgende jare';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Vorige maand';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Vorige jaar';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Vorige jare';

  @override
  String get contextMenuSemanticsLabel => 'Kontekskieslys';

  @override
  String get dateFieldHint => 'Kies \'n datum';

  @override
  String get dateFieldInvalidDateError => 'Ongeldige datum.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Vandag';

  @override
  String get dialogSemanticsLabel => 'Dialoog';

  @override
  String get headerBackSemanticsLabel => 'Terug';

  @override
  String get headerCloseSemanticsLabel => 'Maak toe';

  @override
  String get paginationPreviousSemanticsLabel => 'Vorige';

  @override
  String get paginationNextSemanticsLabel => 'Volgende';

  @override
  String get popoverSemanticsLabel => 'Opspringer';

  @override
  String get progressSemanticsLabel => 'Besig om te laai';

  @override
  String get multiSelectHint => 'Kies items';

  @override
  String get selectHint => 'Kies \'n item';

  @override
  String get selectSearchHint => 'Soek';

  @override
  String get selectNoResults => 'Geen passende resultate nie.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rol op';

  @override
  String get selectScrollDownSemanticsLabel => 'Rol af';

  @override
  String get sheetSemanticsLabel => 'blad';

  @override
  String get textFieldEmailLabel => 'E-pos';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Vee uit';

  @override
  String get passwordFieldLabel => 'Wagwoord';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Versteek wagwoord';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Wys wagwoord';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Kies \'n tyd';

  @override
  String get timeFieldInvalidDateError => 'Ongeldige tyd.';
}

// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class FLocalizationsLv extends FLocalizations {
  FLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get barrierLabel => 'Pārklājums';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Aizvērt \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nav atrasts neviens atbilstošs rezultāts.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabIndex. cilne no $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Nākamais mēnesis';

  @override
  String get calendarNextYearSemanticsLabel => 'Nākamais gads';

  @override
  String get calendarNextYearsSemanticsLabel => 'Nākamie gadi';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Iepriekšējais mēnesis';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Iepriekšējais gads';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Iepriekšējie gadi';

  @override
  String get calendarShowDaysSemanticsHint => 'Rādīt dienas';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Rādīt mēneša atlasītāju';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Rādīt mēneša un gada atlasītāju';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Rādīt gada atlasītāju';

  @override
  String get calendarTodaySemanticsLabel => 'Šodien';

  @override
  String get contextMenuSemanticsLabel => 'Konteksta izvēlne';

  @override
  String get dateFieldHint => 'Atlasīt datumu';

  @override
  String get dateFieldInvalidDateError => 'Nederīgs datums.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dateTimePickerToday => 'Šodien';

  @override
  String get dialogSemanticsLabel => 'Dialoglodziņš';

  @override
  String get headerBackSemanticsLabel => 'Atpakaļ';

  @override
  String get headerCloseSemanticsLabel => 'Aizvērt';

  @override
  String get paginationPreviousSemanticsLabel => 'Iepriekšējais';

  @override
  String get paginationNextSemanticsLabel => 'Tālāk';

  @override
  String get popoverSemanticsLabel => 'Izlecošs logs';

  @override
  String get progressSemanticsLabel => 'Ielādē';

  @override
  String get multiSelectHint => 'Atlasiet vienumus';

  @override
  String get selectHint => 'Atlasiet vienumu';

  @override
  String get selectSearchHint => 'Meklēt';

  @override
  String get selectNoResults => 'Nav atbilstošu rezultātu.';

  @override
  String get selectScrollUpSemanticsLabel => 'Ritināt uz augšu';

  @override
  String get selectScrollDownSemanticsLabel => 'Ritināt uz leju';

  @override
  String get sheetSemanticsLabel => 'lapa';

  @override
  String get textFieldEmailLabel => 'E-pasts';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Notīrīt';

  @override
  String get passwordFieldLabel => 'Parole';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Paslēpt paroli';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Rādīt paroli';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Izvēlieties laiku';

  @override
  String get timeFieldInvalidDateError => 'Nederīgs laiks.';

  @override
  String get timePickerHourSemanticsLabel => 'Stunda';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minūte';
}

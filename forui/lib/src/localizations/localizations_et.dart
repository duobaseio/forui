// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class FLocalizationsEt extends FLocalizations {
  FLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get barrierLabel => 'Sirm';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Sule \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Vasteid ei leitud.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount-st $tabIndex. vahekaart';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Järgmine kuu';

  @override
  String get calendarNextYearSemanticsLabel => 'Järgmine aasta';

  @override
  String get calendarNextYearsSemanticsLabel => 'Järgmised aastad';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Eelmine kuu';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Eelmine aasta';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Eelmised aastad';

  @override
  String get contextMenuSemanticsLabel => 'Kontekstimenüü';

  @override
  String get dateFieldHint => 'Valige kuupäev';

  @override
  String get dateFieldInvalidDateError => 'Sobimatu kuupäev.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Täna';

  @override
  String get dialogSemanticsLabel => 'Dialoog';

  @override
  String get headerBackSemanticsLabel => 'Tagasi';

  @override
  String get headerCloseSemanticsLabel => 'Sule';

  @override
  String get paginationPreviousSemanticsLabel => 'Eelmine';

  @override
  String get paginationNextSemanticsLabel => 'Järgmine';

  @override
  String get popoverSemanticsLabel => 'Hüpikaken';

  @override
  String get progressSemanticsLabel => 'Laadimine';

  @override
  String get multiSelectHint => 'Valige üksused';

  @override
  String get selectHint => 'Valige üksus';

  @override
  String get selectSearchHint => 'Otsi';

  @override
  String get selectNoResults => 'Sobivaid tulemusi pole.';

  @override
  String get selectScrollUpSemanticsLabel => 'Keri üles';

  @override
  String get selectScrollDownSemanticsLabel => 'Keri alla';

  @override
  String get sheetSemanticsLabel => 'leht';

  @override
  String get textFieldEmailLabel => 'E-post';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Kustuta';

  @override
  String get passwordFieldLabel => 'Parool';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Peida parool';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Näita parooli';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vali aeg';

  @override
  String get timeFieldInvalidDateError => 'Vigane aeg.';
}

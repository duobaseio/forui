// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class FLocalizationsSq extends FLocalizations {
  FLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get barrierLabel => 'Kanavacë';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Mbyll \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nuk u gjetën përputhje.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Skeda $tabIndex nga $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Muaji tjetër';

  @override
  String get calendarNextYearSemanticsLabel => 'Viti tjetër';

  @override
  String get calendarNextYearsSemanticsLabel => 'Vitet e ardhshme';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Muaji i mëparshëm';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Viti i mëparshëm';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Vitet e mëparshme';

  @override
  String get calendarShowDaysSemanticsHint => 'Shfaq ditët';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Shfaq zgjedhësin e muajit';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Shfaq zgjedhësin e muajit dhe vitit';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Shfaq zgjedhësin e vitit';

  @override
  String get calendarTodaySemanticsLabel => 'Sot';

  @override
  String get contextMenuSemanticsLabel => 'Menyja e kontekstit';

  @override
  String get dateFieldHint => 'Zgjidh datën';

  @override
  String get dateFieldInvalidDateError => 'Datë e pavlefshme.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Sot';

  @override
  String get dialogSemanticsLabel => 'Dialogu';

  @override
  String get headerBackSemanticsLabel => 'Prapa';

  @override
  String get headerCloseSemanticsLabel => 'Mbyll';

  @override
  String get paginationPreviousSemanticsLabel => 'E mëparshme';

  @override
  String get paginationNextSemanticsLabel => 'Tjetër';

  @override
  String get popoverSemanticsLabel => 'Dritare kërcyese';

  @override
  String get progressSemanticsLabel => 'Po ngarkohet';

  @override
  String get multiSelectHint => 'Zgjidh elementet';

  @override
  String get selectHint => 'Zgjidhni një artikull';

  @override
  String get selectSearchHint => 'Kërko';

  @override
  String get selectNoResults => 'Nuk ka rezultate përputhëse.';

  @override
  String get selectScrollUpSemanticsLabel => 'Lëviz lart';

  @override
  String get selectScrollDownSemanticsLabel => 'Lëviz poshtë';

  @override
  String get sheetSemanticsLabel => 'Fleta';

  @override
  String get textFieldEmailLabel => 'Email';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Pastro';

  @override
  String get passwordFieldLabel => 'Fjalëkalimi';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Fshih fjalëkalimin';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Shfaq fjalëkalimin';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Zgjidh një orë';

  @override
  String get timeFieldInvalidDateError => 'Orë e pavlefshme.';

  @override
  String get timePickerHourSemanticsLabel => 'Ora';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minuta';
}

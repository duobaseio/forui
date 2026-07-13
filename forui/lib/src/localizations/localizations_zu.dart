// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Zulu (`zu`).
class FLocalizationsZu extends FLocalizations {
  FLocalizationsZu([String locale = 'zu']) : super(locale);

  @override
  String get barrierLabel => 'I-Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Vala i-\$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Akukho ukufana okutholiwe.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Ithebhu $tabIndex kwangu-$tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Inyanga elandelayo';

  @override
  String get calendarNextYearSemanticsLabel => 'Unyaka olandelayo';

  @override
  String get calendarNextYearsSemanticsLabel => 'Iminyaka elandelayo';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Inyanga edlule';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Unyaka odlule';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Iminyaka edlule';

  @override
  String get calendarShowDaysSemanticsHint => 'Bonisa izinsuku';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Bonisa isikhethi senyanga';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Bonisa isikhethi senyanga nonyaka';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Bonisa isikhethi sonyaka';

  @override
  String get calendarTodaySemanticsLabel => 'Namuhla';

  @override
  String get contextMenuSemanticsLabel => 'Imenyu yesimo';

  @override
  String get dateFieldHint => 'Khetha usuku';

  @override
  String get dateFieldInvalidDateError => 'Usuku olungalungile.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Namuhla';

  @override
  String get dialogSemanticsLabel => 'Ingxoxo';

  @override
  String get headerBackSemanticsLabel => 'Emuva';

  @override
  String get headerCloseSemanticsLabel => 'Vala';

  @override
  String get paginationPreviousSemanticsLabel => 'Okwedlule';

  @override
  String get paginationNextSemanticsLabel => 'Okulandelayo';

  @override
  String get popoverSemanticsLabel => 'Iwindi eliqhamukayo';

  @override
  String get progressSemanticsLabel => 'Iyalayisha';

  @override
  String get multiSelectHint => 'Khetha izinto';

  @override
  String get selectHint => 'Khetha into';

  @override
  String get selectSearchHint => 'Sesha';

  @override
  String get selectNoResults => 'Ayikho imiphumela efanayo.';

  @override
  String get selectScrollUpSemanticsLabel => 'Skrola phezulu';

  @override
  String get selectScrollDownSemanticsLabel => 'Skrola phansi';

  @override
  String get sheetSemanticsLabel => 'Ishidi';

  @override
  String get textFieldEmailLabel => 'I-imeyili';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Sula';

  @override
  String get passwordFieldLabel => 'Iphasiwedi';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Fihla iphasiwedi';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Bonisa iphasiwedi';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Khetha isikhathi';

  @override
  String get timeFieldInvalidDateError => 'Isikhathi esingalungile.';

  @override
  String get timePickerHourSemanticsLabel => 'Ihora';

  @override
  String get timePickerMinuteSemanticsLabel => 'Iminithi';
}

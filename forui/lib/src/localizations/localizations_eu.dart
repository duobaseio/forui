// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class FLocalizationsEu extends FLocalizations {
  FLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get barrierLabel => 'Barrera';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Itxi \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Ez da bat-etortzerik aurkitu.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount/$tabIndex fitxa';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Hurrengo hilabetea';

  @override
  String get calendarNextYearSemanticsLabel => 'Hurrengo urtea';

  @override
  String get calendarNextYearsSemanticsLabel => 'Hurrengo urteak';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Aurreko hilabetea';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Aurreko urtea';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Aurreko urteak';

  @override
  String get calendarShowDaysSemanticsHint => 'Erakutsi egunak';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Erakutsi hilabete-hautatzailea';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Erakutsi hilabete- eta urte-hautatzailea';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Erakutsi urte-hautatzailea';

  @override
  String get calendarTodaySemanticsLabel => 'Gaur';

  @override
  String get contextMenuSemanticsLabel => 'Testuinguru-menua';

  @override
  String get dateFieldHint => 'Hautatu data';

  @override
  String get dateFieldInvalidDateError => 'Data baliogabea.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Gaur';

  @override
  String get dialogSemanticsLabel => 'Leihoa';

  @override
  String get headerBackSemanticsLabel => 'Atzera';

  @override
  String get headerCloseSemanticsLabel => 'Itxi';

  @override
  String get paginationPreviousSemanticsLabel => 'Aurrekoa';

  @override
  String get paginationNextSemanticsLabel => 'Hurrengoa';

  @override
  String get popoverSemanticsLabel => 'Leiho emergentea';

  @override
  String get progressSemanticsLabel => 'Kargatzen';

  @override
  String get multiSelectHint => 'Hautatu elementuak';

  @override
  String get selectHint => 'Hautatu elementu bat';

  @override
  String get selectSearchHint => 'Bilatu';

  @override
  String get selectNoResults => 'Ez dago bat datorren emaitzarik.';

  @override
  String get selectScrollUpSemanticsLabel => 'Egin gora';

  @override
  String get selectScrollDownSemanticsLabel => 'Egin behera';

  @override
  String get sheetSemanticsLabel => 'orria';

  @override
  String get textFieldEmailLabel => 'Posta elektronikoa';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Garbitu';

  @override
  String get passwordFieldLabel => 'Pasahitza';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ezkutatu pasahitza';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Erakutsi pasahitza';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Aukeratu ordua';

  @override
  String get timeFieldInvalidDateError => 'Ordu baliogabea.';

  @override
  String get timePickerHourSemanticsLabel => 'Ordua';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minutua';
}

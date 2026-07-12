// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class FLocalizationsIs extends FLocalizations {
  FLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get barrierLabel => 'Möskvi';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Loka \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Engar niðurstöður fundust.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Flipi $tabIndex af $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Næsti mánuður';

  @override
  String get calendarNextYearSemanticsLabel => 'Næsta ár';

  @override
  String get calendarNextYearsSemanticsLabel => 'Næstu ár';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Fyrri mánuður';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Fyrra ár';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Fyrri ár';

  @override
  String get calendarShowDaysSemanticsHint => 'Sýna daga';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Sýna mánaðarval';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Sýna mánaðar- og ársval';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Sýna ársval';

  @override
  String get calendarTodaySemanticsLabel => 'Í dag';

  @override
  String get contextMenuSemanticsLabel => 'Samhengisvalmynd';

  @override
  String get dateFieldHint => 'Veldu dagsetningu';

  @override
  String get dateFieldInvalidDateError => 'Ógild dagsetning.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Í dag';

  @override
  String get dialogSemanticsLabel => 'Gluggi';

  @override
  String get headerBackSemanticsLabel => 'Til baka';

  @override
  String get headerCloseSemanticsLabel => 'Loka';

  @override
  String get paginationPreviousSemanticsLabel => 'Fyrri';

  @override
  String get paginationNextSemanticsLabel => 'Næsta';

  @override
  String get popoverSemanticsLabel => 'Sprettgluggi';

  @override
  String get progressSemanticsLabel => 'Hleður';

  @override
  String get multiSelectHint => 'Veldu hluti';

  @override
  String get selectHint => 'Veldu atriði';

  @override
  String get selectSearchHint => 'Leita';

  @override
  String get selectNoResults => 'Engar samsvarandi niðurstöður.';

  @override
  String get selectScrollUpSemanticsLabel => 'Fletta upp';

  @override
  String get selectScrollDownSemanticsLabel => 'Fletta niður';

  @override
  String get sheetSemanticsLabel => 'Blað';

  @override
  String get textFieldEmailLabel => 'Netfang';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Hreinsa';

  @override
  String get passwordFieldLabel => 'Lykilorð';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Fela lykilorð';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Sýna lykilorð';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Veldu tíma';

  @override
  String get timeFieldInvalidDateError => 'Ógildur tími.';
}

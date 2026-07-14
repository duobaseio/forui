// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class FLocalizationsTl extends FLocalizations {
  FLocalizationsTl([String locale = 'tl']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Isara ang \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Walang nahanap na tugma.';

  @override
  String autocompleteResults(int count) {
    return '$count resulta ang available';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Mungkahi: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Tab $tabIndex ng $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Susunod na buwan';

  @override
  String get calendarNextYearSemanticsLabel => 'Susunod na taon';

  @override
  String get calendarNextYearsSemanticsLabel => 'Susunod na mga taon';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Nakaraang buwan';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Nakaraang taon';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Nakaraang mga taon';

  @override
  String get calendarShowDaysSemanticsHint => 'Ipakita ang mga araw';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Ipakita ang pampili ng buwan';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Ipakita ang pampili ng buwan at taon';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Ipakita ang pampili ng taon';

  @override
  String get calendarTodaySemanticsLabel => 'Ngayon';

  @override
  String get contextMenuSemanticsLabel => 'Menu ng konteksto';

  @override
  String get dateFieldHint => 'Pumili ng petsa';

  @override
  String get dateFieldInvalidDateError => 'Hindi wastong petsa.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Ngayon';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'Bumalik';

  @override
  String get headerCloseSemanticsLabel => 'Isara';

  @override
  String get paginationPreviousSemanticsLabel => 'Nakaraan';

  @override
  String get paginationNextSemanticsLabel => 'Susunod';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Naglo-load';

  @override
  String get multiSelectHint => 'Pumili ng mga item';

  @override
  String get selectHint => 'Pumili ng item';

  @override
  String get selectSearchHint => 'Maghanap';

  @override
  String get selectNoResults => 'Walang mga tumutugmang resulta.';

  @override
  String get selectScrollUpSemanticsLabel => 'Mag-scroll pataas';

  @override
  String get selectScrollDownSemanticsLabel => 'Mag-scroll pababa';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get textFieldEmailLabel => 'Email';

  @override
  String get textFieldClearButtonSemanticsLabel => 'I-clear';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Itago ang password';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Ipakita ang password';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pumili ng oras';

  @override
  String get timeFieldInvalidDateError => 'Di-wastong oras.';

  @override
  String get timePickerHourSemanticsLabel => 'Oras';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minuto';
}

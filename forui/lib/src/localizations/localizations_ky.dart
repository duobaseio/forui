// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class FLocalizationsKy extends FLocalizations {
  FLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get barrierLabel => 'Кенеп';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName жабуу';
  }

  @override
  String get autocompleteNoResults => 'Эч кандай дал келүү табылган жок.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount ичинен $tabIndex-өтмөк';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Кийинки ай';

  @override
  String get calendarNextYearSemanticsLabel => 'Кийинки жыл';

  @override
  String get calendarNextYearsSemanticsLabel => 'Кийинки жылдар';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Мурунку ай';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Мурунку жыл';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Мурунку жылдар';

  @override
  String get calendarShowDaysSemanticsHint => 'Күндөрдү көрсөтүү';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Ай тандагычын көрсөтүү';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Ай жана жыл тандагычын көрсөтүү';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Жыл тандагычын көрсөтүү';

  @override
  String get calendarTodaySemanticsLabel => 'Бүгүн';

  @override
  String get contextMenuSemanticsLabel => 'Контексттик меню';

  @override
  String get dateFieldHint => 'Күндү тандоо';

  @override
  String get dateFieldInvalidDateError => 'Жараксыз күн.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Бүгүн';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'Артка';

  @override
  String get headerCloseSemanticsLabel => 'Жабуу';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Калкып чыгуучу терезе';

  @override
  String get progressSemanticsLabel => 'Жүктөлүүдө';

  @override
  String get multiSelectHint => 'Элементтерди тандоо';

  @override
  String get selectHint => 'Элементти тандаңыз';

  @override
  String get selectSearchHint => 'Издөө';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Өйдө сыдыруу';

  @override
  String get selectScrollDownSemanticsLabel => 'Ылдый сыдыруу';

  @override
  String get sheetSemanticsLabel => 'экран';

  @override
  String get textFieldEmailLabel => 'Электрондук почта';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Сырсөз';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Сырсөздү жашыруу';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Сырсөздү көрсөтүү';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Убакытты тандаңыз';

  @override
  String get timeFieldInvalidDateError => 'Жараксыз убакыт.';

  @override
  String get timePickerHourSemanticsLabel => 'Саат';

  @override
  String get timePickerMinuteSemanticsLabel => 'Мүнөт';
}

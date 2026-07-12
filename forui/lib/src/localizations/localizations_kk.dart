// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class FLocalizationsKk extends FLocalizations {
  FLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get barrierLabel => 'Кенеп';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName жабу';
  }

  @override
  String get autocompleteNoResults => 'Ешқандай сәйкестік табылмады.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount қойындының $tabIndex-сы';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Келесі ай';

  @override
  String get calendarNextYearSemanticsLabel => 'Келесі жыл';

  @override
  String get calendarNextYearsSemanticsLabel => 'Келесі жылдар';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Алдыңғы ай';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Алдыңғы жыл';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Алдыңғы жылдар';

  @override
  String get calendarShowDaysSemanticsHint => 'Күндерді көрсету';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Ай таңдағышын көрсету';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Ай мен жыл таңдағышын көрсету';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Жыл таңдағышын көрсету';

  @override
  String get calendarTodaySemanticsLabel => 'Бүгін';

  @override
  String get contextMenuSemanticsLabel => 'Контекстік мәзір';

  @override
  String get dateFieldHint => 'Күнді таңдаңыз';

  @override
  String get dateFieldInvalidDateError => 'Жарамсыз күн.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Бүгін';

  @override
  String get dialogSemanticsLabel => 'Диалогтық терезе';

  @override
  String get headerBackSemanticsLabel => 'Артқа';

  @override
  String get headerCloseSemanticsLabel => 'Жабу';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Қалқымалы терезе';

  @override
  String get progressSemanticsLabel => 'Жүктелуде';

  @override
  String get multiSelectHint => 'Элементтерді таңдаңыз';

  @override
  String get selectHint => 'Элементті таңдаңыз';

  @override
  String get selectSearchHint => 'Іздеу';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Жоғары айналдыру';

  @override
  String get selectScrollDownSemanticsLabel => 'Төмен айналдыру';

  @override
  String get sheetSemanticsLabel => 'парақша';

  @override
  String get textFieldEmailLabel => 'Электрондық пошта';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Құпия сөз';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Құпия сөзді жасыру';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Құпия сөзді көрсету';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Уақытты таңдаңыз';

  @override
  String get timeFieldInvalidDateError => 'Жарамсыз уақыт.';
}

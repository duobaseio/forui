// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class FLocalizationsUk extends FLocalizations {
  FLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get barrierLabel => 'Маскувальний фон';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Закрити: \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Збігів не знайдено.';

  @override
  String autocompleteResults(int count) {
    return 'Доступно результатів: $count';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Пропозиція: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Вкладка $tabIndex з $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Наступний місяць';

  @override
  String get calendarNextYearSemanticsLabel => 'Наступний рік';

  @override
  String get calendarNextYearsSemanticsLabel => 'Наступні роки';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Попередній місяць';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Попередній рік';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Попередні роки';

  @override
  String get calendarShowDaysSemanticsHint => 'Показати дні';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Показати вибір місяця';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Показати вибір місяця та року';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Показати вибір року';

  @override
  String get calendarTodaySemanticsLabel => 'Сьогодні';

  @override
  String get contextMenuSemanticsLabel => 'Контекстне меню';

  @override
  String get dateFieldHint => 'Виберіть дату';

  @override
  String get dateFieldInvalidDateError => 'Недійсна дата.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Сьогодні';

  @override
  String get dialogSemanticsLabel => 'Вікно';

  @override
  String get headerBackSemanticsLabel => 'Назад';

  @override
  String get headerCloseSemanticsLabel => 'Закрити';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Спливаюче вікно';

  @override
  String get progressSemanticsLabel => 'Завантаження';

  @override
  String get multiSelectHint => 'Виберіть елементи';

  @override
  String get selectHint => 'Виберіть елемент';

  @override
  String get selectSearchHint => 'Пошук';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Прокрутити вгору';

  @override
  String get selectScrollDownSemanticsLabel => 'Прокрутити вниз';

  @override
  String get sheetSemanticsLabel => 'екран';

  @override
  String get textFieldEmailLabel => 'Електронна пошта';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Пароль';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Приховати пароль';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Показати пароль';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Виберіть час';

  @override
  String get timeFieldInvalidDateError => 'Недійсний час.';

  @override
  String get timePickerHourSemanticsLabel => 'Години';

  @override
  String get timePickerMinuteSemanticsLabel => 'Хвилини';
}

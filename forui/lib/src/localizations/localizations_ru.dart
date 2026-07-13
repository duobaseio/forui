// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class FLocalizationsRu extends FLocalizations {
  FLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get barrierLabel => 'Маска';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Закрыть \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Совпадений не найдено.';

  @override
  String autocompleteResults(int count) {
    return 'Доступно результатов: $count';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Предложение: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Вкладка $tabIndex из $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Следующий месяц';

  @override
  String get calendarNextYearSemanticsLabel => 'Следующий год';

  @override
  String get calendarNextYearsSemanticsLabel => 'Следующие годы';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Предыдущий месяц';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Предыдущий год';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Предыдущие годы';

  @override
  String get calendarShowDaysSemanticsHint => 'Показать дни';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Показать выбор месяца';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Показать выбор месяца и года';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Показать выбор года';

  @override
  String get calendarTodaySemanticsLabel => 'Сегодня';

  @override
  String get contextMenuSemanticsLabel => 'Контекстное меню';

  @override
  String get dateFieldHint => 'Выберите дату';

  @override
  String get dateFieldInvalidDateError => 'Недействительная дата.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Сегодня';

  @override
  String get dialogSemanticsLabel => 'Диалоговое окно';

  @override
  String get headerBackSemanticsLabel => 'Назад';

  @override
  String get headerCloseSemanticsLabel => 'Закрыть';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Всплывающее окно';

  @override
  String get progressSemanticsLabel => 'Загрузка';

  @override
  String get multiSelectHint => 'Выберите элементы';

  @override
  String get selectHint => 'Выберите элемент';

  @override
  String get selectSearchHint => 'Поиск';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Прокрутить вверх';

  @override
  String get selectScrollDownSemanticsLabel => 'Прокрутить вниз';

  @override
  String get sheetSemanticsLabel => 'экран';

  @override
  String get textFieldEmailLabel => 'Электронная почта';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Пароль';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Скрыть пароль';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Показать пароль';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Выберите время';

  @override
  String get timeFieldInvalidDateError => 'Недействительное время.';

  @override
  String get timePickerHourSemanticsLabel => 'Часы';

  @override
  String get timePickerMinuteSemanticsLabel => 'Минуты';
}

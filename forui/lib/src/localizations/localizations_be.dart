// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class FLocalizationsBe extends FLocalizations {
  FLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get barrierLabel => 'Палатно';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Закрыць: \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Няма знойдзеных супадзенняў.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Укладка $tabIndex з $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Наступны месяц';

  @override
  String get calendarNextYearSemanticsLabel => 'Наступны год';

  @override
  String get calendarNextYearsSemanticsLabel => 'Наступныя гады';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Папярэдні месяц';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Папярэдні год';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Папярэднія гады';

  @override
  String get contextMenuSemanticsLabel => 'Кантэкстнае меню';

  @override
  String get dateFieldHint => 'Выберыце дату';

  @override
  String get dateFieldInvalidDateError => 'Няправільная дата.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Сёння';

  @override
  String get dialogSemanticsLabel => 'Дыялогавае акно';

  @override
  String get headerBackSemanticsLabel => 'Назад';

  @override
  String get headerCloseSemanticsLabel => 'Закрыць';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Усплывальнае акно';

  @override
  String get progressSemanticsLabel => 'Загрузка';

  @override
  String get multiSelectHint => 'Выберыце элементы';

  @override
  String get selectHint => 'Выберыце элемент';

  @override
  String get selectSearchHint => 'Пошук';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Прагартаць уверх';

  @override
  String get selectScrollDownSemanticsLabel => 'Прагартаць уніз';

  @override
  String get sheetSemanticsLabel => 'аркуш';

  @override
  String get textFieldEmailLabel => 'Электронная пошта';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Пароль';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Схаваць пароль';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Паказаць пароль';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Выберыце час';

  @override
  String get timeFieldInvalidDateError => 'Няправільны час.';
}

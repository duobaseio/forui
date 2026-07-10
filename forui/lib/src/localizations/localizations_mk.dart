// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class FLocalizationsMk extends FLocalizations {
  FLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get barrierLabel => 'Скрим';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Затворете ја \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Не се пронајдени совпаѓања.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Картичка $tabIndex од $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Следен месец';

  @override
  String get calendarNextYearSemanticsLabel => 'Следна година';

  @override
  String get calendarNextYearsSemanticsLabel => 'Следни години';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Претходен месец';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Претходна година';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Претходни години';

  @override
  String get contextMenuSemanticsLabel => 'Контекстно мени';

  @override
  String get dateFieldHint => 'Изберете датум';

  @override
  String get dateFieldInvalidDateError => 'Неважечки датум.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => ' г.';

  @override
  String get dateTimePickerToday => 'Денес';

  @override
  String get dialogSemanticsLabel => 'Дијалог';

  @override
  String get headerBackSemanticsLabel => 'Назад';

  @override
  String get headerCloseSemanticsLabel => 'Затвори';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Скокачки прозорец';

  @override
  String get progressSemanticsLabel => 'Се вчитува';

  @override
  String get multiSelectHint => 'Изберете елементи';

  @override
  String get selectHint => 'Изберете ставка';

  @override
  String get selectSearchHint => 'Пребарување';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Лизгај нагоре';

  @override
  String get selectScrollDownSemanticsLabel => 'Лизгај надолу';

  @override
  String get sheetSemanticsLabel => 'лист';

  @override
  String get textFieldEmailLabel => 'Е-пошта';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Лозинка';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Сокриј лозинка';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Прикажи лозинка';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Изберете време';

  @override
  String get timeFieldInvalidDateError => 'Невалидно време.';
}

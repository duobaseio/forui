// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class FLocalizationsMn extends FLocalizations {
  FLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get barrierLabel => 'Скрим';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName-г хаах';
  }

  @override
  String get autocompleteNoResults => 'Тохирох зүйл олдсонгүй.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount-н $tabIndex-р таб';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Дараагийн сар';

  @override
  String get calendarNextYearSemanticsLabel => 'Дараа жил';

  @override
  String get calendarNextYearsSemanticsLabel => 'Дараагийн жилүүд';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Өмнөх сар';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Өмнөх жил';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Өмнөх жилүүд';

  @override
  String get calendarShowDaysSemanticsHint => 'Өдрүүдийг харуулах';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Сар сонгогчийг харуулах';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Сар, жил сонгогчийг харуулах';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Жил сонгогчийг харуулах';

  @override
  String get calendarTodaySemanticsLabel => 'Өнөөдөр';

  @override
  String get contextMenuSemanticsLabel => 'Контекст цэс';

  @override
  String get dateFieldHint => 'Огноо сонгох';

  @override
  String get dateFieldInvalidDateError => 'Огноо буруу байна.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Өнөөдөр';

  @override
  String get dialogSemanticsLabel => 'Харилцах цонх';

  @override
  String get headerBackSemanticsLabel => 'Буцах';

  @override
  String get headerCloseSemanticsLabel => 'Хаах';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Товших цонх';

  @override
  String get progressSemanticsLabel => 'Ачааллаж байна';

  @override
  String get multiSelectHint => 'Зүйлсийг сонгох';

  @override
  String get selectHint => 'Зүйл сонгох';

  @override
  String get selectSearchHint => 'Хайх';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Дээш гүйлгэх';

  @override
  String get selectScrollDownSemanticsLabel => 'Доош гүйлгэх';

  @override
  String get sheetSemanticsLabel => 'хүснэгт';

  @override
  String get textFieldEmailLabel => 'Имэйл';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Нууц үг';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Нууц үгийг нуух';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Нууц үгийг харуулах';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Цаг сонгох';

  @override
  String get timeFieldInvalidDateError => 'Буруу цаг.';

  @override
  String get timePickerHourSemanticsLabel => 'Цаг';

  @override
  String get timePickerMinuteSemanticsLabel => 'Минут';
}

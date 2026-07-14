// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class FLocalizationsKo extends FLocalizations {
  FLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get barrierLabel => '스크림';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName 닫기';
  }

  @override
  String get autocompleteNoResults => '일치하는 항목이 없습니다.';

  @override
  String autocompleteResults(int count) {
    return '$count개의 결과가 있습니다';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return '제안: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '탭 $tabCount개 중 $tabIndex번째';
  }

  @override
  String get calendarNextMonthSemanticsLabel => '다음 달';

  @override
  String get calendarNextYearSemanticsLabel => '다음 해';

  @override
  String get calendarNextYearsSemanticsLabel => '다음 해들';

  @override
  String get calendarPreviousMonthSemanticsLabel => '이전 달';

  @override
  String get calendarPreviousYearSemanticsLabel => '이전 해';

  @override
  String get calendarPreviousYearsSemanticsLabel => '이전 해들';

  @override
  String get calendarShowDaysSemanticsHint => '일 표시';

  @override
  String get calendarShowMonthPickerSemanticsHint => '월 선택 도구 표시';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => '월 및 연도 선택 도구 표시';

  @override
  String get calendarShowYearPickerSemanticsHint => '연도 선택 도구 표시';

  @override
  String get calendarTodaySemanticsLabel => '오늘';

  @override
  String get contextMenuSemanticsLabel => '컨텍스트 메뉴';

  @override
  String get dateFieldHint => '날짜 선택';

  @override
  String get dateFieldInvalidDateError => '날짜가 잘못되었습니다.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dateTimePickerToday => '오늘';

  @override
  String get dialogSemanticsLabel => '대화상자';

  @override
  String get headerBackSemanticsLabel => '뒤로';

  @override
  String get headerCloseSemanticsLabel => '닫기';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => '팝오버';

  @override
  String get progressSemanticsLabel => '로딩 중';

  @override
  String get multiSelectHint => '항목 선택';

  @override
  String get selectHint => '항목 선택';

  @override
  String get selectSearchHint => '검색';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => '위로 스크롤';

  @override
  String get selectScrollDownSemanticsLabel => '아래로 스크롤';

  @override
  String get sheetSemanticsLabel => '시트';

  @override
  String get textFieldEmailLabel => '이메일';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => '비밀번호';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => '비밀번호 숨기기';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => '비밀번호 보이기';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '시간 선택';

  @override
  String get timeFieldInvalidDateError => '잘못된 시간입니다.';

  @override
  String get timePickerHourSemanticsLabel => '시';

  @override
  String get timePickerMinuteSemanticsLabel => '분';
}

// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Pushto Pashto (`ps`).
class FLocalizationsPs extends FLocalizations {
  FLocalizationsPs([String locale = 'ps']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteName';
  }

  @override
  String get autocompleteNoResults => 'هیڅ میچ ونه موندل شو.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'د $tabCount څخه $tabIndex ټب';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'راتلونکې میاشت';

  @override
  String get calendarNextYearSemanticsLabel => 'راتلونکی کال';

  @override
  String get calendarNextYearsSemanticsLabel => 'راتلونکي کلونه';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'تېره میاشت';

  @override
  String get calendarPreviousYearSemanticsLabel => 'تېر کال';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'تېر کلونه';

  @override
  String get contextMenuSemanticsLabel => 'د شرایطو مینو';

  @override
  String get dateFieldHint => 'نېټه وټاکئ';

  @override
  String get dateFieldInvalidDateError => 'ناسمه نېټه.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'نن';

  @override
  String get dialogSemanticsLabel => 'خبرې اترې';

  @override
  String get headerBackSemanticsLabel => 'شاته';

  @override
  String get headerCloseSemanticsLabel => 'بندول';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'پاپ اوور';

  @override
  String get progressSemanticsLabel => 'د بارولو په حال کې';

  @override
  String get multiSelectHint => 'توکي غوره کړئ';

  @override
  String get selectHint => 'یو توکی وټاکئ';

  @override
  String get selectSearchHint => 'لټون';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'پورته سکرول کړئ';

  @override
  String get selectScrollDownSemanticsLabel => 'ښکته سکرول کړئ';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get textFieldEmailLabel => 'برېښنالیک';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'پټنوم';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'پټنوم پټول';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'پټنوم ښودل';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'یو وخت وټاکئ';

  @override
  String get timeFieldInvalidDateError => 'ناسم وخت.';
}

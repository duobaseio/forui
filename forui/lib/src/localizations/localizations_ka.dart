// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class FLocalizationsKa extends FLocalizations {
  FLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get barrierLabel => 'სკრიმი';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName-ის დახურვა';
  }

  @override
  String get autocompleteNoResults => 'შესაბამისობები ვერ იქნა ნაპოვნი.';

  @override
  String get calendarNextMonthSemanticsLabel => 'შემდეგი თვე';

  @override
  String get calendarNextYearSemanticsLabel => 'შემდეგი წელი';

  @override
  String get calendarNextYearsSemanticsLabel => 'შემდეგი წლები';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'წინა თვე';

  @override
  String get calendarPreviousYearSemanticsLabel => 'წინა წელი';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'წინა წლები';

  @override
  String get contextMenuSemanticsLabel => 'კონტექსტური მენიუ';

  @override
  String get dateFieldHint => 'აირჩიეთ თარიღი';

  @override
  String get dateFieldInvalidDateError => 'არასწორი თარიღი.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'დღეს';

  @override
  String get dialogSemanticsLabel => 'დიალოგი';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'ამომხტარი ფანჯარა';

  @override
  String get progressSemanticsLabel => 'იტვირთება';

  @override
  String get multiSelectHint => 'ელემენტების არჩევა';

  @override
  String get selectHint => 'აირჩიეთ ელემენტი';

  @override
  String get selectSearchHint => 'ძიება';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ზემოთ გადაადგილება';

  @override
  String get selectScrollDownSemanticsLabel => 'ქვემოთ გადაადგილება';

  @override
  String get sheetSemanticsLabel => 'ფურცელი';

  @override
  String get textFieldEmailLabel => 'ელფოსტა';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'პაროლი';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'პაროლის დამალვა';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'პაროლის ჩვენება';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'აირჩიეთ დრო';

  @override
  String get timeFieldInvalidDateError => 'არასწორი დრო.';
}

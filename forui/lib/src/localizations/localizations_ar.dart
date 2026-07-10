// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class FLocalizationsAr extends FLocalizations {
  FLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get barrierLabel => 'تمويه';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'إغلاق \"\$modalRouteContentName\"';
  }

  @override
  String get autocompleteNoResults => 'لم يتم العثور على أي تطابقات.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'علامة التبويب $tabIndex من $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'الشهر التالي';

  @override
  String get calendarNextYearSemanticsLabel => 'السنة التالية';

  @override
  String get calendarNextYearsSemanticsLabel => 'السنوات التالية';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'الشهر السابق';

  @override
  String get calendarPreviousYearSemanticsLabel => 'السنة السابقة';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'السنوات السابقة';

  @override
  String get contextMenuSemanticsLabel => 'قائمة السياق';

  @override
  String get dateFieldHint => 'اختر تاريخًا';

  @override
  String get dateFieldInvalidDateError => 'تاريخ غير صالح.';

  @override
  String get shortDateSeparator => '‏/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'اليوم';

  @override
  String get dialogSemanticsLabel => 'مربع حوار';

  @override
  String get headerBackSemanticsLabel => 'رجوع';

  @override
  String get headerCloseSemanticsLabel => 'إغلاق';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'منبثقة';

  @override
  String get progressSemanticsLabel => 'جاري التحميل';

  @override
  String get multiSelectHint => 'حدد العناصر';

  @override
  String get selectHint => 'حدد عنصرا';

  @override
  String get selectSearchHint => 'بحث';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'التمرير لأعلى';

  @override
  String get selectScrollDownSemanticsLabel => 'التمرير لأسفل';

  @override
  String get sheetSemanticsLabel => 'بطاق ';

  @override
  String get textFieldEmailLabel => 'البريد الإلكتروني';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'كلمة المرور';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'إخفاء كلمة المرور';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'إظهار كلمة المرور';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'اختر وقتًا';

  @override
  String get timeFieldInvalidDateError => 'وقت غير صالح.';
}

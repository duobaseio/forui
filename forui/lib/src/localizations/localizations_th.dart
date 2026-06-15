// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class FLocalizationsTh extends FLocalizations {
  FLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'ปิด \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'ไม่พบรายการที่ตรงกัน.';

  @override
  String get calendarNextMonthSemanticsLabel => 'เดือนถัดไป';

  @override
  String get calendarNextYearSemanticsLabel => 'ปีถัดไป';

  @override
  String get calendarNextYearsSemanticsLabel => 'ปีถัดไป';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'เดือนก่อนหน้า';

  @override
  String get calendarPreviousYearSemanticsLabel => 'ปีก่อนหน้า';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'ปีก่อนหน้า';

  @override
  String get contextMenuSemanticsLabel => 'เมนูบริบท';

  @override
  String get dateFieldHint => 'เลือกวันที่';

  @override
  String get dateFieldInvalidDateError => 'วันที่ไม่ถูกต้อง';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'วันนี้';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'ป๊อปโอเวอร์';

  @override
  String get progressSemanticsLabel => 'กำลังโหลด';

  @override
  String get multiSelectHint => 'เลือกรายการ';

  @override
  String get selectHint => 'เลือกรายการ';

  @override
  String get selectSearchHint => 'ค้นหา';

  @override
  String get selectNoResults => 'ไม่มีผลลัพธ์ที่ตรงกัน';

  @override
  String get selectScrollUpSemanticsLabel => 'เลื่อนขึ้น';

  @override
  String get selectScrollDownSemanticsLabel => 'เลื่อนลง';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get textFieldEmailLabel => 'อีเมล';

  @override
  String get textFieldClearButtonSemanticsLabel => 'ล้าง';

  @override
  String get passwordFieldLabel => 'รหัสผ่าน';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'ซ่อนรหัสผ่าน';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'แสดงรหัสผ่าน';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => ' น.';

  @override
  String get timeFieldHint => 'เลือกเวลา';

  @override
  String get timeFieldInvalidDateError => 'เวลาไม่ถูกต้อง';
}

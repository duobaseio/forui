// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class FLocalizationsMs extends FLocalizations {
  FLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Tutup \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Tiada padanan ditemui.';

  @override
  String autocompleteResults(int count) {
    return '$count hasil tersedia';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Cadangan: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Tab $tabIndex daripada $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Bulan seterusnya';

  @override
  String get calendarNextYearSemanticsLabel => 'Tahun seterusnya';

  @override
  String get calendarNextYearsSemanticsLabel => 'Tahun-tahun seterusnya';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Bulan sebelumnya';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Tahun sebelumnya';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Tahun-tahun sebelumnya';

  @override
  String get calendarShowDaysSemanticsHint => 'Tunjukkan hari';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Tunjukkan pemilih bulan';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Tunjukkan pemilih bulan dan tahun';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Tunjukkan pemilih tahun';

  @override
  String get calendarTodaySemanticsLabel => 'Hari ini';

  @override
  String get contextMenuSemanticsLabel => 'Menu konteks';

  @override
  String get dateFieldHint => 'Pilih tarikh';

  @override
  String get dateFieldInvalidDateError => 'Tarikh tidak sah.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Hari ini';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get headerBackSemanticsLabel => 'Kembali';

  @override
  String get headerCloseSemanticsLabel => 'Tutup';

  @override
  String get paginationPreviousSemanticsLabel => 'Sebelumnya';

  @override
  String get paginationNextSemanticsLabel => 'Seterusnya';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Memuatkan';

  @override
  String get multiSelectHint => 'Pilih item';

  @override
  String get selectHint => 'Pilih item';

  @override
  String get selectSearchHint => 'Cari';

  @override
  String get selectNoResults => 'Tiada hasil yang sepadan.';

  @override
  String get selectScrollUpSemanticsLabel => 'Tatal ke atas';

  @override
  String get selectScrollDownSemanticsLabel => 'Tatal ke bawah';

  @override
  String get sheetSemanticsLabel => 'Helaian';

  @override
  String get textFieldEmailLabel => 'E-mel';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Kosongkan';

  @override
  String get passwordFieldLabel => 'Kata laluan';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Sembunyikan kata laluan';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Tunjukkan kata laluan';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pilih masa';

  @override
  String get timeFieldInvalidDateError => 'Masa tidak sah.';

  @override
  String get timePickerHourSemanticsLabel => 'Jam';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minit';
}

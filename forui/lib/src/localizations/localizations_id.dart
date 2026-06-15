// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class FLocalizationsId extends FLocalizations {
  FLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Tutup \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Tidak ada hasil yang cocok.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Bulan berikutnya';

  @override
  String get calendarNextYearSemanticsLabel => 'Tahun berikutnya';

  @override
  String get calendarNextYearsSemanticsLabel => 'Tahun-tahun berikutnya';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Bulan sebelumnya';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Tahun sebelumnya';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Tahun-tahun sebelumnya';

  @override
  String get contextMenuSemanticsLabel => 'Menu konteks';

  @override
  String get dateFieldHint => 'Pilih tanggal';

  @override
  String get dateFieldInvalidDateError => 'Tanggal tidak valid.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Hari ini';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Sebelumnya';

  @override
  String get paginationNextSemanticsLabel => 'Berikutnya';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Memuat';

  @override
  String get multiSelectHint => 'Pilih item';

  @override
  String get selectHint => 'Pilih item';

  @override
  String get selectSearchHint => 'Cari';

  @override
  String get selectNoResults => 'Tidak ada hasil yang cocok.';

  @override
  String get selectScrollUpSemanticsLabel => 'Gulir ke atas';

  @override
  String get selectScrollDownSemanticsLabel => 'Gulir ke bawah';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get textFieldEmailLabel => 'Email';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Hapus';

  @override
  String get passwordFieldLabel => 'Kata sandi';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Sembunyikan kata sandi';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Tampilkan kata sandi';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pilih waktu';

  @override
  String get timeFieldInvalidDateError => 'Waktu tidak valid.';
}

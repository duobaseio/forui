// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class FLocalizationsTr extends FLocalizations {
  FLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get barrierLabel => 'opaklık katmanı';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName içeriğini kapat';
  }

  @override
  String get autocompleteNoResults => 'Eşleşme bulunamadı.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount sekmeden $tabIndex. sekme';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Sonraki ay';

  @override
  String get calendarNextYearSemanticsLabel => 'Sonraki yıl';

  @override
  String get calendarNextYearsSemanticsLabel => 'Sonraki yıllar';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Önceki ay';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Önceki yıl';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Önceki yıllar';

  @override
  String get calendarShowDaysSemanticsHint => 'Günleri göster';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Ay seçiciyi göster';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Ay ve yıl seçiciyi göster';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Yıl seçiciyi göster';

  @override
  String get calendarTodaySemanticsLabel => 'Bugün';

  @override
  String get contextMenuSemanticsLabel => 'Bağlam menüsü';

  @override
  String get dateFieldHint => 'Tarih seçin';

  @override
  String get dateFieldInvalidDateError => 'Geçersiz tarih.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Bugün';

  @override
  String get dialogSemanticsLabel => 'İletişim kutusu';

  @override
  String get headerBackSemanticsLabel => 'Geri';

  @override
  String get headerCloseSemanticsLabel => 'Kapat';

  @override
  String get paginationPreviousSemanticsLabel => 'Önceki';

  @override
  String get paginationNextSemanticsLabel => 'İleri';

  @override
  String get popoverSemanticsLabel => 'Açılır pencere';

  @override
  String get progressSemanticsLabel => 'Yükleniyor';

  @override
  String get multiSelectHint => 'Öğeleri seç';

  @override
  String get selectHint => 'Bir öğe seçin';

  @override
  String get selectSearchHint => 'Ara';

  @override
  String get selectNoResults => 'Eşleşen sonuç yok.';

  @override
  String get selectScrollUpSemanticsLabel => 'Yukarı kaydır';

  @override
  String get selectScrollDownSemanticsLabel => 'Aşağı kaydır';

  @override
  String get sheetSemanticsLabel => 'sayfa';

  @override
  String get textFieldEmailLabel => 'E-posta';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Temizle';

  @override
  String get passwordFieldLabel => 'Şifre';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Şifreyi gizle';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Şifreyi göster';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Bir zaman seçin';

  @override
  String get timeFieldInvalidDateError => 'Geçersiz zaman.';

  @override
  String get timePickerHourSemanticsLabel => 'Saat';

  @override
  String get timePickerMinuteSemanticsLabel => 'Dakika';
}

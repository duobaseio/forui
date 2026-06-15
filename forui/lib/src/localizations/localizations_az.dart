// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class FLocalizationsAz extends FLocalizations {
  FLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get barrierLabel => 'Kətan';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Bağlayın: \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Heç bir uyğunluq tapılmadı.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Növbəti ay';

  @override
  String get calendarNextYearSemanticsLabel => 'Növbəti il';

  @override
  String get calendarNextYearsSemanticsLabel => 'Növbəti illər';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Əvvəlki ay';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Əvvəlki il';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Əvvəlki illər';

  @override
  String get contextMenuSemanticsLabel => 'Kontekst menyusu';

  @override
  String get dateFieldHint => 'Tarix seçin';

  @override
  String get dateFieldInvalidDateError => 'Yanlış tarix.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Bu gün';

  @override
  String get dialogSemanticsLabel => 'Dialoq';

  @override
  String get paginationPreviousSemanticsLabel => 'Əvvəlki';

  @override
  String get paginationNextSemanticsLabel => 'Növbəti';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Yüklənir';

  @override
  String get multiSelectHint => 'Elementləri seçin';

  @override
  String get selectHint => 'Element seçin';

  @override
  String get selectSearchHint => 'Axtarış';

  @override
  String get selectNoResults => 'Uyğun nəticə tapılmadı.';

  @override
  String get selectScrollUpSemanticsLabel => 'Yuxarı sürüşdür';

  @override
  String get selectScrollDownSemanticsLabel => 'Aşağı sürüşdür';

  @override
  String get sheetSemanticsLabel => 'Vərəq';

  @override
  String get textFieldEmailLabel => 'E-poçt';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Təmizlə';

  @override
  String get passwordFieldLabel => 'Parol';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Parolu gizlə';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Parolu göstər';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vaxt seçin';

  @override
  String get timeFieldInvalidDateError => 'Yanlış vaxt.';
}

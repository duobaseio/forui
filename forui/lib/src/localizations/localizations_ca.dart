// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class FLocalizationsCa extends FLocalizations {
  FLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get barrierLabel => 'Fons atenuat';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Tanca \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'No s\'han trobat coincidències.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Pestanya $tabIndex de $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Mes següent';

  @override
  String get calendarNextYearSemanticsLabel => 'Any següent';

  @override
  String get calendarNextYearsSemanticsLabel => 'Anys següents';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mes anterior';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Any anterior';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Anys anteriors';

  @override
  String get calendarShowDaysSemanticsHint => 'Mostra els dies';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Mostra el selector de mes';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Mostra el selector de mes i any';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Mostra el selector d\'any';

  @override
  String get calendarTodaySemanticsLabel => 'Avui';

  @override
  String get contextMenuSemanticsLabel => 'Menú contextual';

  @override
  String get dateFieldHint => 'Selecciona una data';

  @override
  String get dateFieldInvalidDateError => 'Data no vàlida.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Avui';

  @override
  String get dialogSemanticsLabel => 'Diàleg';

  @override
  String get headerBackSemanticsLabel => 'Enrere';

  @override
  String get headerCloseSemanticsLabel => 'Tanca';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Finestra emergent';

  @override
  String get progressSemanticsLabel => 'Carregant';

  @override
  String get multiSelectHint => 'Selecciona elements';

  @override
  String get selectHint => 'Selecciona un element';

  @override
  String get selectSearchHint => 'Cerca';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Desplaça amunt';

  @override
  String get selectScrollDownSemanticsLabel => 'Desplaça avall';

  @override
  String get sheetSemanticsLabel => 'Full';

  @override
  String get textFieldEmailLabel => 'Correu electrònic';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Contrasenya';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Amaga la contrasenya';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Mostra la contrasenya';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Trieu una hora';

  @override
  String get timeFieldInvalidDateError => 'Hora no vàlida.';

  @override
  String get timePickerHourSemanticsLabel => 'Hora';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minut';
}

// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class FLocalizationsGl extends FLocalizations {
  FLocalizationsGl([String locale = 'gl']) : super(locale);

  @override
  String get barrierLabel => 'Sombreado';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Pechar \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Non se atoparon coincidencias.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Pestana $tabIndex de $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Mes seguinte';

  @override
  String get calendarNextYearSemanticsLabel => 'Ano seguinte';

  @override
  String get calendarNextYearsSemanticsLabel => 'Anos seguintes';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mes anterior';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Ano anterior';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Anos anteriores';

  @override
  String get contextMenuSemanticsLabel => 'Menú contextual';

  @override
  String get dateFieldHint => 'Selecciona unha data';

  @override
  String get dateFieldInvalidDateError => 'Data non válida.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Hoxe';

  @override
  String get dialogSemanticsLabel => 'Cadro de diálogo';

  @override
  String get headerBackSemanticsLabel => 'Atrás';

  @override
  String get headerCloseSemanticsLabel => 'Pechar';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Xanela emerxente';

  @override
  String get progressSemanticsLabel => 'Cargando';

  @override
  String get multiSelectHint => 'Seleccionar elementos';

  @override
  String get selectHint => 'Seleccione un elemento';

  @override
  String get selectSearchHint => 'Buscar';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Desprazarse cara arriba';

  @override
  String get selectScrollDownSemanticsLabel => 'Desprazarse cara abaixo';

  @override
  String get sheetSemanticsLabel => 'Panel';

  @override
  String get textFieldEmailLabel => 'Correo electrónico';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Contrasinal';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ocultar contrasinal';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Mostrar contrasinal';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Escolla unha hora';

  @override
  String get timeFieldInvalidDateError => 'Hora non válida.';
}

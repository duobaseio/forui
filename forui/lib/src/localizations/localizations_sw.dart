// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class FLocalizationsSw extends FLocalizations {
  FLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Funga \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Hakuna mechi zilizopatikana.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Kichupo cha $tabIndex kati ya $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Mwezi ujao';

  @override
  String get calendarNextYearSemanticsLabel => 'Mwaka unaofuata';

  @override
  String get calendarNextYearsSemanticsLabel => 'Miaka inayofuata';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mwezi uliopita';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Mwaka uliopita';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Miaka iliyopita';

  @override
  String get contextMenuSemanticsLabel => 'Menyu ya muktadha';

  @override
  String get dateFieldHint => 'Chagua tarehe';

  @override
  String get dateFieldInvalidDateError => 'Tarehe si sahihi.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Leo';

  @override
  String get dialogSemanticsLabel => 'Kidirisha';

  @override
  String get headerBackSemanticsLabel => 'Nyuma';

  @override
  String get headerCloseSemanticsLabel => 'Funga';

  @override
  String get paginationPreviousSemanticsLabel => 'Iliyotangulia';

  @override
  String get paginationNextSemanticsLabel => 'Inayofuata';

  @override
  String get popoverSemanticsLabel => 'Dirisha la haraka';

  @override
  String get progressSemanticsLabel => 'Inapakia';

  @override
  String get multiSelectHint => 'Chagua vipengee';

  @override
  String get selectHint => 'Chagua kipengee';

  @override
  String get selectSearchHint => 'Tafuta';

  @override
  String get selectNoResults => 'Hakuna matokeo yanayolingana.';

  @override
  String get selectScrollUpSemanticsLabel => 'Sogeza juu';

  @override
  String get selectScrollDownSemanticsLabel => 'Sogeza chini';

  @override
  String get sheetSemanticsLabel => 'Safu';

  @override
  String get textFieldEmailLabel => 'Barua pepe';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Futa';

  @override
  String get passwordFieldLabel => 'Nenosiri';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ficha nenosiri';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Onyesha nenosiri';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Chagua wakati';

  @override
  String get timeFieldInvalidDateError => 'Wakati batili.';
}

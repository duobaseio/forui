// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class FLocalizationsRo extends FLocalizations {
  FLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get barrierLabel => 'Material';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Închideți \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nu s-au găsit potriviri.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Luna următoare';

  @override
  String get calendarNextYearSemanticsLabel => 'Anul următor';

  @override
  String get calendarNextYearsSemanticsLabel => 'Anii următori';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Luna anterioară';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Anul precedent';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Anii precedenți';

  @override
  String get contextMenuSemanticsLabel => 'Meniu contextual';

  @override
  String get dateFieldHint => 'Selectați data';

  @override
  String get dateFieldInvalidDateError => 'Dată nevalidă.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Astăzi';

  @override
  String get dialogSemanticsLabel => 'Casetă de dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Anterior';

  @override
  String get paginationNextSemanticsLabel => 'Înainte';

  @override
  String get popoverSemanticsLabel => 'Fereastră contextuală';

  @override
  String get progressSemanticsLabel => 'Se încarcă';

  @override
  String get multiSelectHint => 'Selectează elemente';

  @override
  String get selectHint => 'Selectați un element';

  @override
  String get selectSearchHint => 'Căutare';

  @override
  String get selectNoResults => 'Niciun rezultat care să se potrivească.';

  @override
  String get selectScrollUpSemanticsLabel => 'Derulează în sus';

  @override
  String get selectScrollDownSemanticsLabel => 'Derulează în jos';

  @override
  String get sheetSemanticsLabel => 'Foaie';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Ștergeți';

  @override
  String get passwordFieldLabel => 'Parolă';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ascunde parola';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Afișează parola';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Alegeți o oră';

  @override
  String get timeFieldInvalidDateError => 'Oră invalidă.';
}

// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class FLocalizationsSv extends FLocalizations {
  FLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Stäng \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Inga träffar hittades.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Nästa månad';

  @override
  String get calendarNextYearSemanticsLabel => 'Nästa år';

  @override
  String get calendarNextYearsSemanticsLabel => 'Nästa år';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Föregående månad';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Föregående år';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Föregående år';

  @override
  String get contextMenuSemanticsLabel => 'Kontextmeny';

  @override
  String get dateFieldHint => 'Välj datum';

  @override
  String get dateFieldInvalidDateError => 'Ogiltigt datum.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Idag';

  @override
  String get dialogSemanticsLabel => 'Dialogruta';

  @override
  String get paginationPreviousSemanticsLabel => 'Föregående';

  @override
  String get paginationNextSemanticsLabel => 'Nästa';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Laddar';

  @override
  String get multiSelectHint => 'Välj objekt';

  @override
  String get selectHint => 'Välj ett objekt';

  @override
  String get selectSearchHint => 'Sök';

  @override
  String get selectNoResults => 'Inga matchande resultat.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rulla uppåt';

  @override
  String get selectScrollDownSemanticsLabel => 'Rulla nedåt';

  @override
  String get sheetSemanticsLabel => 'Ark';

  @override
  String get textFieldEmailLabel => 'E-post';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Rensa';

  @override
  String get passwordFieldLabel => 'Lösenord';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Dölj lösenord';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Visa lösenord';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Välj en tid';

  @override
  String get timeFieldInvalidDateError => 'Ogiltig tid.';
}

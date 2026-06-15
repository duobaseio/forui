// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Welsh (`cy`).
class FLocalizationsCy extends FLocalizations {
  FLocalizationsCy([String locale = 'cy']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cau \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Dim cydweddiadau wedi\'u canfod.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Mis nesaf';

  @override
  String get calendarNextYearSemanticsLabel => 'Blwyddyn nesaf';

  @override
  String get calendarNextYearsSemanticsLabel => 'Blynyddoedd nesaf';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mis blaenorol';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Blwyddyn flaenorol';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Blynyddoedd blaenorol';

  @override
  String get contextMenuSemanticsLabel => 'Dewislen cyd-destun';

  @override
  String get dateFieldHint => 'Dewiswch ddyddiad';

  @override
  String get dateFieldInvalidDateError => 'Dyddiad annilys.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Heddiw';

  @override
  String get dialogSemanticsLabel => 'Deialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Blaenorol';

  @override
  String get paginationNextSemanticsLabel => 'Nesaf';

  @override
  String get popoverSemanticsLabel => 'Ffenestr naid';

  @override
  String get progressSemanticsLabel => 'Yn llwytho';

  @override
  String get multiSelectHint => 'Dewis eitemau';

  @override
  String get selectHint => 'Dewiswch eitem';

  @override
  String get selectSearchHint => 'Chwilio';

  @override
  String get selectNoResults => 'Dim canlyniadau cyfatebol.';

  @override
  String get selectScrollUpSemanticsLabel => 'Sgrolio i fyny';

  @override
  String get selectScrollDownSemanticsLabel => 'Sgrolio i lawr';

  @override
  String get sheetSemanticsLabel => 'Taflen';

  @override
  String get textFieldEmailLabel => 'E-bost';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clirio';

  @override
  String get passwordFieldLabel => 'Cyfrinair';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Cuddio cyfrinair';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Dangos cyfrinair';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Dewiswch amser';

  @override
  String get timeFieldInvalidDateError => 'Amser annilys.';
}

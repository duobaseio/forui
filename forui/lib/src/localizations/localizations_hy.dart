// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class FLocalizationsHy extends FLocalizations {
  FLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get barrierLabel => 'Դիմակ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Փակել՝ \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Համընկնումներ չեն գտնվել.';

  @override
  String autocompleteResults(int count) {
    return '$count արդյունք հասանելի է';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Առաջարկ: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Ներդիր $tabIndex/$tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Հաջորդ ամիս';

  @override
  String get calendarNextYearSemanticsLabel => 'Հաջորդ տարի';

  @override
  String get calendarNextYearsSemanticsLabel => 'Հաջորդ տարիներ';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Նախորդ ամիս';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Նախորդ տարի';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Նախորդ տարիներ';

  @override
  String get calendarShowDaysSemanticsHint => 'Ցուցադրել օրերը';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Ցուցադրել ամսվա ընտրիչը';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Ցուցադրել ամսվա և տարվա ընտրիչը';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Ցուցադրել տարվա ընտրիչը';

  @override
  String get calendarTodaySemanticsLabel => 'Այսօր';

  @override
  String get contextMenuSemanticsLabel => 'Համատեկստային մենյու';

  @override
  String get dateFieldHint => 'Ընտրել ամսաթիվը';

  @override
  String get dateFieldInvalidDateError => 'Սխալ ամսաթիվ:';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Այսօր';

  @override
  String get dialogSemanticsLabel => 'Երկխոսության պատուհան';

  @override
  String get headerBackSemanticsLabel => 'Հետ';

  @override
  String get headerCloseSemanticsLabel => 'Փակել';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Ելնող պատուհան';

  @override
  String get progressSemanticsLabel => 'Բեռնում';

  @override
  String get multiSelectHint => 'Ընտրել տարրեր';

  @override
  String get selectHint => 'Ընտրեք տարր';

  @override
  String get selectSearchHint => 'Որոնել';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Ոլորել վերև';

  @override
  String get selectScrollDownSemanticsLabel => 'Ոլորել ներքև';

  @override
  String get sheetSemanticsLabel => 'էկրան';

  @override
  String get textFieldEmailLabel => 'Էլ․ փոստ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Գաղտնաբառ';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Թաքցնել գաղտնաբառը';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Ցույց տալ գաղտնաբառը';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Ընտրեք ժամանակը';

  @override
  String get timeFieldInvalidDateError => 'Անվավեր ժամանակ:';

  @override
  String get timePickerHourSemanticsLabel => 'Ժամ';

  @override
  String get timePickerMinuteSemanticsLabel => 'Րոպե';
}

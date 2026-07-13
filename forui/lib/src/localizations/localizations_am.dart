// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class FLocalizationsAm extends FLocalizations {
  FLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get barrierLabel => 'ገዳቢ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentNameን ዝጋ';
  }

  @override
  String get autocompleteNoResults => 'ማንኛውም ውጤት አልተገኘም.';

  @override
  String autocompleteResults(int count) {
    return '$count ውጤቶች ይገኛሉ';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'ጥቆማ: $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'ትር $tabIndex ከ$tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'የሚቀጥለው ወር';

  @override
  String get calendarNextYearSemanticsLabel => 'የሚቀጥለው ዓመት';

  @override
  String get calendarNextYearsSemanticsLabel => 'የሚቀጥሉት ዓመታት';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'ያለፈው ወር';

  @override
  String get calendarPreviousYearSemanticsLabel => 'ያለፈው ዓመት';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'ያለፉት ዓመታት';

  @override
  String get calendarShowDaysSemanticsHint => 'ቀኖችን አሳይ';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'የወር መራጭ አሳይ';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'የወርና የዓመት መራጭ አሳይ';

  @override
  String get calendarShowYearPickerSemanticsHint => 'የዓመት መራጭ አሳይ';

  @override
  String get calendarTodaySemanticsLabel => 'ዛሬ';

  @override
  String get contextMenuSemanticsLabel => 'የአውድ ምናሌ';

  @override
  String get dateFieldHint => 'ቀን ይምረጡ';

  @override
  String get dateFieldInvalidDateError => 'ልክ ያልሆነ ቀን።';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'ዛሬ';

  @override
  String get dialogSemanticsLabel => 'መገናኛ';

  @override
  String get headerBackSemanticsLabel => 'ተመለስ';

  @override
  String get headerCloseSemanticsLabel => 'ዝጋ';

  @override
  String get paginationPreviousSemanticsLabel => 'ቀዳሚ';

  @override
  String get paginationNextSemanticsLabel => 'ቀጣይ';

  @override
  String get popoverSemanticsLabel => 'ፖፖቨር';

  @override
  String get progressSemanticsLabel => 'በመጫን ላይ';

  @override
  String get multiSelectHint => 'ንጥሎች ይምረጡ';

  @override
  String get selectHint => 'አንድ ንጥል ይምረጡ';

  @override
  String get selectSearchHint => 'ፍለጋ';

  @override
  String get selectNoResults => 'ምንም ተዛማጅ ውጤቶች የሉም።';

  @override
  String get selectScrollUpSemanticsLabel => 'ወደ ላይ ሸብልል';

  @override
  String get selectScrollDownSemanticsLabel => 'ወደ ታች ሸብልል';

  @override
  String get sheetSemanticsLabel => 'ሉህ';

  @override
  String get textFieldEmailLabel => 'ኢሜይል';

  @override
  String get textFieldClearButtonSemanticsLabel => 'አጽዳ';

  @override
  String get passwordFieldLabel => 'የይለፍ ቃል';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'ይለፍ ቃል ደብቅ';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'ይለፍ ቃል አሳይ';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ሰዓት ይምረጡ';

  @override
  String get timeFieldInvalidDateError => 'ልክ ያልሆነ ሰዓት።';

  @override
  String get timePickerHourSemanticsLabel => 'ሰዓት';

  @override
  String get timePickerMinuteSemanticsLabel => 'ደቂቃ';
}

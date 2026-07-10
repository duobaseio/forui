// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class FLocalizationsTa extends FLocalizations {
  FLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get barrierLabel => 'ஸ்க்ரிம்';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName ஐ மூடுக';
  }

  @override
  String get autocompleteNoResults => 'பொருத்தங்கள் எதுவும் கிடைக்கவில்லை.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '$tabCount இல் $tabIndex தாவல்';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'அடுத்த மாதம்';

  @override
  String get calendarNextYearSemanticsLabel => 'அடுத்த ஆண்டு';

  @override
  String get calendarNextYearsSemanticsLabel => 'அடுத்த ஆண்டுகள்';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'முந்தைய மாதம்';

  @override
  String get calendarPreviousYearSemanticsLabel => 'முந்தைய ஆண்டு';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'முந்தைய ஆண்டுகள்';

  @override
  String get contextMenuSemanticsLabel => 'சூழல் பட்டி';

  @override
  String get dateFieldHint => 'தேதியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get dateFieldInvalidDateError => 'தவறான தேதி.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'இன்று';

  @override
  String get dialogSemanticsLabel => 'உரையாடல்';

  @override
  String get headerBackSemanticsLabel => 'பின்செல்';

  @override
  String get headerCloseSemanticsLabel => 'மூடு';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'பாப்ஓவர்';

  @override
  String get progressSemanticsLabel => 'ஏற்றுகிறது';

  @override
  String get multiSelectHint => 'உருப்படிகளைத் தேர்ந்தெடுக்கவும்';

  @override
  String get selectHint => 'ஒரு பொருளைத் தேர்ந்தெடுக்கவும்';

  @override
  String get selectSearchHint => 'தேடு';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'மேலே உருட்டு';

  @override
  String get selectScrollDownSemanticsLabel => 'கீழே உருட்டு';

  @override
  String get sheetSemanticsLabel => 'திரை';

  @override
  String get textFieldEmailLabel => 'மின்னஞ்சல்';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'கடவுச்சொல்';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'கடவுச்சொல்லை மறைக்கவும்';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'கடவுச்சொல்லைக் காட்டு';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'நேரத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get timeFieldInvalidDateError => 'தவறான நேரம்.';
}

// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class FLocalizationsFr extends FLocalizations {
  FLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get barrierLabel => 'Fond';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fermer \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Aucune correspondance trouvée.';

  @override
  String autocompleteResults(int count) {
    return '$count résultats disponibles';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Suggestion : $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Onglet $tabIndex sur $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Mois suivant';

  @override
  String get calendarNextYearSemanticsLabel => 'Année suivante';

  @override
  String get calendarNextYearsSemanticsLabel => 'Années suivantes';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mois précédent';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Année précédente';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Années précédentes';

  @override
  String get calendarShowDaysSemanticsHint => 'Afficher les jours';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Afficher le sélecteur de mois';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Afficher le sélecteur de mois et d\'année';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Afficher le sélecteur d\'année';

  @override
  String get calendarTodaySemanticsLabel => 'Aujourd\'hui';

  @override
  String get contextMenuSemanticsLabel => 'Menu contextuel';

  @override
  String get dateFieldHint => 'Sélectionner une date';

  @override
  String get dateFieldInvalidDateError => 'Date non valide.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Aujourd\'hui';

  @override
  String get dialogSemanticsLabel => 'Boîte de dialogue';

  @override
  String get headerBackSemanticsLabel => 'Retour';

  @override
  String get headerCloseSemanticsLabel => 'Fermer';

  @override
  String get paginationPreviousSemanticsLabel => 'Précédent';

  @override
  String get paginationNextSemanticsLabel => 'Suivant';

  @override
  String get popoverSemanticsLabel => 'Fenêtre contextuelle';

  @override
  String get progressSemanticsLabel => 'Chargement';

  @override
  String get multiSelectHint => 'Sélectionner des éléments';

  @override
  String get selectHint => 'Sélectionnez un élément';

  @override
  String get selectSearchHint => 'Rechercher';

  @override
  String get selectNoResults => 'Aucun résultat correspondant.';

  @override
  String get selectScrollUpSemanticsLabel => 'Faire défiler vers le haut';

  @override
  String get selectScrollDownSemanticsLabel => 'Faire défiler vers le bas';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Effacer';

  @override
  String get passwordFieldLabel => 'Mot de passe';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Masquer le mot de passe';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Afficher le mot de passe';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Choisissez une heure';

  @override
  String get timeFieldInvalidDateError => 'Heure invalide.';

  @override
  String get timePickerHourSemanticsLabel => 'Heure';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minute';
}

/// The translations for French, as used in Canada (`fr_CA`).
class FLocalizationsFrCa extends FLocalizationsFr {
  FLocalizationsFrCa(): super('fr_CA');

  @override
  String get barrierLabel => 'Grille';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fermer \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Aucune correspondance trouvée.';

  @override
  String autocompleteResults(int count) {
    return '$count résultats disponibles';
  }

  @override
  String autocompleteSuggestion(String suggestion) {
    return 'Suggestion : $suggestion';
  }

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return 'Onglet $tabIndex sur $tabCount';
  }

  @override
  String get calendarNextMonthSemanticsLabel => 'Mois suivant';

  @override
  String get calendarNextYearSemanticsLabel => 'Année suivante';

  @override
  String get calendarNextYearsSemanticsLabel => 'Années suivantes';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mois précédent';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Année précédente';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Années précédentes';

  @override
  String get calendarShowDaysSemanticsHint => 'Afficher les jours';

  @override
  String get calendarShowMonthPickerSemanticsHint => 'Afficher le sélecteur de mois';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => 'Afficher le sélecteur de mois et d\'année';

  @override
  String get calendarShowYearPickerSemanticsHint => 'Afficher le sélecteur d\'année';

  @override
  String get calendarTodaySemanticsLabel => 'Aujourd\'hui';

  @override
  String get contextMenuSemanticsLabel => 'Menu contextuel';

  @override
  String get dateFieldHint => 'Sélectionner une date';

  @override
  String get dateFieldInvalidDateError => 'Date non valide.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Aujourd\'hui';

  @override
  String get dialogSemanticsLabel => 'Boîte de dialogue';

  @override
  String get headerBackSemanticsLabel => 'Retour';

  @override
  String get headerCloseSemanticsLabel => 'Fermer';

  @override
  String get paginationPreviousSemanticsLabel => 'Précédent';

  @override
  String get paginationNextSemanticsLabel => 'Suivant';

  @override
  String get popoverSemanticsLabel => 'Fenêtre contextuelle';

  @override
  String get progressSemanticsLabel => 'Chargement';

  @override
  String get multiSelectHint => 'Sélectionner des éléments';

  @override
  String get selectHint => 'Sélectionnez un élément';

  @override
  String get selectSearchHint => 'Rechercher';

  @override
  String get selectNoResults => 'Aucun résultat correspondant.';

  @override
  String get selectScrollUpSemanticsLabel => 'Faire défiler vers le haut';

  @override
  String get selectScrollDownSemanticsLabel => 'Faire défiler vers le bas';

  @override
  String get sheetSemanticsLabel => 'Zone de contenu';

  @override
  String get textFieldEmailLabel => 'Courriel';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Effacer';

  @override
  String get passwordFieldLabel => 'Mot de passe';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Masquer le mot de passe';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Afficher le mot de passe';

  @override
  String get timeFieldTimeSeparator => ' h ';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Choisir une heure';

  @override
  String get timeFieldInvalidDateError => 'Heure invalide.';

  @override
  String get timePickerHourSemanticsLabel => 'Heure';

  @override
  String get timePickerMinuteSemanticsLabel => 'Minute';
}

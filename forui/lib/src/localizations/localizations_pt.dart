// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class FLocalizationsPt extends FLocalizations {
  FLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fechar \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nenhuma correspondência encontrada.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Próximo mês';

  @override
  String get calendarNextYearSemanticsLabel => 'Próximo ano';

  @override
  String get calendarNextYearsSemanticsLabel => 'Próximos anos';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mês anterior';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Ano anterior';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Anos anteriores';

  @override
  String get contextMenuSemanticsLabel => 'Menu de contexto';

  @override
  String get dateFieldHint => 'Selecionar data';

  @override
  String get dateFieldInvalidDateError => 'Data inválida.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Hoje';

  @override
  String get dialogSemanticsLabel => 'Caixa de diálogo';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Janela sobreposta';

  @override
  String get progressSemanticsLabel => 'Carregando';

  @override
  String get multiSelectHint => 'Selecionar itens';

  @override
  String get selectHint => 'Selecione um item';

  @override
  String get selectSearchHint => 'Pesquisar';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rolar para cima';

  @override
  String get selectScrollDownSemanticsLabel => 'Rolar para baixo';

  @override
  String get sheetSemanticsLabel => 'inferior';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Senha';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ocultar senha';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Mostrar senha';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Escolha um horário';

  @override
  String get timeFieldInvalidDateError => 'Horário inválido.';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class FLocalizationsPtPt extends FLocalizationsPt {
  FLocalizationsPtPt(): super('pt_PT');

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fechar \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nenhuma correspondência encontrada.';

  @override
  String get calendarNextMonthSemanticsLabel => 'Mês seguinte';

  @override
  String get calendarNextYearSemanticsLabel => 'Próximo ano';

  @override
  String get calendarNextYearsSemanticsLabel => 'Próximos anos';

  @override
  String get calendarPreviousMonthSemanticsLabel => 'Mês anterior';

  @override
  String get calendarPreviousYearSemanticsLabel => 'Ano anterior';

  @override
  String get calendarPreviousYearsSemanticsLabel => 'Anos anteriores';

  @override
  String get contextMenuSemanticsLabel => 'Menu de contexto';

  @override
  String get dateFieldHint => 'Selecionar data';

  @override
  String get dateFieldInvalidDateError => 'Data inválida.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => 'Hoje';

  @override
  String get dialogSemanticsLabel => 'Caixa de diálogo';

  @override
  String get popoverSemanticsLabel => 'Janela sobreposta';

  @override
  String get progressSemanticsLabel => 'A carregar';

  @override
  String get multiSelectHint => 'Selecionar itens';

  @override
  String get selectHint => 'Selecione um item';

  @override
  String get selectSearchHint => 'Pesquisar';

  @override
  String get selectScrollUpSemanticsLabel => 'Deslocar para cima';

  @override
  String get selectScrollDownSemanticsLabel => 'Deslocar para baixo';

  @override
  String get sheetSemanticsLabel => 'Secção';

  @override
  String get textFieldEmailLabel => 'E-mail';

  @override
  String get passwordFieldLabel => 'Palavra-passe';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ocultar palavra-passe';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Mostrar palavra-passe';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Selecione uma hora';

  @override
  String get timeFieldInvalidDateError => 'Hora inválida.';
}

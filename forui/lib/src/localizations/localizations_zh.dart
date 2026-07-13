// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class FLocalizationsZh extends FLocalizations {
  FLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get barrierLabel => '纱罩';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '关闭 \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => '未找到匹配项.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '第 $tabIndex 个标签，共 $tabCount 个';
  }

  @override
  String get calendarNextMonthSemanticsLabel => '下个月';

  @override
  String get calendarNextYearSemanticsLabel => '下一年';

  @override
  String get calendarNextYearsSemanticsLabel => '后几年';

  @override
  String get calendarPreviousMonthSemanticsLabel => '上个月';

  @override
  String get calendarPreviousYearSemanticsLabel => '上一年';

  @override
  String get calendarPreviousYearsSemanticsLabel => '前几年';

  @override
  String get calendarShowDaysSemanticsHint => '显示日期';

  @override
  String get calendarShowMonthPickerSemanticsHint => '显示月份选择器';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => '显示月份和年份选择器';

  @override
  String get calendarShowYearPickerSemanticsHint => '显示年份选择器';

  @override
  String get calendarTodaySemanticsLabel => '今天';

  @override
  String get contextMenuSemanticsLabel => '上下文菜单';

  @override
  String get dateFieldHint => '选择日期';

  @override
  String get dateFieldInvalidDateError => '日期无效。';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => '今天';

  @override
  String get dialogSemanticsLabel => '对话框';

  @override
  String get headerBackSemanticsLabel => '返回';

  @override
  String get headerCloseSemanticsLabel => '关闭';

  @override
  String get paginationPreviousSemanticsLabel => '上一个';

  @override
  String get paginationNextSemanticsLabel => '下一个';

  @override
  String get popoverSemanticsLabel => '弹出框';

  @override
  String get progressSemanticsLabel => '加载中';

  @override
  String get multiSelectHint => '选择项目';

  @override
  String get selectHint => '选择项目';

  @override
  String get selectSearchHint => '搜索';

  @override
  String get selectNoResults => '没有匹配结果。';

  @override
  String get selectScrollUpSemanticsLabel => '向上滚动';

  @override
  String get selectScrollDownSemanticsLabel => '向下滚动';

  @override
  String get sheetSemanticsLabel => '动作条';

  @override
  String get textFieldEmailLabel => '电子邮件';

  @override
  String get textFieldClearButtonSemanticsLabel => '清除';

  @override
  String get passwordFieldLabel => '密码';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => '隐藏密码';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => '显示密码';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '选择时间';

  @override
  String get timeFieldInvalidDateError => '无效的时间。';

  @override
  String get timePickerHourSemanticsLabel => '小时';

  @override
  String get timePickerMinuteSemanticsLabel => '分钟';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class FLocalizationsZhHk extends FLocalizationsZh {
  FLocalizationsZhHk(): super('zh_HK');

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '關閉 \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => '未找到匹配項.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '第 $tabIndex 個標籤，共 $tabCount 個';
  }

  @override
  String get calendarNextMonthSemanticsLabel => '下個月';

  @override
  String get calendarNextYearSemanticsLabel => '下一年';

  @override
  String get calendarNextYearsSemanticsLabel => '後幾年';

  @override
  String get calendarPreviousMonthSemanticsLabel => '上個月';

  @override
  String get calendarPreviousYearSemanticsLabel => '上一年';

  @override
  String get calendarPreviousYearsSemanticsLabel => '前幾年';

  @override
  String get calendarShowDaysSemanticsHint => '顯示日期';

  @override
  String get calendarShowMonthPickerSemanticsHint => '顯示月份選擇器';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => '顯示月份和年份選擇器';

  @override
  String get calendarShowYearPickerSemanticsHint => '顯示年份選擇器';

  @override
  String get calendarTodaySemanticsLabel => '今天';

  @override
  String get contextMenuSemanticsLabel => '快捷選單';

  @override
  String get dateFieldHint => '選擇日期';

  @override
  String get dateFieldInvalidDateError => '日期無效。';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => '今天';

  @override
  String get dialogSemanticsLabel => '對話方塊';

  @override
  String get headerBackSemanticsLabel => '返回';

  @override
  String get headerCloseSemanticsLabel => '關閉';

  @override
  String get paginationPreviousSemanticsLabel => '上一個';

  @override
  String get paginationNextSemanticsLabel => '下一個';

  @override
  String get popoverSemanticsLabel => '彈出視窗';

  @override
  String get progressSemanticsLabel => '載入中';

  @override
  String get multiSelectHint => '選擇項目';

  @override
  String get selectHint => '選擇項目';

  @override
  String get selectSearchHint => '搜尋';

  @override
  String get selectNoResults => '沒有匹配結果。';

  @override
  String get selectScrollUpSemanticsLabel => '向上捲動';

  @override
  String get selectScrollDownSemanticsLabel => '向下捲動';

  @override
  String get sheetSemanticsLabel => '面板';

  @override
  String get textFieldEmailLabel => '電郵';

  @override
  String get textFieldClearButtonSemanticsLabel => '清除';

  @override
  String get passwordFieldLabel => '密碼';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => '隱藏密碼';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => '顯示密碼';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '選擇時間';

  @override
  String get timeFieldInvalidDateError => '無效的時間。';

  @override
  String get timePickerHourSemanticsLabel => '小時';

  @override
  String get timePickerMinuteSemanticsLabel => '分鐘';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class FLocalizationsZhTw extends FLocalizationsZh {
  FLocalizationsZhTw(): super('zh_TW');

  @override
  String get barrierLabel => '紗罩';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '關閉「\$modalRouteContentName」';
  }

  @override
  String get autocompleteNoResults => '未找到匹配項.';

  @override
  String bottomNavigationBarTabSemanticsLabel(int tabIndex, int tabCount) {
    return '第 $tabIndex 個標籤頁，共 $tabCount 個';
  }

  @override
  String get calendarNextMonthSemanticsLabel => '下個月';

  @override
  String get calendarNextYearSemanticsLabel => '下一年';

  @override
  String get calendarNextYearsSemanticsLabel => '後幾年';

  @override
  String get calendarPreviousMonthSemanticsLabel => '上個月';

  @override
  String get calendarPreviousYearSemanticsLabel => '上一年';

  @override
  String get calendarPreviousYearsSemanticsLabel => '前幾年';

  @override
  String get calendarShowDaysSemanticsHint => '顯示日期';

  @override
  String get calendarShowMonthPickerSemanticsHint => '顯示月份選擇器';

  @override
  String get calendarShowMonthYearPickerSemanticsHint => '顯示月份和年份選擇器';

  @override
  String get calendarShowYearPickerSemanticsHint => '顯示年份選擇器';

  @override
  String get calendarTodaySemanticsLabel => '今天';

  @override
  String get contextMenuSemanticsLabel => '快捷選單';

  @override
  String get dateFieldHint => '選擇日期';

  @override
  String get dateFieldInvalidDateError => '日期無效。';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateTimePickerToday => '今天';

  @override
  String get dialogSemanticsLabel => '對話方塊';

  @override
  String get headerBackSemanticsLabel => '返回';

  @override
  String get headerCloseSemanticsLabel => '關閉';

  @override
  String get paginationPreviousSemanticsLabel => '上一個';

  @override
  String get paginationNextSemanticsLabel => '下一個';

  @override
  String get popoverSemanticsLabel => '彈出視窗';

  @override
  String get progressSemanticsLabel => '載入中';

  @override
  String get multiSelectHint => '選擇項目';

  @override
  String get selectHint => '選擇項目';

  @override
  String get selectSearchHint => '搜尋';

  @override
  String get selectNoResults => '沒有匹配結果。';

  @override
  String get selectScrollUpSemanticsLabel => '向上捲動';

  @override
  String get selectScrollDownSemanticsLabel => '向下捲動';

  @override
  String get sheetSemanticsLabel => '功能表';

  @override
  String get textFieldEmailLabel => '電子郵件';

  @override
  String get textFieldClearButtonSemanticsLabel => '清除';

  @override
  String get passwordFieldLabel => '密碼';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => '隱藏密碼';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => '顯示密碼';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '選擇時間';

  @override
  String get timeFieldInvalidDateError => '無效的時間。';

  @override
  String get timePickerHourSemanticsLabel => '小時';

  @override
  String get timePickerMinuteSemanticsLabel => '分鐘';
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' show DateFormat;
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'header.design.dart';

@internal
class DualHeader extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final FLocalizations localizations;
  final DateTime date;
  final bool month;
  final bool year;
  final VoidCallback? onMonth;
  final VoidCallback? onYear;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const DualHeader({
    required this.style,
    required this.localizations,
    required this.date,
    required this.month,
    required this.year,
    required this.onMonth,
    required this.onYear,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = localizations.localeName;
    final yearTappable = _Tappable(
      style: style,
      label: DateFormat.y(locale).format(date),
      shown: year,
      onPress: onYear,
    );
    final monthTappable = _Tappable(
      style: style,
      label: DateFormat.MMM(locale).format(date),
      shown: month,
      onPress: onMonth,
    );

    return Row(
      children: [
        if (DateFormat.yMMM(locale).pattern case final pattern? when pattern.indexOf('y') < pattern.indexOf('M')) ...[
          yearTappable,
          monthTappable,
        ] else ...[
          monthTappable,
          yearTappable,
        ],
        const Spacer(),
        FButton.icon(
          style: style.buttonStyle,
          onPress: onPrevious,
          semanticsLabel: localizations.calendarPreviousMonthSemanticsLabel,
          child: style.previousIcon(context),
        ),
        FButton.icon(
          style: style.buttonStyle,
          onPress: onNext,
          semanticsLabel: localizations.calendarNextMonthSemanticsLabel,
          child: style.nextIcon(context),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('month', value: month, ifTrue: 'month picker shown'))
      ..add(FlagProperty('year', value: year, ifTrue: 'year picker shown'))
      ..add(ObjectFlagProperty.has('onMonth', onMonth))
      ..add(ObjectFlagProperty.has('onYear', onYear))
      ..add(ObjectFlagProperty.has('onNext', onNext))
      ..add(ObjectFlagProperty.has('onPrevious', onPrevious));
  }
}

@internal
class Header extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final FLocalizations localizations;
  final DateTime date;
  final bool monthYear;
  final VoidCallback? onMonthYear;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const Header({
    required this.style,
    required this.localizations,
    required this.date,
    required this.monthYear,
    required this.onMonthYear,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = localizations.localeName;

    return Row(
      children: [
        _Tappable(style: style, label: DateFormat.yMMMM(locale).format(date), shown: monthYear, onPress: onMonthYear),
        const Spacer(),
        FButton.icon(
          style: style.buttonStyle,
          onPress: onPrevious,
          semanticsLabel: localizations.calendarPreviousMonthSemanticsLabel,
          child: style.previousIcon(context),
        ),
        FButton.icon(
          style: style.buttonStyle,
          onPress: onNext,
          semanticsLabel: localizations.calendarNextMonthSemanticsLabel,
          child: style.nextIcon(context),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('monthYear', value: monthYear, ifTrue: 'month year picker shown'))
      ..add(ObjectFlagProperty.has('onMonthYear', onMonthYear))
      ..add(ObjectFlagProperty.has('onNext', onNext))
      ..add(ObjectFlagProperty.has('onPrevious', onPrevious));
  }
}

class _Tappable extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final String label;
  final bool shown;
  final VoidCallback? onPress;

  const _Tappable({required this.style, required this.label, required this.shown, required this.onPress});

  @override
  Widget build(BuildContext context) => FTappable.static(
    focusedOutlineStyle: style.headerFocusedOutlineStyle,
    onPress: onPress,
    builder: (_, variants, child) => Container(
      decoration: style.headerDecoration.resolve(variants),
      padding: const .directional(start: 6, end: 2, top: 4, bottom: 4),
      child: child,
    ),
    child: Row(
      mainAxisSize: .min,
      spacing: 2,
      children: [
        Text(label, style: style.headerTextStyle),
        AnimatedRotation(
          // toggleIcon (chevronRight) mirrors under matchTextDirection, so it points left in RTL; rotating the
          // opposite way still lands it facing down.
          turns: shown ? (Directionality.of(context) == .ltr ? 0.25 : -0.25) : 0.0,
          duration: style.animationDuration,
          child: IconTheme(data: style.toggleIconStyle, child: style.toggleIcon(context)),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('label', label))
      ..add(FlagProperty('expands', value: shown, ifTrue: 'expanded'))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

/// A calendar header's style.
class FCalendarHeaderStyle with Diagnosticable, _$FCalendarHeaderStyleFunctions {
  /// The month and year tap targets' decoration. Defaults to a [FColors.secondary] background when hovered or pressed.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, Decoration, DecorationDelta> headerDecoration;

  /// The month and year labels' text style.
  @override
  final TextStyle headerTextStyle;

  /// The month and year toggle icons' style. Defaults to [FColors.mutedForeground].
  @override
  final IconThemeData toggleIconStyle;

  /// The focused outline style for the header tappable.
  @override
  final FFocusedOutlineStyle headerFocusedOutlineStyle;

  /// The navigation buttons' style.
  @override
  final FButtonStyle buttonStyle;

  /// The toggle icon builder. Defaults to [FIcons.chevronRight].
  @override
  final FIconBuilder toggleIcon;

  /// The previous-month icon builder. Defaults to [FIcons.chevronLeft].
  @override
  final FIconBuilder previousIcon;

  /// The next-month icon builder. Defaults to [FIcons.chevronRight].
  @override
  final FIconBuilder nextIcon;

  /// The arrow turn animation's duration. Defaults to 200ms.
  @override
  final Duration animationDuration;

  /// Creates a [FCalendarHeaderStyle].
  const FCalendarHeaderStyle({
    required this.headerDecoration,
    required this.headerTextStyle,
    required this.toggleIconStyle,
    required this.headerFocusedOutlineStyle,
    required this.buttonStyle,
    required this.toggleIcon,
    required this.previousIcon,
    required this.nextIcon,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FCalendarHeaderStyle] that inherits its properties.
  factory FCalendarHeaderStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FIcons icons,
    required FStyle style,
    required bool touch,
  }) {
    final buttons = FButtonStyles.inherit(colors: colors, typography: typography, style: style, touch: touch);
    final headerTextStyle = (touch ? typography.md : typography.sm).copyWith(
      color: colors.foreground,
      fontWeight: .w500,
    );
    return FCalendarHeaderStyle(
      headerDecoration: FVariants.from(
        ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md)),
        variants: {
          [.hovered, .pressed]: .shapeDelta(color: colors.secondary),
        },
      ),
      headerTextStyle: headerTextStyle,
      toggleIconStyle: IconThemeData(color: colors.mutedForeground, size: headerTextStyle.fontSize),
      headerFocusedOutlineStyle: style.focusedOutlineStyle,
      buttonStyle: touch ? buttons.ghost.md : buttons.ghost.xs,
      toggleIcon: icons.chevronRight,
      previousIcon: icons.chevronLeft,
      nextIcon: icons.chevronRight,
    );
  }
}

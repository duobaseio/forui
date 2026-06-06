import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' show DateFormat;
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'header.design.dart';

@internal
class Header extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final String label;
  final String previousSemanticsLabel;
  final String nextSemanticsLabel;
  final bool shown;
  final bool navigation;
  final VoidCallback? onPress;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const Header({
    required this.style,
    required this.label,
    required this.previousSemanticsLabel,
    required this.nextSemanticsLabel,
    required this.shown,
    required this.onPress,
    required this.onNext,
    required this.onPrevious,
    super.key,
  }) : navigation = true;

  const Header.single({
    required this.style,
    required this.label,
    required this.shown,
    required this.onPress,
    super.key,
  }) : navigation = false,
       previousSemanticsLabel = '',
       nextSemanticsLabel = '',
       onNext = null,
       onPrevious = null;

  factory Header.day({
    required FCalendarHeaderStyle style,
    required FLocalizations localizations,
    required DateTime monthYear,
    required bool shown,
    required VoidCallback? onPress,
    required VoidCallback? onNext,
    required VoidCallback? onPrevious,
    Key? key,
  }) => Header(
    style: style,
    label: DateFormat.yMMMM(localizations.localeName).format(monthYear),
    previousSemanticsLabel: localizations.calendarPreviousMonthSemanticsLabel,
    nextSemanticsLabel: localizations.calendarNextMonthSemanticsLabel,
    shown: shown,
    onPress: onPress,
    onNext: onNext,
    onPrevious: onPrevious,
    key: key,
  );

  factory Header.singleDay({
    required FCalendarHeaderStyle style,
    required FLocalizations localizations,
    required DateTime monthYear,
    required bool shown,
    required VoidCallback? onPress,
    Key? key,
  }) => Header.single(
    style: style,
    label: DateFormat.yMMMM(localizations.localeName).format(monthYear),
    shown: shown,
    onPress: onPress,
    key: key,
  );

  factory Header.month({
    required FCalendarHeaderStyle style,
    required FLocalizations localizations,
    required DateTime year,
    required bool shown,
    required VoidCallback? onPress,
    required VoidCallback? onNext,
    required VoidCallback? onPrevious,
    Key? key,
  }) => Header(
    style: style,
    label: DateFormat.y(localizations.localeName).format(year),
    previousSemanticsLabel: localizations.calendarPreviousYearSemanticsLabel,
    nextSemanticsLabel: localizations.calendarNextYearSemanticsLabel,
    shown: shown,
    onPress: onPress,
    onNext: onNext,
    onPrevious: onPrevious,
    key: key,
  );

  factory Header.singleMonth({
    required FCalendarHeaderStyle style,
    required FLocalizations localizations,
    required DateTime year,
    required bool shown,
    required VoidCallback? onPress,
    Key? key,
  }) => Header.single(
    style: style,
    label: DateFormat.y(localizations.localeName).format(year),
    shown: shown,
    onPress: onPress,
    key: key,
  );

  factory Header.year({
    required FCalendarHeaderStyle style,
    required FLocalizations localizations,
    required DateTime decade,
    required bool shown,
    required VoidCallback? onPress,
    required VoidCallback? onNext,
    required VoidCallback? onPrevious,
    Key? key,
  }) {
    final locale = localizations.localeName;
    return Header(
      style: style,
      label: '${DateFormat.y(locale).format(decade)} — ${DateFormat.y(locale).format(.utc(decade.year + 9))}',
      previousSemanticsLabel: localizations.calendarPreviousYearsSemanticsLabel,
      nextSemanticsLabel: localizations.calendarNextYearsSemanticsLabel,
      shown: shown,
      onPress: onPress,
      onNext: onNext,
      onPrevious: onPrevious,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) => Row(
    children: [
      _Tappable(style: style, label: label, shown: shown, onPress: onPress),
      if (navigation) ...[
        const Spacer(),
        FButton.icon(
          style: style.buttonStyle,
          onPress: onPrevious,
          semanticsLabel: previousSemanticsLabel,
          child: style.previousIcon(context),
        ),
        FButton.icon(
          style: style.buttonStyle,
          onPress: onNext,
          semanticsLabel: nextSemanticsLabel,
          child: style.nextIcon(context),
        ),
      ],
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('label', label))
      ..add(StringProperty('previousSemanticsLabel', previousSemanticsLabel))
      ..add(StringProperty('nextSemanticsLabel', nextSemanticsLabel))
      ..add(FlagProperty('monthYear', value: shown, ifTrue: 'month year picker shown'))
      ..add(FlagProperty('navigation', value: navigation, ifTrue: 'navigable'))
      ..add(ObjectFlagProperty.has('onMonthYear', onPress))
      ..add(ObjectFlagProperty.has('onNext', onNext))
      ..add(ObjectFlagProperty.has('onPrevious', onPrevious));
  }
}

@internal
class SplitHeader extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final FLocalizations localizations;
  final DateTime date;
  final String previousSemanticsLabel;
  final String nextSemanticsLabel;
  final bool month;
  final bool year;
  final bool navigation;
  final VoidCallback? onMonth;
  final VoidCallback? onYear;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const SplitHeader({
    required this.style,
    required this.localizations,
    required this.date,
    required this.previousSemanticsLabel,
    required this.nextSemanticsLabel,
    required this.month,
    required this.year,
    required this.onMonth,
    required this.onYear,
    required this.onNext,
    required this.onPrevious,
    super.key,
  }) : navigation = true;

  const SplitHeader.single({
    required this.style,
    required this.localizations,
    required this.date,
    required this.month,
    required this.year,
    required this.onMonth,
    required this.onYear,
    super.key,
  }) : navigation = false,
       previousSemanticsLabel = '',
       nextSemanticsLabel = '',
       onNext = null,
       onPrevious = null;

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
      label: DateFormat.MMMM(locale).format(date),
      shown: month,
      onPress: onMonth,
    );

    return Row(
      children: [
        if (DateFormat.yMMMM(locale).pattern case final pattern? when pattern.indexOf('y') < pattern.indexOf('M')) ...[
          yearTappable,
          monthTappable,
        ] else ...[
          monthTappable,
          yearTappable,
        ],
        if (navigation) ...[
          const Spacer(),
          FButton.icon(
            style: style.buttonStyle,
            onPress: onPrevious,
            semanticsLabel: previousSemanticsLabel,
            child: style.previousIcon(context),
          ),
          FButton.icon(
            style: style.buttonStyle,
            onPress: onNext,
            semanticsLabel: nextSemanticsLabel,
            child: style.nextIcon(context),
          ),
        ],
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
      ..add(StringProperty('previousSemanticsLabel', previousSemanticsLabel))
      ..add(StringProperty('nextSemanticsLabel', nextSemanticsLabel))
      ..add(FlagProperty('month', value: month, ifTrue: 'month picker shown'))
      ..add(FlagProperty('year', value: year, ifTrue: 'year picker shown'))
      ..add(FlagProperty('navigation', value: navigation, ifTrue: 'navigable'))
      ..add(ObjectFlagProperty.has('onMonth', onMonth))
      ..add(ObjectFlagProperty.has('onYear', onYear))
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
    builder: (context, variants, _) => Container(
      decoration: style.headerDecoration.resolve(variants),
      padding: const .directional(start: 6, end: 2, top: 4, bottom: 4),
      child: Row(
        mainAxisSize: .min,
        spacing: 2,
        children: [
          Text(label, style: style.headerTextStyle.resolve(variants)),
          AnimatedRotation(
            // toggleIcon (chevronRight) mirrors under matchTextDirection, so it points left in RTL; rotating the
            // opposite way still lands it facing down.
            turns: shown ? (Directionality.of(context) == .ltr ? 0.25 : -0.25) : 0.0,
            duration: style.animationDuration,
            child: IconTheme(data: style.toggleIconStyle.resolve(variants), child: style.toggleIcon(context)),
          ),
        ],
      ),
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
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> headerTextStyle;

  /// The month and year toggle icons' style. Defaults to [FColors.mutedForeground].
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> toggleIconStyle;

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
    this.animationDuration = const Duration(milliseconds: 100),
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
      headerDecoration: .from(
        ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md)),
        variants: {
          [.hovered, .pressed]: .shapeDelta(color: colors.secondary),
        },
      ),
      headerTextStyle: .all(headerTextStyle),
      toggleIconStyle: .all(IconThemeData(color: colors.mutedForeground, size: headerTextStyle.fontSize)),
      headerFocusedOutlineStyle: style.focusedOutlineStyle,
      buttonStyle: touch ? buttons.ghost.md : buttons.ghost.xs,
      toggleIcon: icons.chevronRight,
      previousIcon: icons.chevronLeft,
      nextIcon: icons.chevronRight,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FCalendarDay', {
  'single': (4, 'The day is selected but is not part of a contiguous selection.'),
  'start': (4, 'The day is the start of a contiguous selection.'),
  'middle': (4, 'The day is inside a contiguous selection, between a start and end.'),
  'end': (4, 'The day is the end of a contiguous selection.'),
  //
  'adjacent': (3, 'The semantic variant when the day is not in the current month.'),
  'today': (3, 'The semantic variant when the day is the current day.'),
  //
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'primaryFocused': (1, 'The interaction variant when a given widget (and not its descendants) has focus.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'day.design.dart';

/// A calendar day builder.
typedef FCalendarDayBuilder =
    Widget Function(BuildContext, FCalendarDayStyles, FLocalizations, DateTime, Set<FCalendarDayVariant>);

@internal
class Day extends StatelessWidget {
  final FCalendarDayStyles styles;
  final FLocalizations localizations;
  final DateTime date;
  final bool selected; // Optimization to avoid having to perform 4 checks.
  final Set<FCalendarDayVariant> variants;
  final FocusNode focusNode;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
  final FCalendarDayBuilder builder;

  const Day({
    required this.styles,
    required this.localizations,
    required this.date,
    required this.selected,
    required this.variants,
    required this.focusNode,
    required this.onPress,
    required this.onLongPress,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final semanticsLabel = DateFormat.yMMMMEEEEd(localizations.localeName).format(date);
    return FTappable.static(
      focusNode: focusNode,
      selected: selected,
      semanticsLabel: variants.contains(FCalendarDayVariant.today)
          ? '$semanticsLabel, ${localizations.calendarTodaySemanticsLabel}'
          : semanticsLabel,
      excludeSemantics: true,
      onPress: onPress,
      onLongPress: onLongPress,
      builder: (context, variants, _) =>
          builder(context, styles, localizations, date, {...variants.cast<FCalendarDayVariant>(), ...this.variants}),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('styles', styles))
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('date', date))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(IterableProperty('variants', variants))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// A calendar's day style.
class FCalendarDayStyle with Diagnosticable, _$FCalendarDayStyleFunctions {
  /// The day's text style.
  @override
  final TextStyle textStyle;

  /// The decoration painted in front of [background].
  @override
  final Decoration foreground;

  /// The decoration painted behind [foreground].
  @override
  final Decoration background;

  /// Creates a [FCalendarDayStyle].
  FCalendarDayStyle({required this.textStyle, required this.foreground, this.background = const BoxDecoration()});
}

/// [FCalendarDayStyle]'s variants.
extension type FCalendarDayStyles(
  FVariants<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta> _
) implements FVariants<FCalendarDayVariantConstraint, FCalendarDayVariant, FCalendarDayStyle, FCalendarDayStyleDelta> {
  /// Creates a [FCalendarDayStyles] that inherits its properties.
  factory FCalendarDayStyles.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final base = FCalendarDayStyle(
      textStyle: typography.body.sm.copyWith(color: colors.foreground),
      foreground: ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md)),
    );

    final focused = BorderSide(color: colors.primary, width: style.borderWidth);
    final selectedFocused = BorderSide(color: colors.border, width: style.borderWidth);

    final start = RoundedSuperellipseBorder(borderRadius: .horizontal(start: style.borderRadius.md.topLeft));
    final end = RoundedSuperellipseBorder(borderRadius: .horizontal(end: style.borderRadius.md.topLeft));

    return FCalendarDayStyles(
      FVariants.from(
        base,
        variants: {
          [.focused]: .delta(
            foreground: .shapeDelta(
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.focused.and(.hovered), .focused.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .shapeDelta(
              color: colors.secondary,
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.hovered, .pressed]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .shapeDelta(color: colors.secondary),
          ),
          //
          [.disabled]: .delta(textStyle: .delta(color: colors.disable(colors.mutedForeground))),
          //
          [.today]: .delta(textStyle: .delta(decoration: () => .underline)),
          [.today.and(.hovered), .today.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.secondary),
          ),
          [.today.and(.focused)]: .delta(
            textStyle: .delta(decoration: () => .underline),
            foreground: .shapeDelta(
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.today.and(.focused).and(.hovered), .today.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.secondary,
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.today.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.mutedForeground), decoration: () => .underline),
          ),
          //
          [.adjacent]: .delta(textStyle: .delta(color: colors.mutedForeground)),
          [.adjacent.and(.hovered), .adjacent.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .shapeDelta(color: colors.secondary),
          ),
          [.adjacent.and(.focused)]: .delta(
            textStyle: .delta(color: colors.mutedForeground),
            foreground: .shapeDelta(
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.adjacent.and(.focused).and(.hovered), .adjacent.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .shapeDelta(
              color: colors.secondary,
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.adjacent.and(.disabled)]: .delta(textStyle: .delta(color: colors.disable(colors.mutedForeground))),
          [.adjacent.and(.today)]: .delta(
            textStyle: .delta(color: colors.mutedForeground, decoration: () => .underline),
          ),
          [.adjacent.and(.today).and(.hovered), .adjacent.and(.today).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.secondary),
          ),
          [.adjacent.and(.today).and(.focused)]: .delta(
            textStyle: .delta(color: colors.mutedForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [
            .adjacent.and(.today).and(.focused).and(.hovered),
            .adjacent.and(.today).and(.focused).and(.pressed),
          ]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.secondary,
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.adjacent.and(.today).and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.mutedForeground), decoration: () => .underline),
          ),
          //
          [.single]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(color: colors.primary),
          ),
          [.single.and(.hovered), .single.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(color: colors.hover(colors.primary)),
          ),
          [.single.and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.single.and(.focused).and(.hovered), .single.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.single.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground)),
            foreground: .shapeDelta(color: colors.primary),
          ),
          [.single.and(.today)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.primary),
          ),
          [.single.and(.today).and(.hovered), .single.and(.today).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.hover(colors.primary)),
          ),
          [.single.and(.today).and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.single.and(.today).and(.focused).and(.hovered), .single.and(.today).and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.single.and(.today).and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground), decoration: () => .underline),
            foreground: .shapeDelta(color: colors.primary),
          ),
          //
          // The start of a contiguous selection: a primary chip over a bar rounded on the leading edge.
          [.start]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.hovered), .start.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(color: colors.hover(colors.primary)),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.focused).and(.hovered), .start.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground)),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.today)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.today).and(.hovered), .start.and(.today).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.hover(colors.primary)),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.today).and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.today).and(.focused).and(.hovered), .start.and(.today).and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          [.start.and(.today).and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground), decoration: () => .underline),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: start),
          ),
          //
          // The end of a contiguous selection: same as start, but the bar rounds on the trailing edge.
          [.end]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.hovered), .end.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(color: colors.hover(colors.primary)),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.focused).and(.hovered), .end.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            foreground: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground)),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.today)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.today).and(.hovered), .end.and(.today).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(color: colors.hover(colors.primary)),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.today).and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.today).and(.focused).and(.hovered), .end.and(.today).and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            foreground: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          [.end.and(.today).and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground), decoration: () => .underline),
            foreground: .shapeDelta(color: colors.primary),
            background: .shapeDelta(color: colors.secondary, shape: end),
          ),
          //
          [.middle]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .boxDelta(color: colors.secondary, borderRadius: .zero),
          ),
          [.middle.and(.hovered), .middle.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .boxDelta(color: colors.hover(colors.secondary), borderRadius: .zero),
          ),
          [.middle.and(.focused)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .boxDelta(color: colors.secondary, borderRadius: .zero, border: Border.fromBorderSide(focused)),
          ),
          [.middle.and(.focused).and(.hovered), .middle.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            foreground: .boxDelta(
              color: colors.hover(colors.secondary),
              borderRadius: .zero,
              border: Border.fromBorderSide(focused),
            ),
          ),
          [.middle.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.secondaryForeground)),
            foreground: .boxDelta(color: colors.secondary, borderRadius: .zero),
          ),
          [.middle.and(.today)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .boxDelta(color: colors.secondary, borderRadius: .zero),
          ),
          [.middle.and(.today).and(.hovered), .middle.and(.today).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .boxDelta(color: colors.hover(colors.secondary), borderRadius: .zero),
          ),
          [.middle.and(.today).and(.focused)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .boxDelta(color: colors.secondary, borderRadius: .zero, border: Border.fromBorderSide(focused)),
          ),
          [.middle.and(.today).and(.focused).and(.hovered), .middle.and(.today).and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            foreground: .boxDelta(
              color: colors.hover(colors.secondary),
              borderRadius: .zero,
              border: Border.fromBorderSide(focused),
            ),
          ),
          [.middle.and(.today).and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.secondaryForeground), decoration: () => .underline),
            foreground: .boxDelta(color: colors.secondary, borderRadius: .zero),
          ),
        },
      ),
    );
  }
}

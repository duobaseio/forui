import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FCalendarYear', {
  'selected': (4, 'The semantic variant when the year is selected.'),
  //
  'today': (3, 'The semantic variant when the year is the current year.'),
  //
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'primaryFocused': (1, 'The interaction variant when a given widget (and not its descendants) has focus.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'year.design.dart';

/// A calendar year builder.
typedef FCalendarYearBuilder =
    Widget Function(BuildContext, FCalendarYearStyles, FLocalizations, DateTime, Set<FCalendarYearVariant>);

@internal
class Year extends StatelessWidget {
  final FCalendarYearStyles styles;
  final FLocalizations localizations;
  final DateTime date;
  final Set<FCalendarYearVariant> variants;
  final FocusNode focusNode;
  final VoidCallback? onPress;
  final FCalendarYearBuilder builder;

  const Year({
    required this.styles,
    required this.localizations,
    required this.date,
    required this.variants,
    required this.focusNode,
    required this.onPress,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FTappable.static(
    focusNode: focusNode,
    semanticsLabel: DateFormat.y(localizations.localeName).format(date),
    excludeSemantics: true,
    onPress: onPress,
    builder: (context, variants, _) =>
        builder(context, styles, localizations, date, {...variants.cast<FCalendarYearVariant>(), ...this.variants}),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('styles', styles))
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('date', date))
      ..add(IterableProperty('variants', variants))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// A calendar's year style.
class FCalendarYearStyle with Diagnosticable, _$FCalendarYearStyleFunctions {
  /// The year's text style.
  @override
  final TextStyle textStyle;

  /// The decoration painted behind the year's text.
  @override
  final Decoration decoration;

  /// Creates a [FCalendarYearStyle].
  FCalendarYearStyle({required this.textStyle, required this.decoration});
}

/// [FCalendarYearStyle]'s variants.
extension type FCalendarYearStyles(
  FVariants<FCalendarYearVariantConstraint, FCalendarYearVariant, FCalendarYearStyle, FCalendarYearStyleDelta> _
) implements
    FVariants<FCalendarYearVariantConstraint, FCalendarYearVariant, FCalendarYearStyle, FCalendarYearStyleDelta> {
  /// Creates a [FCalendarYearStyles] that inherits its properties.
  factory FCalendarYearStyles.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final base = FCalendarYearStyle(
      textStyle: typography.sm.copyWith(color: colors.foreground),
      decoration: ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md)),
    );

    final focused = BorderSide(color: colors.primary, width: style.borderWidth);
    final selectedFocused = BorderSide(color: colors.border, width: style.borderWidth);

    return FCalendarYearStyles(
      FVariants.from(
        base,
        variants: {
          [.focused]: .delta(
            decoration: .shapeDelta(
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.focused.and(.hovered), .focused.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            decoration: .shapeDelta(
              color: colors.secondary,
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.hovered, .pressed]: .delta(
            textStyle: .delta(color: colors.secondaryForeground),
            decoration: .shapeDelta(color: colors.secondary),
          ),
          //
          [.disabled]: .delta(textStyle: .delta(color: colors.disable(colors.mutedForeground))),
          //
          [.today]: .delta(textStyle: .delta(decoration: () => .underline)),
          [.today.and(.hovered), .today.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            decoration: .shapeDelta(color: colors.secondary),
          ),
          [.today.and(.focused)]: .delta(
            textStyle: .delta(decoration: () => .underline),
            decoration: .shapeDelta(
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.today.and(.focused).and(.hovered), .today.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.secondaryForeground, decoration: () => .underline),
            decoration: .shapeDelta(
              color: colors.secondary,
              shape: RoundedSuperellipseBorder(side: focused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.today.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.mutedForeground), decoration: () => .underline),
          ),
          //
          [.selected]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            decoration: .shapeDelta(color: colors.primary),
          ),
          [.selected.and(.hovered), .selected.and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            decoration: .shapeDelta(color: colors.hover(colors.primary)),
          ),
          [.selected.and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            decoration: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.selected.and(.focused).and(.hovered), .selected.and(.focused).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground),
            decoration: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.selected.and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground)),
            decoration: .shapeDelta(color: colors.primary),
          ),
          [.selected.and(.today)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            decoration: .shapeDelta(color: colors.primary),
          ),
          [.selected.and(.today).and(.hovered), .selected.and(.today).and(.pressed)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            decoration: .shapeDelta(color: colors.hover(colors.primary)),
          ),
          [.selected.and(.today).and(.focused)]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            decoration: .shapeDelta(
              color: colors.primary,
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [
            .selected.and(.today).and(.focused).and(.hovered),
            .selected.and(.today).and(.focused).and(.pressed),
          ]: .delta(
            textStyle: .delta(color: colors.primaryForeground, decoration: () => .underline),
            decoration: .shapeDelta(
              color: colors.hover(colors.primary),
              shape: RoundedSuperellipseBorder(side: selectedFocused, borderRadius: style.borderRadius.md),
            ),
          ),
          [.selected.and(.today).and(.disabled)]: .delta(
            textStyle: .delta(color: colors.disable(colors.primaryForeground), decoration: () => .underline),
            decoration: .shapeDelta(color: colors.primary),
          ),
        },
      ),
    );
  }
}

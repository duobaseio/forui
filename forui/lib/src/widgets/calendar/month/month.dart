import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';

@Variants('FCalendarMonth', {
  'today': (3, 'The semantic variant when the month is the current month.'),
  //
  'disabled': (2, 'The semantic variant when this widget is disabled and cannot be interacted with.'),
  'primaryFocused': (1, 'The interaction variant when a given widget (and not its descendants) has focus.'),
  'focused': (1, 'The interaction variant when the given widget or any of its descendants have focus.'),
  'hovered': (1, 'The interaction variant when the user drags their mouse cursor over the given widget.'),
  'pressed': (1, 'The interaction variant when the user is actively pressing down on the given widget.'),
})
part 'month.design.dart';

/// A calendar month builder.
typedef FCalendarMonthBuilder =
    Widget Function(BuildContext, FCalendarMonthStyles, FLocalizations, DateTime, Set<FCalendarMonthVariant>);

@internal
class Month extends StatelessWidget {
  final FCalendarMonthStyles styles;
  final FLocalizations localizations;
  final DateTime date;
  final Set<FCalendarMonthVariant> variants;
  final FocusNode focusNode;
  final VoidCallback? onPress;
  final FCalendarMonthBuilder builder;

  const Month({
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
    semanticsLabel: DateFormat.MMMM(localizations.localeName).format(date),
    excludeSemantics: true,
    onPress: onPress,
    builder: (context, variants, _) =>
        builder(context, styles, localizations, date, {...variants.cast<FCalendarMonthVariant>(), ...this.variants}),
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

/// A calendar's month style.
class FCalendarMonthStyle with Diagnosticable, _$FCalendarMonthStyleFunctions {
  /// The month's text style.
  @override
  final TextStyle textStyle;

  /// The decoration painted behind the month's text.
  @override
  final Decoration decoration;

  /// Creates a [FCalendarMonthStyle].
  FCalendarMonthStyle({required this.textStyle, required this.decoration});
}

/// [FCalendarMonthStyle]'s variants.
extension type FCalendarMonthStyles(
  FVariants<FCalendarMonthVariantConstraint, FCalendarMonthVariant, FCalendarMonthStyle, FCalendarMonthStyleDelta> _
) implements
    FVariants<FCalendarMonthVariantConstraint, FCalendarMonthVariant, FCalendarMonthStyle, FCalendarMonthStyleDelta> {
  /// Creates a [FCalendarMonthStyles] that inherits its properties.
  factory FCalendarMonthStyles.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final base = FCalendarMonthStyle(
      textStyle: typography.body.sm.copyWith(color: colors.foreground),
      decoration: ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md)),
    );

    final focused = BorderSide(color: colors.primary, width: style.borderWidth);

    return FCalendarMonthStyles(
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
        },
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/widgets/line_calendar/calendar_layout.dart';

@Variants('FLineCalendarItem', {
  'disabled': (2, 'The semantic variant when this widget is disabled.'),
  'selected': (2, 'The semantic variant when this item has been selected.'),
  'today': (2, 'The semantic variant when the item represents today.'),
  'primaryFocused': (1, 'The interaction variant when this widget has focus.'),
  'focused': (1, 'The interaction variant when the widget or descendants have focus.'),
  'hovered': (1, 'The interaction variant when hovered.'),
  'pressed': (1, 'The interaction variant when pressed.'),
})
part 'line_calendar.design.dart';

/// A line calendar displays dates in a single horizontal, scrollable line.
///
/// Recommended for touch devices. Prefer [FCalendar] on desktop and larger screens.
///
/// ## Desktop and web note
/// As the dates scroll on the horizontal axis (left to right or right to left), hold Shift while using the mouse
/// scroll wheel to scroll the list.
///
/// See:
/// * https://forui.dev/docs/widgets/data/line-calendar for working examples.
/// * [FLineCalendarStyle] for customizing a line calendar's style.
class FLineCalendar extends StatelessWidget {
  /// The default builder that returns the child as-is.
  static Widget defaultBuilder(BuildContext _, FLineCalendarItemData _, Widget? child) => child!;

  /// Defines how this line calendar's value is controlled.
  final FLineCalendarControl control;

  /// Defines how this line calendar is scrolled.
  final FLineCalendarScrollControl scrollControl;

  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FLineCalendarStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create line-calendar
  /// ```
  final FLineCalendarStyleDelta style;

  /// How the scroll view should respond to user input.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? scrollCacheExtent;

  /// [ScrollViewKeyboardDismissBehavior] the defines how this [FLineCalendar] will dismiss the keyboard automatically.
  ///
  /// Defaults to [ScrollViewKeyboardDismissBehavior.manual].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Returns whether a date is selectable. Defaults to [FCalendarController.defaultSelectable].
  final bool Function(DateTime) selectable;

  /// The builder used to build a line calendar item. Defaults to returning the given child.
  ///
  /// The `child` is the default content with no alterations. Consider wrapping the `child` and other custom decoration
  /// in a [Stack] to avoid re-creating the custom content from scratch.
  final ValueWidgetBuilder<FLineCalendarItemData> builder;

  /// Creates a [FLineCalendar].
  const FLineCalendar({
    this.control = const .managed(),
    this.scrollControl = const .managed(),
    this.style = const .context(),
    this.physics,
    this.scrollCacheExtent,
    this.keyboardDismissBehavior = .manual,
    this.selectable = FCalendarController.defaultSelectable,
    this.builder = defaultBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => CalendarLayout(
      control: control,
      scrollControl: scrollControl,
      style: style(context.theme.lineCalendarStyle),
      physics: physics,
      scrollCacheExtent: scrollCacheExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      scale: MediaQuery.textScalerOf(context),
      textStyle: DefaultTextStyle.of(context).style,
      selectable: selectable,
      builder: builder,
      constraints: constraints,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('scrollControl', scrollControl))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(DiagnosticsProperty('scrollCacheExtent', scrollCacheExtent))
      ..add(DiagnosticsProperty('keyboardDismissBehavior', keyboardDismissBehavior))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// [FLineCalendar]'s style.
class FLineCalendarStyle with Diagnosticable, _$FLineCalendarStyleFunctions {
  /// The horizontal spacing between each calendar item. Defaults to 10.
  @override
  final double itemSpacing;

  /// The vertical height between the content and the edges. Defaults to 13.
  @override
  final double contentEdgeSpacing;

  /// The vertical height between the date and weekday. Defaults to 4.
  @override
  final double contentSpacing;

  /// The decoration.
  @override
  final FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Decoration, DecorationDelta> decoration;

  /// The color of the today indicator.
  @override
  final FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, Color, Delta> todayIndicatorColor;

  /// The text style for the date.
  @override
  final FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>
  dateTextStyle;

  /// The text style for the day of the week.
  @override
  final FVariants<FLineCalendarItemVariantConstraint, FLineCalendarItemVariant, TextStyle, TextStyleDelta>
  weekdayTextStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.decoration,
    required this.todayIndicatorColor,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
    required this.tappableStyle,
    this.itemSpacing = 10,
    this.contentEdgeSpacing = 13,
    this.contentSpacing = 4,
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties.
  factory FLineCalendarStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final focusedShape = RoundedSuperellipseBorder(
      side: BorderSide(color: colors.primary, width: style.borderWidth),
      borderRadius: style.borderRadius.md,
    );

    return .new(
      decoration: FVariants.from(
        ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
          color: colors.card,
        ),
        variants: {
          [.focused]: .shapeDelta(shape: focusedShape),
          [.hovered, .pressed]: .shapeDelta(color: colors.secondary),
          [.hovered.and(.focused), .pressed.and(.focused)]: .shapeDelta(color: colors.secondary, shape: focusedShape),
          //
          [.disabled]: .shapeDelta(color: colors.disable(colors.card)),
          [.disabled.and(.focused)]: .shapeDelta(color: colors.disable(colors.card), shape: focusedShape),
          [.disabled.and(.selected).and(.focused)]: .shapeDelta(
            shape: focusedShape,
            color: colors.disable(colors.primary),
          ),
          //
          [.selected]: .shapeDelta(
            shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
            color: colors.primary,
          ),
          [.selected.and(.focused)]: .shapeDelta(color: colors.primary, shape: focusedShape),
          [.selected.and(.hovered), .selected.and(.pressed)]: .shapeDelta(
            shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
            color: colors.hover(colors.primary),
          ),
          [.selected.and(.hovered).and(.focused), .selected.and(.pressed).and(.focused)]: .shapeDelta(
            shape: focusedShape,
            color: colors.hover(colors.primary),
          ),
          [.selected.and(.disabled)]: .shapeDelta(color: colors.disable(colors.primary)),
          //
          [.today]: .shapeDelta(color: colors.secondary),
          [.today.and(.focused)]: .shapeDelta(color: colors.secondary, shape: focusedShape),
          [.today.and(.hovered), .today.and(.pressed)]: .shapeDelta(color: colors.hover(colors.secondary)),
          [.today.and(.hovered).and(.focused), .today.and(.pressed).and(.focused)]: .shapeDelta(
            color: colors.hover(colors.secondary),
            shape: focusedShape,
          ),
        },
      ),
      todayIndicatorColor: FVariants(
        colors.foreground,
        variants: {
          [.hovered, .pressed]: colors.hover(colors.foreground),
          //
          [.disabled]: colors.disable(colors.foreground),
          //
          [.selected]: colors.primaryForeground,
          [.selected.and(.hovered), .selected.and(.pressed)]: colors.hover(colors.primaryForeground),
          [.selected.and(.disabled)]: colors.disable(colors.primaryForeground),
        },
      ),
      dateTextStyle: FVariants.from(
        typography.body.sm.copyWith(color: colors.foreground, height: 1),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.foreground)),
          //
          [.selected]: .delta(color: colors.primaryForeground),
          [.selected.and(.disabled)]: .delta(color: colors.disable(colors.primaryForeground)),
        },
      ),
      weekdayTextStyle: FVariants.from(
        typography.body.xs3.copyWith(color: colors.mutedForeground, height: 1),
        variants: {
          [.disabled]: .delta(color: colors.disable(colors.mutedForeground)),
          //
          [.selected]: .delta(color: colors.primaryForeground),
          [.selected.and(.disabled)]: .delta(color: colors.disable(colors.primaryForeground)),
        },
      ),
      tappableStyle: style.tappableStyle,
    );
  }
}

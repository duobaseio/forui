import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'pagination_style.design.dart';

/// The [FPagination] styles.
class FPaginationStyle with Diagnosticable, _$FPaginationStyleFunctions {
  /// The padding around each item. Defaults to EdgeInsets.symmetric(horizontal: 2)`.
  @override
  final EdgeInsets itemPadding;

  /// The item's constraints. Defaults to `BoxConstraints(maxWidth: 40, minWidth: 40, maxHeight: 40, minHeight: 40)`.
  @override
  final BoxConstraints itemConstraints;

  /// The icon's style.
  @override
  final FVariants<FTappableVariantConstraint, IconThemeData, IconThemeDataDelta> itemIconStyle;

  /// The decoration applied to the pagination item.
  @override
  final FVariants<FTappableVariantConstraint, BoxDecoration, BoxDecorationDelta> itemDecoration;

  /// The default text style applied to the pagination item.
  @override
  final FVariants<FTappableVariantConstraint, TextStyle, TextStyleDelta> itemTextStyle;

  /// The ellipsis's text style.
  @override
  final TextStyle ellipsisTextStyle;

  /// The action's tappable style.
  @override
  final FTappableStyle actionTappableStyle;

  /// The pagination item's tappable style.
  @override
  final FTappableStyle pageTappableStyle;

  /// The pagination item's focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.itemIconStyle,
    required this.itemDecoration,
    required this.itemTextStyle,
    required this.ellipsisTextStyle,
    required this.actionTappableStyle,
    required this.pageTappableStyle,
    required this.focusedOutlineStyle,
    this.itemPadding = const .symmetric(horizontal: 2),
    this.itemConstraints = const .tightFor(width: 40.0, height: 40.0),
  });

  /// Creates a [FPaginationStyle] that inherits its properties.
  FPaginationStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        itemIconStyle: .raw(IconThemeData(color: colors.primary, size: 18)),
        itemDecoration: .delta(
          BoxDecoration(borderRadius: style.borderRadius, color: colors.background),
          variants: {
            {.selected.and(.hovered), .selected.and(.pressed)}: .merge(color: colors.hover(colors.primary)),
            {.selected}: .merge(color: colors.primary),
            {.hovered}: .merge(color: colors.border),
          },
        ),
        itemTextStyle: .delta(
          typography.sm.copyWith(color: colors.primary),
          variants: {
            {.selected}: .merge(color: colors.primaryForeground),
          },
        ),
        ellipsisTextStyle: typography.sm.copyWith(color: colors.primary),
        actionTappableStyle: style.tappableStyle,
        pageTappableStyle: style.tappableStyle,
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

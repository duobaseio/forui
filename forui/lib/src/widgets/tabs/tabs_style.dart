part of 'tabs.dart';

/// Defines how the bounds of the selected tab indicator are computed.
enum FTabBarIndicatorSize(final TabBarIndicatorSize _value) {
  /// The tab indicator's bounds are as wide as the space occupied by the tab
  /// in the tab bar: from the right edge of the previous tab to the left edge
  /// of the next tab.
  tab(.tab),

  /// The tab's bounds are only as wide as the (centered) tab widget itself.
  ///
  /// This value is used to align the tab's label, typically a [Tab]
  /// widget's text or icon, with the selected tab indicator.
  label(.label),
}

/// [FTabs]'s style.
class FTabsStyle({
  /// The decoration.
  @override required final Decoration decoration,

  /// The label's [TextStyle].
  @override required final FVariants<FTabVariantConstraint, FTabVariant, TextStyle, TextStyleDelta> labelTextStyle,

  /// The indicator.
  @override required final Decoration indicatorDecoration,

  /// The focused outline style.
  @override required final FFocusedOutlineStyle focusedOutlineStyle,

  /// The padding. Defaults to `EdgeInsets.all(4)`.
  @override final EdgeInsetsGeometry padding = const .all(4),

  /// The indicator size. Defaults to [FTabBarIndicatorSize.tab].
  @override final FTabBarIndicatorSize indicatorSize = .tab,

  /// The minimum height of each tab. Tabs grow to fit taller labels.
  ///
  /// Defaults to 36.
  @override final double minHeight = 36,

  /// The spacing between the tab bar and the views. Defaults to 10.
  @override final double spacing = 10,
}) with Diagnosticable, _$FTabsStyleFunctions {
  /// Creates a [FTabsStyle].
  this;

  /// Creates a [FTabsStyle] that inherits its properties.
  new inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(
            side: BorderSide(color: colors.muted, width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
          color: colors.muted,
        ),
        labelTextStyle: FVariants.from(
          typography.body.sm.copyWith(fontWeight: .w500, color: colors.mutedForeground),
          variants: {
            [.selected]: .delta(color: colors.foreground),
          },
        ),
        indicatorDecoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.md),
          color: colors.background,
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

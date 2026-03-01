part of 'tabs.dart';

/// Defines how the bounds of the selected tab indicator are computed.
enum FTabBarIndicatorSize {
  /// The tab indicator's bounds are as wide as the space occupied by the tab
  /// in the tab bar: from the right edge of the previous tab to the left edge
  /// of the next tab.
  tab(.tab),

  /// The tab's bounds are only as wide as the (centered) tab widget itself.
  ///
  /// This value is used to align the tab's label, typically a [Tab]
  /// widget's text or icon, with the selected tab indicator.
  label(.label);

  final TabBarIndicatorSize _value;

  const FTabBarIndicatorSize(this._value);
}

/// [FTabs]'s style.
class FTabsStyle with Diagnosticable, _$FTabsStyleFunctions {
  /// The decoration.
  @override
  final Decoration decoration;

  /// The padding.
  @override
  final EdgeInsetsGeometry padding;

  /// The label's [TextStyle].
  @override
  final FVariants<FTabVariantConstraint, FTabVariant, TextStyle, TextStyleDelta> labelTextStyle;

  /// The indicator.
  @override
  final Decoration indicatorDecoration;

  /// The indicator size.
  @override
  final FTabBarIndicatorSize indicatorSize;

  /// The height.
  @override
  final double height;

  /// The spacing between the tab bar and the views.
  @override
  final double spacing;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FTabsStyle].
  FTabsStyle({
    required this.decoration,
    required this.labelTextStyle,
    required this.indicatorDecoration,
    required this.focusedOutlineStyle,
    this.padding = const .all(4),
    this.indicatorSize = .tab,
    this.height = 36,
    this.spacing = 10,
  });

  /// Creates a [FTabsStyle] that inherits its properties.
  FTabsStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(
            side: BorderSide(color: colors.muted, width: style.borderWidth),
            borderRadius: style.borderRadius.md,
          ),
          color: colors.muted,
        ),
        labelTextStyle: FVariants.from(
          typography.sm.copyWith(
            fontWeight: .w500,
            fontFamily: typography.defaultFontFamily,
            color: colors.mutedForeground,
          ),
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

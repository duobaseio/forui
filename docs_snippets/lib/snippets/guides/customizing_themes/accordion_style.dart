// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
FAccordionStyle accordionStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
  required bool touch,
}) => FAccordionStyle(
  titleTextStyle: FVariants.from(
    // This text style is applied when the accordion is NOT hovered OR pressed.
    typography.sm.copyWith(fontWeight: .w500, color: colors.foreground),
    variants: {
      // This text style is applied when the accordion is hovered OR pressed.
      // {@highlight}
      [.hovered, .pressed]: .delta(decoration: () => .underline),
      // {@endhighlight}
    },
  ),
  childTextStyle: typography.sm.copyWith(color: colors.foreground),
  iconStyle: .all(
    IconThemeData(color: colors.mutedForeground, size: touch ? typography.lg.fontSize : typography.md.fontSize),
  ),
  focusedOutlineStyle: style.focusedOutlineStyle,
  dividerStyle: FDividerStyle(color: colors.border, padding: .zero),
  tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
  titlePadding: const .symmetric(vertical: 16),
  childPadding: const .only(bottom: 16),
  motion: const FAccordionMotion(),
);
// {@endsnippet}

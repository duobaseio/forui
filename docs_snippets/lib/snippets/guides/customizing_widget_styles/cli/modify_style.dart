// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
FAccordionStyle accordionStyle({required FColors colors, required FTypography typography, required FStyle style}) =>
    FAccordionStyle(
      titleTextStyle: FVariants.from(
        // This text style is applied when the accordion is NOT hovered OR pressed.
        typography.md.copyWith(fontWeight: .w500, color: colors.foreground),
        variants: {
          // This text style is applied when the accordion is hovered OR pressed OR focused (new).
          // {@highlight}
          [.hovered, .pressed, .focused]: .delta(decoration: () => TextDecoration.underline),
        },
      ),
      // {@endsnippet}
      childTextStyle: typography.sm.copyWith(color: colors.foreground),
      // This decoration is ALWAYS applied.
      iconStyle: .all(IconThemeData(color: colors.primary, size: 20)),
      focusedOutlineStyle: style.focusedOutlineStyle,
      dividerStyle: FDividerStyle(color: colors.border, padding: .zero),
      tappableStyle: style.tappableStyle.copyWith(motion: const .delta(bounceTween: FTappableMotion.noBounceTween)),
      titlePadding: const .symmetric(vertical: 15),
      childPadding: const .only(bottom: 15),
      motion: const FAccordionMotion(),
      // {@snippet}
    );
// {@endsnippet}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_styles.design.dart';

/// [FButtonStyle]'s style.
class FButtonStyles with Diagnosticable, _$FButtonStylesFunctions {
  /// The primary button style.
  @override
  final FButtonStyle primary;

  /// The secondary  button style.
  @override
  final FButtonStyle secondary;

  /// The destructive button style.
  @override
  final FButtonStyle destructive;

  /// The outlined button style.
  @override
  final FButtonStyle outline;

  /// The ghost button style.
  @override
  final FButtonStyle ghost;

  /// Creates a [FButtonStyle].
  const FButtonStyles({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outline,
    required this.ghost,
  });

  /// Creates a [FButtonStyle] that inherits its properties.
  FButtonStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        primary: .inherit(
          colors: colors,
          style: style,
          typography: typography,
          color: colors.primary,
          foregroundColor: colors.primaryForeground,
        ),
        secondary: .inherit(
          colors: colors,
          style: style,
          typography: typography,
          color: colors.secondary,
          foregroundColor: colors.secondaryForeground,
        ),
        destructive: .inherit(
          colors: colors,
          style: style,
          typography: typography,
          color: colors.destructive,
          foregroundColor: colors.destructiveForeground,
        ),
        outline: FButtonStyle(
          decoration: FVariants.delta(
            BoxDecoration(
              border: .all(color: colors.border),
              borderRadius: style.borderRadius,
            ),
            variants: {
              [.disabled]: .delta(border: .all(color: colors.disable(colors.border))),
              [.hovered, .pressed]: .delta(color: colors.secondary),
            },
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: .inherit(
            typography: typography,
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          iconContentStyle: .inherit(
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          tappableStyle: style.tappableStyle,
        ),
        ghost: FButtonStyle(
          decoration: FVariants.delta(
            BoxDecoration(borderRadius: style.borderRadius),
            variants: {
              [.disabled]: const .delta(),
              [.hovered, .pressed]: .delta(color: colors.secondary),
            },
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: .inherit(
            typography: typography,
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          iconContentStyle: .inherit(
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          tappableStyle: style.tappableStyle,
        ),
      );
}

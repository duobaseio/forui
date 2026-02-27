import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// The color tokens.
///
/// The main color groups in this scheme are [primary], [secondary], [muted], [destructive], and [error].
/// * Primary colors are used for key widgets across the UI.
/// * Secondary colors are used for less prominent widgets.
/// * Mute colors are typically used for disabled widgets.
/// * Destructive colors are used for destructive actions such as "Delete" buttons.
/// * Error colors are typically used to highlight errors, such as invalid input in text-fields.
///
/// Each color group includes a `-Foreground` suffixed color, i.e. [primaryForeground], used to color text and other
/// visual elements on top of their respective background colors.
///
/// Hovered colors are derived by adjusting the lightness of the original color. To derive these colors, use the [hover]
/// method. The lightness can be adjusted with [hoverLighten].
///
/// Disabled colors are derived by adjusting the opacity. To derive these colors, use the [disable] method. The opacity
/// can be adjusted with [disabledOpacity].
///
/// See [FThemes] for predefined themes and color schemes.
final class FColors with Diagnosticable {
  /// The [Neutral](https://ui.shadcn.com/docs/theming#neutral) light color scheme.
  static const neutralLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF0A0A0A),
    primary: Color(0xFF171717),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF5F5F5),
    secondaryForeground: Color(0xFF171717),
    muted: Color(0xFFF5F5F5),
    mutedForeground: Color(0xFF737373),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE5E5E5),
  );

  /// The [Neutral](https://ui.shadcn.com/docs/theming#neutral) dark color scheme.
  static const neutralDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF0A0A0A),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFE5E5E5),
    primaryForeground: Color(0xFF171717),
    secondary: Color(0xFF262626),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF262626),
    mutedForeground: Color(0xFFA1A1A1),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF171717),
    border: Color(0x1AFFFFFF),
  );

  /// The [Zinc](https://ui.shadcn.com/docs/theming#zinc) light color scheme.
  static const zincLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFF18181B),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Zinc](https://ui.shadcn.com/docs/theming#zinc) dark color scheme.
  static const zincDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFE4E4E7),
    primaryForeground: Color(0xFF18181B),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Slate](https://ui.shadcn.com/docs/theming#slate) light color scheme.
  static const slateLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF020618),
    primary: Color(0xFF0F172B),
    primaryForeground: Color(0xFFF8FAFC),
    secondary: Color(0xFFF1F5F9),
    secondaryForeground: Color(0xFF0F172B),
    muted: Color(0xFFF1F5F9),
    mutedForeground: Color(0xFF62748E),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE2E8F0),
  );

  /// The [Slate](https://ui.shadcn.com/docs/theming#slate) dark color scheme.
  static const slateDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF020618),
    foreground: Color(0xFFF8FAFC),
    primary: Color(0xFFE2E8F0),
    primaryForeground: Color(0xFF0F172B),
    secondary: Color(0xFF1D293D),
    secondaryForeground: Color(0xFFF8FAFC),
    muted: Color(0xFF1D293D),
    mutedForeground: Color(0xFF90A1B9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF0F172B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Blue](https://ui.shadcn.com/themes) light color scheme.
  static const blueLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFF1447E6),
    primaryForeground: Color(0xFFEFF6FF),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Blue](https://ui.shadcn.com/themes) dark color scheme.
  static const blueDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFF1447E6),
    primaryForeground: Color(0xFFEFF6FF),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Green](https://ui.shadcn.com/themes) light color scheme.
  static const greenLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFF5EA500),
    primaryForeground: Color(0xFFF7FEE7),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Green](https://ui.shadcn.com/themes) dark color scheme.
  static const greenDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFF5EA500),
    primaryForeground: Color(0xFFF7FEE7),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Orange](https://ui.shadcn.com/themes) light color scheme.
  static const orangeLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFFF54A00),
    primaryForeground: Color(0xFFFFF7ED),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Orange](https://ui.shadcn.com/themes) dark color scheme.
  static const orangeDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFFF6900),
    primaryForeground: Color(0xFFFFF7ED),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Red](https://ui.shadcn.com/themes) light color scheme.
  static const redLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFFE7000B),
    primaryForeground: Color(0xFFFEF2F2),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Red](https://ui.shadcn.com/themes) dark color scheme.
  static const redDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFFB2C36),
    primaryForeground: Color(0xFFFEF2F2),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Rose](https://ui.shadcn.com/themes) light color scheme.
  static const roseLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFFEC003F),
    primaryForeground: Color(0xFFFFF1F2),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Rose](https://ui.shadcn.com/themes) dark color scheme.
  static const roseDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFFF2056),
    primaryForeground: Color(0xFFFFF1F2),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Violet](https://ui.shadcn.com/themes) light color scheme.
  static const violetLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFF7F22FE),
    primaryForeground: Color(0xFFF5F3FF),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Violet](https://ui.shadcn.com/themes) dark color scheme.
  static const violetDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFF8E51FF),
    primaryForeground: Color(0xFFF5F3FF),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// The [Yellow](https://ui.shadcn.com/themes) light color scheme.
  static const yellowLight = FColors(
    brightness: .light,
    systemOverlayStyle: .dark,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFFFCC800),
    primaryForeground: Color(0xFF733E0A),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717B),
    destructive: Color(0xFFE7000B),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFE7000B),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E4E7),
  );

  /// The [Yellow](https://ui.shadcn.com/themes) dark color scheme.
  static const yellowDark = FColors(
    brightness: .dark,
    systemOverlayStyle: .light,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFEFB100),
    primaryForeground: Color(0xFF733E0A),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF9F9FA9),
    destructive: Color(0xFFFF6467),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFFF6467),
    errorForeground: Color(0xFFFAFAFA),
    card: Color(0xFF18181B),
    border: Color(0x1AFFFFFF),
  );

  /// Linearly interpolates between two colors [a] and [b] using the given factor [t].
  ///
  /// Both colors are converted to Display P3 if they do not share the same color space.
  static Color? lerpColor(Color? a, Color? b, double t) {
    if (a != null && b != null && a.colorSpace != b.colorSpace) {
      a = a.withValues(colorSpace: .displayP3);
      b = b.withValues(colorSpace: .displayP3);
    }

    return Color.lerp(a, b, t);
  }

  /// The system brightness.
  ///
  /// This is typically used to determine the appearance of native UI elements such as on-screen keyboards.
  final Brightness brightness;

  /// The system overlay style.
  ///
  /// This is typically used to determine the appearance of native system overlays such as status bars.
  final SystemUiOverlayStyle systemOverlayStyle;

  /// The barrier color.
  ///
  /// Typically used as a background for modal/pop-up routes.
  final Color barrier;

  /// The background color.
  ///
  /// Typically used as a background for [foreground] colored widgets.
  final Color background;

  /// The foreground color.
  ///
  /// Typically used to color widgets against a [background].
  final Color foreground;

  /// The primary color.
  ///
  /// Typically used as a background for [primaryForeground] colored widgets.
  final Color primary;

  /// The primary foreground color.
  ///
  /// Typically used to color widgets against a [primary] colored background.
  final Color primaryForeground;

  /// The secondary color.
  ///
  /// Typically used as a background for [secondaryForeground] colored widgets.
  final Color secondary;

  /// The secondary foreground color.
  ///
  /// Typically used to color widgets against a [secondary] colored background.
  final Color secondaryForeground;

  /// The muted color.
  ///
  /// Typically used as a background for [mutedForeground] colored widgets.
  final Color muted;

  /// The muted foreground color.
  ///
  /// Typically used to color widgets against a [muted] colored background.
  final Color mutedForeground;

  /// The destructive color.
  ///
  /// Typically used as a background for [destructiveForeground] colored widgets.
  final Color destructive;

  /// The destructive foreground color.
  ///
  /// Typically used to color widgets against a [destructive] colored background.
  final Color destructiveForeground;

  /// The error color.
  ///
  /// Typically used as a background for [errorForeground] colored widgets.
  final Color error;

  /// The error foreground color.
  ///
  /// Typically used to color widgets against a [error] colored background.
  final Color errorForeground;

  /// The card color.
  ///
  /// Typically used as a background for card widgets.
  final Color card;

  /// The border color.
  final Color border;

  /// The percentage to lighten dark colors by. A higher value will result in a more pronounced lightening effect.
  ///
  /// Defaults to 0.075.
  ///
  /// ## Contract
  /// `0.0 <= hoverLighten <= 1.0`
  final double hoverLighten;

  /// The percentage to darken light colors by. A higher value will result in a more pronounced darkening effect.
  ///
  /// Defaults to 0.05.
  ///
  /// ## Contract
  /// `0.0 <= hoverDarken <= 1.0`
  final double hoverDarken;

  /// The factor by which to multiply a color's opacity when a widget is disabled. Defaults to 0.5.
  ///
  /// For example, a fully opaque color will become 50% transparent, and a color at 80% opacity will become 40%.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the value is less than 0 or greater than 1.
  final double disabledOpacity;

  /// Creates a [FColors].
  ///
  /// **Note:**
  /// Unless you are creating a completely new color scheme, modifying [FThemes]' predefined color schemes is preferred.
  const FColors({
    required this.brightness,
    required this.systemOverlayStyle,
    required this.barrier,
    required this.background,
    required this.foreground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.error,
    required this.errorForeground,
    required this.card,
    required this.border,
    this.hoverLighten = 0.075,
    this.hoverDarken = 0.05,
    this.disabledOpacity = 0.5,
  }) : assert(0.0 <= hoverLighten && hoverLighten <= 1.0, 'hoverLighten must be between 0 and 1.'),
       assert(0.0 <= hoverDarken && hoverDarken <= 1.0, 'hoverDarken must be between 0 and 1.'),
       assert(0 <= disabledOpacity && disabledOpacity <= 1, 'disabledOpacity must be between 0 and 1.');

  /// Creates a linear interpolation between two [FColors] using the given factor [t].
  factory FColors.lerp(FColors a, FColors b, double t) => .new(
    brightness: t < 0.5 ? a.brightness : b.brightness,
    systemOverlayStyle: t < 0.5 ? a.systemOverlayStyle : b.systemOverlayStyle,
    barrier: FColors.lerpColor(a.barrier, b.barrier, t)!,
    background: FColors.lerpColor(a.background, b.background, t)!,
    foreground: FColors.lerpColor(a.foreground, b.foreground, t)!,
    primary: FColors.lerpColor(a.primary, b.primary, t)!,
    primaryForeground: FColors.lerpColor(a.primaryForeground, b.primaryForeground, t)!,
    secondary: FColors.lerpColor(a.secondary, b.secondary, t)!,
    secondaryForeground: FColors.lerpColor(a.secondaryForeground, b.secondaryForeground, t)!,
    muted: FColors.lerpColor(a.muted, b.muted, t)!,
    mutedForeground: FColors.lerpColor(a.mutedForeground, b.mutedForeground, t)!,
    destructive: FColors.lerpColor(a.destructive, b.destructive, t)!,
    destructiveForeground: FColors.lerpColor(a.destructiveForeground, b.destructiveForeground, t)!,
    error: FColors.lerpColor(a.error, b.error, t)!,
    errorForeground: FColors.lerpColor(a.errorForeground, b.errorForeground, t)!,
    card: FColors.lerpColor(a.card, b.card, t)!,
    border: FColors.lerpColor(a.border, b.border, t)!,
    hoverLighten: lerpDouble(a.hoverLighten, b.hoverLighten, t)!,
    hoverDarken: lerpDouble(a.hoverDarken, b.hoverDarken, t)!,
    disabledOpacity: lerpDouble(a.disabledOpacity, b.disabledOpacity, t)!,
  );

  /// Generates a hovered variant of the given [color] by darkening light colors and lighting dark colors based on their
  /// HSL lightness.
  ///
  /// Colors at the extremes (very light or very dark) will be adjusted more aggressively than colors in the middle.
  ///
  /// The lightening and darkening are controlled by [hoverLighten] and [hoverDarken].
  Color hover(Color color) {
    // This results in a slight precision loss when using Display P3 colors, but it's negligible for hover effects.
    final hsl = HSLColor.fromColor(color);
    final l = hsl.lightness;

    // More aggressive color change when lightness is close to extremes & less when in the middle.
    final (space, factor, sign) = l > 0.5 ? (1.0 - l, hoverDarken, -1) : (l, hoverLighten, 1);
    final aggressiveness = 1 + ((0.5 - space) / 0.5);
    final adjustment = factor * aggressiveness * sign;
    final lightness = clampDouble(l + adjustment, 0, 1);

    // This isn't accurate since Display P3 colors will be interpreted in sRGB space. We keep this since converting to
    // Display P3 causes a noticeable color shift. A proper fix will require oklch.
    final hovered = hsl.withLightness(lightness).toColor();
    if (hovered.colorSpace != color.colorSpace) {
      return hovered.withValues(colorSpace: color.colorSpace);
    }

    return hovered;
  }

  /// Returns a disabled variant of the [color] by multiplying its opacity by [disabledOpacity].
  Color disable(Color color) => color.withValues(alpha: color.a * disabledOpacity);

  /// Returns a copy of this [FColors] with the given properties replaced.
  ///
  /// ```dart
  /// final colors = FColors(
  ///   brightness: Brightness.light,
  ///   background: Colors.blue,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = colors.copyWith(brightness: Brightness.dark);
  ///
  /// print(copy.brightness); // Brightness.dark
  /// print(copy.background); // Colors.blue
  /// ```
  @useResult
  FColors copyWith({
    Brightness? brightness,
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? barrier,
    Color? background,
    Color? foreground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? error,
    Color? errorForeground,
    Color? card,
    Color? border,
    double? hoverLighten,
    double? hoverDarken,
    double? disabledOpacity,
  }) => .new(
    brightness: brightness ?? this.brightness,
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    barrier: barrier ?? this.barrier,
    background: background ?? this.background,
    foreground: foreground ?? this.foreground,
    primary: primary ?? this.primary,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    secondary: secondary ?? this.secondary,
    secondaryForeground: secondaryForeground ?? this.secondaryForeground,
    muted: muted ?? this.muted,
    mutedForeground: mutedForeground ?? this.mutedForeground,
    destructive: destructive ?? this.destructive,
    destructiveForeground: destructiveForeground ?? this.destructiveForeground,
    error: error ?? this.error,
    errorForeground: errorForeground ?? this.errorForeground,
    card: card ?? this.card,
    border: border ?? this.border,
    hoverLighten: hoverLighten ?? this.hoverLighten,
    hoverDarken: hoverDarken ?? this.hoverDarken,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('brightness', brightness))
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle))
      ..add(ColorProperty('barrier', barrier))
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('foreground', foreground))
      ..add(ColorProperty('primary', primary))
      ..add(ColorProperty('primaryForeground', primaryForeground))
      ..add(ColorProperty('secondary', secondary))
      ..add(ColorProperty('secondaryForeground', secondaryForeground))
      ..add(ColorProperty('muted', muted))
      ..add(ColorProperty('mutedForeground', mutedForeground))
      ..add(ColorProperty('destructive', destructive))
      ..add(ColorProperty('destructiveForeground', destructiveForeground))
      ..add(ColorProperty('error', error))
      ..add(ColorProperty('errorForeground', errorForeground))
      ..add(ColorProperty('card', card))
      ..add(ColorProperty('border', border))
      ..add(PercentProperty('hoverLighten', hoverLighten))
      ..add(PercentProperty('hoverDarken', hoverDarken))
      ..add(PercentProperty('disabledOpacity', disabledOpacity));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FColors &&
          brightness == other.brightness &&
          systemOverlayStyle == other.systemOverlayStyle &&
          barrier == other.barrier &&
          background == other.background &&
          foreground == other.foreground &&
          primary == other.primary &&
          primaryForeground == other.primaryForeground &&
          secondary == other.secondary &&
          secondaryForeground == other.secondaryForeground &&
          muted == other.muted &&
          mutedForeground == other.mutedForeground &&
          destructive == other.destructive &&
          destructiveForeground == other.destructiveForeground &&
          error == other.error &&
          errorForeground == other.errorForeground &&
          card == other.card &&
          border == other.border &&
          hoverLighten == other.hoverLighten &&
          hoverDarken == other.hoverDarken &&
          disabledOpacity == other.disabledOpacity;

  @override
  int get hashCode =>
      brightness.hashCode ^
      systemOverlayStyle.hashCode ^
      barrier.hashCode ^
      background.hashCode ^
      foreground.hashCode ^
      primary.hashCode ^
      primaryForeground.hashCode ^
      secondary.hashCode ^
      secondaryForeground.hashCode ^
      muted.hashCode ^
      mutedForeground.hashCode ^
      destructive.hashCode ^
      destructiveForeground.hashCode ^
      error.hashCode ^
      errorForeground.hashCode ^
      card.hashCode ^
      border.hashCode ^
      hoverLighten.hashCode ^
      hoverDarken.hashCode ^
      disabledOpacity.hashCode;
}

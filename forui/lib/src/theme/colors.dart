import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

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
/// See [FColors.neutral], [FColors.zinc], and other predefined base color schemes. Use [withPrimary] and
/// [FPrimaryColors] to swap the accent color:
/// ```dart
/// final colors = FColors.zinc.light.with(FPrimaryColors.blue.light);
/// ```
final class FColors with Diagnosticable {
  /// The Neutral base color scheme.
  static const neutral = (
    light: FColors(
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
    ),
    dark: FColors(
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
    ),
  );

  /// The neutral color scheme.
  static const zinc = (
    light: FColors(
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
    ),
    dark: FColors(
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
    ),
  );

  /// The Stone color scheme.
  static const stone = (
    light: FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: Color(0x33000000),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF0C0A09),
      primary: Color(0xFF1C1917),
      primaryForeground: Color(0xFFFAFAF9),
      secondary: Color(0xFFF5F5F4),
      secondaryForeground: Color(0xFF1C1917),
      muted: Color(0xFFF5F5F4),
      mutedForeground: Color(0xFF79716B),
      destructive: Color(0xFFE7000B),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFE7000B),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFFFFFFFF),
      border: Color(0xFFE7E5E4),
    ),
    dark: FColors(
      brightness: .dark,
      systemOverlayStyle: .light,
      barrier: Color(0x7A000000),
      background: Color(0xFF0C0A09),
      foreground: Color(0xFFFAFAF9),
      primary: Color(0xFFE7E5E4),
      primaryForeground: Color(0xFF1C1917),
      secondary: Color(0xFF292524),
      secondaryForeground: Color(0xFFFAFAF9),
      muted: Color(0xFF292524),
      mutedForeground: Color(0xFFA6A09B),
      destructive: Color(0xFFFF6467),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFFF6467),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFF1C1917),
      border: Color(0x1AFFFFFF),
    ),
  );

  /// The Mauve color scheme.
  static const mauve = (
    light: FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: Color(0x33000000),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF0C090C),
      primary: Color(0xFF1D161E),
      primaryForeground: Color(0xFFFAFAFA),
      secondary: Color(0xFFF3F1F3),
      secondaryForeground: Color(0xFF1D161E),
      muted: Color(0xFFF3F1F3),
      mutedForeground: Color(0xFF79697B),
      destructive: Color(0xFFE7000B),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFE7000B),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFFFFFFFF),
      border: Color(0xFFE7E4E7),
    ),
    dark: FColors(
      brightness: .dark,
      systemOverlayStyle: .light,
      barrier: Color(0x7A000000),
      background: Color(0xFF0C090C),
      foreground: Color(0xFFFAFAFA),
      primary: Color(0xFFE7E4E7),
      primaryForeground: Color(0xFF1D161E),
      secondary: Color(0xFF2A212C),
      secondaryForeground: Color(0xFFFAFAFA),
      muted: Color(0xFF2A212C),
      mutedForeground: Color(0xFFA89EA9),
      destructive: Color(0xFFFF6467),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFFF6467),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFF1D161E),
      border: Color(0x1AFFFFFF),
    ),
  );

  /// The Olive color scheme.
  static const olive = (
    light: FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: Color(0x33000000),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF0C0C09),
      primary: Color(0xFF1D1D16),
      primaryForeground: Color(0xFFFBFBF9),
      secondary: Color(0xFFF4F4F0),
      secondaryForeground: Color(0xFF1D1D16),
      muted: Color(0xFFF4F4F0),
      mutedForeground: Color(0xFF7C7C67),
      destructive: Color(0xFFE7000B),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFE7000B),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFFFFFFFF),
      border: Color(0xFFE8E8E3),
    ),
    dark: FColors(
      brightness: .dark,
      systemOverlayStyle: .light,
      barrier: Color(0x7A000000),
      background: Color(0xFF0C0C09),
      foreground: Color(0xFFFBFBF9),
      primary: Color(0xFFE8E8E3),
      primaryForeground: Color(0xFF1D1D16),
      secondary: Color(0xFF2B2B22),
      secondaryForeground: Color(0xFFFBFBF9),
      muted: Color(0xFF2B2B22),
      mutedForeground: Color(0xFFABAB9C),
      destructive: Color(0xFFFF6467),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFFF6467),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFF1D1D16),
      border: Color(0x1AFFFFFF),
    ),
  );

  /// The Mist color scheme.
  static const mist = (
    light: FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: Color(0x33000000),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF090B0C),
      primary: Color(0xFF161B1D),
      primaryForeground: Color(0xFFF9FBFB),
      secondary: Color(0xFFF1F3F3),
      secondaryForeground: Color(0xFF161B1D),
      muted: Color(0xFFF1F3F3),
      mutedForeground: Color(0xFF67787C),
      destructive: Color(0xFFE7000B),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFE7000B),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFFFFFFFF),
      border: Color(0xFFE3E7E8),
    ),
    dark: FColors(
      brightness: .dark,
      systemOverlayStyle: .light,
      barrier: Color(0x7A000000),
      background: Color(0xFF090B0C),
      foreground: Color(0xFFF9FBFB),
      primary: Color(0xFFE3E7E8),
      primaryForeground: Color(0xFF161B1D),
      secondary: Color(0xFF22292B),
      secondaryForeground: Color(0xFFF9FBFB),
      muted: Color(0xFF22292B),
      mutedForeground: Color(0xFF9CA8AB),
      destructive: Color(0xFFFF6467),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFFF6467),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFF161B1D),
      border: Color(0x1AFFFFFF),
    ),
  );

  /// The Taupe color scheme.
  static const taupe = (
    light: FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
      barrier: Color(0x33000000),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF0C0A09),
      primary: Color(0xFF1D1816),
      primaryForeground: Color(0xFFFBFAF9),
      secondary: Color(0xFFF3F1F1),
      secondaryForeground: Color(0xFF1D1816),
      muted: Color(0xFFF3F1F1),
      mutedForeground: Color(0xFF7C6D67),
      destructive: Color(0xFFE7000B),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFE7000B),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFFFFFFFF),
      border: Color(0xFFE8E4E3),
    ),
    dark: FColors(
      brightness: .dark,
      systemOverlayStyle: .light,
      barrier: Color(0x7A000000),
      background: Color(0xFF0C0A09),
      foreground: Color(0xFFFBFAF9),
      primary: Color(0xFF1D1816),
      primaryForeground: Color(0xFFFBFAF9),
      secondary: Color(0xFF2B2422),
      secondaryForeground: Color(0xFFFBFAF9),
      muted: Color(0xFF2B2422),
      mutedForeground: Color(0xFFABA09C),
      destructive: Color(0xFFFF6467),
      destructiveForeground: Color(0xFFFAFAFA),
      error: Color(0xFFFF6467),
      errorForeground: Color(0xFFFAFAFA),
      card: Color(0xFF1D1816),
      border: Color(0x1AFFFFFF),
    ),
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
  /// Unless you are creating a completely new color scheme, using the predefined base color schemes with
  /// [withPrimary] is preferred:
  /// ```dart
  /// final colors = FColors.zinc.light.withPrimary(FPrimaryColors.blue.light);
  /// ```
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
  Color disable(Color color, [Color? background]) {
    final disabled = color.withValues(alpha: color.a * disabledOpacity);
    // This is required for cases where there are other elements beneath the disabled widget that would show through the
    // transparency, e.g. slider's active track and the ticks beneath it.
    return background == null ? disabled : Color.alphaBlend(disabled, background);
  }

  /// Returns a copy of this [FColors] with the given [primary] and [primaryForeground] replaced.
  ///
  /// Typically used with [FPrimaryColors] to compose a base color scheme with an accent color:
  /// ```dart
  /// final colors = FColors.zinc.light.withPrimary(FPrimaryColors.blue.light);
  /// ```
  @useResult
  FColors withPrimary(({Color primary, Color primaryForeground}) colors) =>
      copyWith(primary: colors.primary, primaryForeground: colors.primaryForeground);

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

/// The primary accent colors.
///
/// Each color provides `light` and `dark` variants as `({Color primary, Color primaryForeground})` records.
/// Use with [FColors.withPrimary] to compose a base color scheme with an accent:
/// ```dart
/// final colors = FColors.zinc.light.withPrimary(FPrimaryColors.blue.light);
/// ```
extension FPrimaryColors on Never {
  /// The [Blue](https://ui.shadcn.com/themes) primary color.
  static const blue = (
    light: (primary: Color(0xFF1447E6), primaryForeground: Color(0xFFEFF6FF)),
    dark: (primary: Color(0xFF1447E6), primaryForeground: Color(0xFFEFF6FF)),
  );

  /// The [Green](https://ui.shadcn.com/themes) primary color.
  static const green = (
    light: (primary: Color(0xFF5EA500), primaryForeground: Color(0xFFF7FEE7)),
    dark: (primary: Color(0xFF5EA500), primaryForeground: Color(0xFFF7FEE7)),
  );

  /// The [Orange](https://ui.shadcn.com/themes) primary color.
  static const orange = (
    light: (primary: Color(0xFFF54A00), primaryForeground: Color(0xFFFFF7ED)),
    dark: (primary: Color(0xFFFF6900), primaryForeground: Color(0xFFFFF7ED)),
  );

  /// The [Red](https://ui.shadcn.com/themes) primary color.
  static const red = (
    light: (primary: Color(0xFFE7000B), primaryForeground: Color(0xFFFEF2F2)),
    dark: (primary: Color(0xFFFB2C36), primaryForeground: Color(0xFFFEF2F2)),
  );

  /// The [Rose](https://ui.shadcn.com/themes) primary color.
  static const rose = (
    light: (primary: Color(0xFFEC003F), primaryForeground: Color(0xFFFFF1F2)),
    dark: (primary: Color(0xFFFF2056), primaryForeground: Color(0xFFFFF1F2)),
  );

  /// The [Violet](https://ui.shadcn.com/themes) primary color.
  static const violet = (
    light: (primary: Color(0xFF7F22FE), primaryForeground: Color(0xFFF5F3FF)),
    dark: (primary: Color(0xFF8E51FF), primaryForeground: Color(0xFFF5F3FF)),
  );

  /// The [Yellow](https://ui.shadcn.com/themes) primary color.
  static const yellow = (
    light: (primary: Color(0xFFFCC800), primaryForeground: Color(0xFF733E0A)),
    dark: (primary: Color(0xFFEFB100), primaryForeground: Color(0xFF733E0A)),
  );
}

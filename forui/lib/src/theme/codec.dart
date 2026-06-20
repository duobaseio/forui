// ignore_for_file: public_member_api_docs

/// An internal codec used by the create application and CLI for encoding and decoding presets.
///
/// Import this file using the full path and ignore the corresponding lint.
///
/// It is included as part of Forui to reduce the amount of boilerplate and surrounding infrastructure that a separate
/// Flutter project would necessitate.
library;

import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/border_radius.dart';

/// A theme preset: one selection from each customization category.
final class Preset {
  final BaseColor base;
  final PrimaryColor primary;
  final FontFamily display;
  final FontFamily body;
  final IconLibrary icon;
  final Radius radius;

  const Preset({
    required this.base,
    required this.primary,
    required this.display,
    required this.body,
    required this.icon,
    required this.radius,
  });

  factory Preset.decode(String encoded) {
    if (encoded.length != 6) {
      throw FormatException('A preset must be exactly 6 codes long.', encoded, encoded.length);
    }

    // This is not optimal since it is O(n), but realistically it doesn't matter as n is small.
    T decode<T extends Code>(List<T> values, String encoded, int index) {
      final char = encoded[index];
      for (final value in values) {
        if (value.code == char) {
          return value;
        }
      }

      throw FormatException("Invalid code '$char' at index $index.", encoded, index);
    }

    return Preset(
      base: decode(BaseColor.values, encoded, 0),
      primary: decode(PrimaryColor.values, encoded, 1),
      display: decode(FontFamily.values, encoded, 2),
      body: decode(FontFamily.values, encoded, 3),
      icon: decode(IconLibrary.values, encoded, 4),
      radius: decode(Radius.values, encoded, 5),
    );
  }

  String encode() =>
      '${base.code}${primary.code}${display.code}'
      '${body.code}${icon.code}${radius.code}';
}

abstract interface class Code {
  String get code;
}

enum BaseColor implements Code {
  neutral(
    code: 'a',
    name: 'Neutral',
    light: BaseColors(
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
    dark: BaseColors(
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
  ),
  zinc(
    code: 'b',
    name: 'Zinc',
    light: BaseColors(
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
    dark: BaseColors(
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
  ),
  stone(
    code: 'c',
    name: 'Stone',
    light: BaseColors(
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
    dark: BaseColors(
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
  ),
  mauve(
    code: 'd',
    name: 'Mauve',
    light: BaseColors(
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
    dark: BaseColors(
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
  ),
  olive(
    code: 'e',
    name: 'Olive',
    light: BaseColors(
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
    dark: BaseColors(
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
  ),
  mist(
    code: 'f',
    name: 'Mist',
    light: BaseColors(
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
    dark: BaseColors(
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
  ),
  taupe(
    code: 'g',
    name: 'Taupe',
    light: BaseColors(
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
    dark: BaseColors(
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

  @override
  final String code;
  final String name;
  final BaseColors light;
  final BaseColors dark;

  const BaseColor({required this.code, required this.name, required this.light, required this.dark});
}

final class BaseColors {
  final Color barrier;
  final Color background;
  final Color foreground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color error;
  final Color errorForeground;
  final Color card;
  final Color border;

  const BaseColors({
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
  });
}

enum PrimaryColor implements Code {
  blue(
    code: 'a',
    name: 'Blue',
    light: PrimaryColors(primary: Color(0xFF1447E6), primaryForeground: Color(0xFFEFF6FF)),
    dark: PrimaryColors(primary: Color(0xFF1447E6), primaryForeground: Color(0xFFEFF6FF)),
  ),
  green(
    code: 'b',
    name: 'Green',
    light: PrimaryColors(primary: Color(0xFF5EA500), primaryForeground: Color(0xFFF7FEE7)),
    dark: PrimaryColors(primary: Color(0xFF5EA500), primaryForeground: Color(0xFFF7FEE7)),
  ),
  orange(
    code: 'c',
    name: 'Orange',
    light: PrimaryColors(primary: Color(0xFFF54A00), primaryForeground: Color(0xFFFFF7ED)),
    dark: PrimaryColors(primary: Color(0xFFFF6900), primaryForeground: Color(0xFFFFF7ED)),
  ),
  red(
    code: 'd',
    name: 'Red',
    light: PrimaryColors(primary: Color(0xFFE7000B), primaryForeground: Color(0xFFFEF2F2)),
    dark: PrimaryColors(primary: Color(0xFFFB2C36), primaryForeground: Color(0xFFFEF2F2)),
  ),
  rose(
    code: 'e',
    name: 'Rose',
    light: PrimaryColors(primary: Color(0xFFEC003F), primaryForeground: Color(0xFFFFF1F2)),
    dark: PrimaryColors(primary: Color(0xFFFF2056), primaryForeground: Color(0xFFFFF1F2)),
  ),
  violet(
    code: 'f',
    name: 'Violet',
    light: PrimaryColors(primary: Color(0xFF7F22FE), primaryForeground: Color(0xFFF5F3FF)),
    dark: PrimaryColors(primary: Color(0xFF8E51FF), primaryForeground: Color(0xFFF5F3FF)),
  ),
  yellow(
    code: 'g',
    name: 'Yellow',
    light: PrimaryColors(primary: Color(0xFFFCC800), primaryForeground: Color(0xFF733E0A)),
    dark: PrimaryColors(primary: Color(0xFFEFB100), primaryForeground: Color(0xFF733E0A)),
  );

  @override
  final String code;
  final String name;
  final PrimaryColors light;
  final PrimaryColors dark;

  const PrimaryColor({required this.code, required this.name, required this.light, required this.dark});
}

final class PrimaryColors {
  final Color primary;
  final Color primaryForeground;

  const PrimaryColors({required this.primary, required this.primaryForeground});
}

enum FontFamily implements Code {
  geist('a', 'Geist', .sans),
  inter('b', 'Inter', .sans),
  notoSans('c', 'Noto Sans', .sans),
  nunitoSans('d', 'Nunito Sans', .sans),
  figtree('e', 'Figtree', .sans),
  roboto('f', 'Roboto', .sans),
  raleway('g', 'Raleway', .sans),
  dmSans('h', 'DM Sans', .sans),
  publicSans('i', 'Public Sans', .sans),
  outfit('j', 'Outfit', .sans),
  oxanium('k', 'Oxanium', .sans),
  manrope('l', 'Manrope', .sans),
  spaceGrotesk('m', 'Space Grotesk', .sans),
  montserrat('n', 'Montserrat', .sans),
  ibmPlexSans('o', 'IBM Plex Sans', .sans),
  sourceSans3('p', 'Source Sans 3', .sans),
  instrumentSans('q', 'Instrument Sans', .sans),
  jetBrainsMono('r', 'JetBrains Mono', .mono),
  geistMono('s', 'Geist Mono', .mono),
  notoSerif('t', 'Noto Serif', .serif),
  robotoSlab('u', 'Roboto Slab', .serif),
  merriweather('v', 'Merriweather', .serif),
  lora('w', 'Lora', .serif),
  playfairDisplay('x', 'Playfair Display', .serif),
  ebGaramond('y', 'EB Garamond', .serif),
  instrumentSerif('z', 'Instrument Serif', .serif);

  @override
  final String code;
  final String name;
  final FontFamilyCategory category;

  const FontFamily(this.code, this.name, this.category);
}

enum FontFamilyCategory { sans, serif, mono }

enum IconLibrary implements Code {
  hugeicons('a', 'Hugeicons', 'hugeicons', 'https://hugeicons.com'),
  lucide('b', 'Lucide', 'forui_assets', 'https://lucide.dev'),
  tabler('c', 'Tabler', 'tabler_icons_plus', 'https://tabler.io/icons'),
  remix('d', 'Remix', 'remixicon', 'https://remixicon.com'),
  iconoir('e', 'Iconoir', 'iconoir_flutter', 'https://iconoir.com');

  @override
  final String code;
  final String name;
  final String package;
  final String url;

  const IconLibrary(this.code, this.name, this.package, this.url);
}

enum Radius implements Code {
  none(
    'a',
    'None',
    FBorderRadius(xs2: .zero, xs: .zero, sm: .zero, md: .zero, lg: .zero, xl: .zero, xl2: .zero, xl3: .zero),
  ),
  small(
    'b',
    'Small',
    FBorderRadius(
      xs2: .all(.circular(3)),
      xs: .all(.circular(4)),
      sm: .all(.circular(6)),
      md: .all(.circular(7)),
      lg: .all(.circular(10)),
      xl: .all(.circular(13)),
      xl2: .all(.circular(16)),
      xl3: .all(.circular(19)),
    ),
  ),
  medium('c', 'Medium', FBorderRadius()),
  large(
    'd',
    'Large',
    FBorderRadius(
      xs2: .all(.circular(6)),
      xs: .all(.circular(8)),
      sm: .all(.circular(11)),
      md: .all(.circular(14)),
      lg: .all(.circular(20)),
      xl: .all(.circular(25)),
      xl2: .all(.circular(31)),
      xl3: .all(.circular(36)),
    ),
  );

  @override
  final String code;
  final String name;
  final FBorderRadius radius;

  const Radius(this.code, this.name, this.radius);
}

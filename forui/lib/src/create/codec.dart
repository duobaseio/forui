// ignore_for_file: public_member_api_docs

/// An internal codec used by the create application and CLI for encoding and decoding presets.
///
/// Import this file using the full path and ignore the corresponding lint.
///
/// This file is included as part of Forui to reduce the amount of boilerplate and surrounding infrastructure that a
/// separate Flutter project would necessitate. It must remain free of Flutter (`dart:ui`/`package:flutter`) imports so
/// the CLI can use it on the standalone Dart VM.
library;

final class Preset {
  final BaseColor base;
  final PrimaryColor primary;
  final FontFamily display;
  final FontFamily body;
  final IconLibrary icon;
  final Radius radius;

  const Preset._({
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

    T decode<T extends Code>(List<T> values, String encoded, int index) {
      final char = encoded[index];
      for (final value in values) {
        if (value.code == char) {
          return value;
        }
      }

      throw FormatException("Invalid code '$char' at index $index.", encoded, index);
    }

    return ._(
      base: decode(BaseColor.values, encoded, 0),
      primary: decode(PrimaryColor.values, encoded, 1),
      display: decode(FontFamily.values, encoded, 2),
      body: decode(FontFamily.values, encoded, 3),
      icon: decode(IconLibrary.values, encoded, 4),
      radius: decode(Radius.values, encoded, 5),
    );
  }

  String encode() => '${base.code}${primary.code}${display.code}${body.code}${icon.code}${radius.code}';
}

abstract interface class Code {
  String get code;
}

enum BaseColor implements Code {
  neutral(
    code: 'a',
    name: 'Neutral',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF0A0A0A,
      primary: 0xFF171717,
      primaryForeground: 0xFFFAFAFA,
      secondary: 0xFFF5F5F5,
      secondaryForeground: 0xFF171717,
      muted: 0xFFF5F5F5,
      mutedForeground: 0xFF737373,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE5E5E5,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF0A0A0A,
      foreground: 0xFFFAFAFA,
      primary: 0xFFE5E5E5,
      primaryForeground: 0xFF171717,
      secondary: 0xFF262626,
      secondaryForeground: 0xFFFAFAFA,
      muted: 0xFF262626,
      mutedForeground: 0xFFA1A1A1,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF171717,
      border: 0x1AFFFFFF,
    ),
  ),
  zinc(
    code: 'b',
    name: 'Zinc',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF09090B,
      primary: 0xFF18181B,
      primaryForeground: 0xFFFAFAFA,
      secondary: 0xFFF4F4F5,
      secondaryForeground: 0xFF18181B,
      muted: 0xFFF4F4F5,
      mutedForeground: 0xFF71717B,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE4E4E7,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF09090B,
      foreground: 0xFFFAFAFA,
      primary: 0xFFE4E4E7,
      primaryForeground: 0xFF18181B,
      secondary: 0xFF27272A,
      secondaryForeground: 0xFFFAFAFA,
      muted: 0xFF27272A,
      mutedForeground: 0xFF9F9FA9,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF18181B,
      border: 0x1AFFFFFF,
    ),
  ),
  stone(
    code: 'c',
    name: 'Stone',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF0C0A09,
      primary: 0xFF1C1917,
      primaryForeground: 0xFFFAFAF9,
      secondary: 0xFFF5F5F4,
      secondaryForeground: 0xFF1C1917,
      muted: 0xFFF5F5F4,
      mutedForeground: 0xFF79716B,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE7E5E4,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF0C0A09,
      foreground: 0xFFFAFAF9,
      primary: 0xFFE7E5E4,
      primaryForeground: 0xFF1C1917,
      secondary: 0xFF292524,
      secondaryForeground: 0xFFFAFAF9,
      muted: 0xFF292524,
      mutedForeground: 0xFFA6A09B,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF1C1917,
      border: 0x1AFFFFFF,
    ),
  ),
  mauve(
    code: 'd',
    name: 'Mauve',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF0C090C,
      primary: 0xFF1D161E,
      primaryForeground: 0xFFFAFAFA,
      secondary: 0xFFF3F1F3,
      secondaryForeground: 0xFF1D161E,
      muted: 0xFFF3F1F3,
      mutedForeground: 0xFF79697B,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE7E4E7,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF0C090C,
      foreground: 0xFFFAFAFA,
      primary: 0xFFE7E4E7,
      primaryForeground: 0xFF1D161E,
      secondary: 0xFF2A212C,
      secondaryForeground: 0xFFFAFAFA,
      muted: 0xFF2A212C,
      mutedForeground: 0xFFA89EA9,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF1D161E,
      border: 0x1AFFFFFF,
    ),
  ),
  olive(
    code: 'e',
    name: 'Olive',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF0C0C09,
      primary: 0xFF1D1D16,
      primaryForeground: 0xFFFBFBF9,
      secondary: 0xFFF4F4F0,
      secondaryForeground: 0xFF1D1D16,
      muted: 0xFFF4F4F0,
      mutedForeground: 0xFF7C7C67,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE8E8E3,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF0C0C09,
      foreground: 0xFFFBFBF9,
      primary: 0xFFE8E8E3,
      primaryForeground: 0xFF1D1D16,
      secondary: 0xFF2B2B22,
      secondaryForeground: 0xFFFBFBF9,
      muted: 0xFF2B2B22,
      mutedForeground: 0xFFABAB9C,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF1D1D16,
      border: 0x1AFFFFFF,
    ),
  ),
  mist(
    code: 'f',
    name: 'Mist',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF090B0C,
      primary: 0xFF161B1D,
      primaryForeground: 0xFFF9FBFB,
      secondary: 0xFFF1F3F3,
      secondaryForeground: 0xFF161B1D,
      muted: 0xFFF1F3F3,
      mutedForeground: 0xFF67787C,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE3E7E8,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF090B0C,
      foreground: 0xFFF9FBFB,
      primary: 0xFFE3E7E8,
      primaryForeground: 0xFF161B1D,
      secondary: 0xFF22292B,
      secondaryForeground: 0xFFF9FBFB,
      muted: 0xFF22292B,
      mutedForeground: 0xFF9CA8AB,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF161B1D,
      border: 0x1AFFFFFF,
    ),
  ),
  taupe(
    code: 'g',
    name: 'Taupe',
    light: BaseColors(
      barrier: 0x33000000,
      background: 0xFFFFFFFF,
      foreground: 0xFF0C0A09,
      primary: 0xFF1D1816,
      primaryForeground: 0xFFFBFAF9,
      secondary: 0xFFF3F1F1,
      secondaryForeground: 0xFF1D1816,
      muted: 0xFFF3F1F1,
      mutedForeground: 0xFF7C6D67,
      destructive: 0xFFE7000B,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFE7000B,
      errorForeground: 0xFFFAFAFA,
      card: 0xFFFFFFFF,
      border: 0xFFE8E4E3,
    ),
    dark: BaseColors(
      barrier: 0x7A000000,
      background: 0xFF0C0A09,
      foreground: 0xFFFBFAF9,
      primary: 0xFF1D1816,
      primaryForeground: 0xFFFBFAF9,
      secondary: 0xFF2B2422,
      secondaryForeground: 0xFFFBFAF9,
      muted: 0xFF2B2422,
      mutedForeground: 0xFFABA09C,
      destructive: 0xFFFF6467,
      destructiveForeground: 0xFFFAFAFA,
      error: 0xFFFF6467,
      errorForeground: 0xFFFAFAFA,
      card: 0xFF1D1816,
      border: 0x1AFFFFFF,
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
  final int barrier;
  final int background;
  final int foreground;
  final int primary;
  final int primaryForeground;
  final int secondary;
  final int secondaryForeground;
  final int muted;
  final int mutedForeground;
  final int destructive;
  final int destructiveForeground;
  final int error;
  final int errorForeground;
  final int card;
  final int border;

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
    light: PrimaryColors(primary: 0xFF1447E6, primaryForeground: 0xFFEFF6FF),
    dark: PrimaryColors(primary: 0xFF1447E6, primaryForeground: 0xFFEFF6FF),
  ),
  green(
    code: 'b',
    name: 'Green',
    light: PrimaryColors(primary: 0xFF5EA500, primaryForeground: 0xFFF7FEE7),
    dark: PrimaryColors(primary: 0xFF5EA500, primaryForeground: 0xFFF7FEE7),
  ),
  orange(
    code: 'c',
    name: 'Orange',
    light: PrimaryColors(primary: 0xFFF54A00, primaryForeground: 0xFFFFF7ED),
    dark: PrimaryColors(primary: 0xFFFF6900, primaryForeground: 0xFFFFF7ED),
  ),
  red(
    code: 'd',
    name: 'Red',
    light: PrimaryColors(primary: 0xFFE7000B, primaryForeground: 0xFFFEF2F2),
    dark: PrimaryColors(primary: 0xFFFB2C36, primaryForeground: 0xFFFEF2F2),
  ),
  rose(
    code: 'e',
    name: 'Rose',
    light: PrimaryColors(primary: 0xFFEC003F, primaryForeground: 0xFFFFF1F2),
    dark: PrimaryColors(primary: 0xFFFF2056, primaryForeground: 0xFFFFF1F2),
  ),
  violet(
    code: 'f',
    name: 'Violet',
    light: PrimaryColors(primary: 0xFF7F22FE, primaryForeground: 0xFFF5F3FF),
    dark: PrimaryColors(primary: 0xFF8E51FF, primaryForeground: 0xFFF5F3FF),
  ),
  yellow(
    code: 'g',
    name: 'Yellow',
    light: PrimaryColors(primary: 0xFFFCC800, primaryForeground: 0xFF733E0A),
    dark: PrimaryColors(primary: 0xFFEFB100, primaryForeground: 0xFF733E0A),
  );

  @override
  final String code;
  final String name;
  final PrimaryColors light;
  final PrimaryColors dark;

  const PrimaryColor({required this.code, required this.name, required this.light, required this.dark});
}

final class PrimaryColors {
  final int primary;
  final int primaryForeground;

  const PrimaryColors({required this.primary, required this.primaryForeground});
}

enum FontFamily implements Code {
  geist(
    'a',
    'Geist',
    'A clean, modern sans-serif designed for developer tools and digital products.',
    VariableFontFormat(normal: 'Geist/Geist.ttf', italic: 'Geist/Geist-Italic.ttf'),
    .sans,
  ),
  inter(
    'b',
    'Inter',
    'Optimized for screen legibility; a dependable default for interfaces and body text.',
    VariableFontFormat(normal: 'Inter/Inter.ttf', italic: 'Inter/Inter-Italic.ttf'),
    .sans,
  ),
  notoSans(
    'c',
    'Noto Sans',
    'Wide multilingual coverage for products spanning many languages and scripts.',
    VariableFontFormat(normal: 'Noto_Sans/NotoSans.ttf', italic: 'Noto_Sans/NotoSans-Italic.ttf'),
    .sans,
  ),
  nunitoSans(
    'd',
    'Nunito Sans',
    'A balanced, lightly rounded sans-serif for friendly interfaces and body text.',
    VariableFontFormat(normal: 'Nunito_Sans/NunitoSans.ttf', italic: 'Nunito_Sans/NunitoSans-Italic.ttf'),
    .sans,
  ),
  figtree(
    'e',
    'Figtree',
    'A geometric sans-serif with a friendly tone for branding and interfaces.',
    VariableFontFormat(normal: 'Figtree/Figtree.ttf', italic: 'Figtree/Figtree-Italic.ttf'),
    .sans,
  ),
  roboto(
    'f',
    'Roboto',
    'A versatile workhorse sans-serif for dense interfaces and body text.',
    VariableFontFormat(normal: 'Roboto/Roboto.ttf', italic: 'Roboto/Roboto-Italic.ttf'),
    .sans,
  ),
  raleway(
    'g',
    'Raleway',
    'An elegant sans-serif best reserved for headings and display sizes.',
    VariableFontFormat(normal: 'Raleway/Raleway.ttf', italic: 'Raleway/Raleway-Italic.ttf'),
    .sans,
  ),
  dmSans(
    'h',
    'DM Sans',
    'A low-contrast geometric sans-serif for clean interfaces and small headings.',
    VariableFontFormat(normal: 'DM_Sans/DMSans.ttf', italic: 'DM_Sans/DMSans-Italic.ttf'),
    .sans,
  ),
  publicSans(
    'i',
    'Public Sans',
    'A neutral, accessible sans-serif well suited to long-form body text.',
    VariableFontFormat(normal: 'Public_Sans/PublicSans.ttf', italic: 'Public_Sans/PublicSans-Italic.ttf'),
    .sans,
  ),
  outfit(
    'j',
    'Outfit',
    'A uniform geometric sans-serif with strong presence for headings and logos.',
    VariableFontFormat(normal: 'Outfit/Outfit.ttf', italic: null),
    .sans,
  ),
  oxanium(
    'k',
    'Oxanium',
    'A semi-rounded, techy display face for gaming and futuristic branding.',
    VariableFontFormat(normal: 'Oxanium/Oxanium.ttf', italic: null),
    .sans,
  ),
  manrope(
    'l',
    'Manrope',
    'A semi-condensed geometric sans-serif that works for both interfaces and headings.',
    VariableFontFormat(normal: 'Manrope/Manrope.ttf', italic: null),
    .sans,
  ),
  spaceGrotesk(
    'm',
    'Space Grotesk',
    'A distinctive sans-serif for headings and technology-focused branding.',
    VariableFontFormat(normal: 'Space_Grotesk/SpaceGrotesk.ttf', italic: null),
    .sans,
  ),
  montserrat(
    'n',
    'Montserrat',
    'A geometric sans-serif inspired by urban signage; strong for headings and logos.',
    VariableFontFormat(normal: 'Montserrat/Montserrat.ttf', italic: 'Montserrat/Montserrat-Italic.ttf'),
    .sans,
  ),
  ibmPlexSans(
    'o',
    'IBM Plex Sans',
    'A neutral corporate sans-serif that reads well in interfaces and body text.',
    VariableFontFormat(normal: 'IBM_Plex_Sans/IBMPlexSans.ttf', italic: 'IBM_Plex_Sans/IBMPlexSans-Italic.ttf'),
    .sans,
  ),
  sourceSans3(
    'p',
    'Source Sans 3',
    'A clean sans-serif designed for user interfaces and long-form reading.',
    VariableFontFormat(normal: 'Source_Sans_3/SourceSans3.ttf', italic: 'Source_Sans_3/SourceSans3-Italic.ttf'),
    .sans,
  ),
  instrumentSans(
    'q',
    'Instrument Sans',
    'A versatile grotesque sans-serif for both interfaces and headings.',
    VariableFontFormat(
      normal: 'Instrument_Sans/InstrumentSans.ttf',
      italic: 'Instrument_Sans/InstrumentSans-Italic.ttf',
    ),
    .sans,
  ),
  atkinsonHyperlegible(
    'r',
    'Atkinson Hyperlegible',
    'A highly legible sans-serif designed for low-vision readers and accessible interfaces.',
    StaticFontFormat(
      normal: {
        400: 'Atkinson_Hyperlegible/AtkinsonHyperlegible-Regular.ttf',
        700: 'Atkinson_Hyperlegible/AtkinsonHyperlegible-Bold.ttf',
      },
      italic: {
        400: 'Atkinson_Hyperlegible/AtkinsonHyperlegible-Italic.ttf',
        700: 'Atkinson_Hyperlegible/AtkinsonHyperlegible-BoldItalic.ttf',
      },
    ),
    .sans,
  ),
  jetBrainsMono(
    's',
    'JetBrains Mono',
    'A monospaced face tuned for reading code in editors and terminals.',
    VariableFontFormat(
      normal: 'JetBrains_Mono/JetBrainsMono.ttf',
      italic: 'JetBrains_Mono/JetBrainsMono-Italic.ttf',
    ),
    .mono,
  ),
  geistMono(
    't',
    'Geist Mono',
    'A monospaced companion to Geist for code, data, and technical interfaces.',
    VariableFontFormat(normal: 'Geist_Mono/GeistMono.ttf', italic: 'Geist_Mono/GeistMono-Italic.ttf'),
    .mono,
  ),
  notoSerif(
    'u',
    'Noto Serif',
    'A multilingual serif for long-form reading across many languages.',
    VariableFontFormat(normal: 'Noto_Serif/NotoSerif.ttf', italic: 'Noto_Serif/NotoSerif-Italic.ttf'),
    .serif,
  ),
  robotoSlab(
    'v',
    'Roboto Slab',
    'A geometric slab serif that balances structure and readability for headings and body.',
    VariableFontFormat(normal: 'Roboto_Slab/RobotoSlab.ttf', italic: null),
    .serif,
  ),
  merriweather(
    'w',
    'Merriweather',
    'A sturdy serif designed for comfortable on-screen reading.',
    VariableFontFormat(normal: 'Merriweather/Merriweather.ttf', italic: 'Merriweather/Merriweather-Italic.ttf'),
    .serif,
  ),
  lora(
    'x',
    'Lora',
    'A well-balanced serif with calligraphic roots for body text and editorial content.',
    VariableFontFormat(normal: 'Lora/Lora.ttf', italic: 'Lora/Lora-Italic.ttf'),
    .serif,
  ),
  playfairDisplay(
    'y',
    'Playfair Display',
    'A high-contrast display serif for elegant headings and titles.',
    VariableFontFormat(
      normal: 'Playfair_Display/PlayfairDisplay.ttf',
      italic: 'Playfair_Display/PlayfairDisplay-Italic.ttf',
    ),
    .serif,
  ),
  ebGaramond(
    'z',
    'EB Garamond',
    'A classic old-style serif for refined, book-like body text.',
    VariableFontFormat(normal: 'EB_Garamond/EBGaramond.ttf', italic: 'EB_Garamond/EBGaramond-Italic.ttf'),
    .serif,
  ),
  instrumentSerif(
    'A',
    'Instrument Serif',
    'An elegant high-contrast display serif for expressive headings.',
    StaticFontFormat(
      normal: {400: 'Instrument_Serif/InstrumentSerif.ttf'},
      italic: {400: 'Instrument_Serif/InstrumentSerif-Italic.ttf'},
    ),
    .serif,
  );

  @override
  final String code;
  final String name;
  final String description;
  final FontFormat format;
  final FontFamilyCategory category;

  const FontFamily(this.code, this.name, this.description, this.format, this.category);
}

enum FontFamilyCategory { sans, serif, mono }

sealed class FontFormat {}

final class VariableFontFormat implements FontFormat {
  final String normal;
  final String? italic;

  const VariableFontFormat({required this.normal, required this.italic});
}

final class StaticFontFormat implements FontFormat {
  final Map<int, String> normal;
  final Map<int, String> italic;

  const StaticFontFormat({required this.normal, required this.italic});
}

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
  none('a', 'None', (xs2: 0, xs: 0, sm: 0, md: 0, lg: 0, xl: 0, xl2: 0, xl3: 0, pill: 0)),
  small('b', 'Small', (xs2: 3, xs: 4, sm: 6, md: 7, lg: 10, xl: 13, xl2: 16, xl3: 19, pill: 100)),
  medium('c', 'Medium', (xs2: 4, xs: 6, sm: 8, md: 10, lg: 14, xl: 18, xl2: 22, xl3: 26, pill: 100)),
  large('d', 'Large', (xs2: 6, xs: 8, sm: 11, md: 14, lg: 20, xl: 25, xl2: 31, xl3: 36, pill: 100));

  @override
  final String code;
  final String name;
  final BorderRadii radius;

  const Radius(this.code, this.name, this.radius);
}

typedef BorderRadii = ({
  double xs2,
  double xs,
  double sm,
  double md,
  double lg,
  double xl,
  double xl2,
  double xl3,
  double pill,
});

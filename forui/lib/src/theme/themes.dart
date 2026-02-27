import 'package:forui/forui.dart';

/// The Forui themes.
extension FThemes on Never {
  /// The [Neutral](https://ui.shadcn.com/docs/theming#neutral) theme.
  static final neutral = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Neutral Light Desktop',
        colors: FColors.neutralLight,
        typography: .inherit(colors: FColors.neutralLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Neutral Light Touch', colors: FColors.neutralLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Neutral Dark Desktop',
        colors: FColors.neutralDark,
        typography: .inherit(colors: FColors.neutralDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Neutral Dark Touch', colors: FColors.neutralDark),
    ),
  );

  /// The [Zinc](https://ui.shadcn.com/docs/theming#zinc) theme.
  static final zinc = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Zinc Light Desktop',
        colors: FColors.zincLight,
        typography: .inherit(colors: FColors.zincLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Zinc Light Touch', colors: FColors.zincLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Zinc Dark Desktop',
        colors: FColors.zincDark,
        typography: .inherit(colors: FColors.zincDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Zinc Dark Touch', colors: FColors.zincDark),
    ),
  );

  /// The [Slate](https://ui.shadcn.com/docs/theming#slate) theme.
  static final slate = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Slate Light Desktop',
        colors: FColors.slateLight,
        typography: .inherit(colors: FColors.slateLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Slate Light Touch', colors: FColors.slateLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Slate Dark Desktop',
        colors: FColors.slateDark,
        typography: .inherit(colors: FColors.slateDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Slate Dark Touch', colors: FColors.slateDark),
    ),
  );

  /// The [Blue](https://ui.shadcn.com/themes) theme.
  static final blue = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Blue Light Desktop',
        colors: FColors.blueLight,
        typography: .inherit(colors: FColors.blueLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Blue Light Touch', colors: FColors.blueLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Blue Dark Desktop',
        colors: FColors.blueDark,
        typography: .inherit(colors: FColors.blueDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Blue Dark Touch', colors: FColors.blueDark),
    ),
  );

  /// The [Green](https://ui.shadcn.com/themes) theme.
  static final green = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Green Light Desktop',
        colors: FColors.greenLight,
        typography: .inherit(colors: FColors.greenLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Green Light Touch', colors: FColors.greenLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Green Dark Desktop',
        colors: FColors.greenDark,
        typography: .inherit(colors: FColors.greenDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Green Dark Touch', colors: FColors.greenDark),
    ),
  );

  /// The [Orange](https://ui.shadcn.com/themes) theme.
  static final orange = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Orange Light Desktop',
        colors: FColors.orangeLight,
        typography: .inherit(colors: FColors.orangeLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Orange Light Touch', colors: FColors.orangeLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Orange Dark Desktop',
        colors: FColors.orangeDark,
        typography: .inherit(colors: FColors.orangeDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Orange Dark Touch', colors: FColors.orangeDark),
    ),
  );

  /// The [Red](https://ui.shadcn.com/themes) theme.
  static final red = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Red Light Desktop',
        colors: FColors.redLight,
        typography: .inherit(colors: FColors.redLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Red Light Touch', colors: FColors.redLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Red Dark Desktop',
        colors: FColors.redDark,
        typography: .inherit(colors: FColors.redDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Red Dark Touch', colors: FColors.redDark),
    ),
  );

  /// The [Rose](https://ui.shadcn.com/themes) theme.
  static final rose = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Rose Light Desktop',
        colors: FColors.roseLight,
        typography: .inherit(colors: FColors.roseLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Rose Light Touch', colors: FColors.roseLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Rose Dark Desktop',
        colors: FColors.roseDark,
        typography: .inherit(colors: FColors.roseDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Rose Dark Touch', colors: FColors.roseDark),
    ),
  );

  /// The [Violet](https://ui.shadcn.com/themes) theme.
  static final violet = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Violet Light Desktop',
        colors: FColors.violetLight,
        typography: .inherit(colors: FColors.violetLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Violet Light Touch', colors: FColors.violetLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Violet Dark Desktop',
        colors: FColors.violetDark,
        typography: .inherit(colors: FColors.violetDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Violet Dark Touch', colors: FColors.violetDark),
    ),
  );

  /// The [Yellow](https://ui.shadcn.com/themes) theme.
  static final yellow = FAutoThemeData(
    light: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Yellow Light Desktop',
        colors: FColors.yellowLight,
        typography: .inherit(colors: FColors.yellowLight, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Yellow Light Touch', colors: FColors.yellowLight),
    ),
    dark: () => FPlatformThemeData(
      desktop: () => FThemeData(
        debugLabel: 'Yellow Dark Desktop',
        colors: FColors.yellowDark,
        typography: .inherit(colors: FColors.yellowDark, desktop: true),
      ),
      touch: () => FThemeData(debugLabel: 'Yellow Dark Touch', colors: FColors.yellowDark),
    ),
  );
}

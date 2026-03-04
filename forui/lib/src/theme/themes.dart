import 'package:forui/forui.dart';

/// The Forui themes.
extension FThemes on Never {
  /// The [Neutral](https://ui.shadcn.com/docs/theming#neutral) theme.
  static final neutral = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Neutral Light Desktop', colors: FColors.neutralLight),
      touch: FThemeData(touch: true, debugLabel: 'Neutral Light Touch', colors: FColors.neutralLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Neutral Dark Desktop', colors: FColors.neutralDark),
      touch: FThemeData(touch: true, debugLabel: 'Neutral Dark Touch', colors: FColors.neutralDark),
    ),
  );

  /// The [Zinc](https://ui.shadcn.com/docs/theming#zinc) theme.
  static final zinc = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Zinc Light Desktop', colors: FColors.zincLight),
      touch: FThemeData(touch: true, debugLabel: 'Zinc Light Touch', colors: FColors.zincLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Zinc Dark Desktop', colors: FColors.zincDark),
      touch: FThemeData(touch: true, debugLabel: 'Zinc Dark Touch', colors: FColors.zincDark),
    ),
  );

  /// The [Slate](https://ui.shadcn.com/docs/theming#slate) theme.
  static final slate = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Slate Light Desktop', colors: FColors.slateLight),
      touch: FThemeData(touch: true, debugLabel: 'Slate Light Touch', colors: FColors.slateLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Slate Dark Desktop', colors: FColors.slateDark),
      touch: FThemeData(touch: true, debugLabel: 'Slate Dark Touch', colors: FColors.slateDark),
    ),
  );

  /// The [Blue](https://ui.shadcn.com/themes) theme.
  static final blue = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Blue Light Desktop', colors: FColors.blueLight),
      touch: FThemeData(touch: true, debugLabel: 'Blue Light Touch', colors: FColors.blueLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Blue Dark Desktop', colors: FColors.blueDark),
      touch: FThemeData(touch: true, debugLabel: 'Blue Dark Touch', colors: FColors.blueDark),
    ),
  );

  /// The [Green](https://ui.shadcn.com/themes) theme.
  static final green = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Green Light Desktop', colors: FColors.greenLight),
      touch: FThemeData(touch: true, debugLabel: 'Green Light Touch', colors: FColors.greenLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Green Dark Desktop', colors: FColors.greenDark),
      touch: FThemeData(touch: true, debugLabel: 'Green Dark Touch', colors: FColors.greenDark),
    ),
  );

  /// The [Orange](https://ui.shadcn.com/themes) theme.
  static final orange = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Orange Light Desktop', colors: FColors.orangeLight),
      touch: FThemeData(touch: true, debugLabel: 'Orange Light Touch', colors: FColors.orangeLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Orange Dark Desktop', colors: FColors.orangeDark),
      touch: FThemeData(touch: true, debugLabel: 'Orange Dark Touch', colors: FColors.orangeDark),
    ),
  );

  /// The [Red](https://ui.shadcn.com/themes) theme.
  static final red = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Red Light Desktop', colors: FColors.redLight),
      touch: FThemeData(touch: true, debugLabel: 'Red Light Touch', colors: FColors.redLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Red Dark Desktop', colors: FColors.redDark),
      touch: FThemeData(touch: true, debugLabel: 'Red Dark Touch', colors: FColors.redDark),
    ),
  );

  /// The [Rose](https://ui.shadcn.com/themes) theme.
  static final rose = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Rose Light Desktop', colors: FColors.roseLight),
      touch: FThemeData(touch: true, debugLabel: 'Rose Light Touch', colors: FColors.roseLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Rose Dark Desktop', colors: FColors.roseDark),
      touch: FThemeData(touch: true, debugLabel: 'Rose Dark Touch', colors: FColors.roseDark),
    ),
  );

  /// The [Violet](https://ui.shadcn.com/themes) theme.
  static final violet = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Violet Light Desktop', colors: FColors.violetLight),
      touch: FThemeData(touch: true, debugLabel: 'Violet Light Touch', colors: FColors.violetLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Violet Dark Desktop', colors: FColors.violetDark),
      touch: FThemeData(touch: true, debugLabel: 'Violet Dark Touch', colors: FColors.violetDark),
    ),
  );

  /// The [Yellow](https://ui.shadcn.com/themes) theme.
  static final yellow = (
    light: (
      desktop: FThemeData(touch: false, debugLabel: 'Yellow Light Desktop', colors: FColors.yellowLight),
      touch: FThemeData(touch: true, debugLabel: 'Yellow Light Touch', colors: FColors.yellowLight),
    ),
    dark: (
      desktop: FThemeData(touch: false, debugLabel: 'Yellow Dark Desktop', colors: FColors.yellowDark),
      touch: FThemeData(touch: true, debugLabel: 'Yellow Dark Touch', colors: FColors.yellowDark),
    ),
  );
}

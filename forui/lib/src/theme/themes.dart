import 'package:forui/forui.dart';

/// The Forui themes.
extension FThemes on Never {
  /// The [Neutral](https://ui.shadcn.com/docs/theming#neutral) theme.
  static final neutral = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Neutral Light Desktop', colors: FColors.neutralLight),
      touch: FThemeData(debugLabel: 'Neutral Light Touch', colors: FColors.neutralLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Neutral Dark Desktop', colors: FColors.neutralDark),
      touch: FThemeData(debugLabel: 'Neutral Dark Touch', colors: FColors.neutralDark),
    ),
  );

  /// The [Zinc](https://ui.shadcn.com/docs/theming#zinc) theme.
  static final zinc = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Zinc Light Desktop', colors: FColors.zincLight),
      touch: FThemeData(debugLabel: 'Zinc Light Touch', colors: FColors.zincLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Zinc Dark Desktop', colors: FColors.zincDark),
      touch: FThemeData(debugLabel: 'Zinc Dark Touch', colors: FColors.zincDark),
    ),
  );

  /// The [Slate](https://ui.shadcn.com/docs/theming#slate) theme.
  static final slate = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Slate Light Desktop', colors: FColors.slateLight),
      touch: FThemeData(debugLabel: 'Slate Light Touch', colors: FColors.slateLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Slate Dark Desktop', colors: FColors.slateDark),
      touch: FThemeData(debugLabel: 'Slate Dark Touch', colors: FColors.slateDark),
    ),
  );

  /// The [Blue](https://ui.shadcn.com/themes) theme.
  static final blue = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Blue Light Desktop', colors: FColors.blueLight),
      touch: FThemeData(debugLabel: 'Blue Light Touch', colors: FColors.blueLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Blue Dark Desktop', colors: FColors.blueDark),
      touch: FThemeData(debugLabel: 'Blue Dark Touch', colors: FColors.blueDark),
    ),
  );

  /// The [Green](https://ui.shadcn.com/themes) theme.
  static final green = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Green Light Desktop', colors: FColors.greenLight),
      touch: FThemeData(debugLabel: 'Green Light Touch', colors: FColors.greenLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Green Dark Desktop', colors: FColors.greenDark),
      touch: FThemeData(debugLabel: 'Green Dark Touch', colors: FColors.greenDark),
    ),
  );

  /// The [Orange](https://ui.shadcn.com/themes) theme.
  static final orange = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Orange Light Desktop', colors: FColors.orangeLight),
      touch: FThemeData(debugLabel: 'Orange Light Touch', colors: FColors.orangeLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Orange Dark Desktop', colors: FColors.orangeDark),
      touch: FThemeData(debugLabel: 'Orange Dark Touch', colors: FColors.orangeDark),
    ),
  );

  /// The [Red](https://ui.shadcn.com/themes) theme.
  static final red = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Red Light Desktop', colors: FColors.redLight),
      touch: FThemeData(debugLabel: 'Red Light Touch', colors: FColors.redLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Red Dark Desktop', colors: FColors.redDark),
      touch: FThemeData(debugLabel: 'Red Dark Touch', colors: FColors.redDark),
    ),
  );

  /// The [Rose](https://ui.shadcn.com/themes) theme.
  static final rose = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Rose Light Desktop', colors: FColors.roseLight),
      touch: FThemeData(debugLabel: 'Rose Light Touch', colors: FColors.roseLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Rose Dark Desktop', colors: FColors.roseDark),
      touch: FThemeData(debugLabel: 'Rose Dark Touch', colors: FColors.roseDark),
    ),
  );

  /// The [Violet](https://ui.shadcn.com/themes) theme.
  static final violet = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Violet Light Desktop', colors: FColors.violetLight),
      touch: FThemeData(debugLabel: 'Violet Light Touch', colors: FColors.violetLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Violet Dark Desktop', colors: FColors.violetDark),
      touch: FThemeData(debugLabel: 'Violet Dark Touch', colors: FColors.violetDark),
    ),
  );

  /// The [Yellow](https://ui.shadcn.com/themes) theme.
  static final yellow = (
    light: (
      desktop: FThemeData(desktop: true, debugLabel: 'Yellow Light Desktop', colors: FColors.yellowLight),
      touch: FThemeData(debugLabel: 'Yellow Light Touch', colors: FColors.yellowLight),
    ),
    dark: (
      desktop: FThemeData(desktop: true, debugLabel: 'Yellow Dark Desktop', colors: FColors.yellowDark),
      touch: FThemeData(debugLabel: 'Yellow Dark Touch', colors: FColors.yellowDark),
    ),
  );
}

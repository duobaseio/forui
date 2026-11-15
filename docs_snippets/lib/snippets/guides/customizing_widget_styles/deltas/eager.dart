import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

// {@snippet}
// light is a light neutral theme with a custom blue thumb color.
final light = FTheme.neutral.light.touch.copyWith(switchStyle: .delta(thumbColor: .delta([.base(Colors.blue)])));

// Bad: the modified light-themed switch is applied to the dark theme!
final bad = FTheme.neutral.dark.touch.copyWith(switchStyle: light.switchStyle);

// Good: the custom blue thumb color is applied to the dark theme.
final good = FTheme.neutral.dark.touch.copyWith(switchStyle: .delta(thumbColor: .delta([.base(Colors.blue)])));
// {@endsnippet}

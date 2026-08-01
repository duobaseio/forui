import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A repro for issue 1123: https://github.com/duobaseio/forui/issues/1123
///
/// The theme is rebuilt from scratch on every `setState` rather than being hoisted above the app. Toggling one tile
/// should not disturb the others: if [FThemeData] compares unequal, [FTheme] lerps between two identical themes and
/// every other checkbox flickers.
///
/// Switch between the modes to isolate the cause. Both allocate a new [FThemeData] per build; only [_Mode.sharedBarriers]
/// reuses the two styles that hold a closure, which is enough to make the themes compare equal and the flicker stop.
class Flicker extends StatefulWidget {
  const Flicker({super.key});

  @override
  State<Flicker> createState() => _FlickerState();
}

enum _Mode {
  /// A new [FThemeData] per build. [FDialogRouteStyle.inherit] and [FModalSheetStyle.inherit] each allocate a new
  /// `barrierFilter` closure, so the themes never compare equal.
  fresh('Fresh'),

  /// Identical, except the two closure-holding styles are reused.
  sharedBarriers('Shared barriers');

  final String label;

  const _Mode(this.label);
}

class _FlickerState extends State<Flicker> {
  // Reused by _Mode.sharedBarriers so that the only varying fields are held constant.
  static final _dialogRouteStyle = FDialogRouteStyle.inherit();
  static final _modalSheetStyle = FModalSheetStyle.inherit();

  _Mode _mode = .fresh;
  bool _protect = true;
  bool _lockOnLaunch = true;
  bool _blur = true;

  @override
  Widget build(BuildContext context) {
    final theme = _theme();
    return FTheme(
      data: theme,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            spacing: 8,
            children: [
              for (final mode in _Mode.values)
                FButton(
                  variant: _mode == mode ? .primary : .outline,
                  onPress: () => setState(() => _mode = mode),
                  child: Text(mode.label),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text('theme == theme: ${_theme() == _theme()}'),
          ),
          FTileGroup(
            children: [
              _tile('Protect', _protect, (value) => _protect = value),
              _tile('Always lock on launch', _lockOnLaunch, (value) => _lockOnLaunch = value),
              _tile('Blur in app switcher', _blur, (value) => _blur = value),
            ],
          ),
        ],
      ),
    );
  }

  FThemeData _theme() => switch (_mode) {
    .fresh => FThemeData(colors: FColors.neutralLight, touch: true),
    .sharedBarriers => FThemeData(
      colors: FColors.neutralLight,
      touch: true,
      dialogRouteStyle: _dialogRouteStyle,
      modalSheetStyle: _modalSheetStyle,
    ),
  };

  FTileMixin _tile(String title, bool value, ValueChanged<bool> onChange) => FTile(
    title: Text(title),
    suffix: IgnorePointer(child: FCheckbox(value: value)),
    onPress: () => setState(() => onChange(!value)),
  );
}

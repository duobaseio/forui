import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import '../selection.dart';
import 'copyable.dart';
import 'dialogs.dart';
import 'sidebar.dart';

/// The sidebar's footer: preset code, load/shuffle/reset/settings actions, and the get-code call to action.
class Footer extends StatelessWidget {
  final Selection selection;
  final ThemeMode mode;
  final ValueChanged<ThemeMode> onModeChanged;
  final VoidCallback onShuffle;
  final VoidCallback onReset;
  final ValueChanged<Selection> onLoad;

  const Footer({
    required this.selection,
    required this.mode,
    required this.onModeChanged,
    required this.onShuffle,
    required this.onReset,
    required this.onLoad,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final code = selection.encode();

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const FDivider(style: .delta(padding: .value(.only(bottom: 12)))),
        Padding(
          padding: sidebarHInset,
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 8,
            children: [
              Copyable(
                text: '--preset $code',
                builder: (context, copied, copy) => FButton(
                  key: const ValueKey('copy-preset'),
                  variant: .outline,
                  onPress: copy,
                  child: Text(
                    copied ? 'Copied' : '--preset $code',
                    style: theme.typography.body.sm.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                ),
              ),
              FButton(
                variant: .outline,
                onPress: () async {
                  final selection = await showFDialog<Selection>(
                    context: context,
                    builder: (context, _, animation) => LoadPresetDialog(animation: animation),
                  );
                  if (selection != null) {
                    onLoad(selection);
                  }
                },
                child: const Text('Load Preset'),
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FButton(
                      variant: .outline,
                      prefix: const Icon(FLucideIcons.shuffle),
                      onPress: onShuffle,
                      child: const Text('Shuffle'),
                    ),
                  ),
                  FButton.icon(
                    key: const ValueKey('reset'),
                    variant: .outline,
                    onPress: onReset,
                    child: const Icon(FLucideIcons.rotateCcw),
                  ),
                ],
              ),
              FButton(
                variant: .outline,
                prefix: const Icon(FLucideIcons.settings),
                onPress: () => showFDialog(
                  context: context,
                  builder: (context, _, animation) =>
                      SettingsDialog(animation: animation, mode: mode, onModeChanged: onModeChanged),
                ),
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
        const FDivider(style: .delta(padding: .value(.symmetric(vertical: 12)))),
        Padding(
          padding: sidebarHInset.add(const .only(bottom: 16)),
          child: FButton(
            onPress: () => showFDialog(
              context: context,
              builder: (context, _, animation) => GetCodeDialog(code: code, animation: animation),
            ),
            child: const Text('Get Code'),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import '../selection.dart';
import 'controls.dart';
import 'copyable.dart';

class _DialogHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final FDialogStyle style;

  const _DialogHeader({required this.title, required this.subtitle, required this.style});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: .start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(title, style: style.titleTextStyle),
            const SizedBox(height: 4),
            Text(subtitle, style: style.bodyTextStyle),
          ],
        ),
      ),
      FButton.icon(
        key: const ValueKey('close-dialog'),
        variant: .ghost,
        size: .xs,
        onPress: () => Navigator.of(context).pop(),
        child: Icon(FLucideIcons.x, size: 16, color: context.theme.colors.mutedForeground),
      ),
    ],
  );
}

/// The dialog for get code.
class GetCodeDialog extends StatelessWidget {
  final String code;
  final Animation<double> animation;

  const GetCodeDialog({required this.code, required this.animation, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final command = 'flutter pub add forui\ndart run forui init --preset $code';
    final mono = theme.typography.body.sm.copyWith(fontFamily: 'JetBrains Mono', color: theme.colors.foreground);

    return FDialog(
      animation: animation,
      constraints: const BoxConstraints.tightFor(width: 420),
      builder: (context, style) => Padding(
        padding: const .all(20),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            _DialogHeader(
              title: 'Get Code',
              subtitle: 'Run this in your Flutter project to apply the theme.',
              style: style,
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.secondary,
                borderRadius: theme.style.borderRadius.md,
                border: Border.all(color: theme.colors.border),
              ),
              child: Padding(
                padding: const .fromLTRB(12, 12, 8, 12),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(child: Text(command, style: mono)),
                    Copyable(
                      text: command,
                      builder: (context, copied, copy) => FButton.icon(
                        variant: .ghost,
                        size: .xs,
                        onPress: copy,
                        child: Icon(
                          copied ? FLucideIcons.check : FLucideIcons.copy,
                          size: 16,
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Copyable(
              text: command,
              builder: (context, copied, copy) => FButton(
                key: const ValueKey('copy-command'),
                onPress: copy,
                child: Text(copied ? 'Copied' : 'Copy Command'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The dialog for load preset.
class LoadPresetDialog extends StatefulWidget {
  final Animation<double> animation;

  const LoadPresetDialog({required this.animation, super.key});

  @override
  State<LoadPresetDialog> createState() => _LoadPresetDialogState();
}

class _LoadPresetDialogState extends State<LoadPresetDialog> {
  Selection? _parsed;

  @override
  Widget build(BuildContext context) => FDialog(
    animation: widget.animation,
    constraints: const BoxConstraints.tightFor(width: 420),
    builder: (context, style) => Padding(
      padding: const .all(20),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          _DialogHeader(title: 'Load Preset', subtitle: 'Paste a preset code to apply a saved theme.', style: style),
          const SizedBox(height: 16),
          FTextField(
            key: const ValueKey('load-preset-code'),
            autofocus: true,
            hint: 'aabbbc or --preset aabbbc',
            control: .managed(onChange: (value) => setState(() => _parsed = _parse(value.text))),
            onSubmit: (_) => _load(context),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: .end,
            spacing: 8,
            children: [
              FButton(variant: .outline, onPress: () => Navigator.of(context).pop(), child: const Text('Cancel')),
              FButton(onPress: _parsed == null ? null : () => _load(context), child: const Text('Load')),
            ],
          ),
        ],
      ),
    ),
  );

  void _load(BuildContext context) {
    if (_parsed case final selection?) {
      Navigator.of(context).pop(selection);
    }
  }

  static Selection? _parse(String input) {
    final code = input.trim().replaceFirst(RegExp(r'^--preset\s+'), '');
    if (code.isEmpty) {
      return null;
    }
    try {
      return Selection.decode(code);
    } on FormatException {
      return null;
    }
  }
}

/// The settings dialog.
class SettingsDialog extends StatefulWidget {
  final Animation<double> animation;
  final ThemeMode mode;
  final ValueChanged<ThemeMode> onModeChanged;

  const SettingsDialog({required this.animation, required this.mode, required this.onModeChanged, super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late ThemeMode _mode = widget.mode;

  @override
  Widget build(BuildContext context) => FDialog(
    animation: widget.animation,
    constraints: const BoxConstraints.tightFor(width: 420),
    builder: (context, style) => Padding(
      padding: const .all(20),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          _DialogHeader(title: 'Settings', subtitle: 'Configure Forui Create.', style: style),
          const SizedBox(height: 16),
          FSelect<ThemeMode>.rich(
            key: const ValueKey('theme-mode'),
            label: const Text('Theme'),
            format: _name,
            control: .lifted(
              value: _mode,
              onChange: (mode) {
                if (mode != null) {
                  setState(() => _mode = mode);
                  widget.onModeChanged(mode);
                }
              },
            ),
            prefixBuilder: (context, style, _) => fieldPrefix(
              Icon(switch (_mode) {
                ThemeMode.system => FLucideIcons.monitor,
                ThemeMode.light => FLucideIcons.sun,
                ThemeMode.dark => FLucideIcons.moon,
              }, color: context.theme.colors.mutedForeground),
            ),
            children: [
              for (final (icon, mode) in [
                (FLucideIcons.monitor, ThemeMode.system),
                (FLucideIcons.sun, ThemeMode.light),
                (FLucideIcons.moon, ThemeMode.dark),
              ])
                .item(
                  prefix: Icon(icon, color: context.theme.colors.mutedForeground),
                  title: Text(_name(mode)),
                  value: mode,
                ),
            ],
          ),
        ],
      ),
    ),
  );

  static String _name(ThemeMode mode) => switch (mode) {
    ThemeMode.system => 'System',
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
  };
}

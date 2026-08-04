import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show SelectionArea, ThemeMode;
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Widget build(BuildContext context) => FDialog(
    animation: animation,
    constraints: const BoxConstraints.tightFor(width: 420),
    builder: (context, style) => SelectionArea(
      child: Padding(
        padding: const .all(20),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            _DialogHeader(
              title: 'Get Code',
              subtitle: 'Run these commands in your Flutter project to apply the theme.',
              style: style,
            ),
            const SizedBox(height: 16),
            const _Command(title: '1. Install Forui', command: 'flutter pub add forui'),
            const SizedBox(height: 16),
            _Command(title: '2. Initialize Forui with theme', command: 'dart run forui init --preset $code'),
            const SizedBox(height: 20),
            const _Support(),
          ],
        ),
      ),
    ),
  );
}

class _Command extends StatelessWidget {
  final String title;
  final String command;

  const _Command({required this.title, required this.command});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final mono = theme.typography.body.sm.copyWith(fontFamily: 'JetBrains Mono', color: theme.colors.foreground);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Text(title, style: theme.typography.body.sm.copyWith(fontWeight: .w600, color: theme.colors.foreground)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.secondary,
            borderRadius: theme.style.borderRadius.md,
            border: Border.all(color: theme.colors.border),
          ),
          child: Padding(
            padding: const .fromLTRB(12, 8, 8, 8),
            child: Row(
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
      ],
    );
  }
}

class _Support extends StatefulWidget {
  const _Support();

  @override
  State<_Support> createState() => _SupportState();
}

class _SupportState extends State<_Support> {
  late TapGestureRecognizer _github;
  late TapGestureRecognizer _pub;

  @override
  void initState() {
    super.initState();
    _github = TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse('https://github.com/duobaseio/forui'));
    _pub = TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse('https://pub.dev/packages/forui'));
  }

  @override
  Widget build(BuildContext context) {
    final link = TextStyle(color: context.theme.colors.foreground, decoration: TextDecoration.underline);

    return FAlert(
      liveRegion: false,
      style: .delta(titleTextStyle: .delta(fontWeight: .w600)),
      icon: const Icon(FLucideIcons.heart),
      title: const Text('Enjoying Forui?'),
      subtitle: Padding(
        padding: const .only(top: 4),
        child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Support the project by starring the repo on '),
              TextSpan(text: 'GitHub', style: link, recognizer: _github, mouseCursor: SystemMouseCursors.click),
              const TextSpan(text: ' and liking it on '),
              TextSpan(text: 'pub.dev', style: link, recognizer: _pub, mouseCursor: SystemMouseCursors.click),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _github.dispose();
    _pub.dispose();
    super.dispose();
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
    builder: (context, style) => SelectionArea(
      child: Padding(
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
    builder: (context, style) => SelectionArea(
      child: Padding(
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
    ),
  );

  static String _name(ThemeMode mode) => switch (mode) {
    ThemeMode.system => 'System',
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
  };
}

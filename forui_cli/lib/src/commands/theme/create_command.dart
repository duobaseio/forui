import 'dart:io';

import 'package:forui_cli/src/codec.dart';
import 'package:forui_cli/src/components/autocomplete.dart';
import 'package:forui_cli/src/components/log.dart';
import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/preset/theme.dart';
import 'package:forui_cli/src/terminal/command.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';

class ThemeCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create a Forui theme file from a preset code, or interactively.';

  @override
  final arguments = '';

  final Configuration configuration;

  ThemeCreateCommand(this.configuration) {
    argParser
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption('preset', abbr: 'p', help: 'A 6-character code for the theme.')
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: configuration.theme,
      );
  }

  @override
  Future<void> run() async {
    final interactive = terminal.interactive && !globalResults!.flag('no-input');
    final force = argResults!.flag('force');
    final output = argResults!['output'] as String;
    final code = argResults!['preset'] as String?;

    if (argResults!.rest.isNotEmpty) {
      terminal.error(
        'Unexpected argument "${argResults!.rest.first}". Pass --preset <preset> or run without arguments.\n',
      );
      exit(1);
    }

    Preset? preset;
    if (code != null) {
      try {
        preset = Preset.decode(code);
      } on FormatException catch (e) {
        terminal.error('Invalid preset: ${e.message}\n');
        exit(1);
      }
    } else if (!interactive) {
      terminal.error('Theme creation requires --preset when --no-input is set.\n');
      exit(1);
    }

    if (interactive) {
      intro('Create a Forui theme');

      // Build the preset interactively when --preset wasn't given. Each prompt exits with 130 if cancelled.
      if (preset == null) {
        // The base palette's mid-tone reads its tint better than the near-black primary, so use it for the swatch.
        final base = _require(
          select<BaseColor>(
            message: 'Base color',
            options: [
              for (final base in BaseColor.values)
                SelectOption(base, label: base.name, swatch: base.light.mutedForeground),
            ],
            initialValue: .neutral,
          ),
        );

        final primary = _require(
          select<PrimaryColor?>(
            message: 'Primary color',
            options: <SelectOption<PrimaryColor?>>[
              // 'None' inherits the base colour, so show the chosen base's swatch beside it.
              SelectOption(null, label: 'None', hint: 'use base', swatch: base.light.mutedForeground),
              for (final primary in PrimaryColor.values)
                SelectOption(primary, label: primary.name, swatch: primary.light.primary),
            ],
          ),
        );

        // Group the fonts by category for the autocomplete's subgroup headers.
        final fonts = <String, List<SelectOption<FontFamily>>>{};
        for (final font in FontFamily.values) {
          final group = switch (font.category) {
            FontFamilyCategory.sans => 'Sans',
            FontFamilyCategory.serif => 'Serif',
            FontFamilyCategory.mono => 'Mono',
          };
          (fonts[group] ??= []).add(SelectOption(font, label: font.name, hint: font.url));
        }

        final display = _require(autocomplete<FontFamily>(message: 'Display font', options: fonts, maxItems: 27));
        final body = _require(autocomplete<FontFamily>(message: 'Body font', options: fonts, maxItems: 27));

        final icon = _require(
          select<IconLibrary>(
            message: 'Icon library',
            options: [for (final icon in IconLibrary.values) SelectOption(icon, label: icon.name, hint: icon.url)],
            initialValue: .lucide,
          ),
        );

        final radius = _require(
          select<Radius>(
            message: 'Border radius',
            options: [for (final radius in Radius.values) SelectOption(radius, label: radius.name)],
            initialValue: .medium,
          ),
        );

        preset = Preset(base: base, primary: primary, display: display, body: body, icon: icon, radius: radius);
      }
    }

    // preset is non-null here: the wizard fills it when interactive, and a non-interactive run is required to pass one.
    await create(configuration, preset!, force: force, interactive: interactive, output: output);

    if (interactive) {
      outro('Theme created!');
    }
  }

  /// Returns the value of [result], or cancels the wizard and exits if the user cancelled.
  T _require<T>(Result<T> result) {
    if (result case Value(:final value)) {
      return value;
    }

    cancel('No theme created.');
    exit(130);
  }
}

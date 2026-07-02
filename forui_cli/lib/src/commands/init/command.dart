import 'dart:io';

import 'package:yaml/yaml.dart';

import 'package:forui_cli/src/codec.dart';
import 'package:forui_cli/src/commands/snippet/snippet.dart';
import 'package:forui_cli/src/components/autocomplete.dart';
import 'package:forui_cli/src/components/confirm.dart';
import 'package:forui_cli/src/components/log.dart';
import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/preset/theme.dart';
import 'package:forui_cli/src/terminal/command.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/theme.dart';

const _placeholderImport = "import 'theme.dart';";

class InitCommand extends ForuiCommand {
  @override
  final name = 'init';

  @override
  final aliases = ['initialize'];

  @override
  final description = 'Initialize this project to use Forui.';

  @override
  final arguments = '';

  final Configuration configuration;

  InitCommand(this.configuration) {
    argParser
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption('preset', abbr: 'p', help: "A theme's code.")
      ..addOption(
        'template',
        abbr: 't',
        help: 'The main.dart template to generate. Defaults to "basic".',
        allowed: ['basic', 'router'],
      );
  }

  @override
  Future<void> run() async {
    ansi.enabled = globalResults!.flag('color');
    truecolor.enabled = globalResults!.flag('color');
    terminal.interactive = !globalResults!.flag('no-input');
    final force = argResults!.flag('force');
    final code = argResults!['preset'] as String?;
    var template = argResults!['template'] as String?;

    if (argResults!.rest.isNotEmpty) {
      terminal.writeErrorln(
        'Unexpected argument "${argResults!.rest.first}". Pass --preset <preset> or run without arguments.',
      );
      exit(1);
    }

    Preset? preset;
    if (code != null) {
      try {
        preset = Preset.decode(code);
      } on FormatException catch (e) {
        terminal.writeErrorln('Invalid preset: ${e.message}');
        exit(1);
      }
    } else if (!terminal.interactive) {
      // Non-interactive with no preset falls back to the default theme so init always produces a working project.
      preset = const Preset();
    }

    if (terminal.interactive) {
      terminal.intro('Initialize Forui');

      template ??= _require(
        select<String>(
          message: 'Main template',
          options: [
            SelectOption('basic', label: 'Basic', hint: 'A minimal Forui app entry point'),
            SelectOption('router', label: 'Router', hint: 'A Forui app entry point using MaterialApp.router'),
          ],
          initial: 'basic',
        ),
      );

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
            initial: .neutral,
          ),
        );

        final primary = _require(
          select<PrimaryColor?>(
            message: 'Primary color',
            options: [
              // 'None' inherits the base colour, so show the chosen base's swatch beside it.
              SelectOption(null, label: 'None (${base.name})', swatch: base.light.mutedForeground),
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

        terminal.note(
          'Display fonts set headings and large text. Pick for character:\n'
          'serifs and geometric sans add personality, and detail shows at size.\n'
          '\n'
          'Body fonts set paragraphs and UI. Pick for legibility:\n'
          'a neutral sans with open, even letterforms reads best when small.\n'
          '\n'
          'Pair a characterful display with a plain body, or use one sans for both.\n'
          '\n'
          'See https://fonts.google.com/knowledge/choosing_type for more information on choosing & pairing fonts.',
          title: 'Choosing fonts',
        );

        final display = _require(
          autocomplete<FontFamily>(message: 'Display font', options: fonts, initial: .inter, maxItems: 27),
        );
        final body = _require(
          autocomplete<FontFamily>(message: 'Body font', options: fonts, initial: .inter, maxItems: 27),
        );

        final icon = _require(
          select<IconLibrary>(
            message: 'Icon library',
            options: [for (final icon in IconLibrary.values) SelectOption(icon, label: icon.name, hint: icon.url)],
            initial: .lucide,
          ),
        );

        final radius = _require(
          select<Radius>(
            message: 'Border radius',
            options: [for (final radius in Radius.values) SelectOption(radius, label: radius.name)],
            initial: .medium,
          ),
        );

        preset = Preset(base: base, primary: primary, display: display, body: body, icon: icon, radius: radius);
      }
    }

    // preset is non-null here: the wizard fills it when interactive, and a non-interactive run defaults it above.
    _configuration(force: force);
    await create(configuration, preset!, force: force, output: configuration.theme);
    _main(template: template ?? 'basic', force: force);

    if (terminal.interactive) {
      terminal.outro('Forui initialized!');
    }
  }

  void _configuration({required bool force}) {
    final yaml = File('${configuration.root.path}/forui.yaml');
    final yml = File('${configuration.root.path}/forui.yml');
    final file = yaml.existsSync() ? yaml : (yml.existsSync() ? yml : yaml);

    if (!force && (yaml.existsSync() || yml.existsSync())) {
      // Non-interactive runs can't prompt, so a conflict is a hard error; interactive runs ask.
      if (!terminal.interactive) {
        terminal.writeErrorln('${file.path} already exists; pass --force to overwrite.');
        exit(1);
      }

      if (!confirm(message: 'Overwrite ${Uri.file(file.path)}?', initial: false)) {
        terminal.cancel('Forui not initialized.');
        exit(130);
      }
    }

    file.writeAsStringSync(defaults);
    _created(file);
  }

  void _main({required String template, required bool force}) {
    final file = File('${configuration.root.path}/lib/main.dart');

    if (!force && file.existsSync()) {
      // Non-interactive runs can't prompt, so a conflict is a hard error; interactive runs ask.
      if (!terminal.interactive) {
        terminal.writeErrorln('${file.path} already exists; pass --force to overwrite.');
        exit(1);
      }

      if (!confirm(message: 'Overwrite ${Uri.file(file.path)}?', initial: false)) {
        terminal.cancel('Forui not initialized.');
        exit(130);
      }
    }

    // The package: import for the generated theme.
    final theme = configuration.theme.endsWith('.dart') ? configuration.theme : '${configuration.theme}/theme.dart';
    final package = (loadYaml(File('${configuration.root.path}/pubspec.yaml').readAsStringSync()) as YamlMap)['name'];
    final path = theme.startsWith('lib/') ? theme.substring('lib/'.length) : theme;

    final main = init[template]!.$2.replaceFirst(_placeholderImport, "import 'package:$package/$path';");

    file
      ..createSync(recursive: true)
      ..writeAsStringSync(formatter.format(main));
    _created(file);
  }

  void _created(File file) {
    final message = 'Created ${Uri.file(file.absolute.path)}';
    if (terminal.interactive) {
      terminal.success(message);
    } else {
      terminal.writeln(message);
    }
  }

  /// Returns the value of [result], or cancels the wizard and exits if the user cancelled.
  T _require<T>(Result<T> result) {
    if (result case Value(:final value)) {
      return value;
    }

    terminal.cancel('Forui not initialized.');
    exit(130);
  }
}

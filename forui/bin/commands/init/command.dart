import 'dart:io';

import 'package:forui/src/create/codec.dart';
import 'package:yaml/yaml.dart';

import '../../args/command.dart';
import '../../args/prompts.dart';
import '../../configuration.dart';
import '../snippet/snippet.dart';
import '../../preset/create.dart';
import '../../preset/wizard.dart';

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
      ..addOption('preset', abbr: 'p', help: 'A 6-character code for the theme (see create.forui.dev).')
      ..addOption(
        'template',
        abbr: 't',
        help: 'The main.dart template to generate.',
        allowed: ['basic', 'router'],
        defaultsTo: 'basic',
      );
  }

  @override
  Future<void> run() async {
    try {
      final input = !globalResults!.flag('no-input');
      final force = argResults!.flag('force');
      final template = argResults!['template'] as String;
      final preset = switch (argResults!['preset'] as String?) {
        final code? => Preset.decode(code),
        _ when input => wizard(),
        _ => const Preset(),
      };

      final config = _configuration(input: input, force: force)..writeAsStringSync(defaults);
      stdout.writeln('${emoji ? '✅' : '[Done]'} Created ${Uri.file(config.absolute.path)}.');

      await create(configuration, preset, input: input, force: force, output: configuration.theme);

      _main(template: template, input: input, force: force);
    } on FormatException catch (e) {
      stdout.writeln('Invalid preset code: ${e.message}');
    }
  }

  File _configuration({required bool input, required bool force}) {
    final yaml = File('${configuration.root.path}/forui.yaml');
    final yml = File('${configuration.root.path}/forui.yml');

    if (force) {
      return yaml;
    }

    if (yaml.existsSync() || yml.existsSync()) {
      final file = yaml.existsSync() ? yaml : yml;
      confirm(file, input: input);
      return file;
    }

    return yaml;
  }

  void _main({required String template, required bool input, required bool force}) {
    final file = File('${configuration.root.path}/lib/main.dart');

    if (!force && file.existsSync()) {
      confirm(
        file,
        input: input,
        message: 'You can generate a main.dart later by running "dart forui snippet create main-basic/main-router". ',
      );
    }

    // The package: import for the generated theme.
    final theme = configuration.theme.endsWith('.dart') ? configuration.theme : '${configuration.theme}/theme.dart';
    final package = (loadYaml(File('${configuration.root.path}/pubspec.yaml').readAsStringSync()) as YamlMap)['name'];
    final path = theme.startsWith('lib/') ? theme.substring('lib/'.length) : theme;

    final main = init[template]!.$2.replaceFirst(_placeholderImport, "import 'package:$package/$path';");

    file.writeAsStringSync(formatter.format(main));
    stdout.writeln('${emoji ? '✅' : '[Done]'} Created ${Uri.file(file.absolute.path)}.');
  }
}

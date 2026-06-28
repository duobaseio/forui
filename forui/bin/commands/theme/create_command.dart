import 'dart:io';

import '../../args/command.dart';
import '../../args/prompts.dart';
import '../../configuration.dart';
import '../../preset/create.dart';
import '../../preset/wizard.dart';

class ThemeCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Creates a Forui theme file from a preset code, or interactively.';

  @override
  final arguments = '';

  final Configuration configuration;

  ThemeCreateCommand(this.configuration) {
    argParser
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption('preset', abbr: 'p', help: 'A 6-character preset for the theme (see create.forui.dev).')
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: configuration.theme,
      );
  }

  @override
  Future<void> run() async {
    final input = !globalResults!.flag('no-input');
    final force = argResults!.flag('force');
    final output = argResults!['output'] as String;
    final code = argResults!['preset'] as String?;

    if (argResults!.rest.isNotEmpty) {
      stdout.writeln(
        'Unexpected argument "${argResults!.rest.first}". Pass --preset <preset> or run without arguments.',
      );
      exit(1);
    }

    if (code != null) {
      try {
        return await create(configuration, .decode(code), input: input, force: force, output: output);
      } on FormatException catch (e) {
        stdout.writeln('Invalid preset: ${e.message}');
        exit(1);
      }
    }

    if (!input) {
      stdout.writeln('Theme creation requires --preset when --no-input is set.');
      exit(1);
    }

    requireTerminal();
    await create(configuration, wizard(), input: input, force: force, output: output);
  }
}

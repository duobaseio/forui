import 'dart:io';

import '../../args/command.dart';
import '../../commands/snippet/snippet.dart';
import '../../configuration.dart';

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
      ..addOption(
        'template',
        abbr: 't',
        help: 'The main.dart template to generate.',
        allowed: ['basic', 'router'],
        defaultsTo: 'basic',
      );
  }

  @override
  void run() {
    final template = argResults!['template'] as String;

    final config = _configuration()..writeAsStringSync(defaults);
    stdout.writeln('${emoji ? '✅' : '[Done]'} Created ${Uri.file(config.absolute.path)}.');

    final main = _main()..writeAsStringSync(formatter.format(snippets['main-$template']!.$2));
    stdout.writeln('${emoji ? '✅' : '[Done]'} Created ${Uri.file(main.absolute.path)}.');
  }

  File _configuration() {
    final force = argResults!.flag('force');

    final yaml = File('${configuration.root.path}/forui.yaml');
    final yml = File('${configuration.root.path}/forui.yml');

    var file = yaml;
    if (force) {
      return file;
    }

    if (yaml.existsSync() || yml.existsSync()) {
      file = yaml.existsSync() ? yaml : yml;

      _prompt(file);
    }

    return file;
  }

  File _main() {
    final force = argResults!.flag('force');

    final file = File('${configuration.root.path}/lib/main.dart');
    if (force) {
      return file;
    }

    if (file.existsSync()) {
      _prompt(
        file,
        'You can generate a main.dart later by running "dart forui snippet create main-basic/main-router". ',
      );
    }

    return file;
  }

  void _prompt(File file, [String message = '']) {
    final input = !globalResults!.flag('no-input');
    final uri = Uri.file(file.absolute.path);

    if (!input) {
      stdout.writeln('$uri already exists. Skipping... ');
      exit(0);
    }

    while (true) {
      stdout.write('${emoji ? '⚠️' : '[Warning]'} $uri already exists. ${message}Overwrite it? [Y/n] ');

      switch (stdin.readLineSync()) {
        case 'y' || 'Y' || '':
          return;
        case 'n' || 'N':
          exit(0);
        default:
          stdout.writeln('Invalid option. Please enter enter either "y" or "n".');
      }
    }
  }
}

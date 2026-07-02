import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:forui_cli/src/commands/init/command.dart';
import 'package:forui_cli/src/commands/snippet/command.dart';
import 'package:forui_cli/src/commands/style/command.dart';
import 'package:forui_cli/src/commands/theme/command.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/command.dart';
import 'package:forui_cli/src/terminal/terminal.dart';

Future<void> main(List<String> arguments) async {
  final configuration = Configuration.parse();

  final runner = ForuiCommandRunner('forui', 'Manage your Forui development environment.')
    ..addCommand(InitCommand(configuration))
    ..addCommand(SnippetCommand(configuration))
    ..addCommand(StyleCommand(configuration))
    ..addCommand(ThemeCommand(configuration));

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    terminal.writeError(e.toString());
    exit(127);
  }
}

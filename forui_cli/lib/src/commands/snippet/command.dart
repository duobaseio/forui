import 'package:forui_cli/src/commands/snippet/create_command.dart';
import 'package:forui_cli/src/commands/snippet/ls_command.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/command.dart';

class SnippetCommand extends ForuiCommand {
  @override
  final name = 'snippet';

  @override
  final aliases = ['sn'];

  @override
  final description = 'Manage your code snippets.';

  SnippetCommand(Configuration configuration) {
    addSubcommand(SnippetCreateCommand(configuration));
    addSubcommand(SnippetLsCommand());
  }
}

import 'dart:io';

import 'package:forui_cli/src/commands/snippet/snippet.dart';
import 'package:forui_cli/src/terminal/command.dart';

class SnippetLsCommand extends ForuiCommand {
  @override
  final name = 'ls';

  @override
  final aliases = ['list'];

  @override
  final description = 'List all snippets.';

  @override
  final String arguments = '';

  @override
  void run() => (snippets.keys.toList()..sort()).forEach(stdout.writeln);
}

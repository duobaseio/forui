import 'dart:io';

import 'package:forui_cli/src/commands/snippet/snippet.dart';
import 'package:forui_cli/src/components/confirm.dart';
import 'package:forui_cli/src/components/log.dart';
import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/command.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';

class SnippetCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create code snippet files.';

  @override
  final arguments = '[snippet]';

  final Configuration configuration;

  SnippetCreateCommand(this.configuration) {
    argParser
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: configuration.snippet,
      );
  }

  @override
  void run() {
    final output = argResults!['output'] as String;
    final interactive = terminal.interactive && !globalResults!.flag('no-input');
    final arguments = argResults!.rest;

    if (arguments.length > 1) {
      terminal.error('Only one snippet can be created at a time.\n');
      exit(1);
    }

    // `select` auto-returns the first option when not interactive, so a script would silently scaffold it. Error instead.
    if (arguments.isEmpty && !interactive) {
      terminal.error('No snippet specified. Run "forui snippet ls" to see all snippets.\n');
      exit(1);
    }

    if (arguments.isNotEmpty) {
      final snippet = arguments.first;
      if (!_validate(snippet)) {
        exit(1);
      }

      // Non-interactive runs emit a plain line instead of an interactive box.
      if (!interactive) {
        terminal.write('Created ${_generate(snippet, output: output, interactive: false)}\n');
        return;
      }
    }

    intro('Create code snippet');

    final snippet = arguments.isEmpty
        ? switch (select<String>(
            message: 'Snippet',
            options: [
              for (final name in snippets.keys.toList()..sort()) SelectOption(name, hint: '(${snippets[name]!.$2})'),
            ],
          )) {
            Value(:final value) => value,
            Cancelled() => null,
          }
        : arguments.first;

    if (snippet == null) {
      cancel('No snippet created.');
      exit(130);
    }

    outro('Created ${_generate(snippet, output: output, interactive: true)}');
  }

  bool _validate(String snippet) {
    if (snippets.containsKey(snippet.toLowerCase())) {
      return true;
    }

    final suggestions =
        snippets.keys.map((e) => (e, e.startsWith(snippet) ? 1 : distance(snippet, e))).where((e) => e.$2 <= 3).toList()
          ..sort((a, b) => a.$2.compareTo(b.$2));

    final buffer = StringBuffer('Could not find a code snippet named "$snippet".');
    if (suggestions.isNotEmpty) {
      buffer.write('\nDid you mean one of these?');
      for (final (suggestion, _) in suggestions) {
        buffer.write('\n  $suggestion');
      }
    }

    terminal
      ..error('$buffer\n')
      ..error('Run "forui snippet ls" to see all code snippets.\n');

    return false;
  }

  Uri _generate(String snippet, {required String output, required bool interactive}) {
    final force = argResults!.flag('force');

    final (file, _, source) = snippets[snippet.toLowerCase()]!;
    final path =
        '${configuration.root.path}${Platform.pathSeparator}'
        '${output.endsWith('.dart') ? output : '$output${Platform.pathSeparator}$file.dart'}';

    if (!force && File(path).existsSync()) {
      if (interactive) {
        final overwrite = switch (confirm(message: 'Overwrite existing file?', initialValue: false)) {
          Value(:final value) => value,
          Cancelled() => false,
        };

        if (!overwrite) {
          cancel('No snippet created.');
          exit(130);
        }
      } else {
        terminal.error('File already exists; pass --force to overwrite.\n');
        exit(1);
      }
    }

    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(formatter.format(source));

    return .file(path);
  }
}

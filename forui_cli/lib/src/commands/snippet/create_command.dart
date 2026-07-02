import 'dart:io';

import 'package:forui_cli/src/commands/snippet/snippet.dart';
import 'package:forui_cli/src/components/confirm.dart';
import 'package:forui_cli/src/components/log.dart';
import 'package:forui_cli/src/components/multiselect.dart';
import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/command.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

class SnippetCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create code snippet files.';

  @override
  final arguments = '[snippet...]';

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
    ansi.enabled = globalResults!.flag('color');
    terminal.interactive = !globalResults!.flag('no-input');
    final output = argResults!['output'] as String;
    final arguments = argResults!.rest;

    // Multiple snippets can't all be written to the same file.
    if (arguments.length > 1 && output.endsWith('.dart')) {
      terminal.writeErrorln(
        'Cannot write multiple snippets to a single file. Try passing a directory to --output or omitting --output.',
      );
      exit(1);
    }

    // The multiselect can't prompt without a TTY, so a script must name its snippets.
    if (arguments.isEmpty && !terminal.interactive) {
      terminal.writeErrorln('No snippet specified. Run "forui snippet ls" to see all snippets.');
      exit(1);
    }

    if (arguments.isNotEmpty) {
      var valid = true;
      for (final snippet in arguments) {
        if (!_validate(snippet)) {
          valid = false;
        }
      }
      if (!valid) {
        exit(1);
      }

      // Non-interactive runs emit plain lines instead of an interactive box.
      if (!terminal.interactive) {
        for (final snippet in arguments) {
          terminal.writeln('Created ${_generate(snippet, output: output)}');
        }
        return;
      }
    }

    terminal.intro('Create code snippets');

    final selected = arguments.isEmpty
        ? switch (multiselect<String>(
            message: 'Snippets',
            min: 1,
            options: [
              for (final name in snippets.keys.toList()..sort()) SelectOption(name, hint: '(${snippets[name]!.$2})'),
            ],
          )) {
            Value(:final value) => value,
            Cancelled() => null,
          }
        : arguments;

    if (selected == null) {
      terminal.cancel('No snippets created.');
      exit(130);
    }

    // The multiselect can pick several, but only one snippet fits a single file.
    if (selected.length > 1 && output.endsWith('.dart')) {
      terminal
        ..error(
          'Cannot write multiple snippets to a single file.',
          hint: 'Try passing a directory to --output or omitting --output.',
        )
        ..outro();
      exit(1);
    }

    for (final snippet in selected) {
      terminal.success('Created ${_generate(snippet, output: output)}');
    }
    terminal.outro('Created ${selected.length} snippet(s).');
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
      ..writeErrorln('$buffer')
      ..writeErrorln('Run "forui snippet ls" to see all code snippets.');

    return false;
  }

  Uri _generate(String snippet, {required String output}) {
    final force = argResults!.flag('force');

    final (file, _, source) = snippets[snippet.toLowerCase()]!;
    final path =
        '${configuration.root.path}${Platform.pathSeparator}'
        '${output.endsWith('.dart') ? output : '$output${Platform.pathSeparator}$file.dart'}';

    if (!force && File(path).existsSync()) {
      if (!terminal.interactive) {
        terminal.writeErrorln('File already exists; pass --force to overwrite.');
        exit(1);
      }

      if (!confirm(message: 'Overwrite existing file?', initial: false)) {
        terminal.cancel('No snippet created.');
        exit(130);
      }
    }

    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(formatter.format(source));

    return .file(path);
  }
}

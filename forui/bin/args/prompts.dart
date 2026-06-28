import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

import 'command.dart';

/// Prompts the user to confirm whether to override [file].
void confirm(File file, {required bool input, String message = ''}) {
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
        stdout.writeln('Invalid option. Please enter either "y" or "n".');
    }
  }
}

/// Exits with an error if interactive prompts are unsupported, i.e. stdin or stdout is not attached to a terminal.
void requireTerminal() {
  if (!stdin.hasTerminal || !stdout.hasTerminal) {
    stdout.writeln(
      'Interactive prompts require a terminal. Pass --preset <preset> or --no-input to run non-interactively.',
    );
    exit(1);
  }
}

/// Prompts the user to pick one of the options in [groups] using arrow-key navigation.
T pick<T>(String title, Map<String, Map<String, T>> groups, {required T defaultValue}) {
  // chooseOne renders a flat list, so we flatten the groups and show each subheader once, aligned in a column on the
  // first item of its group.
  final width = groups.values
      .expand((group) => group.keys)
      .fold(0, (max, label) => label.length > max ? label.length : max);

  final choices = [
    for (final MapEntry(key: header, value: group) in groups.entries)
      for (final (index, MapEntry(key: label, :value)) in group.entries.indexed)
        (display: index == 0 && header.isNotEmpty ? '${label.padRight(width)}   $header' : label, value: value),
  ];
  final fallback = choices.firstWhere((c) => c.value == defaultValue, orElse: () => choices.first);

  return Logger()
      .chooseOne<({String display, T value})>(
        title,
        choices: choices,
        defaultValue: fallback,
        display: (c) => c.display,
      )
      .value;
}

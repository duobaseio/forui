import 'dart:io';

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

/// Prompts the user to pick one of the options in [groups] by number.
T pick<T>(String title, Map<String, Map<String, T>> groups, {required T defaultValue}) {
  final options = <MapEntry<String, T>>[];

  stdout.writeln(title);
  for (final MapEntry(key: header, value: group) in groups.entries) {
    if (header.isNotEmpty) {
      stdout
        ..writeln()
        ..writeln('  $header');
    }

    for (final option in group.entries) {
      final marker = option.value == defaultValue ? ' (default)' : '';
      stdout.writeln('  ${options.length + 1}. ${option.key}$marker');
      options.add(option);
    }
  }

  while (true) {
    stdout.write('> ');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (input.isEmpty) {
      return defaultValue;
    }

    if (int.tryParse(input) case final number? when number >= 1 && number <= options.length) {
      return options[number - 1].value;
    }

    stdout.writeln('Invalid option. Please enter a number between 1 and ${options.length}.');
  }
}

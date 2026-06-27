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
  final width = groups.values.fold(0, (count, group) => count + group.length).toString().length;

  stdout.writeln(title);
  var first = true;
  for (final MapEntry(key: header, value: group) in groups.entries) {
    if (header.isNotEmpty) {
      // Separate subheaders from each other, but not the first subheader from the title.
      if (!first) {
        stdout.writeln();
      }
      stdout.writeln('  $header');
    }
    first = false;

    final indent = header.isEmpty ? '  ' : '    ';
    for (final option in group.entries) {
      final marker = option.value == defaultValue ? ' (default)' : '';
      final number = '${options.length + 1}.'.padRight(width + 1);
      stdout.writeln('$indent$number ${option.key}$marker');
      options.add(option);
    }
  }

  stdout.writeln();
  while (true) {
    stdout.write('> ');
    final input = stdin.readLineSync()?.trim() ?? '';

    final T selected;
    if (input.isEmpty) {
      selected = defaultValue;
    } else if (int.tryParse(input) case final number? when number >= 1 && number <= options.length) {
      selected = options[number - 1].value;
    } else {
      stdout.writeln('Invalid option. Please enter a number between 1 and ${options.length}.');
      continue;
    }

    stdout.writeln();
    return selected;
  }
}

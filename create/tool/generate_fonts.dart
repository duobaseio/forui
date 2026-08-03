// ignore_for_file: avoid_print

/// One-off generator: mirrors `docs/public/fonts` into the create app's assets and prints the pubspec `fonts:` block
/// (derived from [FontFamily]) to stdout.
///
/// Run from the repository root: `dart run create/tool/generate_fonts.dart`.
library;

import 'dart:io';

import 'package:forui_cli/forui_cli.dart';

const _source = 'docs/public/fonts';
const _destDir = 'create/assets/fonts';
const _assetPrefix = 'assets/fonts';

void main() {
  // Clear _destDir from any existing files.
  final dest = Directory(_destDir);
  if (dest.existsSync()) {
    dest.deleteSync(recursive: true);
  }

  // Copy all fonts to the _destDir.
  for (final file in Directory(_source).listSync(recursive: true).whereType<File>()) {
    final to = File('$_destDir/${file.path.substring(_source.length + 1)}');
    to.parent.createSync(recursive: true);
    file.copySync(to.path);
  }

  // Build the pubspec `fonts:` block.
  final buffer = StringBuffer('  fonts:\n');
  for (final family in FontFamily.values) {
    final entries = <({String path, int? weight, bool italic})>[];

    switch (family.format) {
      case VariableFontFormat(:final normal, :final italic):
        entries.add((path: normal, weight: null, italic: false));
        if (italic != null) {
          entries.add((path: italic, weight: null, italic: true));
        }
      case StaticFontFormat(:final normal, :final italic):
        for (final MapEntry(key: weight, value: path) in normal.entries) {
          entries.add((path: path, weight: weight, italic: false));
        }
        for (final MapEntry(key: weight, value: path) in italic.entries) {
          entries.add((path: path, weight: weight, italic: true));
        }
    }

    buffer
      ..writeln('    - family: ${family.name}')
      ..writeln('      fonts:');
    for (final entry in entries) {
      buffer.writeln('        - asset: $_assetPrefix/${entry.path}');
      if (entry.weight != null) {
        buffer.writeln('          weight: ${entry.weight}');
      }
      if (entry.italic) {
        buffer.writeln('          style: italic');
      }
    }
  }

  print(buffer.toString());
}

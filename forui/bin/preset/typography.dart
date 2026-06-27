import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'package:forui/src/create/codec.dart';

import '../args/command.dart';
import '../commands/theme/theme.dart';
import '../configuration.dart';

String generateTypography(Preset preset) {
  var typography = Theme.neutral.typography;

  if (preset.display != .inter) {
    typography = typography.replaceFirst(
      'display: _display(colors: colors, touch: touch)',
      "display: _display(colors: colors, touch: touch, fontFamily: '${preset.display.name}')",
    );
  }

  if (preset.body != .inter) {
    typography = typography.replaceFirst(
      'body: _body(colors: colors, touch: touch)',
      "body: _body(colors: colors, touch: touch, fontFamily: '${preset.body.name}')",
    );
  }

  return typography;
}

Future<void> installTypography(Preset preset, Directory root, {required String directory, required bool force}) async {
  final pubspec = File('${root.path}/pubspec.yaml');
  final editor = YamlEditor(pubspec.readAsStringSync());

  if (editor.at(['flutter']) is! YamlMap) {
    editor.update(['flutter'], {'fonts': []});
  } else if (editor.at(['flutter', 'fonts']) is! YamlList) {
    editor.update(['flutter', 'fonts'], []);
  }

  final existing = {
    if (editor.at(['flutter', 'fonts']) case YamlList(nodes: final fonts))
      for (final entry in fonts.whereType<YamlMap>())
        if (entry['family'] case final String family) family,
  };

  final client = HttpClient();
  try {
    for (final FontFamily(:name, :format) in {preset.display, preset.body}..remove(FontFamily.inter)) {
      stdout.writeln('${emoji ? '⏳' : '[Waiting]'} Downloading $name...');

      final assets = switch (format) {
        VariableFontFormat(:final normal, :final italic) => [
          (path: normal, weight: null, italic: false),
          if (italic != null) (path: italic, weight: null, italic: true),
        ],
        StaticFontFormat(:final normal, :final italic) => [
          for (final MapEntry(key: weight, value: path) in normal.entries) (path: path, weight: weight, italic: false),
          for (final MapEntry(key: weight, value: path) in italic.entries) (path: path, weight: weight, italic: true),
        ],
      };

      Future<void> fetch(String path) async {
        final file = File('${root.path}/$directory/$path');
        if (!force && file.existsSync()) {
          return;
        }

        if (await client.fetch('$fonts/$path') case final bytes?) {
          file
            ..createSync(recursive: true)
            ..writeAsBytesSync(bytes);
        } else {
          stderr.writeln('Failed to fetch $name from $fonts/$path.');
          exit(1);
        }
      }

      await Future.wait([
        for (final path in [...assets.map((a) => a.path), '${assets.first.path.split('/').first}/LICENSE.txt'])
          fetch(path),
      ]);

      if (!existing.contains(name)) {
        editor.appendToList(
          ['flutter', 'fonts'],
          {
            'family': name,
            'fonts': [
              for (final (:path, :weight, :italic) in assets)
                {'asset': '$directory/$path', 'weight': ?weight, if (italic) 'style': 'italic'},
            ],
          },
        );
      }
    }
  } finally {
    client.close();
  }

  pubspec.writeAsStringSync(editor.toString());
}

extension on YamlEditor {
  static final _missing = wrapAsYamlNode(null);

  YamlNode? at(List<Object> path) {
    final node = parseAt(path, orElse: () => _missing);
    return identical(node, _missing) ? null : node;
  }
}

extension on HttpClient {
  Future<List<int>?> fetch(String url) async {
    try {
      if (await (await getUrl(.parse(url))).close() case final response when response.statusCode == 200) {
        return response.expand((c) => c).toList();
      }

      return null;
    } on SocketException {
      return null;
    } on HttpException {
      return null;
    }
  }
}

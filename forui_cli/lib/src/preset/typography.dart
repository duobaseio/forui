import 'dart:io';

import 'package:forui_cli/src/codec.dart';
import 'package:forui_cli/src/commands/theme/theme.dart';
import 'package:forui_cli/src/components/log.dart';
import 'package:forui_cli/src/components/spinner.dart';
import 'package:forui_cli/src/configuration.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// Generates the typography section, swapping in [preset]'s display and body fonts where they differ from the default.
String generateTypography(Preset preset) {
  var typography = neutral.typography;

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

/// Downloads [preset]'s non-default font assets into [directory] and registers them in pubspec.yaml.
Future<void> installTypography(Preset preset, Directory root, {required String directory, required bool force}) async {
  final families = {preset.display, preset.body}..remove(FontFamily.inter);
  if (families.isEmpty) {
    return;
  }

  final pubspec = File('${root.path}/pubspec.yaml');
  final editor = YamlEditor(pubspec.readAsStringSync());

  if (editor.at(['flutter']) is! YamlMap) {
    editor.update(['flutter'], {'fonts': <Object?>[]});
  } else if (editor.at(['flutter', 'fonts']) is! YamlList) {
    editor.update(['flutter', 'fonts'], <Object?>[]);
  }

  final existing = {
    if (editor.at(['flutter', 'fonts']) case YamlList(:final nodes))
      for (final entry in nodes.whereType<YamlMap>())
        if (entry['family'] case final String family) family,
  };

  final additions = <Map<String, Object?>>[];

  final spinner = Spinner()..start('Downloading fonts...');
  final client = HttpClient();
  try {
    for (final FontFamily(:name, :format) in families) {
      spinner.message('Downloading $name...');

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

        file
          ..createSync(recursive: true)
          ..writeAsBytesSync(await client.fetch('$fonts/$path'));
      }

      try {
        await Future.wait([
          for (final path in [...assets.map((a) => a.path), '${assets.first.path.split('/').first}/LICENSE.txt'])
            fetch(path),
        ]);
      } on _DownloadException catch (e) {
        spinner.error('Failed to download the $name font.', e.reason);
        terminal.outro();
        exit(1);
      }

      if (!existing.contains(name)) {
        additions.add({
          'family': name,
          'fonts': [
            for (final (:path, :weight, :italic) in assets)
              {'asset': '$directory/$path', 'weight': ?weight, if (italic) 'style': 'italic'},
          ],
        });
      }
    }
  } finally {
    client.close();
  }

  spinner.stop('Downloaded ${families.length == 1 ? '1 font' : '${families.length} fonts'}');

  // Rewrite the whole list as a block node. yaml_edit keeps a list that started empty (`[]`) in flow style, so
  // appending would emit nasty inline `[{family: ...}]` entries instead of `- family: ...`.
  if (additions.isNotEmpty) {
    final entries = [
      if (editor.at(['flutter', 'fonts']) case YamlList(:final nodes)) ...nodes,
      ...additions,
    ];
    editor.update(['flutter', 'fonts'], wrapAsYamlNode(entries, collectionStyle: .BLOCK));
    pubspec.writeAsStringSync(editor.toString());
  }
}

extension on YamlEditor {
  static final _missing = wrapAsYamlNode(null);

  YamlNode? at(List<Object> path) {
    final node = parseAt(path, orElse: () => _missing);
    return identical(node, _missing) ? null : node;
  }
}

extension on HttpClient {
  Future<List<int>> fetch(String url) async {
    final HttpClientResponse response;
    try {
      response = await (await getUrl(.parse(url))).close();
    } on SocketException {
      throw _DownloadException('Could not reach ${Uri.parse(url).host}. Check your internet connection.');
    } on HttpException {
      throw _DownloadException('Could not reach ${Uri.parse(url).host}. Check your internet connection.');
    }

    if (response.statusCode != 200) {
      throw _DownloadException('$url returned HTTP ${response.statusCode}. ');
    }

    return response.expand((c) => c).toList();
  }
}

class _DownloadException implements Exception {
  final String reason;

  _DownloadException(this.reason);
}

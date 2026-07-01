import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

import 'snippets/generate_snippets.dart';
import 'generate_icons.dart';
import 'generate_styles.dart';
import 'generate_theme.dart';

final library = p.join(Directory.current.parent.path, 'forui', 'lib');
final _base =  p.join(Directory.current.parent.path, 'forui_cli', 'lib', 'src');
final _snippet = p.join(_base, 'commands', 'snippet', 'snippet.dart');
final _icons = p.join(_base, 'preset', 'icon_mapping.dart');
final _style = p.join(_base, 'commands', 'style', 'style.dart');
final _theme = p.join(_base, 'commands', 'theme', 'theme.dart');

final assetsLibrary = p.join(Directory.current.parent.path, 'forui_assets', 'lib', 'src');

final emitter = DartEmitter();

/// The formatter used to format the generated fragments actually seen & used by end-users.
final fragmentFormatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

/// The formatter to used format the generated code used in the CLI.
final metaFormatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion, pageWidth: 120);

const header = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// 
// **************************************************************************
// forui
// **************************************************************************
//
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use

''';

Future<void> main() async {
  final collection = AnalysisContextCollection(
    includedPaths: [library, assetsLibrary],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  final snippets = await mapSnippets(collection);
  File(_snippet)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(generateSnippets(snippets));

  final icons = await traverseIcons(collection);
  File(_icons)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(generateIconMapping(icons));

  final styles = mapStyles(await traverseStyles(collection));
  File(_style)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(generateStyles(styles));

  final themes = mapThemes(await traverseThemes(collection));
  File(_theme)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(generateThemes(themes));

  await traverseThemes(collection);
}

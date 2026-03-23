// ignore_for_file: avoid_print

import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:html/parser.dart' as html;
import 'package:sugar/core.dart';

const family = 'ForuiLucideIcons';
const package = 'forui_assets';

const directional = {
  'arrow-big-left-dash',
  'arrow-big-left',
  'arrow-big-right-dash',
  'arrow-big-right',
  'arrow-left-from-line',
  'arrow-left-to-line',
  'arrow-left',
  'arrow-right-from-line',
  'arrow-right-to-line',
  'arrow-right',
  'chevron-first',
  'chevron-last',
  'chevron-left',
  'chevron-right',
  'chevrons-left',
  'chevrons-right',
  'circle-arrow-left',
  'circle-arrow-right',
  'circle-chevron-left',
  'circle-chevron-right',
  'indent-decrease',
  'indent-increase',
  'square-arrow-left',
  'square-arrow-right',
  'square-chevrons-left',
  'square-chevrons-right',
};

// UPDATE BEFORE EACH RELEASE.
const _url = 'https://raw.githubusercontent.com/lucide-icons/lucide/refs/tags/0.575.0/icons';

final _pattern = RegExp(r'static const (\w+) = IconData\((\d+),');

void main() {
  print('Remember to update the version in the url constant when updating the font.');

  final icons = parse();
  verify(icons);
  
  generate(icons);
  if (File('./.dart_tool/lucide-font/lucide.ttf') case final file when file.existsSync()) {
    file.copySync('./assets/lucide.ttf');
  } else {
    throw StateError('Lucide font not found. Please download and unzip it into .dart_tool/lucide-font/');
  }
}

// This script assumes that .dart_tool/lucide-font exists. The archive is manually downloaded and unzipped from
// https://github.com/lucide-icons/lucide/releases/latest.
List<(String fieldName, String actualName, String unicode)> parse() {
  final icons = html
      .parse(File('./.dart_tool/lucide-font/unicode.html').readAsStringSync())
      .getElementsByClassName('unicode-icon')
      .map(
        (element) => (
          element.getElementsByTagName('h4').single.text.toCamelCase(),
          element.getElementsByTagName('h4').single.text,
          element.getElementsByClassName('unicode').single.text.replaceAll('&#', '').replaceAll(';', ''),
        ),
      );

  final seen = <String, String>{};
  final result = <(String, String, String)>[];
  for (final icon in icons) {
    final existing = seen[icon.$1];
    if (existing != null) {
      print('Duplicate field name ${icon.$1} for ${icon.$2} (already used by $existing), discarding.');
      continue;
    }

    seen[icon.$1] = icon.$2;
    result.add(icon);
  }

  return result;
}

void verify(List<(String, String, String)> icons) {
  final file = File('./lib/src/assets.g.dart');
  if (!file.existsSync()) {
    return;
  }

  final existing = {for (final match in _pattern.allMatches(file.readAsStringSync())) match.group(1)!: match.group(2)};
  if (existing.isEmpty) {
    return;
  }

  final mismatches = [
    for (final (fieldName, actualName, unicode) in icons)
      if (existing[fieldName] case final old? when old != unicode) '$actualName ($fieldName): $old → $unicode',
  ];

  if (mismatches.isNotEmpty) {
    print('ERROR: ${mismatches.length} icon(s) have changed codepoints:\n${mismatches.join('\n')}');
    print('\nThis may indicate incorrect mappings in unicode.html.');
    exit(1);
  }
}

const header =
    '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// 
// **************************************************************************
// $package
// **************************************************************************
//
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use
''';

void generate(List<(String, String, String)> icons) {
  final library = LibraryBuilder()
    ..directives.addAll([Directive.import('package:flutter/widgets.dart')])
    ..body
    ..comments.addAll([header])
    ..body.addAll([
      (ClassBuilder()
            ..docs.addAll([
              '/// The Lucide icons bundled with Forui.',
              '/// ',
              '/// Use with the [Icon] class to show specific icons. Icons are identified by their name as listed below, e.g. ',
              '/// [FIcons.armchair].',
              '/// ',
              '/// Search and find the perfect icon on the [Lucide Icons](https://lucide.dev/icons/) website.',
            ])
            ..annotations.add(refer('staticIconProvider'))
            ..name = 'FIcons'
            ..fields.addAll([
              for (final icon in icons)
                (FieldBuilder()
                      ..docs.addAll([
                        '/// [![`${icon.$2}`]($_url/${icon.$2}.svg)](https://lucide.dev/icons/${icon.$2})',
                      ])
                      ..static = true
                      ..modifier = FieldModifier.constant
                      ..type
                      ..name = icon.$1
                      ..assignment = refer('IconData')
                          .newInstance(
                            [literalNum(int.parse(icon.$3))],
                            {
                              'fontFamily': literalString(family),
                              'fontPackage': literalString(package),
                              if (directional.contains(icon.$2)) 'matchTextDirection': literalTrue,
                            },
                          )
                          .code)
                    .build(),
            ])
            ..constructors.add(
              (ConstructorBuilder()
                    ..name = '_'
                    ..constant = true)
                  .build(),
            ))
          .build(),
    ]);

  final code = DartFormatter(
    pageWidth: 120,
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format(DartEmitter(orderDirectives: true, useNullSafetySyntax: true).visitLibrary(library.build()).toString());

  File('./lib/src/assets.g.dart').writeAsStringSync(code);
}

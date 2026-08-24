// ignore_for_file: avoid_print

import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:sugar/core.dart';

const package = 'forui_phosphor';

// The phosphor-icons/core commit containing this release's SVGs. Unlike lucide, phosphor's core repo does not tag
// 2.1.x releases, so preview links are pinned to the core submodule commit of the phosphor-icons/web release tag:
// https://github.com/phosphor-icons/web/tree/v2.1.2 -> core @ 33fb01d. UPDATE BEFORE EACH RELEASE.
const _commit = '33fb01d1d33cd0156633ea4d33f4011fabe4d2da';

/// Icons that should be mirrored in right-to-left locales.
// TODO: curate the directional icon set before the first release.
const directional = <String>{};

/// The weights bundled with this package, in declaration order.
const weights = [
  (name: 'regular', family: 'ForuiPhosphorIcons', type: 'FPhosphorIcons', ttf: 'Phosphor.ttf'),
  (name: 'thin', family: 'ForuiPhosphorThinIcons', type: 'FPhosphorThinIcons', ttf: 'Phosphor-Thin.ttf'),
  (name: 'light', family: 'ForuiPhosphorLightIcons', type: 'FPhosphorLightIcons', ttf: 'Phosphor-Light.ttf'),
  (name: 'bold', family: 'ForuiPhosphorBoldIcons', type: 'FPhosphorBoldIcons', ttf: 'Phosphor-Bold.ttf'),
  (name: 'fill', family: 'ForuiPhosphorFillIcons', type: 'FPhosphorFillIcons', ttf: 'Phosphor-Fill.ttf'),
];

final _pattern = RegExp(r'static const (\w+) = IconData\((\d+),');

void main() {
  for (final weight in weights) {
    final icons = parse(weight.name);
    verify(weight.name, icons);

    generate(weight.name, weight.family, weight.type, icons);
    if (File('./.dart_tool/phosphor-font/${weight.name}/${weight.ttf}') case final file when file.existsSync()) {
      file.copySync('./assets/${weight.name}.ttf');
    } else {
      throw StateError(
        'Phosphor ${weight.name} font not found. Please download it into .dart_tool/phosphor-font/${weight.name}/',
      );
    }

    print('Generated ${icons.length} ${weight.name} icons.');
  }
}

// This script assumes that .dart_tool/phosphor-font/<weight>/ exists for each weight, containing the `style.css` and
// ttf from https://github.com/phosphor-icons/web/tree/v<version>/src/<weight>.
//
// The regular weight's selectors are `.ph.ph-<name>:before`; other weights use `.ph-<weight>.ph-<name>:before`.
List<(String fieldName, String actualName, int codepoint)> parse(String weight) {
  final css = File('./.dart_tool/phosphor-font/$weight/style.css').readAsStringSync();
  final prefix = weight == 'regular' ? r'\.ph' : '\\.ph-$weight';
  final icon = RegExp('$prefix\\.ph-([\\w-]+):before\\s*\\{\\s*content:\\s*"\\\\([0-9a-fA-F]+)"');

  final seen = <String, String>{};
  final result = <(String, String, int)>[];
  for (final match in icon.allMatches(css)) {
    final actualName = match.group(1)!;
    final fieldName = actualName.toCamelCase();
    final codepoint = int.parse(match.group(2)!, radix: 16);

    final existing = seen[fieldName];
    if (existing != null) {
      print('Duplicate field name $fieldName for $actualName (already used by $existing), discarding.');
      continue;
    }

    seen[fieldName] = actualName;
    result.add((fieldName, actualName, codepoint));
  }

  return result;
}

void verify(String weight, List<(String, String, int)> icons) {
  final file = File('./lib/src/$weight.g.dart');
  if (!file.existsSync()) {
    return;
  }

  final existing = {for (final match in _pattern.allMatches(file.readAsStringSync())) match.group(1)!: match.group(2)};
  if (existing.isEmpty) {
    return;
  }

  final mismatches = [
    for (final (fieldName, actualName, codepoint) in icons)
      if (existing[fieldName] case final old? when old != '$codepoint') '$actualName ($fieldName): $old → $codepoint',
  ];

  if (mismatches.isNotEmpty) {
    print('ERROR: ${mismatches.length} $weight icon(s) have changed codepoints:\n${mismatches.join('\n')}');
    print('\nThis may indicate incorrect mappings in style.css.');
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

void generate(String weight, String family, String type, List<(String, String, int)> icons) {
  String svg(String name) => weight == 'regular'
      ? 'https://raw.githubusercontent.com/phosphor-icons/core/$_commit/assets/regular/$name.svg'
      : 'https://raw.githubusercontent.com/phosphor-icons/core/$_commit/assets/$weight/$name-$weight.svg';

  Class iconClass(String name, List<String> docs, List<(String, String, int)> icons) => (ClassBuilder()
        ..docs.addAll(docs)
        ..annotations.add(refer('staticIconProvider'))
        ..name = name
        ..fields.addAll([
          for (final icon in icons)
            (FieldBuilder()
                  ..docs.addAll(['/// [![`${icon.$2}`](${svg(icon.$2)})](https://phosphoricons.com/)'])
                  ..static = true
                  ..modifier = FieldModifier.constant
                  ..type
                  ..name = icon.$1
                  ..assignment = refer('IconData')
                      .newInstance(
                        [literalNum(icon.$3)],
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
      .build();

  final library = LibraryBuilder()
    ..directives.addAll([Directive.import('package:flutter/widgets.dart')])
    ..body
    ..comments.addAll([header])
    ..body.addAll([
      iconClass(type, [
        '/// The Phosphor $weight icons maintained by the Forui team.',
        '/// ',
        '/// Use with the [Icon] class to show specific icons. Icons are identified by their name as listed below, e.g. ',
        '/// [$type.acorn].',
        '/// ',
        '/// Search and find the perfect icon on the [Phosphor Icons](https://phosphoricons.com/) website.',
      ], icons),
    ]);

  final code = DartFormatter(
    pageWidth: 120,
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format(DartEmitter(orderDirectives: true, useNullSafetySyntax: true).visitLibrary(library.build()).toString());

  File('./lib/src/$weight.g.dart').writeAsStringSync(code);
}

// ignore_for_file: non_const_argument_for_const_parameter

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

const _family = 'ForuiPhosphorDuotoneIcons';
const _columns = 40;
const _size = 32.0;

final _icon = RegExp(
  r'static const \w+ = FPhosphorDuotoneIconData\(\s*foreground: IconData\(\s*(\d+)[^)]*\)(?:,\s*background: IconData\(\s*(\d+)[^)]*\))?',
);

// Reconstructed from the generated file rather than referencing the consts so the golden always covers every icon.
List<FPhosphorDuotoneIconData> parseIcons() => [
  for (final match in _icon.allMatches(File('lib/src/duotone.g.dart').readAsStringSync()))
    FPhosphorDuotoneIconData(
      foreground: IconData(int.parse(match.group(1)!), fontFamily: _family, fontPackage: 'forui_phosphor'),
      background: match.group(2) == null
          ? null
          : IconData(int.parse(match.group(2)!), fontFamily: _family, fontPackage: 'forui_phosphor'),
    ),
];

void main() {
  setUpAll(() async {
    final bytes = File('assets/duotone.ttf').readAsBytesSync();
    final loader = FontLoader('packages/forui_phosphor/$_family')..addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
  });

  testWidgets('duotone', (tester) async {
    final icons = parseIcons();
    expect(icons.length, 1512);
    expect(icons.where((icon) => icon.background == null).length, 2);

    final rows = (icons.length / _columns).ceil();
    tester.view.physicalSize = Size(_columns * _size, rows * _size);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ColoredBox(
          color: const Color(0xFFFFFFFF),
          child: Wrap(
            children: [
              for (final icon in icons) FPhosphorDuotoneIcon(icon, size: _size, color: const Color(0xFF6750A4)),
            ],
          ),
        ),
      ),
    );

    await expectLater(find.byType(ColoredBox), matchesGoldenFile('golden/duotone.png'));
  });
}

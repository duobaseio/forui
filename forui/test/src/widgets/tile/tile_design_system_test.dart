@TestOn('mac-os')
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('touch tile has consistent height (48)', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        theme: FThemes.neutral.light.touch,
        child: FTile(key: const Key('tile'), title: const Text('Tile'), onPress: () {}),
      ),
    );

    expect(tester.getSize(find.byKey(const Key('tile'))).height, closeTo(48, 0.001));
  });
}

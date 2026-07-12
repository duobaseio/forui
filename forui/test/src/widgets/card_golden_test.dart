@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FCard(style: TestScaffold.blueScreen.cardStyle, child: const SizedBox(width: 50, height: 50)),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with child', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FCard(child: SizedBox(width: 50, height: 50)),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/${theme.name}/child.png'));
    });
  }

  for (final clip in [Clip.none, Clip.antiAlias]) {
    testWidgets('clip ${clip.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FCard(
            clipBehavior: clip,
            child: const ColoredBox(color: Colors.red, child: SizedBox(width: 200, height: 100)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/clip-${clip.name}.png'));
    });
  }
}

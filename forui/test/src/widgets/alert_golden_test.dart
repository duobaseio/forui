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
        child: FAlert(
          title: const Text('Alert Title'),
          subtitle: const Text('Alert description with extra text'),
          style: TestScaffold.blueScreen.alertStyles.base,
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    for (final (name, variant) in [('primary', FAlertVariant.primary), ('destructive', FAlertVariant.destructive)]) {
      testWidgets('${theme.name} with default icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FAlert(
              variant: variant,
              title: const Text('Alert Title'),
              subtitle: const Text('Alert description with extra text'),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('alert/${theme.name}/$name-default-icon.png'));
      });

      testWidgets('${theme.name} with user icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FAlert(
              variant: variant,
              icon: const Icon(FLucideIcons.badgeAlert),
              title: const Text('Alert Title'),
              subtitle: const Text('Alert description with extra text'),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('alert/${theme.name}/$name-user-icon.png'));
      });
    }
  }

  for (final clip in [Clip.none, Clip.antiAlias]) {
    testWidgets('clip ${clip.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FAlert(
            clipBehavior: clip,
            style: const .delta(padding: .value(.zero)),
            title: const ColoredBox(color: Colors.red, child: SizedBox(width: 200, height: 30)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('alert/clip-${clip.name}.png'));
    });
  }
}

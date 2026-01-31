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
    for (final (name, Set<FAlertVariant> variants) in [
      ('primary', {}),
      ('destructive', {.destructive}),
    ]) {
      testWidgets('${theme.name} with default icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FAlert(
              variants: variants,
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
              variants: variants,
              icon: const Icon(FIcons.badgeAlert),
              title: const Text('Alert Title'),
              subtitle: const Text('Alert description with extra text'),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('alert/${theme.name}/$name-user-icon.png'));
      });
    }
  }
}

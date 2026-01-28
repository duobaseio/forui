import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: SizedBox(
          width: 300,
          child: FLabel(
            style: TestScaffold.blueScreen.labelStyles.horizontalStyle,
            axis: .horizontal,
            label: const Text('Email'),
            description: const Text('Enter your email address.'),
            error: const Text('Please enter a valid email address.'),
            variants: {.error},
            child: const SizedBox(width: 16, height: 16),
          ),
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    for (final Set<FFormFieldVariant> variants in [
      {.disabled},
      {.error},
      {},
    ]) {
      testWidgets('${theme.name} horizontal with $variants', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: SizedBox(
              width: 300,
              child: FLabel(
                axis: .horizontal,
                label: const Text('Email'),
                description: const Text('Enter your email address.'),
                error: const Text('Please enter a valid email address.'),
                variants: variants,
                child: const DecoratedBox(
                  decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
                  child: SizedBox(width: 16, height: 16),
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('label/${theme.name}/horizontal-$variants.png'));
      });
    }

    for (final Set<FFormFieldVariant> variants in [
      {.disabled},
      {.error},
      {},
    ]) {
      testWidgets('${theme.name} vertical with $variants', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLabel(
              axis: .vertical,
              label: const Text('Email'),
              description: const Text('Enter your email address.'),
              error: const Text('Please enter a valid email address.'),
              variants: variants,
              child: const DecoratedBox(
                decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
                child: SizedBox(width: 200, height: 30),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('label/${theme.name}/vertical-$variants.png'));
      });
    }
  }
}

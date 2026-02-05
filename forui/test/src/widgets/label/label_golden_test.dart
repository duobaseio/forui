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
    for (final (name, Set<FFormFieldVariant> variants) in [
      ('disabled', {.disabled}),
      ('error', {.error}),
      ('disabled-error', {.disabled, .error}),
      ('default', {}),
    ]) {
      testWidgets('${theme.name} horizontal with $name', (tester) async {
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('label/${theme.name}/horizontal-$name.png'));
      });
    }

    for (final (name, Set<FFormFieldVariant> variants) in [
      ('disabled', {.disabled}),
      ('error', {.error}),
      ('disabled-error', {.disabled, .error}),
      ('default', {}),
    ]) {
      testWidgets('${theme.name} vertical with $name', (tester) async {
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('label/${theme.name}/vertical-$name.png'));
      });
    }

    for (final (name, from, to) in [
      ('enabled-to-error', <FFormFieldVariant>{}, {FFormFieldVariant.error}),
      ('error-to-enabled', {FFormFieldVariant.error}, <FFormFieldVariant>{}),
      ('enabled-to-disabled', <FFormFieldVariant>{}, {FFormFieldVariant.disabled}),
      ('disabled-to-enabled', {FFormFieldVariant.disabled}, <FFormFieldVariant>{}),
    ]) {
      testWidgets('${theme.name} horizontal $name transition', (tester) async {
        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(300, 100)));

        await tester.pumpWidget(
          sheet.record(
            TestScaffold.app(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FLabel(
                  axis: .horizontal,
                  label: const Text('Email'),
                  description: const Text('Enter your email address.'),
                  error: const Text('Please enter a valid email address.'),
                  variants: from,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
                    child: SizedBox(width: 16, height: 16),
                  ),
                ),
              ),
            ),
            recording: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.pumpFrames(
          sheet.record(
            TestScaffold.app(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FLabel(
                  axis: .horizontal,
                  label: const Text('Email'),
                  description: const Text('Enter your email address.'),
                  error: const Text('Please enter a valid email address.'),
                  variants: to,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
                    child: SizedBox(width: 16, height: 16),
                  ),
                ),
              ),
            ),
          ),
          const Duration(milliseconds: 120),
        );

        await expectLater(sheet.collate(5), matchesGoldenFile('label/${theme.name}/horizontal-$name.png'));
      });

      testWidgets('${theme.name} vertical $name transition', (tester) async {
        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(250, 150)));

        await tester.pumpWidget(
          sheet.record(
            TestScaffold.app(
              theme: theme.data,
              child: FLabel(
                axis: .vertical,
                label: const Text('Email'),
                description: const Text('Enter your email address.'),
                error: const Text('Please enter a valid email address.'),
                variants: from,
                child: const DecoratedBox(
                  decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
                  child: SizedBox(width: 200, height: 30),
                ),
              ),
            ),
            recording: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.pumpFrames(
          sheet.record(
            TestScaffold.app(
              theme: theme.data,
              child: FLabel(
                axis: .vertical,
                label: const Text('Email'),
                description: const Text('Enter your email address.'),
                error: const Text('Please enter a valid email address.'),
                variants: to,
                child: const DecoratedBox(
                  decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
                  child: SizedBox(width: 200, height: 30),
                ),
              ),
            ),
          ),
          const Duration(milliseconds: 120),
        );

        await expectLater(sheet.collate(5), matchesGoldenFile('label/${theme.name}/vertical-$name.png'));
      });
    }
  }
}

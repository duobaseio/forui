import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('onVariantChange & onHoverChange callback called', (tester) async {
    Set<FTappableVariant>? previous;
    Set<FTappableVariant>? current;
    bool? hovered;
    await tester.pumpWidget(
      TestScaffold(
        child: FButton(
          onVariantChange: (p, c) {
            previous = p;
            current = c;
          },
          onHoverChange: (v) => hovered = v,
          onPress: () {},
          child: const Text('Button'),
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('Button')));
    await tester.pumpAndSettle();

    expect(previous, isNot(contains(FTappableVariant.hovered)));
    expect(current, contains(FTappableVariant.hovered));
    expect(hovered, true);

    await gesture.moveTo(.zero);
    await tester.pumpAndSettle();

    expect(previous, contains(FTappableVariant.hovered));
    expect(current, isNot(contains(FTappableVariant.hovered)));
    expect(hovered, false);
  });

  group('builders', () {
    testWidgets('FButton prefixBuilder & suffixBuilder receive child widgets', (tester) async {
      Widget? capturedPrefixChild;
      Widget? capturedSuffixChild;

      await tester.pumpWidget(
        TestScaffold(
          child: FButton(
            onPress: () {},
            prefix: const Text('prefix'),
            prefixBuilder: (context, style, textStyle, iconStyle, progressStyle, child) {
              capturedPrefixChild = child;
              return child!;
            },
            suffix: const Text('suffix'),
            suffixBuilder: (context, style, textStyle, iconStyle, progressStyle, child) {
              capturedSuffixChild = child;
              return child!;
            },
            child: const Text('child'),
          ),
        ),
      );

      expect(capturedPrefixChild, isA<Text>().having((t) => t.data, 'data', 'prefix'));
      expect(capturedSuffixChild, isA<Text>().having((t) => t.data, 'data', 'suffix'));
    });

    testWidgets('FButton with prefixBuilder only passes null child', (tester) async {
      Widget? capturedChild;

      await tester.pumpWidget(
        TestScaffold(
          child: FButton(
            onPress: () {},
            prefixBuilder: (context, style, textStyle, iconStyle, progressStyle, child) {
              capturedChild = child;
              return const Text('prefix');
            },
            child: const Text('child'),
          ),
        ),
      );

      expect(capturedChild, null);
      expect(find.text('prefix'), findsOneWidget);
    });

    testWidgets('FButton with builder only renders', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FButton(
            onPress: () {},
            builder: (context, style, textStyle, iconStyle, progressStyle, child) => const Text('built'),
          ),
        ),
      );

      expect(find.text('built'), findsOneWidget);
    });

    test('FButton asserts when neither builder nor child is provided', () {
      expect(() => FButton(onPress: () {}), throwsAssertionError);
    });

    testWidgets('FButton.icon with builder only renders', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FButton.icon(
            onPress: () {},
            builder: (context, style, iconStyle, child) => const Icon(FIcons.search),
          ),
        ),
      );

      expect(find.byIcon(FIcons.search), findsOneWidget);
    });

    test('FButton.icon asserts when neither builder nor child is provided', () {
      expect(() => FButton.icon(onPress: () {}), throwsAssertionError);
    });
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName, sizes) in [
      (
        FThemes.neutral.light.desktop,
        'desktop',
        [
          (FButtonSizeVariant.xs, 'xs', FThemes.neutral.light.desktop.style.sizes.field.xs),
          (FButtonSizeVariant.sm, 'sm', FThemes.neutral.light.desktop.style.sizes.field.sm),
          (FButtonSizeVariant.md, 'md', FThemes.neutral.light.desktop.style.sizes.field.md),
          (FButtonSizeVariant.lg, 'lg', FThemes.neutral.light.desktop.style.sizes.field.lg),
        ],
      ),
      (
        FThemes.neutral.light.touch,
        'touch',
        [
          (FButtonSizeVariant.xs, 'xs', FThemes.neutral.light.touch.style.sizes.field.xs),
          (FButtonSizeVariant.sm, 'sm', FThemes.neutral.light.touch.style.sizes.field.sm),
          (FButtonSizeVariant.md, 'md', FThemes.neutral.light.touch.style.sizes.field.md),
          (FButtonSizeVariant.lg, 'lg', FThemes.neutral.light.touch.style.sizes.field.lg),
        ],
      ),
    ]) {
      for (final (size, name, height) in sizes) {
        testWidgets('$themeName $name button and icon button have consistent height ($height)', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme,
              child: Column(
                mainAxisSize: .min,
                children: [
                  FButton(key: const Key('button'), size: size, onPress: () {}, child: const Text('Button')),
                  FButton.icon(
                    key: const Key('icon-button'),
                    size: size,
                    onPress: () {},
                    child: const Icon(FIcons.search),
                  ),
                ],
              ),
            ),
          );

          expect(tester.getSize(find.byKey(const Key('button'))).height, closeTo(height, 0.001));
          expect(tester.getSize(find.byKey(const Key('icon-button'))).height, closeTo(height, 0.001));
        });
      }
    }
  });
}

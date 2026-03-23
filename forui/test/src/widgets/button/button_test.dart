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

  group('design system', skip: !Platform.isMacOS, () {
    final desktop = FThemeData(touch: false, colors: FColors.neutral.light);
    final touch = FThemeData(touch: true, colors: FColors.neutral.light);

    for (final (theme, themeName, sizes) in [
      (
        desktop,
        'desktop',
        [
          (FButtonSizeVariant.xs, 'xs', desktop.style.sizes.field.xs),
          (FButtonSizeVariant.sm, 'sm', desktop.style.sizes.field.sm),
          (FButtonSizeVariant.md, 'md', desktop.style.sizes.field.md),
          (FButtonSizeVariant.lg, 'lg', desktop.style.sizes.field.lg),
        ],
      ),
      (
        touch,
        'touch',
        [
          (FButtonSizeVariant.xs, 'xs', touch.style.sizes.field.xs),
          (FButtonSizeVariant.sm, 'sm', touch.style.sizes.field.sm),
          (FButtonSizeVariant.md, 'md', touch.style.sizes.field.md),
          (FButtonSizeVariant.lg, 'lg', touch.style.sizes.field.lg),
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

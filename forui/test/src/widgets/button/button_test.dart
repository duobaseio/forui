import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
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

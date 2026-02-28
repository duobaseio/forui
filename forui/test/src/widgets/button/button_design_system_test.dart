@TestOn('mac-os')
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (platform, sizes) in [
    (
      FPlatformVariant.macOS,
      [
        (FButtonSizeVariant.xs, 'xs', 24.0),
        (FButtonSizeVariant.sm, 'sm', 32.0),
        (FButtonSizeVariant.md, 'md', 36.0),
        (FButtonSizeVariant.lg, 'lg', 40.0),
      ],
    ),
    (
      FPlatformVariant.iOS,
      [
        (FButtonSizeVariant.xs, 'xs', 32.0),
        (FButtonSizeVariant.sm, 'sm', 40.0),
        (FButtonSizeVariant.md, 'md', 44.0),
        (FButtonSizeVariant.lg, 'lg', 48.0),
      ],
    ),
  ]) {
    final platformName = platform == FPlatformVariant.macOS ? 'macOS' : 'iOS';
    for (final (size, name, height) in sizes) {
      testWidgets('$platformName $name button and icon button have consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            platform: platform,
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
}

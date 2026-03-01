@TestOn('mac-os')
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (platform, platformName, height) in [
    (FPlatformVariant.macOS, 'macOS', 28.0),
    (FPlatformVariant.iOS, 'iOS', 44.0),
  ]) {
    testWidgets('$platformName item has consistent height ($height)', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: platform,
          child: FItem(key: const Key('item'), title: const Text('Item'), onPress: () {}),
        ),
      );

      expect(tester.getSize(find.byKey(const Key('item'))).height, closeTo(height, 0.001));
    });

    testWidgets('$platformName raw item has consistent height ($height)', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: platform,
          child: FItem.raw(key: const Key('raw-item'), onPress: () {}, child: const Text('Item')),
        ),
      );

      expect(tester.getSize(find.byKey(const Key('raw-item'))).height, closeTo(height, 0.001));
    });
  }
}

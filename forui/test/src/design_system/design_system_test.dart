import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('consistent height', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: Column(
          mainAxisSize: .min,
          children: [
            FButton(key: const Key('button'), onPress: () {}, child: const Text('Button')),
            FButton.icon(key: const Key('icon-button'), onPress: () {}, child: const Icon(FIcons.search)),
            FMultiSelect(key: const Key('multi-select'), items: const {'A': 'A', 'B': 'B'}),
            const FTextField(key: Key('field'), hint: 'hint'),
          ],
        ),
      ),
    );

    final textFieldHeight = tester.getSize(find.byKey(const Key('field'))).height;

    expect(tester.getSize(find.byKey(const Key('button'))).height, textFieldHeight);
    expect(tester.getSize(find.byKey(const Key('icon-button'))).height, textFieldHeight);
    expect(tester.getSize(find.byKey(const Key('multi-select'))).height, textFieldHeight);
  });

  for (final (size, name) in [
    (FButtonSizeVariant.xs, 'xs'),
    (FButtonSizeVariant.sm, 'sm'),
    (null, 'base'),
    (FButtonSizeVariant.lg, 'lg'),
  ]) {
    testWidgets('$name button and icon button have consistent height', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            mainAxisSize: .min,
            children: [
              FButton(key: const Key('button'), size: size, onPress: () {}, child: const Text('Button')),
              FButton.icon(key: const Key('icon-button'), size: size, onPress: () {}, child: const Icon(FIcons.search)),
            ],
          ),
        ),
      );

      expect(
        tester.getSize(find.byKey(const Key('button'))).height,
        tester.getSize(find.byKey(const Key('icon-button'))).height,
      );
    });
  }
}

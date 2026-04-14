import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName, height) in [
      (FThemes.neutral.light.desktop, 'desktop', 54.0),
      (FThemes.neutral.light.touch, 'touch', 62.0),
    ]) {
      testWidgets('$themeName FHeader and FHeader.nested have consistent height ($height) without actions', (
        tester,
      ) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: const Column(
              mainAxisSize: .min,
              children: [
                FHeader(key: Key('root'), title: Text('Root')),
                FHeader.nested(key: Key('nested'), title: Text('Nested')),
              ],
            ),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('root'))).height, closeTo(height, 0.001));
        expect(tester.getSize(find.byKey(const Key('nested'))).height, closeTo(height, 0.001));
      });

      testWidgets('$themeName FHeader and FHeader.nested have consistent height ($height) with actions', (
        tester,
      ) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: Column(
              mainAxisSize: .min,
              children: [
                FHeader(
                  key: const Key('root'),
                  title: const Text('Root'),
                  suffixes: [FHeaderAction(icon: const Icon(FIcons.bell), onPress: () {})],
                ),
                FHeader.nested(
                  key: const Key('nested'),
                  title: const Text('Nested'),
                  prefixes: [FHeaderAction.back(onPress: () {})],
                  suffixes: [FHeaderAction(icon: const Icon(FIcons.bell), onPress: () {})],
                ),
              ],
            ),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('root'))).height, closeTo(height, 0.001));
        expect(tester.getSize(find.byKey(const Key('nested'))).height, closeTo(height, 0.001));
      });
    }
  });
}

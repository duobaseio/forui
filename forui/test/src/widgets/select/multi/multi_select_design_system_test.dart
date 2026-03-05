@TestOn('mac-os')
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  for (final (theme, themeName, sizes) in [
    (
      FThemes.neutral.light.desktop,
      'desktop',
      [
        (FTextFieldSizeVariant.sm, 'sm', 32.0),
        (FTextFieldSizeVariant.md, 'md', 36.0),
        (FTextFieldSizeVariant.lg, 'lg', 40.0),
      ],
    ),
    (
      FThemes.neutral.light.touch,
      'touch',
      [
        (FTextFieldSizeVariant.sm, 'sm', 40.0),
        (FTextFieldSizeVariant.md, 'md', 44.0),
        (FTextFieldSizeVariant.lg, 'lg', 48.0),
      ],
    ),
  ]) {
    for (final (size, name, height) in sizes) {
      testWidgets('$themeName $name empty multi-select has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FMultiSelect<String>(items: const {}, size: size, key: key),
          ),
        );

        expect(tester.getSize(find.byKey(key)).height, closeTo(height, 0.001));
      });

      testWidgets('$themeName $name multi-select with 1 item has consistent height ($height)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FMultiSelect<String>(
              items: const {'Item': 'item'},
              control: const .managed(initial: {'item'}),
              size: size,
              key: key,
            ),
          ),
        );

        expect(tester.getSize(find.byKey(key)).height, closeTo(height, 0.001));
      });
    }
  }
}

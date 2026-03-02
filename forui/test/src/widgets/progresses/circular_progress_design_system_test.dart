@TestOn('mac-os')
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (theme, themeName, sizes) in [
    (
      FThemes.neutral.light.desktop,
      'desktop',
      [
        (FCircularProgressSizeVariant.xs, 'xs', 12.0),
        (FCircularProgressSizeVariant.sm, 'sm', 14.0),
        (FCircularProgressSizeVariant.md, 'md', 16.0),
        (FCircularProgressSizeVariant.lg, 'lg', 18.0),
        (FCircularProgressSizeVariant.xl, 'xl', 20.0),
      ],
    ),
    (
      FThemes.neutral.light.touch,
      'touch',
      [
        (FCircularProgressSizeVariant.xs, 'xs', 14.0),
        (FCircularProgressSizeVariant.sm, 'sm', 16.0),
        (FCircularProgressSizeVariant.md, 'md', 18.0),
        (FCircularProgressSizeVariant.lg, 'lg', 20.0),
        (FCircularProgressSizeVariant.xl, 'xl', 22.0),
      ],
    ),
  ]) {
    for (final (size, name, iconSize) in sizes) {
      testWidgets('$themeName $name has consistent icon size ($iconSize)', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FCircularProgress(size: size),
          ),
        );

        final iconTheme = tester.widget<IconTheme>(find.byType(IconTheme).last);
        expect(iconTheme.data.size, iconSize);
      });
    }
  }
}

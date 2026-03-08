import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('ticker provider', (tester) async {
    await tester.pumpWidget(TestScaffold(theme: FThemes.neutral.light.touch, child: const FCircularProgress()));
    await tester.pump();

    await tester.pumpWidget(TestScaffold(theme: FThemes.neutral.dark.touch, child: const FCircularProgress()));
    await tester.pump();

    expect(tester.takeException(), null);
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName) in [
      (FThemes.neutral.light.desktop, 'desktop'),
      (FThemes.neutral.light.touch, 'touch'),
    ]) {
      for (final (size, name, iconSize) in [
        (FCircularProgressSizeVariant.xs, 'xs', theme.typography.xs.fontSize!),
        (FCircularProgressSizeVariant.sm, 'sm', theme.typography.sm.fontSize!),
        (FCircularProgressSizeVariant.md, 'md', theme.typography.md.fontSize!),
        (FCircularProgressSizeVariant.lg, 'lg', theme.typography.lg.fontSize!),
        (FCircularProgressSizeVariant.xl, 'xl', theme.typography.xl.fontSize!),
      ]) {
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
  });
}

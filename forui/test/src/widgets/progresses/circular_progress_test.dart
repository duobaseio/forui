import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('ticker provider', (tester) async {
    await tester.pumpWidget(TestScaffold(theme: FTheme.neutral.light.touch, child: const FCircularProgress()));
    await tester.pump();

    await tester.pumpWidget(TestScaffold(theme: FTheme.neutral.dark.touch, child: const FCircularProgress()));
    await tester.pump();

    expect(tester.takeException(), null);
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (theme, themeName) in [
      (FTheme.neutral.light.desktop, 'desktop'),
      (FTheme.neutral.light.touch, 'touch'),
    ]) {
      for (final (size, name, iconSize) in [
        (FCircularProgressSizeVariant.xs, 'xs', theme.typography.body.xs.fontSize!),
        (FCircularProgressSizeVariant.sm, 'sm', theme.typography.body.sm.fontSize!),
        (FCircularProgressSizeVariant.md, 'md', theme.typography.body.md.fontSize!),
        (FCircularProgressSizeVariant.lg, 'lg', theme.typography.body.lg.fontSize!),
        (FCircularProgressSizeVariant.xl, 'xl', theme.typography.body.xl.fontSize!),
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

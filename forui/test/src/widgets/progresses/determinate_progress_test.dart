import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('ticker provider', (tester) async {
    await tester.pumpWidget(
      TestScaffold(theme: FThemes.neutral.light.touch, child: const FDeterminateProgress(value: 0.5)),
    );
    await tester.pump();

    await tester.pumpWidget(
      TestScaffold(theme: FThemes.neutral.dark.touch, child: const FDeterminateProgress(value: 0.6)),
    );
    await tester.pump();

    expect(tester.takeException(), null);
  });

  for (final curve in [Curves.linear, Curves.easeInOut, Curves.elasticOut]) {
    testWidgets('settles at exact value with $curve', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.neutral.light.touch,
          child: FDeterminateProgress(
            value: 0.5,
            style: .delta(motion: .delta(curve: curve)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox)).widthFactor, 0.5);
    });
  }

  testWidgets('does not restart animation when rebuilt with the same value', (tester) async {
    Widget tree() =>
        TestScaffold(theme: FThemes.neutral.light.touch, child: const FDeterminateProgress(value: 0.5));

    await tester.pumpWidget(tree());
    await tester.pump(const Duration(milliseconds: 500));

    await tester.pumpWidget(tree());
    await tester.pump(const Duration(milliseconds: 500));

    expect(tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox)).widthFactor, 0.5);
  });
}

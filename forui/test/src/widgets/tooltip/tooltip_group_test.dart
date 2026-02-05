import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTooltipGroup', () {
    testWidgets('hover eliminates warmup', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltipGroup(
            activeDuration: const Duration(seconds: 1),
            child: Row(
              children: [
                FTooltip(
                  tipBuilder: (_, _) => const Text('Tooltip 1'),
                  child: const Text('Target 1'),
                ),
                FTooltip(
                  tipBuilder: (_, _) => const Text('Tooltip 2'),
                  child: const Text('Target 2'),
                ),
              ],
            ),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('Target 1')));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Tooltip 1'), findsNothing);

      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(find.text('Tooltip 1'), findsOneWidget);

      await gesture.moveTo(tester.getCenter(find.text('Target 2')));
      await tester.pump();
      expect(find.text('Tooltip 2'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('long press eliminates warmup', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltipGroup(
            activeDuration: const Duration(seconds: 1),
            child: Row(
              children: [
                FTooltip(
                  tipBuilder: (_, _) => const Text('Tooltip 1'),
                  child: const Text('Target 1'),
                ),
                FTooltip(
                  tipBuilder: (_, _) => const Text('Tooltip 2'),
                  child: const Text('Target 2'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Target 1'));
      await tester.pumpAndSettle();
      expect(find.text('Tooltip 1'), findsOneWidget);

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('Target 2')));
      await tester.pump();
      expect(find.text('Tooltip 2'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}

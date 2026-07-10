import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCollapsible', () {
    testWidgets('relayouts when axis changes', (tester) async {
      await tester.pumpWidget(
        TestScaffold(child: const FCollapsible(value: 0.5, child: SizedBox.square(dimension: 50))),
      );

      expect(tester.getSize(find.byType(FCollapsible)), const Size(50, 25));

      await tester.pumpWidget(
        TestScaffold(
          child: const FCollapsible(value: 0.5, axis: Axis.horizontal, child: SizedBox.square(dimension: 50)),
        ),
      );

      expect(tester.getSize(find.byType(FCollapsible)), const Size(25, 50));
    });

    group('accessibility', () {
      testWidgets('excludes collapsed content from semantics', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(TestScaffold(child: const FCollapsible(value: 0, child: Text('content'))));
        expect(find.bySemanticsLabel('content'), findsNothing);

        await tester.pumpWidget(TestScaffold(child: const FCollapsible(value: 1, child: Text('content'))));
        expect(find.bySemanticsLabel('content'), findsOneWidget);

        handle.dispose();
      });

      testWidgets('excludes collapsed content from focus traversal', (tester) async {
        final node = FocusNode();
        addTearDown(node.dispose);

        await tester.pumpWidget(
          TestScaffold(
            child: FCollapsible(
              value: 0,
              child: Focus(focusNode: node, child: const SizedBox.square(dimension: 40)),
            ),
          ),
        );
        node.requestFocus();
        await tester.pump();
        expect(node.hasFocus, false);

        await tester.pumpWidget(
          TestScaffold(
            child: FCollapsible(
              value: 1,
              child: Focus(focusNode: node, child: const SizedBox.square(dimension: 40)),
            ),
          ),
        );
        node.requestFocus();
        await tester.pump();
        expect(node.hasFocus, true);
      });
    });
  });
}

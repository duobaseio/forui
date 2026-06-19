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
  });
}

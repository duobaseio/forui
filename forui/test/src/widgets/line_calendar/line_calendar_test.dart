import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('accessibility', () {
    testWidgets('day belongs to a mutually exclusive group and exposes its selected state', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(scrollControl: .managed(today: DateTime(2024, 11, 28))),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('November 29, 2024')),
        isSemantics(isInMutuallyExclusiveGroup: true, hasSelectedState: true, isSelected: false),
      );

      await tester.tap(find.text('29').last);
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('November 29, 2024')),
        isSemantics(isInMutuallyExclusiveGroup: true, hasSelectedState: true, isSelected: true),
      );

      semantics.dispose();
    });

    testWidgets("day's label includes its today status", (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(scrollControl: .managed(today: DateTime(2024, 11, 28))),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('November 28, 2024, Today'), findsOne);
      expect(find.bySemanticsLabel('November 27, 2024'), findsOne);

      semantics.dispose();
    });
  });
}

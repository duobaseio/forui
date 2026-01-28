import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('onVariantChange & onHoverChange callback called', (tester) async {
    Set<FTappableVariant>? previous;
    Set<FTappableVariant>? current;
    bool? hovered;
    await tester.pumpWidget(
      TestScaffold(
        child: FHeader.nested(
          title: const Text('Title'),
          prefixes: [
            FHeaderAction.back(
              onHoverChange: (v) => hovered = v,
              onVariantChange: (p, c) {
                previous = p;
                current = c;
              },
              onPress: () {},
            ),
          ],
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byType(FHeaderAction)));
    await tester.pumpAndSettle();

    expect(previous, isNot(contains(FTappableVariant.hovered)));
    expect(current, contains(FTappableVariant.hovered));
    expect(hovered, true);

    await gesture.moveTo(.zero);
    await tester.pumpAndSettle();

    expect(previous, contains(FTappableVariant.hovered));
    expect(current, isNot(contains(FTappableVariant.hovered)));
    expect(hovered, false);
  });
}

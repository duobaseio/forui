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
        child: FBottomNavigationBar(
          children: [
            FBottomNavigationBarItem(
              icon: const Icon(FLucideIcons.house),
              label: const Text('Home'),
              onVariantChange: (p, c) {
                previous = p;
                current = c;
              },
              onHoverChange: (v) => hovered = v,
            ),
          ],
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('Home')));
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

  group('accessibility', () {
    testWidgets('labelled item announces its label, position and selected state', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const FBottomNavigationBar(
            index: 2,
            children: [
              FBottomNavigationBarItem(icon: Icon(FLucideIcons.house), label: Text('Home')),
              FBottomNavigationBarItem(icon: Icon(FLucideIcons.layoutGrid), label: Text('Browse')),
              FBottomNavigationBarItem(icon: Icon(FLucideIcons.radio), label: Text('Radio')),
            ],
          ),
        ),
      );

      expect(
        tester.getSemantics(find.text('Home')),
        isSemantics(label: 'Home\nTab 1 of 3', isButton: true, isSelected: false),
      );
      expect(
        tester.getSemantics(find.text('Radio')),
        isSemantics(label: 'Radio\nTab 3 of 3', isButton: true, isSelected: true),
      );
    });

    testWidgets('icon-only item is announced via its semanticsLabel', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const FBottomNavigationBar(
            children: [
              FBottomNavigationBarItem(icon: Icon(FLucideIcons.house), semanticsLabel: 'Home'),
              FBottomNavigationBarItem(icon: Icon(FLucideIcons.radio), semanticsLabel: 'Radio'),
            ],
          ),
        ),
      );

      expect(
        tester.getSemantics(find.bySemanticsLabel(RegExp('Home'))),
        isSemantics(label: 'Home\nTab 1 of 2', isButton: true),
      );
    });
  });
}

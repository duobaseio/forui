import 'dart:io';

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

  group('design system', skip: !Platform.isMacOS, () {
    group('root header', () {
      testWidgets('consistent height with and without actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: FThemeData(touch: true, colors: FColors.neutral.light),
            child: Column(
              mainAxisSize: .min,
              children: [
                FHeader(
                  key: const Key('with-actions'),
                  title: const Text('Title'),
                  suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                ),
                const FHeader(key: Key('without-actions'), title: Text('Title')),
              ],
            ),
          ),
        );

        final withActions = tester.getSize(find.byKey(const Key('with-actions'))).height;
        final withoutActions = tester.getSize(find.byKey(const Key('without-actions'))).height;
        expect(withActions, withoutActions);
      });
    });

    group('nested header', () {
      testWidgets('consistent height with and without actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: FThemeData(touch: true, colors: FColors.neutral.light),
            child: Column(
              mainAxisSize: .min,
              children: [
                FHeader.nested(
                  key: const Key('with-actions'),
                  title: const Text('Title'),
                  prefixes: [FHeaderAction.back(onPress: () {})],
                  suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                ),
                const FHeader.nested(key: Key('without-actions'), title: Text('Title')),
              ],
            ),
          ),
        );

        final withActions = tester.getSize(find.byKey(const Key('with-actions'))).height;
        final withoutActions = tester.getSize(find.byKey(const Key('without-actions'))).height;
        expect(withActions, withoutActions);
      });
    });
  });
}

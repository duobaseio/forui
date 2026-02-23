import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  Widget buildGroup(
    List<({String label, VoidCallback? onPress, VoidCallback? onLongPress})> items, {
    double itemHeight = 50,
  }) => TestScaffold(
    child: FTappableGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items)
            SizedBox(
              height: itemHeight,
              width: 200,
              child: FTappable.static(onPress: item.onPress, onLongPress: item.onLongPress, child: Text(item.label)),
            ),
        ],
      ),
    ),
  );

  group('tap', () {
    testWidgets('fires onPress on tapped entry', (tester) async {
      var aCount = 0;
      var bCount = 0;
      await tester.pumpWidget(
        buildGroup([
          (label: 'A', onPress: () => aCount++, onLongPress: null),
          (label: 'B', onPress: () => bCount++, onLongPress: null),
        ]),
      );

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(aCount, 1);
      expect(bCount, 0);
    });

    testWidgets('does not fire when onPress is null', (tester) async {
      var bCount = 0;
      await tester.pumpWidget(
        buildGroup([
          (label: 'A', onPress: null, onLongPress: null),
          (label: 'B', onPress: () => bCount++, onLongPress: null),
        ]),
      );

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(bCount, 0);
    });

    testWidgets('secondary button does not trigger group', (tester) async {
      var count = 0;
      await tester.pumpWidget(buildGroup([(label: 'A', onPress: () => count++, onLongPress: null)]));

      await tester.tap(find.text('A'), buttons: kSecondaryButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(count, 0);
    });
  });

  group('long press', () {
    testWidgets('fires onLongPress after timeout', (tester) async {
      var longPressCount = 0;
      var pressCount = 0;
      await tester.pumpWidget(
        buildGroup([(label: 'A', onPress: () => pressCount++, onLongPress: () => longPressCount++)]),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

      expect(longPressCount, 1);
      expect(pressCount, 0);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(longPressCount, 1);
      expect(pressCount, 0);
    });

    testWidgets('fires onPress after timeout when onLongPress is null', (tester) async {
      var pressCount = 0;
      await tester.pumpWidget(buildGroup([(label: 'A', onPress: () => pressCount++, onLongPress: null)]));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

      expect(pressCount, 0);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(pressCount, 1);
    });

    testWidgets('does not fire before timeout', (tester) async {
      var longPressCount = 0;
      await tester.pumpWidget(buildGroup([(label: 'A', onPress: () {}, onLongPress: () => longPressCount++)]));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(const Duration(milliseconds: 200));

      expect(longPressCount, 0);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    });
  });

  group('slide across', () {
    group('press', () {
      testWidgets('press A, slide to B, lift fires B onPress', (tester) async {
        var aCount = 0;
        var bCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () => aCount++, onLongPress: null),
            (label: 'B', onPress: () => bCount++, onLongPress: null),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump();
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(aCount, 0);
        expect(bCount, 1);
      });

      testWidgets('press A, slide to B, slide to C, lift fires C onPress', (tester) async {
        var aCount = 0;
        var bCount = 0;
        var cCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () => aCount++, onLongPress: null),
            (label: 'B', onPress: () => bCount++, onLongPress: null),
            (label: 'C', onPress: () => cCount++, onLongPress: null),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('C')));
        await tester.pump();
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(aCount, 0);
        expect(bCount, 0);
        expect(cCount, 1);
      });

      testWidgets('press A, slide to empty, lift fires nothing', (tester) async {
        var count = 0;
        await tester.pumpWidget(buildGroup([(label: 'A', onPress: () => count++, onLongPress: null)]));

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(Offset.zero);
        await tester.pump();
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(count, 0);
      });

      testWidgets('press A, slide to B, slide to empty, lift fires nothing', (tester) async {
        var aCount = 0;
        var bCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () => aCount++, onLongPress: null),
            (label: 'B', onPress: () => bCount++, onLongPress: null),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump();
        await gesture.moveTo(Offset.zero);
        await tester.pump();
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(aCount, 0);
        expect(bCount, 0);
      });

      testWidgets('press A, slide to empty, slide to B, lift fires B onPress', (tester) async {
        var aCount = 0;
        var bCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () => aCount++, onLongPress: null),
            (label: 'B', onPress: () => bCount++, onLongPress: null),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(Offset.zero);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump();
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(aCount, 0);
        expect(bCount, 1);
      });

      testWidgets('press A, slide to B, lift before timeout fires B onPress', (tester) async {
        var bPressCount = 0;
        var bLongPressCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () {}, onLongPress: () {}),
            (label: 'B', onPress: () => bPressCount++, onLongPress: () => bLongPressCount++),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump(kLongPressTimeout - const Duration(milliseconds: 1));
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(bPressCount, 1);
        expect(bLongPressCount, 0);
      });
    });

    group('long press', () {
      testWidgets('press A, slide to B, hold past timeout fires B onLongPress', (tester) async {
        var aLongPressCount = 0;
        var aPressCount = 0;
        var bLongPressCount = 0;
        var bPressCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () => aPressCount++, onLongPress: () => aLongPressCount++),
            (label: 'B', onPress: () => bPressCount++, onLongPress: () => bLongPressCount++),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

        expect(aLongPressCount, 0);
        expect(aPressCount, 0);
        expect(bLongPressCount, 1);
        expect(bPressCount, 0);

        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(aLongPressCount, 0);
        expect(aPressCount, 0);
        expect(bLongPressCount, 1);
        expect(bPressCount, 0);
      });

      testWidgets('press A, slide to B, slide to C, hold past timeout fires C onLongPress', (tester) async {
        var aLongPressCount = 0;
        var bLongPressCount = 0;
        var cLongPressCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () {}, onLongPress: () => aLongPressCount++),
            (label: 'B', onPress: () {}, onLongPress: () => bLongPressCount++),
            (label: 'C', onPress: () {}, onLongPress: () => cLongPressCount++),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('C')));
        await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

        expect(aLongPressCount, 0);
        expect(bLongPressCount, 0);
        expect(cLongPressCount, 1);

        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
      });

      testWidgets('press A, slide to empty, slide to B, hold past timeout fires B onLongPress', (tester) async {
        var aLongPressCount = 0;
        var bLongPressCount = 0;
        var bPressCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () {}, onLongPress: () => aLongPressCount++),
            (label: 'B', onPress: () => bPressCount++, onLongPress: () => bLongPressCount++),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(Offset.zero);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

        expect(aLongPressCount, 0);
        expect(bLongPressCount, 1);
        expect(bPressCount, 0);

        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
      });

      testWidgets('press A, slide to B, slide to empty, hold past timeout fires nothing', (tester) async {
        var aLongPressCount = 0;
        var bLongPressCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () {}, onLongPress: () => aLongPressCount++),
            (label: 'B', onPress: () {}, onLongPress: () => bLongPressCount++),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump();
        await gesture.moveTo(Offset.zero);
        await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

        expect(aLongPressCount, 0);
        expect(bLongPressCount, 0);

        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
      });

      testWidgets('slide cancels initial long press timer', (tester) async {
        var longPressCount = 0;
        var bCount = 0;
        await tester.pumpWidget(
          buildGroup([
            (label: 'A', onPress: () {}, onLongPress: () => longPressCount++),
            (label: 'B', onPress: () => bCount++, onLongPress: null),
          ]),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
        await tester.pump(const Duration(milliseconds: 200));
        await gesture.moveTo(tester.getCenter(find.text('B')));
        await tester.pump(kLongPressTimeout);
        await gesture.up();
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(longPressCount, 0);
        expect(bCount, 1);
      });
    });
  });

  group('cancel', () {
    testWidgets('pointer cancel fires nothing', (tester) async {
      var count = 0;
      await tester.pumpWidget(buildGroup([(label: 'A', onPress: () => count++, onLongPress: null)]));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.cancel();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(count, 0);
    });

    testWidgets('pointer cancel during slide fires nothing', (tester) async {
      var aCount = 0;
      var bCount = 0;
      await tester.pumpWidget(
        buildGroup([
          (label: 'A', onPress: () => aCount++, onLongPress: null),
          (label: 'B', onPress: () => bCount++, onLongPress: null),
        ]),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();
      await gesture.cancel();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(aCount, 0);
      expect(bCount, 0);
    });
  });

  group('scrollable', () {
    Widget buildScrollableGroup(List<({String label, VoidCallback? onPress, VoidCallback? onLongPress})> items) =>
        TestScaffold(
          child: SizedBox(
            height: 200,
            child: ListView(
              children: [
                FTappableGroup(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final item in items)
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: FTappable.static(
                            onPress: item.onPress,
                            onLongPress: item.onLongPress,
                            child: Text(item.label),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 1000),
              ],
            ),
          ),
        );

    testWidgets('tap fires onPress', (tester) async {
      var count = 0;
      await tester.pumpWidget(buildScrollableGroup([(label: 'A', onPress: () => count++, onLongPress: null)]));

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(count, 1);
    });

    testWidgets('scroll does not fire onPress', (tester) async {
      var count = 0;
      await tester.pumpWidget(buildScrollableGroup([(label: 'A', onPress: () => count++, onLongPress: null)]));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.moveBy(const Offset(0, -50));
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(count, 0);
    });

    testWidgets('scroll cancels long press timer', (tester) async {
      var longPressCount = 0;
      var pressCount = 0;
      await tester.pumpWidget(
        buildScrollableGroup([(label: 'A', onPress: () => pressCount++, onLongPress: () => longPressCount++)]),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(const Duration(milliseconds: 200));
      await gesture.moveBy(const Offset(0, -50));
      await tester.pump(kLongPressTimeout);
      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(longPressCount, 0);
      expect(pressCount, 0);
    });

    testWidgets('long press fires onPress when onLongPress is null', (tester) async {
      var pressCount = 0;
      await tester.pumpWidget(buildScrollableGroup([(label: 'A', onPress: () => pressCount++, onLongPress: null)]));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

      expect(pressCount, 0);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(pressCount, 1);
    });

    testWidgets('long press fires without scrolling', (tester) async {
      var longPressCount = 0;
      var pressCount = 0;
      await tester.pumpWidget(
        buildScrollableGroup([(label: 'A', onPress: () => pressCount++, onLongPress: () => longPressCount++)]),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(kLongPressTimeout + const Duration(milliseconds: 1));

      expect(longPressCount, 1);
      expect(pressCount, 0);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    });
  });
}

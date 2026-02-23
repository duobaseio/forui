import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable/tappable.dart';
import '../../test_scaffold.dart';

// ignore: avoid_positional_boolean_parameters
Set<FTappableVariant> set(bool enabled) => {if (!enabled) .disabled, .android};

void main() {
  Widget buildGroup(List<({String label, GlobalKey<AnimatedTappableState>? key, VoidCallback? onPress})> items) =>
      TestScaffold(
        child: FTappableGroup(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in items)
                SizedBox(
                  key: ValueKey(item.label),
                  height: 50,
                  width: 200,
                  child: FTappable(
                    key: item.key,
                    onPress: item.onPress,
                    builder: (_, states, _) => Text('${item.label}: $states'),
                  ),
                ),
            ],
          ),
        ),
      );

  group('pressed variant', () {
    testWidgets('press and hold applies pressed variant', (tester) async {
      await tester.pumpWidget(buildGroup([(label: 'A', key: null, onPress: () {})]));
      expect(find.text('A: ${set(true)}'), findsOneWidget);

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('A: ${{...set(true), FTappableVariant.pressed}}'), findsOneWidget);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
    });

    testWidgets('release removes pressed variant', (tester) async {
      await tester.pumpWidget(buildGroup([(label: 'A', key: null, onPress: () {})]));

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('A: ${{...set(true), FTappableVariant.pressed}}'), findsOneWidget);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('A: ${set(true)}'), findsOneWidget);
    });

    testWidgets('slide-across transfers pressed variant', (tester) async {
      await tester.pumpWidget(
        buildGroup([(label: 'A', key: null, onPress: () {}), (label: 'B', key: null, onPress: () {})]),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('A: ${{...set(true), FTappableVariant.pressed}}'), findsOneWidget);
      expect(find.text('B: ${set(true)}'), findsOneWidget);

      await gesture.moveTo(tester.getCenter(find.byKey(const ValueKey('B'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('A: ${set(true)}'), findsOneWidget);
      expect(find.text('B: ${{...set(true), FTappableVariant.pressed}}'), findsOneWidget);

      await gesture.up();
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('B: ${set(true)}'), findsOneWidget);
    });
  });

  group('bounce animation', () {
    testWidgets('bounce down on press', (tester) async {
      final key = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(buildGroup([(label: 'A', key: key, onPress: () {})]));
      expect(key.currentState?.bounce.value, 1.0);

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(key.currentState?.bounce.value, 0.97);

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('bounce up on release', (tester) async {
      final key = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(buildGroup([(label: 'A', key: key, onPress: () {})]));

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(key.currentState?.bounce.value, 0.97);

      await gesture.up();
      await tester.pumpAndSettle();
      expect(key.currentState?.bounce.value, 1.0);
    });

    testWidgets('bounce transfers on slide-across', (tester) async {
      final keyA = GlobalKey<AnimatedTappableState>();
      final keyB = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(
        buildGroup([(label: 'A', key: keyA, onPress: () {}), (label: 'B', key: keyB, onPress: () {})]),
      );
      expect(keyA.currentState?.bounce.value, 1.0);
      expect(keyB.currentState?.bounce.value, 1.0);

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(keyA.currentState?.bounce.value, 0.97);
      expect(keyB.currentState?.bounce.value, 1.0);

      await gesture.moveTo(tester.getCenter(find.byKey(const ValueKey('B'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(keyA.currentState?.bounce.value, 1.0);
      expect(keyB.currentState?.bounce.value, 0.97);

      await gesture.up();
      await tester.pumpAndSettle();
      expect(keyB.currentState?.bounce.value, 1.0);
    });

    testWidgets('bounce on long press', (tester) async {
      final key = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(buildGroup([(label: 'A', key: key, onPress: () {})]));
      expect(key.currentState?.bounce.value, 1.0);

      final gesture = await tester.startGesture(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(key.currentState?.bounce.value, 0.97);

      // Hold through long press timeout — bounce stays down.
      await tester.pump(kLongPressTimeout);
      expect(key.currentState?.bounce.value, 0.97);

      await gesture.up();
      await tester.pumpAndSettle();
      expect(key.currentState?.bounce.value, 1.0);
    });
  });

  group('gestures not managed by group', () {
    testWidgets('onDoubleTap still fires', (tester) async {
      var count = 0;
      await tester.pumpWidget(
        TestScaffold(
          child: FTappableGroup(
            child: SizedBox(
              height: 50,
              width: 200,
              child: FTappable(onPress: () {}, onDoubleTap: () => count++, child: const Text('tap')),
            ),
          ),
        ),
      );

      await tester.tap(find.text('tap'));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.text('tap'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(count, 1);
    });

    testWidgets('onSecondaryPress still fires', (tester) async {
      var count = 0;
      await tester.pumpWidget(
        TestScaffold(
          child: FTappableGroup(
            child: SizedBox(
              height: 50,
              width: 200,
              child: FTappable(onPress: () {}, onSecondaryPress: () => count++, child: const Text('tap')),
            ),
          ),
        ),
      );

      await tester.tap(find.text('tap'), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(count, 1);
    });
  });

  group('hover and focus', () {
    testWidgets('hover still works', (tester) async {
      await tester.pumpWidget(buildGroup([(label: 'A', key: null, onPress: () {})]));
      expect(find.text('A: ${set(true)}'), findsOneWidget);

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byKey(const ValueKey('A'))));
      await tester.pumpAndSettle();
      expect(find.text('A: ${{...set(true), FTappableVariant.hovered}}'), findsOneWidget);

      await gesture.moveTo(.zero);
      await tester.pumpAndSettle();
      expect(find.text('A: ${set(true)}'), findsOneWidget);
    });

    testWidgets('focus still works', (tester) async {
      final focusNode = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold(
          child: FTappableGroup(
            child: SizedBox(
              height: 50,
              width: 200,
              child: FTappable(focusNode: focusNode, onPress: () {}, builder: (_, states, _) => Text('$states')),
            ),
          ),
        ),
      );
      expect(find.text(set(true).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(
        find.text({...set(true), FTappableVariant.focused, FTappableVariant.primaryFocused}.toString()),
        findsOneWidget,
      );
    });
  });
}

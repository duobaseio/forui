import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/toast/toaster.dart';
import '../../test_scaffold.dart';

Widget small(
  String text, [
  String? button,
  FToastAlignment alignment = .bottomRight,
  Duration? duration = const Duration(seconds: 5),
]) => Builder(
  builder: (context) => FButton(
    mainAxisSize: .min,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      duration: duration,
      builder: (_, _) => Container(
        width: 250,
        height: 143,
        alignment: .center,
        decoration: BoxDecoration(border: .all(), borderRadius: .circular(8), color: Colors.blue),
        child: Text(text),
      ),
    ),
    child: Text(button ?? text),
  ),
);

Widget button([
  FToastAlignment alignment = .bottomRight,
  List<AxisDirection>? swipeToDismiss,
  Duration? duration = const Duration(seconds: 5),
  double dismissThreshold = 0.5,
]) => Builder(
  builder: (context) => FButton(
    mainAxisSize: .min,
    onPress: () {
      for (var i = 1; i <= 3; i++) {
        showRawFToast(
          alignment: alignment,
          swipeToDismiss: swipeToDismiss,
          dismissThreshold: dismissThreshold,
          context: context,
          duration: duration,
          builder: (_, _) => Container(
            width: 250,
            height: 143,
            alignment: .center,
            decoration: BoxDecoration(border: .all(), borderRadius: .circular(8), color: Colors.blue),
            child: Text('$i'),
          ),
        );
      }
    },
    child: const Text('button'),
  ),
);

void main() {
  group('FToasterStyle.inherit', () {
    test('defaults toastAlignment to topCenter on touch', () {
      expect(FTheme.neutral.light.touch.toasterStyle.toastAlignment, FToastAlignment.topCenter);
    });

    test('defaults toastAlignment to bottomEnd on desktop', () {
      expect(FTheme.neutral.light.desktop.toasterStyle.toastAlignment, FToastAlignment.bottomEnd);
    });
  });

  group('default swipeToDismiss', () {
    for (final (FToastAlignment alignment, TextDirection textDirection, List<AxisDirection> expected) in [
      (.topCenter, .ltr, [.up]),
      (.bottomCenter, .ltr, [.down]),
      (.topLeft, .ltr, [.up, .left]),
      (.topRight, .ltr, [.up, .right]),
      (.bottomLeft, .ltr, [.down, .left]),
      (.bottomRight, .ltr, [.down, .right]),
      (.topStart, .ltr, [.up, .left]),
      (.topEnd, .ltr, [.up, .right]),
      (.topStart, .rtl, [.up, .right]),
      (.bottomEnd, .rtl, [.down, .left]),
    ]) {
      testWidgets('$alignment ($textDirection) has $expected swipe to dismiss', (tester) async {
        late BuildContext capturedContext;
        await tester.pumpWidget(
          TestScaffold(
            child: Directionality(
              textDirection: textDirection,
              child: FToaster(
                child: Builder(
                  builder: (context) {
                    capturedContext = context;
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        );

        final entry =
            showRawFToast(
                  context: capturedContext,
                  alignment: alignment,
                  builder: (_, _) => const SizedBox(width: 100, height: 50),
                )
                as ToasterEntry;

        expect(entry.swipeToDismiss, expected);
      });
    }
  });

  for (final behavior in FToasterExpandBehavior.values) {
    group('$behavior', () {
      testWidgets('auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: .delta(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: .min, children: [small('1')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));

        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.text('1'), findsOne);
      });

      testWidgets('does not auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: .delta(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: .min, children: [small('1', null, .bottomRight, null)]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));

        await tester.pumpAndSettle(const Duration(seconds: 10));

        expect(find.text('1'), findsExactly(2));
      });

      testWidgets('hover stops auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: .delta(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: .min, children: [small('1')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('1').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await tester.pumpAndSettle(const Duration(seconds: 10));

        expect(find.text('1'), findsExactly(2));
      });

      testWidgets('press stops auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: .delta(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: .min, children: [small('1'), small('2'), small('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));
        expect(find.text('2'), findsExactly(2));
        expect(find.text('3'), findsExactly(2));

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle(const Duration(seconds: 10));

        expect(find.text('1'), findsExactly(2));
        expect(find.text('2'), findsExactly(2));
        expect(find.text('3'), findsExactly(2));
      });
    });
  }

  testWidgets('hover over non-first toast prevents auto-dismiss', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FToaster(
          child: Center(
            child: Column(mainAxisSize: .min, children: [button()]),
          ),
        ),
      ),
    );

    await tester.tap(find.text('button'));
    await tester.pumpAndSettle();

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('3')));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await gesture.moveTo(tester.getCenter(find.text('2')));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('1'), findsOne);
    expect(find.text('2'), findsOne);
    expect(find.text('3'), findsOne);
  });

  group('swipe to dismiss', () {
    const offsets = [
      Offset(-200, 0), // left
      Offset(200, 0), // right
      Offset(0, -100), // up
      Offset(0, 100), // down
    ];

    for (final (direction, offset) in [
      (AxisDirection.left, const Offset(-200, 0)),
      (AxisDirection.right, const Offset(200, 0)),
      (AxisDirection.up, const Offset(0, -100)),
      (AxisDirection.down, const Offset(0, 100)),
    ]) {
      group('$direction', () {
        testWidgets('dismiss', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: FToaster(
                child: Center(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      button(.bottomCenter, [direction]),
                    ],
                  ),
                ),
              ),
            ),
          );

          await tester.tap(find.text('button'));
          await tester.pumpAndSettle();

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('3')));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
          await tester.pumpAndSettle();

          expect(find.text('1'), findsOne);
          expect(find.text('2'), findsNothing);
          expect(find.text('3'), findsOne);
        });

        testWidgets('same direction does not dismiss', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: FToaster(
                child: Center(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      button(.bottomCenter, [direction]),
                    ],
                  ),
                ),
              ),
            ),
          );

          await tester.tap(find.text('button'));
          await tester.pumpAndSettle();

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('3')));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await tester.timedDrag(find.text('2'), offset * 0.5, const Duration(seconds: 1));
          await tester.pumpAndSettle();

          expect(find.text('1'), findsOne);
          expect(find.text('2'), findsOne);
          expect(find.text('3'), findsOne);
        });

        testWidgets('disabled does not dismiss', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: FToaster(
                child: Center(
                  child: Column(mainAxisSize: .min, children: [button(.bottomCenter, [])]),
                ),
              ),
            ),
          );

          await tester.tap(find.text('button'));
          await tester.pumpAndSettle();

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('3')));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
          await tester.pumpAndSettle();

          expect(find.text('1'), findsOne);
          expect(find.text('2'), findsOne);
          expect(find.text('3'), findsOne);
        });

        for (final offset in offsets.whereNot((o) => o == offset)) {
          testWidgets('$offset - different direction - does not dismiss', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                child: FToaster(
                  child: Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        button(.bottomCenter, [direction]),
                      ],
                    ),
                  ),
                ),
              ),
            );

            await tester.tap(find.text('button'));
            await tester.pumpAndSettle();

            final gesture = await tester.createPointerGesture();
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.text('3')));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
            await tester.pumpAndSettle();

            expect(find.text('1'), findsOne);
            expect(find.text('2'), findsOne);
            expect(find.text('3'), findsOne);
          });
        }
      });
    }

    for (final (threshold, offset, dismissed) in [
      (0.3, const Offset(-100, 0), true),
      (0.8, const Offset(-100, 0), false),
      (0.3, const Offset(0, -70), true),
      (0.8, const Offset(0, -70), false),
    ]) {
      testWidgets('dismissThreshold $threshold with $offset - ${dismissed ? 'dismisses' : 'does not dismiss'}', (
        tester,
      ) async {
        final direction = offset.dx == 0 ? AxisDirection.up : AxisDirection.left;

        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    button(.bottomCenter, [direction], const Duration(seconds: 5), threshold),
                  ],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('button'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('3')));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
        await tester.pumpAndSettle();

        expect(find.text('2'), dismissed ? findsNothing : findsOne);
      });
    }
  });

  testWidgets('SelectableText inside toast has Overlay ancestor', (tester) async {
    // FToaster is placed in MaterialApp.builder (above the Navigator's Overlay) to replicate the typical app setup.
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: FLocalizations.localizationsDelegates,
        supportedLocales: FLocalizations.supportedLocales,
        builder: (context, child) => FTheme(
          data: FTheme.neutral.light.touch,
          child: FToaster(child: child!),
        ),
        home: Builder(
          builder: (context) => Center(
            child: FButton(
              mainAxisSize: .min,
              onPress: () => showRawFToast(
                alignment: .bottomRight,
                context: context,
                duration: null,
                builder: (_, _) => const SizedBox(width: 250, child: SelectableText('selectable')),
              ),
              child: const Text('show'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('show'));
    await tester.pumpAndSettle();

    expect(find.text('selectable'), findsOne);

    await tester.longPress(find.text('selectable'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

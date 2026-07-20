import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('basic', (tester) async {
      var shown = false;

      Future<void> rebuild() async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              control: .lifted(shown: shown, onChange: (value) => shown = value),
              tipBuilder: (_, _) => const Text('Tooltip'),
              child: const SizedBox.square(dimension: 100),
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      await rebuild();
      expect(find.text('Tooltip'), findsNothing);

      shown = true;
      await rebuild();
      expect(find.text('Tooltip'), findsOneWidget);

      shown = false;
      await rebuild();
      expect(find.text('Tooltip'), findsNothing);

      shown = true;
      await rebuild();
      expect(find.text('Tooltip'), findsOneWidget);

      shown = false;
      await rebuild();
      expect(find.text('Tooltip'), findsNothing);
    });

    testWidgets('does nothing', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            control: .lifted(shown: false, onChange: (_) {}),
            tipBuilder: (_, _) => const Text('Tooltip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Tooltip'), findsNothing);
    });
  });

  group('managed', () {
    testWidgets('onChange', (tester) async {
      final controller = FTooltipController(vsync: tester);
      addTearDown(controller.dispose);
      var value = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            control: .managed(controller: controller, onChange: (v) => value = v),
            tipBuilder: (_, _) => const Text('Tooltip'),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();
      expect(value, true);

      unawaited(controller.hide());
      await tester.pumpAndSettle();
      expect(value, false);
    });
  });

  testWidgets('does nothing', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTooltip(
          hover: false,
          longPress: false,
          tipBuilder: (context, _) => const Text('tip'),
          child: FButton(onPress: () {}, child: const Text('button')),
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byType(FButton)));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('tip'), findsNothing);
  });

  testWidgets('wraps long tip text within the viewport', (tester) async {
    tester.view.physicalSize = const Size(400, 600);
    tester.view.devicePixelRatio = 1.0;
    tester.view.padding = FakeViewPadding.zero;
    addTearDown(tester.view.reset);

    const tip =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et '
        'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex '
        'ea commodo consequat.';

    final controller = FTooltipController(vsync: tester);
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestScaffold.app(
        padded: false,
        child: FTooltip(
          control: .managed(controller: controller),
          tipBuilder: (_, _) => const Text(tip),
          child: const SizedBox.square(dimension: 20),
        ),
      ),
    );

    unawaited(controller.show());
    await tester.pumpAndSettle();

    expect(tester.getSize(find.text(tip)).width, lessThanOrEqualTo(400));
  });

  testWidgets('caps the tip at the style constraints', (tester) async {
    const tip =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et '
        'dolore magna aliqua.';

    final controller = FTooltipController(vsync: tester);
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FTooltip(
          style: const .delta(constraints: BoxConstraints(maxWidth: 150)),
          control: .managed(controller: controller),
          tipBuilder: (_, _) => const Text(tip),
          child: const SizedBox.square(dimension: 20),
        ),
      ),
    );

    unawaited(controller.show());
    await tester.pumpAndSettle();

    expect(tester.getSize(find.text(tip)).width, lessThanOrEqualTo(150));
  });

  group('long press', () {
    testWidgets('shows tooltip', (tester) async {
      const duration = Duration(milliseconds: 1000);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            style: const .delta(longPressExitDuration: duration),
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      await tester.longPress(find.byType(FButton));
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsOneWidget);

      await tester.pumpAndSettle(kLongPressTimeout + kPressTimeout + duration);

      expect(find.text('tip'), findsNothing);
    });

    testWidgets('re-long-press shows resets longPressExitDuration', (tester) async {
      const duration = Duration(milliseconds: 1000);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            style: const .delta(longPressExitDuration: duration),
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      await tester.longPress(find.byType(FButton));
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsOneWidget);
      await tester.pumpAndSettle(kLongPressTimeout + kPressTimeout + const Duration(milliseconds: 100));

      await tester.longPress(find.byType(FButton));
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsOneWidget);
      await tester.pumpAndSettle(kLongPressTimeout + kPressTimeout + const Duration(milliseconds: 1000));

      expect(find.text('tip'), findsNothing);
    });
  });

  group('hover', () {
    testWidgets('hover shows tooltip', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsOneWidget);

      await gesture.moveTo(.zero);
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsNothing);
    });

    testWidgets('hover enter and re-enter resets hoverEnterDuration', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            style: const .delta(hoverEnterDuration: Duration(seconds: 1)),
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle();

      await gesture.moveTo(.zero);
      await tester.pumpAndSettle();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsOneWidget);
    });

    testWidgets('hover exit and re-exit resets hoverExitDuration', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            style: const .delta(hoverEnterDuration: .zero, hoverExitDuration: Duration(seconds: 1)),
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle();

      await gesture.moveTo(.zero);
      await tester.pumpAndSettle();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle();

      await gesture.moveTo(.zero);
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsNothing);
    });

    testWidgets('tap hides tooltip even if child is GestureDetector', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsOneWidget);

      await tester.tapAt(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle();

      expect(find.text('tip'), findsNothing);
    });
  });

  group('focus', () {
    testWidgets('shows tooltip on immediate descendant primary focus', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            tipBuilder: (context, controller) => const Text('Tooltip'),
            child: DecoratedBox(
              decoration: BoxDecoration(border: .all()),
              child: Padding(
                padding: const .all(8.0),
                child: FTappable(
                  focusedOutlineStyle: FTheme.neutral.light.touch.style.focusedOutlineStyle,
                  onPress: () {},
                  child: Padding(
                    padding: const .all(8.0),
                    child: FButton.icon(onPress: () {}, child: const Icon(FLucideIcons.pencil)),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Tooltip'), findsOne);
    });

    testWidgets('hides tooltip on nested descendant primary focus', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            tipBuilder: (context, controller) => const Text('Tooltip'),
            child: DecoratedBox(
              decoration: BoxDecoration(border: .all()),
              child: Padding(
                padding: const .all(8.0),
                child: FTappable(
                  focusedOutlineStyle: FTheme.neutral.light.touch.style.focusedOutlineStyle,
                  onPress: () {},
                  child: Padding(
                    padding: const .all(8.0),
                    child: FButton.icon(onPress: () {}, child: const Icon(FLucideIcons.pencil)),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Tooltip'), findsOne);

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Tooltip'), findsNothing);
    });
  });

  group('accessibility', () {
    testWidgets('exposes the tip as the child tooltip without showing the overlay', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            semanticsLabel: 'Save',
            tipBuilder: (context, controller) => const Text('Save changes'),
            child: const Text('target'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Save changes'), findsNothing);
      expect(tester.getSemantics(find.text('target')).getSemanticsData().tooltip, 'Save');

      semantics.dispose();
    });

    testWidgets('tip remains visible when the pointer moves onto it', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsOneWidget);

      // Moving the pointer from the trigger onto the tip must not dismiss it (WCAG 1.4.13 hoverable).
      await gesture.moveTo(tester.getCenter(find.text('tip')));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsOneWidget);
    });
  });
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('lifted', (tester) async {
      var shown = false;

      Future<void> rebuild() async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopover(
              control: .lifted(shown: shown, onChange: (value) => shown = value),
              popoverBuilder: (_, _) => const Text('Popover'),
              child: const SizedBox.square(dimension: 100),
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      await rebuild();
      expect(find.text('Popover'), findsNothing);

      shown = true;
      await rebuild();
      expect(find.text('Popover'), findsOneWidget);

      shown = false;
      await rebuild();
      expect(find.text('Popover'), findsNothing);

      shown = true;
      await rebuild();
      expect(find.text('Popover'), findsOneWidget);

      shown = false;
      await rebuild();
      expect(find.text('Popover'), findsNothing);
    });
  });

  group('managed', () {
    testWidgets('onChange', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));
      var value = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller, onChange: (v) => value = v),
            popoverBuilder: (_, _) => const Text('Popover'),
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

  testWidgets('barrier blocks taps', (tester) async {
    var outside = 0;

    await tester.pumpWidget(
      TestScaffold.app(
        child: Row(
          mainAxisSize: .min,
          children: [
            FPopover(
              style: .delta(
                barrierFilter: (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
              ),
              popoverBuilder: (context, _) => const Text('popover'),
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
            ),
            const SizedBox(height: 10),
            FButton(onPress: () => outside++, child: const Text('outside')),
          ],
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tap(find.text('outside'), warnIfMissed: false); // expected to miss
    await tester.pumpAndSettle();

    expect(outside, 0);
  });

  testWidgets('tap outside hides popover', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          onTapHide: () => count++,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pumpAndSettle();

    expect(count, 1);
    expect(find.text('popover'), findsNothing);
  });

  testWidgets('tap outside with barrier hides popover', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          style: .delta(
            barrierFilter: (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
          ),
          onTapHide: () => count++,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tap(find.byType(FAnimatedModalBarrier));
    await tester.pumpAndSettle();

    expect(count, 1);
    expect(find.text('popover'), findsNothing);
  });

  testWidgets('tap outside with barrier and no hide region does not hide popover', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          style: .delta(
            barrierFilter: (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
          ),
          onTapHide: () => count++,
          hideRegion: .none,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pumpAndSettle();

    expect(count, 0);
    expect(find.text('popover'), findsOneWidget);
  });

  testWidgets('tap outside does not hide popover', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          onTapHide: () => count++,
          hideRegion: .none,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pumpAndSettle();

    expect(count, 0);
    expect(find.text('popover'), findsOneWidget);
  });

  testWidgets('tap button when popover is open and FPopoverHideRegion.excludeChild remains open', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          onTapHide: () => count++,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => Row(
            children: [
              const Text('other'),
              FButton(onPress: controller.toggle, child: const Text('target')),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tap(find.text('other'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pumpAndSettle();

    expect(count, 1);
    expect(find.text('popover'), findsNothing);
  });

  testWidgets('tap button when popover is open and FPopoverHideRegion.anywhere closes it', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          onTapHide: () => count++,
          hideRegion: .anywhere,
          popoverBuilder: (context, _) => const Text('follower'),
          builder: (_, controller, _) => Row(
            children: [
              const Text('other'),
              FButton(onPress: controller.toggle, child: const Text('target')),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('follower'), findsOneWidget);

    await tester.tap(find.text('other'));
    await tester.pumpAndSettle();

    expect(count, 1);
    expect(find.text('follower'), findsNothing);
  });

  group('nested popovers', () {
    Widget nested({required bool outer, required bool inner}) => TestScaffold.app(
      child: FPopover(
        groupId: 'nested',
        style: outer
            ? .delta(
                barrierFilter: (a) => .blur(sigmaX: a * 5, sigmaY: a * 5),
              )
            : const .context(),
        popoverBuilder: (context, _) => Container(
          width: 280,
          height: 220,
          color: const Color(0xFFFFF4E5),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const Text('A body'),
              const SizedBox(height: 12),
              FPopover(
                groupId: 'nested',
                style: inner
                    ? .delta(
                        barrierFilter: (a) => .blur(sigmaX: a * 5, sigmaY: a * 5),
                      )
                    : const .context(),
                popoverBuilder: (context, _) => Container(
                  width: 200,
                  height: 120,
                  color: const Color(0xFFE5F0FF),
                  padding: const EdgeInsets.all(16),
                  child: const Text('B body'),
                ),
                builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('open B')),
              ),
            ],
          ),
        ),
        builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('open A')),
      ),
    );

    Future<void> openBoth(WidgetTester tester) async {
      await tester.tap(find.text('open A'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('open B'));
      await tester.pumpAndSettle();
    }

    Future<void> tapBarrier(WidgetTester tester, {bool topmost = false}) async {
      final barrier = topmost ? find.byType(FAnimatedModalBarrier).last : find.byType(FAnimatedModalBarrier);
      await tester.tapAt(tester.getTopLeft(barrier) + const Offset(5, 5));
    }

    testWidgets('both have barriers', (tester) async {
      await tester.pumpWidget(nested(outer: true, inner: true));
      await openBoth(tester);

      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tester.tap(find.text('B body'));
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tapBarrier(tester, topmost: true);
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsNothing);

      await tapBarrier(tester);
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsNothing);
    });

    testWidgets('parent has barrier, nested does not', (tester) async {
      await tester.pumpWidget(nested(outer: true, inner: false));
      await openBoth(tester);

      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tester.tap(find.text('B body'));
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tester.tap(find.text('A body'));
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tapBarrier(tester);
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsNothing);
      expect(find.text('B body'), findsNothing);
    });

    testWidgets('parent does not have barrier, nested does', (tester) async {
      await tester.pumpWidget(nested(outer: false, inner: true));
      await openBoth(tester);

      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tester.tap(find.text('B body'));
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsOneWidget);

      await tapBarrier(tester);
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsOneWidget);
      expect(find.text('B body'), findsNothing);

      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      expect(find.text('A body'), findsNothing);
    });
  });

  group('focus', () {
    testWidgets("focuses on popover's children", (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FPopover(
                popoverBuilder: (context, _) => Row(
                  children: [
                    FButton(onPress: () {}, child: const Text('1')),
                    FButton(onPress: () {}, child: const Text('2')),
                    FButton(onPress: () {}, child: const Text('3')),
                  ],
                ),
                builder: (_, controller, child) => GestureDetector(onTap: controller.toggle, child: child),
                child: Container(color: Colors.black, height: 10, width: 10),
              ),
              Padding(
                padding: const .symmetric(horizontal: 20),
                child: FButton(onPress: () {}, child: const Text('Underneath')),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Container).last);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(Focus.of(tester.element(find.text('3'))).hasFocus, true);
    });

    testWidgets('shift focus outside', (tester) async {
      final first = autoDispose(FocusNode());
      final second = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FPopover(
                control: const .managed(initial: true),
                traversalEdgeBehavior: .parentScope,
                popoverBuilder: (_, _) => SizedBox.square(dimension: 100, child: FTextField(focusNode: first)),
                child: Container(color: Colors.black, height: 10, width: 10),
              ),
              FTextField(focusNode: second),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      first.requestFocus();
      await tester.pumpAndSettle();

      expect(first.hasFocus, true);
      expect(second.hasFocus, false);

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(first.hasFocus, false);
      expect(second.hasFocus, true);
    });

    testWidgets('does not shift focus outside', (tester) async {
      final first = autoDispose(FocusNode());
      final second = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FPopover(
                control: const .managed(initial: true),
                popoverBuilder: (_, _) => SizedBox.square(dimension: 100, child: FTextField(focusNode: first)),
                child: Container(color: Colors.black, height: 10, width: 10),
              ),
              FTextField(focusNode: second),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      first.requestFocus();
      await tester.pumpAndSettle();

      expect(first.hasFocus, true);
      expect(second.hasFocus, false);

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      expect(first.hasFocus, true);
      expect(second.hasFocus, false);
    });
  });

  group('state', () {
    testWidgets('update focusNode', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));

      final first = autoDispose(FocusScopeNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller),
            focusNode: first,
            popoverBuilder: (_, _) => const SizedBox(),
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      expect(first.context, isNotNull);

      final second = autoDispose(FocusScopeNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller),
            focusNode: second,
            popoverBuilder: (_, _) => const SizedBox(),
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      expect(first.context, isNotNull);
      expect(second.context, isNotNull);
    });

    testWidgets('dispose focusNode', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));
      final node = autoDispose(FocusScopeNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller),
            focusNode: node,
            popoverBuilder: (_, _) => const SizedBox(),
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      expect(node.context, isNotNull);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(node.context, isNotNull);
    });
  });
}

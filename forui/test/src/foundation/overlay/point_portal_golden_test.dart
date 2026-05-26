@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hidden', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPointPortal(
          point: const Offset(50, 50),
          control: .managed(controller: controller),
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/hidden.png'));
  });

  testWidgets('shown', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPointPortal(
          point: const Offset(50, 50),
          control: .managed(controller: controller),
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/shown.png'));
  });

  testWidgets('shown with barrier', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPointPortal(
          point: const Offset(50, 50),
          control: .managed(controller: controller),
          barrier: (_) => Container(color: Colors.blue),
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/barrier.png'));
  });

  testWidgets('constraints', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPointPortal(
          point: const Offset(50, 50),
          constraints: const BoxConstraints.tightFor(width: 25, height: 25),
          control: .managed(controller: controller),
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/constraints.png'));
  });

  group('anchor', () {
    for (final (name, anchor) in const [
      ('topLeft', Alignment.topLeft),
      ('topCenter', Alignment.topCenter),
      ('topRight', Alignment.topRight),
      ('centerLeft', Alignment.centerLeft),
      ('center', Alignment.center),
      ('centerRight', Alignment.centerRight),
      ('bottomLeft', Alignment.bottomLeft),
      ('bottomCenter', Alignment.bottomCenter),
      ('bottomRight', Alignment.bottomRight),
    ]) {
      testWidgets(name, (tester) async {
        final controller = OverlayPortalController();

        await tester.pumpWidget(
          TestScaffold.app(
            child: FPointPortal(
              point: const Offset(100, 100),
              anchor: anchor,
              control: .managed(controller: controller),
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox(width: 120, height: 60)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
            ),
          ),
        );

        controller.show();
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/anchor-$name.png'));
      });
    }
  });

  group('point', () {
    for (final (name, point) in const [
      ('origin', Offset.zero),
      ('center', Offset(100, 100)),
      ('edge', Offset(190, 190)),
    ]) {
      testWidgets(name, (tester) async {
        final controller = OverlayPortalController();

        await tester.pumpWidget(
          TestScaffold.app(
            child: FPointPortal(
              point: point,
              control: .managed(controller: controller),
              portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 80)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
            ),
          ),
        );

        controller.show();
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/point-$name.png'));
      });
    }

    testWidgets('repositions', (tester) async {
      final controller = OverlayPortalController();
      final point = autoDispose(ValueNotifier(const Offset(30, 30)));

      await tester.pumpWidget(
        TestScaffold.app(
          child: ValueListenableBuilder(
            valueListenable: point,
            builder: (_, value, _) => FPointPortal(
              point: value,
              control: .managed(controller: controller),
              portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 80)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      point.value = const Offset(120, 100);
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/point-repositions.png'));
    });
  });

  group('spacing, overflow & offset', () {
    testWidgets('spacing', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPointPortal(
            point: const Offset(25, 25),
            spacing: 5,
            control: .managed(controller: controller),
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/spacing.png'));
    });

    testWidgets('overflowed', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              control: .managed(controller: controller),
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      // The shifted portal IS correct even if it doesn't look like it.
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/overflow.png'));
    });

    testWidgets('offset', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPointPortal(
            point: const Offset(25, 25),
            offset: const Offset(50, 70),
            control: .managed(controller: controller),
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/offset.png'));
    });

    testWidgets('spacing & overflowed', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              spacing: 5,
              control: .managed(controller: controller),
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/spacing-overflowed.png'));
    });

    testWidgets('overflowed & offset', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              offset: const Offset(30, 0),
              control: .managed(controller: controller),
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/overflowed-offset.png'));
    });
  });

  group('paddings & insets', () {
    testWidgets('view padding only', (tester) async {
      final controller = OverlayPortalController();

      tester.view.viewPadding = const FakeViewPadding(left: 100, top: 100, right: 100, bottom: 100);
      tester.view.viewInsets = const FakeViewPadding(left: 500, top: 500, right: 500, bottom: 500);

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              control: .managed(controller: controller),
              useViewInsets: false,
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/view-padding.png'));
    });

    testWidgets('view insets only', (tester) async {
      final controller = OverlayPortalController();

      tester.view.viewPadding = const FakeViewPadding(left: 200, top: 200, right: 200, bottom: 200);
      tester.view.viewInsets = const FakeViewPadding(left: 500, top: 500, right: 500, bottom: 500);

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              control: .managed(controller: controller),
              useViewPadding: false,
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/view-insets.png'));
    });

    testWidgets('custom padding', (tester) async {
      final controller = OverlayPortalController();

      tester.view.viewPadding = const FakeViewPadding(left: 200, top: 200, right: 200, bottom: 200);
      tester.view.viewInsets = const FakeViewPadding(left: 200, top: 200, right: 200, bottom: 200);

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              control: .managed(controller: controller),
              padding: const EdgeInsets.all(50),
              useViewPadding: false,
              useViewInsets: false,
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/custom-padding.png'));
    });

    testWidgets('no padding', (tester) async {
      final controller = OverlayPortalController();

      tester.view.viewPadding = const FakeViewPadding(left: 100, top: 100, right: 100, bottom: 100);
      tester.view.viewInsets = const FakeViewPadding(left: 100, top: 100, right: 100, bottom: 100);

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPointPortal(
              point: const Offset(25, 25),
              control: .managed(controller: controller),
              useViewPadding: false,
              useViewInsets: false,
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('point-portal/no-padding.png'));
    });
  });
}

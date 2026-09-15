@Tags(['golden'])
library;

import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/clippers.dart';

import '../../test_scaffold.dart';

void main() {
  Widget arrowed({
    required OverlayPortalController controller,
    AlignmentGeometry portalAnchor = .topCenter,
    AlignmentGeometry childAnchor = .bottomCenter,
    FPortalArrowStyle style = const FPortalArrowStyle(),
    FPortalArrowAlignment alignment = FPortalArrowAlignment.childCenter,
    Decoration? decoration,
    ImageFilter? filter,
    double spacing = 2,
    double width = 120,
  }) => Builder(
    builder: (context) => FPortal(
      control: .managed(controller: controller),
      portalAnchor: portalAnchor,
      childAnchor: childAnchor,
      spacing: FPortalSpacing(style.height + spacing),
      portalBuilder: (context, _, geometry) {
        final arrowed = FPortalArrowDecoration(
          decoration: decoration ?? context.theme.popoverStyle.decoration,
          style: style,
          alignment: alignment,
          geometry: geometry,
        );

        Widget portal = DecoratedBox(
          decoration: arrowed,
          child: SizedBox(width: width, height: 60),
        );
        if (filter != null) {
          // Mirrors how FPopover confines its background filter to the decoration.
          portal = Stack(
            fit: .passthrough,
            children: [
              Positioned.fill(
                child: ClipPath(
                  clipper: InnerPathClipper(decoration: arrowed),
                  child: BackdropFilter(filter: filter, child: Container()),
                ),
              ),
              portal,
            ],
          );
        }

        return portal;
      },
      child: const ColoredBox(color: Color(0xFF888888), child: SizedBox.square(dimension: 40)),
    ),
  );

  for (final (name, portalAnchor, childAnchor) in [
    ('top', Alignment.topCenter, Alignment.bottomCenter),
    ('bottom', Alignment.bottomCenter, Alignment.topCenter),
    ('left', Alignment.centerLeft, Alignment.centerRight),
    ('right', Alignment.centerRight, Alignment.centerLeft),
  ]) {
    testWidgets(name, (tester) async {
      final controller = OverlayPortalController();
      await tester.pumpWidget(
        TestScaffold.app(
          child: arrowed(controller: controller, portalAnchor: portalAnchor, childAnchor: childAnchor),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/$name.png'));
    });
  }

  testWidgets('no base radius', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: arrowed(controller: controller, style: const FPortalArrowStyle(baseRadius: 0)),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/no-base-radius.png'));
  });

  testWidgets('clamped off the corner', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: arrowed(controller: controller, portalAnchor: .topLeft, childAnchor: .bottomLeft, width: 200),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/clamped.png'));
  });

  testWidgets('hidden when clamped off the child', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: arrowed(
          controller: controller,
          portalAnchor: .topLeft,
          childAnchor: .bottomLeft,
          style: const FPortalArrowStyle(cornerSpacing: 30),
          width: 200,
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/hidden.png'));
  });

  for (final direction in TextDirection.values) {
    testWidgets('alignment start, $direction', (tester) async {
      final controller = OverlayPortalController();
      await tester.pumpWidget(
        TestScaffold.app(
          textDirection: direction,
          child: arrowed(controller: controller, alignment: const FPortalArrowAlignment.start(24), width: 200),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('portal-arrow-decoration/alignment-start-$direction.png'),
      );
    });
  }

  testWidgets('portal over child', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: arrowed(controller: controller, portalAnchor: .center, childAnchor: .center, spacing: -9),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/over-child.png'));
  });

  testWidgets('shadow', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: arrowed(
          controller: controller,
          decoration: const ShapeDecoration(
            color: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(10))),
            shadows: [
              BoxShadow(color: Color(0xFFFF0000), offset: Offset(4, 4), blurRadius: 4),
              BoxShadow(color: Color(0x800000FF), spreadRadius: 4),
            ],
          ),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/shadow.png'));
  });

  testWidgets('gradient', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: arrowed(
          controller: controller,
          decoration: const ShapeDecoration(
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
            ),
            shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/gradient.png'));
  });

  testWidgets('backdrop filter', (tester) async {
    final controller = OverlayPortalController();
    await tester.pumpWidget(
      TestScaffold.app(
        child: Stack(
          alignment: .center,
          children: [
            // High-contrast stripes so the blur is visible through both the box and the arrow.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  tileMode: .repeated,
                  stops: [0, 0.5, 0.5, 1],
                  colors: [Color(0xFF000000), Color(0xFF000000), Color(0xFFFFFF00), Color(0xFFFFFF00)],
                ),
              ),
              child: SizedBox(width: 24, height: 200),
            ),
            arrowed(
              controller: controller,
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              decoration: const ShapeDecoration(
                color: Color(0x40FFFFFF),
                shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal-arrow-decoration/backdrop-filter.png'));
  });
}

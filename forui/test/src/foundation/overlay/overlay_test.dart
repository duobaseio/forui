import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FOverlay', () {
    testWidgets('show/hide via controller', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FOverlay(
            controller: controller,
            overlay: const [Text('overlay')],
            child: const Text('anchor'),
          ),
        ),
      );

      expect(find.text('overlay'), findsNothing);

      controller.show();
      await tester.pumpAndSettle();

      expect(find.text('overlay'), findsOneWidget);

      controller.hide();
      await tester.pumpAndSettle();

      expect(find.text('overlay'), findsNothing);
    });

    testWidgets('Positioned lays out relative to child bounds', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topLeft,
          child: FOverlay(
            controller: controller,
            overlay: const [
              Positioned(
                top: 100,
                left: 0,
                child: SizedBox.square(dimension: 20, key: Key('overlay-content')),
              ),
            ],
            child: const SizedBox(width: 150, height: 100),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      // The child is at (16, 16) due to TestScaffold.app padding.
      // Positioned(top: 100) places content at child's top + 100 = just below the child.
      final overlay = tester.getTopLeft(find.byKey(const Key('overlay-content')));
      expect(overlay, const Offset(16, 116));
    });

    testWidgets('hit test works on overlay content outside child bounds', (tester) async {
      final controller = OverlayPortalController();
      var taps = 0;

      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topLeft,
          child: FOverlay(
            controller: controller,
            overlay: [
              Positioned(
                top: 110,
                left: 0,
                child: SizedBox.square(
                  dimension: 50,
                  child: GestureDetector(key: const Key('outside'), onTap: () => taps++),
                ),
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      // Overlay content is positioned below the 100px child, outside its bounds.
      await tester.tap(find.byKey(const Key('outside')));

      expect(taps, 1);
    });

    testWidgets('overlay repositions when child grows', (tester) async {
      final controller = OverlayPortalController();
      final childHeight = autoDispose(ValueNotifier(100.0));

      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topLeft,
          child: FOverlay(
            controller: controller,
            overlay: const [
              Positioned(
                bottom: -20,
                left: 0,
                child: SizedBox.square(dimension: 20, key: Key('overlay-content')),
              ),
            ],
            child: ValueListenableBuilder<double>(
              valueListenable: childHeight,
              builder: (context, height, _) => SizedBox(width: 150, height: height),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      // Child is 100px tall at (16, 16). Positioned(bottom: -20) places content at child bottom + 0 = 116.
      expect(tester.getTopLeft(find.byKey(const Key('overlay-content'))), const Offset(16, 116));

      // Grow the child to 200px.
      childHeight.value = 200;
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pumpAndSettle();

      // The overlay Stack should now be 200px tall, so Positioned(bottom: -20) → 216.
      expect(tester.getTopLeft(find.byKey(const Key('overlay-content'))), const Offset(16, 216));
    });
  });
}

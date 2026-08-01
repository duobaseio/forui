import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hit test', (tester) async {
    final controller = OverlayPortalController();
    var taps = 0;

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPortal(
          portalAnchor: .topRight,
          childAnchor: .bottomLeft,
          control: .managed(controller: controller),
          portalBuilder: (context, _) => Padding(
            padding: const .all(5),
            child: ColoredBox(
              color: Colors.red,
              child: SizedBox.square(
                dimension: 100,
                child: Align(
                  alignment: .bottomLeft,
                  child: SizedBox.square(dimension: 1, child: GestureDetector(onTap: () => taps++)),
                ),
              ),
            ),
          ),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(GestureDetector));

    expect(taps, 1);
  });

  testWidgets('avoids a keyboard that opens while shown inside a scrollable Scaffold', (tester) async {
    // 400x600 screen; the keyboard occupies the bottom 300 (its top edge sits at y = 300).
    tester.view.physicalSize = const Size(400, 600);
    tester.view.devicePixelRatio = 1.0;
    tester.view.viewInsets = FakeViewPadding.zero; // keyboard closed
    addTearDown(tester.view.reset);

    final controller = OverlayPortalController();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: FLocalizations.localizationsDelegates,
        supportedLocales: FLocalizations.supportedLocales,
        home: FTheme(
          data: FTheme.neutral.light.touch,
          child: Scaffold(
            body: ListView(
              children: [
                const SizedBox(height: 250), // places the child above the keyboard
                FPortal(
                  control: .managed(controller: controller),
                  portalBuilder: (context, _) => const ColoredBox(
                    key: ValueKey('portal'),
                    color: Colors.red,
                    child: SizedBox(height: 150, width: 200),
                  ),
                  child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 20)),
                ),
                const SizedBox(height: 600), // makes the list scrollable
              ],
            ),
          ),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    // The keyboard slides up after the portal is already shown.
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();

    // The portal flips above its child instead of rendering behind the keyboard.
    expect(tester.getRect(find.byKey(const ValueKey('portal'))).bottom, lessThanOrEqualTo(300));
  });

  group('overlayLocation', () {
    for (final (location, nested) in const <(OverlayChildLocation, bool)>[
      (.nearestOverlay, true),
      (.rootOverlay, false),
    ]) {
      testWidgets('$location attaches to the ${nested ? 'nested' : 'root'} overlay', (tester) async {
        final controller = OverlayPortalController();
        final key = GlobalKey();
        late OverlayEntry entry;

        await tester.pumpWidget(
          TestScaffold.app(
            child: SizedBox.square(
              dimension: 200,
              child: Overlay(
                key: key,
                initialEntries: [
                  entry = OverlayEntry(
                    builder: (_) => FPortal(
                      control: .managed(controller: controller),
                      overlayLocation: location,
                      portalBuilder: (_, _) => const SizedBox.square(dimension: 10, child: Text('portal')),
                      child: const SizedBox.square(dimension: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        controller.show();
        await tester.pumpAndSettle();

        final overlay = key.currentContext!.findRenderObject();
        var descendant = false;
        for (RenderObject? node = tester.renderObject(find.text('portal')); node != null; node = node.parent) {
          if (identical(node, overlay)) {
            descendant = true;
            break;
          }
        }

        expect(descendant, nested);

        entry.remove();
        await tester.pumpAndSettle();
        entry.dispose();
      });
    }
  });
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('SubmenuTrigger', () {
    Widget siblingMenu() => TestScaffold.app(
      platform: .macOS,
      child: FPopoverMenu(
        control: const .managed(initial: true),
        menu: [
          .group(
            children: [
              .submenu(
                title: const Text('Submenu A'),
                submenu: [
                  .group(children: [.item(title: const Text('A1'), onPress: () {})]),
                ],
              ),
              .submenu(
                title: const Text('Submenu B'),
                submenu: [
                  .group(children: [.item(title: const Text('B1'), onPress: () {})]),
                ],
              ),
            ],
          ),
        ],
        child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
      ),
    );

    testWidgets('tap sibling switch shows with animation', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(800, 300)));
      final widget = siblingMenu();

      await tester.pumpWidget(sheet.record(widget, recording: false));
      await tester.pumpAndSettle();

      // Open Submenu A via tap and settle.
      await tester.tap(find.text('Submenu A'));
      await tester.pumpWidget(sheet.record(widget, recording: false));
      await tester.pumpAndSettle();

      // Tap Submenu B — A hides animated, B opens animated.
      await tester.tap(find.text('Submenu B'));

      await tester.pumpFrames(sheet.record(widget), const Duration(milliseconds: 150));

      await expectLater(sheet.collate(5), matchesGoldenFile('popover-menu/submenu-tap-sibling-switch.png'));
    });

    testWidgets('hover switch shows instantly', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(800, 300)));
      final widget = siblingMenu();

      await tester.pumpWidget(sheet.record(widget, recording: false));
      await tester.pumpAndSettle();

      // Open Submenu A via hover — pump past the debounce delay and animation.
      final gesture = await tester.createPointerGesture();
      await gesture.moveTo(tester.getCenter(find.text('Submenu A')));
      await tester.pump(const Duration(milliseconds: 150)); // hoverEnterDuration
      await tester.pumpAndSettle();

      // Hover over Submenu B — A should hide instantly, B should show instantly.
      await gesture.moveTo(tester.getCenter(find.text('Submenu B')));

      await tester.pumpFrames(sheet.record(widget), const Duration(milliseconds: 200));

      await expectLater(sheet.collate(10), matchesGoldenFile('popover-menu/submenu-hover-switch.png'));
    });

    testWidgets('parent hide cascades to submenu', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(500, 300)));
      final controller = autoDispose(FPopoverController(vsync: tester, shown: true));

      final widget = TestScaffold.app(
        platform: .macOS,
        child: FPopoverMenu(
          control: .managed(controller: controller),
          menu: [
            .group(
              children: [
                .submenu(
                  title: const Text('Share'),
                  submenu: [
                    .group(
                      children: [
                        .item(title: const Text('Email'), onPress: () {}),
                        .item(title: const Text('Message'), onPress: () {}),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
        ),
      );

      // Open menu and submenu, settle.
      await tester.pumpWidget(sheet.record(widget, recording: false));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Share'));
      await tester.pumpWidget(sheet.record(widget, recording: false));
      await tester.pumpAndSettle();

      // Hide parent popover and record cascading close.
      unawaited(controller.hide());

      await tester.pumpFrames(sheet.record(widget), const Duration(milliseconds: 150));

      await expectLater(sheet.collate(5), matchesGoldenFile('popover-menu/submenu-parent-hide-cascade.png'));
    });
  });
}

@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('blue screen', () {
    testWidgets('items', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FContextMenu(
            control: const .managed(initial: true),
            style: TestScaffold.blueScreen.popoverMenuStyle,
            menu: [
              .group(
                children: [.item(title: const Text('Item 1'), onPress: () {})],
              ),
              .group(
                children: [.item(title: const Text('Item 2'), onPress: () {})],
              ),
            ],
            child: ColoredBox(
              color: TestScaffold.blueScreen.colors.border,
              child: const SizedBox.square(dimension: 50),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('tiles', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FContextMenu.tiles(
            control: const .managed(initial: true),
            style: TestScaffold.blueScreen.popoverMenuStyle,
            menu: [
              .group(
                children: [.tile(title: const Text('Item 1'), onPress: () {})],
              ),
              .group(
                children: [.tile(title: const Text('Item 2'), onPress: () {})],
              ),
            ],
            child: ColoredBox(
              color: TestScaffold.blueScreen.colors.border,
              child: const SizedBox.square(dimension: 50),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} hidden', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FContextMenu(
            menu: [
              .group(
                children: [.item(title: const Text('Item 1'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('context-menu/hidden-${theme.name}.png'));
    });

    testWidgets('${theme.name} items shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FContextMenu(
            control: const .managed(initial: true),
            menu: [
              .group(
                children: [
                  .item(title: const Text('Cut'), variant: .destructive, onPress: () {}),
                  .item(title: const Text('Copy'), onPress: () {}),
                ],
              ),
              .group(
                children: [
                  .item(title: const Text('Paste'), onPress: () {}),
                  .item(title: const Text('Select All'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('context-menu/items-shown-${theme.name}.png'));
    });

    testWidgets('${theme.name} tiles shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FContextMenu.tiles(
            control: const .managed(initial: true),
            menu: [
              .group(
                children: [.tile(title: const Text('Cut'), variant: .destructive, onPress: () {})],
              ),
              .group(
                children: [.tile(title: const Text('Copy'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('context-menu/tiles-shown-${theme.name}.png'));
    });

    testWidgets('${theme.name} scrollable', (tester) async {
      final scrollController = ScrollController();
      addTearDown(scrollController.dispose);

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FContextMenu(
            control: const .managed(initial: true),
            scrollController: scrollController,
            maxHeight: 100,
            menu: [
              .group(
                children: [
                  .item(title: const Text('Item 1'), onPress: () {}),
                  .item(title: const Text('Item 2'), onPress: () {}),
                  .item(title: const Text('Item 3'), onPress: () {}),
                  .item(title: const Text('Item 4'), onPress: () {}),
                  .item(title: const Text('Item 5'), onPress: () {}),
                  .item(title: const Text('Item 6'), onPress: () {}),
                  .item(title: const Text('Item 7'), onPress: () {}),
                  .item(title: const Text('Item 8'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      scrollController.jumpTo(20);
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('context-menu/scrollable-${theme.name}.png'));
    });

    for (final (platformName, platform) in [('touch', FPlatformVariant.iOS), ('desktop', FPlatformVariant.macOS)]) {
      testWidgets('${theme.name} $platformName submenu open', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            platform: platform,
            child: FContextMenu(
              control: const .managed(initial: true),
              menu: [
                .group(
                  children: [
                    .item(title: const Text('Cut'), onPress: () {}),
                    FSubmenuItem(
                      title: const Text('Share'),
                      control: const .managed(initial: true),
                      submenu: [
                        FItemGroup(
                          children: [
                            FItem(title: const Text('Email'), onPress: () {}),
                            FItem(title: const Text('Messages'), onPress: () {}),
                          ],
                        ),
                      ],
                    ),
                    .item(title: const Text('Paste'), onPress: () {}),
                  ],
                ),
              ],
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 200)),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('context-menu/submenu-$platformName-${theme.name}.png'),
        );
      });
    }
  }

  testWidgets('background filter matches the decoration', (tester) async {
    final theme = TestScaffold.themes.first.data;

    await tester.pumpWidget(
      TestScaffold.app(
        theme: theme,
        // The menu opens over the two-tone box with transparent items so the frosted blur shows through.
        child: FContextMenu(
          control: const .managed(initial: true),
          style: .delta(
            minWidth: 250,
            backgroundFilter: () =>
                (v) => .blur(sigmaX: v * 8, sigmaY: v * 8),
            decoration: .value(
              BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: theme.style.borderRadius.md,
                border: .all(color: Colors.white.withValues(alpha: 0.5)),
              ),
            ),
            itemGroupStyle: .delta(
              decoration: const .value(BoxDecoration()),
              itemStyles: .delta([
                .all(
                  .delta(
                    backgroundColor: const FVariants.all(Colors.transparent),
                    contentDecoration: .delta([.base(const .shapeDelta(color: Colors.transparent))]),
                  ),
                ),
              ]),
            ),
          ),
          menu: [
            .group(
              children: [
                .item(title: const Text('Cut'), onPress: () {}),
                .item(title: const Text('Copy'), onPress: () {}),
              ],
            ),
          ],
          child: const SizedBox(
            width: 400,
            height: 120,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Expanded(child: ColoredBox(color: Colors.amber)),
                Expanded(child: ColoredBox(color: Colors.deepOrange)),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('context-menu/background-filter.png'));
  });

  group('accessibility', () {
    // The menu scales up and fades in under full motion, drops the scale to a plain fade under reduced motion, and
    // appears instantly (fully opaque, no scale) under disabled motion.
    for (final (name, features) in [
      ('full', const FakeAccessibilityFeatures()),
      ('reduced', const FakeAccessibilityFeatures(reduceMotion: true)),
      ('disabled', const FakeAccessibilityFeatures(disableAnimations: true)),
    ]) {
      testWidgets('$name motion', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final controller = autoDispose(FPopoverController(vsync: tester));
        final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(260, 320)));

        Widget build() => TestScaffold.app(
          child: FContextMenu(
            control: .managed(controller: controller),
            menu: [
              .group(
                children: [
                  .item(title: const Text('Cut'), onPress: () {}),
                  .item(title: const Text('Copy'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 60)),
          ),
        );

        await tester.pumpWidget(sheet.record(build(), recording: false));
        unawaited(controller.show());
        // Pump past the entrance so the controller's ticker stops before the tree is disposed.
        await tester.pumpFrames(sheet.record(build()), const Duration(milliseconds: 300));

        await expectLater(sheet.collate(5), matchesGoldenFile('context-menu/motion-$name.png'));
      });
    }
  });
}

@Tags(['golden'])
library;

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
}

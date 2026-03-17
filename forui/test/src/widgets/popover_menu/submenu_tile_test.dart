import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSubmenuTile', () {
    group('tap mode', () {
      testWidgets('tap on submenu tile opens submenu', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Edit'), onPress: () {}),
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('tap on open submenu tile closes submenu', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
      });

      testWidgets('tap on sibling submenu tile closes first and opens second', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                    .submenu(
                      title: const Text('Export'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('PDF'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await tester.tap(find.text('Export'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(find.text('PDF'), findsOneWidget);
      });

      testWidgets('tap on enabled non-submenu tile closes open submenu', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            platform: .macOS,
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Edit'), onPress: () {}),
                    .submenu(
                      title: const Text('Export'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('PDF'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Export'));
        await tester.pumpAndSettle();
        expect(find.text('PDF'), findsOneWidget);

        await tester.tap(find.text('Edit'));
        await tester.pumpAndSettle();
        expect(find.text('PDF'), findsNothing);
      });

      testWidgets('tap on disabled non-submenu tile does nothing', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            platform: .macOS,
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Disabled'), enabled: false),
                    .submenu(
                      title: const Text('Export'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('PDF'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Export'));
        await tester.pumpAndSettle();
        expect(find.text('PDF'), findsOneWidget);

        await tester.tap(find.text('Disabled'));
        await tester.pumpAndSettle();
        expect(find.text('PDF'), findsOneWidget);
      });

      testWidgets('tap outside closes entire menu hierarchy', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(find.text('Share'), findsNothing);
      });
    });

    group('hover mode', () {
      testWidgets('hover over submenu tile shows submenu', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: true,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Edit'), onPress: () {}),
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('hover exit cancels pending show', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: true,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Edit'), onPress: () {}),
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 50));

        // Move away before hoverEnterDuration (150ms) elapses
        await gesture.moveTo(tester.getCenter(find.text('Edit')));
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsNothing);
      });

      testWidgets('hover over sibling submenu hides first, shows second', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: true,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                    .submenu(
                      title: const Text('Export'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('PDF'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await gesture.moveTo(tester.getCenter(find.text('Export')));
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(find.text('PDF'), findsOneWidget);
      });

      testWidgets('hover over enabled non-submenu tile hides open submenu', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            platform: .macOS,
            child: FPopoverMenu.tiles(
              hover: true,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Edit'), onPress: () {}),
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await gesture.moveTo(tester.getCenter(find.text('Edit')));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
      });

      testWidgets('hover over disabled non-submenu tile hides open submenu', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            platform: .macOS,
            child: FPopoverMenu.tiles(
              hover: true,
              menu: [
                .group(
                  children: [
                    .tile(title: const Text('Disabled'), enabled: false),
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await gesture.moveTo(tester.getCenter(find.text('Disabled')));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
      });
    });

    group('nested submenus', () {
      testWidgets('deeply nested submenu opens correctly', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Level 1'),
                      menu: [
                        .group(
                          children: [
                            .submenu(
                              title: const Text('Level 2'),
                              menu: [
                                .group(
                                  children: [.tile(title: const Text('Level 3'), onPress: () {})],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Level 1'));
        await tester.pumpAndSettle();
        expect(find.text('Level 2'), findsOneWidget);

        await tester.tap(find.text('Level 2'));
        await tester.pumpAndSettle();
        expect(find.text('Level 3'), findsOneWidget);
      });

      testWidgets('closing middle level closes all children', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Level 1'),
                      menu: [
                        .group(
                          children: [
                            .submenu(
                              title: const Text('Level 2'),
                              menu: [
                                .group(
                                  children: [.tile(title: const Text('Level 3'), onPress: () {})],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Level 1'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Level 2'));
        await tester.pumpAndSettle();
        expect(find.text('Level 3'), findsOneWidget);

        // Close Level 1 which should close Level 2 and Level 3
        await tester.tap(find.text('Level 1'));
        await tester.pumpAndSettle();
        expect(find.text('Level 2'), findsNothing);
        expect(find.text('Level 3'), findsNothing);
      });

      testWidgets('tap on nested FSubmenuTile trigger does not close parent menus', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Level 1'),
                      menu: [
                        .group(
                          children: [
                            .submenu(
                              title: const Text('Level 2'),
                              menu: [
                                .group(
                                  children: [.tile(title: const Text('Level 3'), onPress: () {})],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Level 1'));
        await tester.pumpAndSettle();

        // Tapping Level 2 (a submenu trigger) should open it, not close Level 1
        await tester.tap(find.text('Level 2'));
        await tester.pumpAndSettle();
        expect(find.text('Level 1'), findsOneWidget);
        expect(find.text('Level 2'), findsOneWidget);
        expect(find.text('Level 3'), findsOneWidget);
      });

      testWidgets('tap outside closes entire menu hierarchy', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FPopoverMenu.tiles(
              hover: false,
              menu: [
                .group(
                  children: [
                    .submenu(
                      title: const Text('Share'),
                      menu: [
                        .group(
                          children: [.tile(title: const Text('Email'), onPress: () {})],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await tester.tapAt(.zero);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(find.text('Share'), findsNothing);
      });
    });
  });
}

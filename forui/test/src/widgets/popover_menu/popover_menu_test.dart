import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

const key = Key('key');

class PopoverItem extends StatelessWidget with FItemMixin {
  const new({super.key});

  @override
  Widget build(BuildContext context) => FPopoverMenu(
    menu: [
      FItemGroup(
        children: [
          FItem(title: const Text('Group 1'), onPress: () {}),
          FItem(title: const Text('Group 2'), onPress: () {}),
        ],
      ),
    ],
    builder: (_, controller, _) => FItem(title: const Text('Tap me'), onPress: controller.toggle),
  );
}

class PopoverTile extends StatelessWidget with FTileMixin {
  const new({super.key});

  @override
  Widget build(BuildContext context) => FPopoverMenu.tiles(
    menu: [
      FTileGroup(
        children: [
          FTile(title: const Text('Group 1'), onPress: () {}),
          FTile(title: const Text('Group 2'), onPress: () {}),
        ],
      ),
    ],
    builder: (_, controller, _) => FTile(title: const Text('Tap me'), onPress: controller.toggle),
  );
}

void main() {
  testWidgets('leaky inherited FItemData does not affect popover with items', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FItemGroup(children: const [PopoverItem(key: key)]),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
  });

  testWidgets('leaky inherited FItemData does not affect popover with tiles', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTileGroup(children: const [PopoverTile(key: key)]),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
  });

  testWidgets('tap outside hides popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopoverMenu.tiles(
          menu: [
            .group(
              children: [.tile(title: const Text('Group 1'), onPress: () {})],
            ),
            .group(
              children: [.tile(title: const Text('Group 2'), onPress: () {})],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsNothing);
  });

  testWidgets('tap outside does not hide popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopoverMenu.tiles(
          hideRegion: .none,
          menu: [
            .group(
              children: [.tile(title: const Text('Group 1'), onPress: () {})],
            ),
            .group(
              children: [.tile(title: const Text('Group 2'), onPress: () {})],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);

    await tester.tapAt(.zero);
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);
  });

  testWidgets('tap button when popover is open closes it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopoverMenu.tiles(
          menu: [
            .group(
              children: [.tile(title: const Text('Group 1'), onPress: () {})],
            ),
            .group(
              children: [.tile(title: const Text('Group 2'), onPress: () {})],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsNothing);
  });

  group('accessibility', () {
    testWidgets('submenu remains open when the pointer moves onto it', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopoverMenu(
            menu: [
              .group(
                children: [
                  .item(title: const Text('Edit'), onPress: () {}),
                  .submenu(
                    title: const Text('Share'),
                    submenu: [
                      .group(
                        children: [.item(title: const Text('Email'), onPress: () {})],
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

      // Open the submenu by hovering its trigger.
      final gesture = await tester.createPointerGesture();
      await gesture.moveTo(tester.getCenter(find.text('Share')));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);

      // Moving the pointer from the trigger onto the submenu must not dismiss it (WCAG 1.4.13 hoverable).
      await gesture.moveTo(tester.getCenter(find.text('Email')));
      await tester.pumpAndSettle();

      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });
    for (final (name, menu) in [
      (
        'items',
        FPopoverMenu(
          menu: [
            .group(
              children: [
                .item(title: const Text('First'), onPress: () {}),
                .submenu(
                  title: const Text('Share'),
                  submenu: [
                    .group(
                      children: [
                        .item(title: const Text('Email'), onPress: () {}),
                        .item(title: const Text('SMS'), onPress: () {}),
                      ],
                    ),
                  ],
                ),
                .item(title: const Text('Last'), onPress: () {}),
              ],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
        ),
      ),
      (
        'tiles',
        FPopoverMenu.tiles(
          menu: [
            .group(
              children: [
                .tile(title: const Text('First'), onPress: () {}),
                .submenu(
                  title: const Text('Share'),
                  menu: [
                    .group(
                      children: [
                        .tile(title: const Text('Email'), onPress: () {}),
                        .tile(title: const Text('SMS'), onPress: () {}),
                      ],
                    ),
                  ],
                ),
                .tile(title: const Text('Last'), onPress: () {}),
              ],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
        ),
      ),
    ]) {
      group('hover ($name)', () {
        bool focused(WidgetTester tester, String text) => Focus.of(tester.element(find.text(text))).hasFocus;

        testWidgets('hovering an item focuses it', (tester) async {
          await tester.pumpWidget(TestScaffold.app(child: menu));

          await tester.tap(find.text('Open'));
          await tester.pumpAndSettle();

          final mouse = await tester.createPointerGesture();
          await mouse.moveTo(tester.getCenter(find.text('Last')));
          await tester.pumpAndSettle();
          expect(focused(tester, 'Last'), true);

          await mouse.moveTo(tester.getCenter(find.text('First')));
          await tester.pumpAndSettle();
          expect(focused(tester, 'First'), true);
          expect(focused(tester, 'Last'), false);
        });

        testWidgets('End after hovering into submenu focuses its last item', (tester) async {
          await tester.pumpWidget(TestScaffold.app(child: menu));

          await tester.tap(find.text('Open'));
          await tester.pumpAndSettle();

          final mouse = await tester.createPointerGesture();
          await mouse.moveTo(tester.getCenter(find.text('Share')));
          await tester.pump(const Duration(milliseconds: 200));
          await tester.pumpAndSettle();
          expect(find.text('Email'), findsOneWidget);
          expect(focused(tester, 'Share'), true);

          await mouse.moveTo(tester.getCenter(find.text('Email')));
          await tester.pumpAndSettle();
          expect(focused(tester, 'Email'), true);

          await tester.sendKeyEvent(LogicalKeyboardKey.end);
          await tester.pumpAndSettle();
          expect(focused(tester, 'SMS'), true);
        });
      });

      testWidgets('menu & item roles ($name)', (tester) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpWidget(TestScaffold.app(child: menu));

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.semantics.byPredicate((node) => node.role == SemanticsRole.menu), findsOneWidget);
        expect(tester.getSemantics(find.text('First')), isSemantics(role: .menuItem, isButton: true));
        expect(tester.getSemantics(find.text('Last')), isSemantics(role: .menuItem, isButton: true));
        expect(
          tester.getSemantics(find.text('Share')),
          isSemantics(role: .menuItem, hasExpandedState: true, isExpanded: false),
        );

        final mouse = await tester.createPointerGesture();
        await mouse.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pumpAndSettle();

        expect(find.semantics.byPredicate((node) => node.role == SemanticsRole.menu), findsNWidgets(2));
        expect(tester.getSemantics(find.text('Share')), isSemantics(role: .menuItem, isExpanded: true));
        expect(tester.getSemantics(find.text('Email')), isSemantics(role: .menuItem, isButton: true));
        expect(tester.getSemantics(find.text('SMS')), isSemantics(role: .menuItem, isButton: true));

        semantics.dispose();
      });
    }

    group('key navigation', () {
      Widget menu({bool submenuLast = false, TextDirection direction = .ltr}) => TestScaffold.app(
        child: Directionality(
          textDirection: direction,
          child: FPopoverMenu(
            menu: [
              .group(
                children: [
                  .item(title: const Text('First'), onPress: () {}),
                  .item(title: const Text('Second'), onPress: () {}),
                  .submenu(
                    title: const Text('Share'),
                    submenu: [
                      .group(
                        children: [
                          .item(title: const Text('Email'), onPress: () {}),
                          .item(title: const Text('SMS'), onPress: () {}),
                        ],
                      ),
                    ],
                  ),
                  if (!submenuLast) .item(title: const Text('Last'), onPress: () {}),
                ],
              ),
            ],
            builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('Open')),
          ),
        ),
      );

      bool focused(WidgetTester tester, String text) => Focus.of(tester.element(find.text(text))).hasFocus;

      Future<void> focus(WidgetTester tester, String text) async {
        Focus.of(tester.element(find.text(text))).requestFocus();
        await tester.pumpAndSettle();
        expect(focused(tester, text), true);
      }

      for (final (key, from, to) in [
        (LogicalKeyboardKey.home, 'Open', 'First'),
        (LogicalKeyboardKey.end, 'Open', 'Last'),
        (LogicalKeyboardKey.home, 'Second', 'First'),
        (LogicalKeyboardKey.end, 'First', 'Last'),
      ]) {
        testWidgets('${key.keyLabel} from $from focuses $to', (tester) async {
          await tester.pumpWidget(menu());

          await tester.tap(find.text('Open'));
          await tester.pumpAndSettle();

          await focus(tester, from);

          await tester.sendKeyEvent(key);
          await tester.pumpAndSettle();
          expect(focused(tester, to), true);
        });
      }

      testWidgets('ignored when closed', (tester) async {
        await tester.pumpWidget(menu());

        await focus(tester, 'Open');

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Open'), true);
        expect(find.text('First'), findsNothing);
      });

      testWidgets('inside submenu stay within submenu', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await focus(tester, 'Email');

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pumpAndSettle();
        expect(focused(tester, 'SMS'), true);

        await tester.sendKeyEvent(LogicalKeyboardKey.home);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Email'), true);
      });

      testWidgets('in parent menu ignores open submenu items', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await focus(tester, 'First');

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Last'), true);
      });

      testWidgets('End from an open submenu trigger stays in the parent menu', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await focus(tester, 'Share');

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Last'), true);
      });

      testWidgets('End focuses trigger of open submenu when it is the last item', (tester) async {
        await tester.pumpWidget(menu(submenuLast: true));

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await focus(tester, 'First');

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Share'), true);
      });

      testWidgets('Down and Up move between items and wrap', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await focus(tester, 'First');

        for (final expected in ['Second', 'Share', 'Last', 'First']) {
          await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
          await tester.pumpAndSettle();
          expect(focused(tester, expected), true, reason: 'Down -> $expected');
        }

        for (final expected in ['Last', 'Share', 'Second', 'First']) {
          await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
          await tester.pumpAndSettle();
          expect(focused(tester, expected), true, reason: 'Up -> $expected');
        }
      });

      testWidgets('Down past an open submenu stays in the parent menu', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await focus(tester, 'Share');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Last'), true);
      });

      testWidgets('Down and Up inside submenu stay within submenu', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();

        await focus(tester, 'Email');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(focused(tester, 'SMS'), true);

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Email'), true);

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
        await tester.pumpAndSettle();
        expect(focused(tester, 'SMS'), true);
      });

      testWidgets('Down on a closed trigger does not open the menu', (tester) async {
        await tester.pumpWidget(menu());

        await focus(tester, 'Open');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(find.text('First'), findsNothing);
        expect(focused(tester, 'Open'), true);
      });

      testWidgets('Down on a closed submenu trigger moves on without opening it', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await focus(tester, 'Share');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(focused(tester, 'Last'), true);
      });

      testWidgets('enter on a submenu trigger opens it and focuses its first item', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await focus(tester, 'Share');

        await tester.sendKeyEvent(.enter);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);
        expect(focused(tester, 'Email'), true);
      });

      testWidgets('enter on a hovered submenu trigger focuses its first item', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final mouse = await tester.createPointerGesture();
        await mouse.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);
        expect(focused(tester, 'Share'), true);

        await tester.sendKeyEvent(.enter);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);
        expect(focused(tester, 'Email'), true);
      });

      testWidgets('keyboard navigation closes a submenu opened by hovering its trigger', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        final mouse = await tester.createPointerGesture();
        await mouse.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);
        expect(focused(tester, 'Share'), true);

        await tester.sendKeyEvent(.arrowDown);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(focused(tester, 'Last'), true);
      });

      testWidgets('tap on a submenu trigger opens it without moving focus', (tester) async {
        await tester.pumpWidget(menu());

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);
        for (final text in ['First', 'Second', 'Share', 'Last', 'Email', 'SMS']) {
          expect(focused(tester, text), false, reason: text);
        }
      });

      for (final (direction, open, close) in [
        (TextDirection.ltr, LogicalKeyboardKey.arrowRight, LogicalKeyboardKey.arrowLeft),
        (TextDirection.rtl, LogicalKeyboardKey.arrowLeft, LogicalKeyboardKey.arrowRight),
      ]) {
        group('$direction', () {
          Widget directional() => menu(direction: direction);

          testWidgets('open key on a submenu trigger opens it and focuses its first item', (tester) async {
            await tester.pumpWidget(directional());

            await tester.tap(find.text('Open'));
            await tester.pumpAndSettle();

            await focus(tester, 'Share');

            await tester.sendKeyEvent(open);
            await tester.pumpAndSettle();
            expect(find.text('Email'), findsOneWidget);
            expect(focused(tester, 'Email'), true);
          });

          testWidgets('open key on an already open submenu trigger focuses its first item', (tester) async {
            await tester.pumpWidget(directional());

            await tester.tap(find.text('Open'));
            await tester.pumpAndSettle();

            await tester.tap(find.text('Share'));
            await tester.pumpAndSettle();
            expect(find.text('Email'), findsOneWidget);

            await focus(tester, 'Share');

            await tester.sendKeyEvent(open);
            await tester.pumpAndSettle();
            expect(focused(tester, 'Email'), true);
          });

          testWidgets('close key inside a submenu closes it and focuses its trigger', (tester) async {
            await tester.pumpWidget(directional());

            await tester.tap(find.text('Open'));
            await tester.pumpAndSettle();

            await tester.tap(find.text('Share'));
            await tester.pumpAndSettle();

            await focus(tester, 'SMS');

            await tester.sendKeyEvent(close);
            await tester.pumpAndSettle();
            expect(find.text('Email'), findsNothing);
            expect(focused(tester, 'Share'), true);
          });
        });
      }
    });
  });
}

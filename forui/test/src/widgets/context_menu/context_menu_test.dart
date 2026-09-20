import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

const _childKey = Key('child');

Widget _contextMenu({
  FPopoverHideRegion hideRegion = .excludeChild,
  bool? longPress,
  bool? secondaryPress,
  List<FItemGroupMixin>? menu,
}) => TestScaffold.app(
  child: FContextMenu(
    hideRegion: hideRegion,
    longPress: longPress,
    secondaryPress: secondaryPress,
    menu:
        menu ??
        [
          FItemGroup(
            children: [
              FItem(title: const Text('Cut'), onPress: () {}),
              FItem(title: const Text('Copy'), onPress: () {}),
            ],
          ),
        ],
    child: const ColoredBox(key: _childKey, color: Colors.yellow, child: SizedBox.square(dimension: 200)),
  ),
);

Widget _contextMenuWithSubmenu({VoidCallback? onSubmenuItemPress, Widget? sibling}) => TestScaffold.app(
  child: Column(
    children: [
      ?sibling,
      _submenu(onSubmenuItemPress: onSubmenuItemPress),
    ],
  ),
);

Widget _submenu({VoidCallback? onSubmenuItemPress}) => FContextMenu(
  secondaryPress: true,
  menu: [
    FItemGroup(
      children: [
        FItem(title: const Text('Cut'), onPress: () {}),
        FSubmenuItem(
          title: const Text('Share'),
          submenu: [
            FItemGroup(
              children: [
                FItem(title: const Text('Email'), onPress: onSubmenuItemPress ?? () {}),
                FItem(title: const Text('Messages'), onPress: () {}),
              ],
            ),
          ],
        ),
        FItem(title: const Text('Paste'), onPress: () {}),
      ],
    ),
  ],
  child: const ColoredBox(key: _childKey, color: Colors.yellow, child: SizedBox.square(dimension: 200)),
);

void main() {
  group('FContextMenu', () {
    testWidgets('secondary press opens menu', (tester) async {
      await tester.pumpWidget(_contextMenu(secondaryPress: true));

      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);
      expect(find.text('Copy'), findsOneWidget);
    });

    testWidgets('long press opens menu', (tester) async {
      await tester.pumpWidget(_contextMenu(longPress: true));

      await tester.longPress(find.byKey(_childKey));
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);
      expect(find.text('Copy'), findsOneWidget);
    });

    testWidgets('tap outside hides menu', (tester) async {
      await tester.pumpWidget(_contextMenu(secondaryPress: true));

      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsNothing);
    });

    testWidgets('primary click inside child closes menu', (tester) async {
      await tester.pumpWidget(_contextMenu(secondaryPress: true));

      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);

      await tester.tap(find.byKey(_childKey));
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsNothing);
    });

    testWidgets('secondary press repositions menu', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          padded: false,
          alignment: .topLeft,
          child: FContextMenu(
            secondaryPress: true,
            useViewPadding: false,
            useViewInsets: false,
            menu: [
              FItemGroup(
                children: [FItem(title: const Text('Cut'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(key: _childKey, color: Colors.yellow, child: SizedBox.square(dimension: 400)),
          ),
        ),
      );

      await tester.tapAt(const Offset(50, 50), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      final firstPosition = tester.getTopLeft(find.text('Cut'));

      await tester.tapAt(const Offset(200, 200), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      final secondPosition = tester.getTopLeft(find.text('Cut'));

      expect(find.text('Cut'), findsOneWidget);
      expect(secondPosition, isNot(firstPosition));
    });

    testWidgets('escape key hides menu', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FContextMenu(
            secondaryPress: true,
            autofocus: true,
            menu: [
              FItemGroup(
                children: [FItem(title: const Text('Cut'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(key: _childKey, color: Colors.yellow, child: SizedBox.square(dimension: 200)),
          ),
        ),
      );

      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsNothing);
    });

    testWidgets('tap outside does not hide menu when hideRegion is none', (tester) async {
      await tester.pumpWidget(_contextMenu(secondaryPress: true, hideRegion: .none));

      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      expect(find.text('Cut'), findsOneWidget);
    });

    group('submenu', () {
      testWidgets('opens on press', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());

        await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
        await tester.pumpAndSettle();

        expect(find.text('Share'), findsOneWidget);
        expect(find.text('Email'), findsNothing);

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Messages'), findsOneWidget);
      });

      testWidgets('opens on hover', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());

        await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Share')));
        await tester.pump(const Duration(milliseconds: 200));
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Messages'), findsOneWidget);
      });

      testWidgets('tapping submenu item does not close entire menu', (tester) async {
        var pressed = false;
        await tester.pumpWidget(_contextMenuWithSubmenu(onSubmenuItemPress: () => pressed = true));

        await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsOneWidget);

        await tester.tap(find.text('Email'));
        await tester.pumpAndSettle();

        expect(pressed, true);
        expect(find.text('Cut'), findsOneWidget);
      });
    });
  });

  group('accessibility', () {
    bool focused(WidgetTester tester, String text) => Focus.of(tester.element(find.text(text))).hasFocus;

    Future<void> focus(WidgetTester tester, String text) async {
      Focus.of(tester.element(find.text(text))).requestFocus();
      await tester.pumpAndSettle();
      expect(focused(tester, text), true);
    }

    Future<void> open(WidgetTester tester) async {
      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
      await tester.pumpAndSettle();
      expect(find.text('Cut'), findsOneWidget);
    }

    testWidgets('submenu remains open when the pointer moves onto it', (tester) async {
      await tester.pumpWidget(_contextMenuWithSubmenu());

      await tester.tap(find.byKey(_childKey), buttons: kSecondaryButton);
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

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Messages'), findsOneWidget);
    });

    group('key navigation', () {
      for (final (key, from, to) in [
        (LogicalKeyboardKey.home, 'Share', 'Cut'),
        (LogicalKeyboardKey.end, 'Cut', 'Paste'),
      ]) {
        testWidgets('${key.keyLabel} from $from focuses $to', (tester) async {
          await tester.pumpWidget(_contextMenuWithSubmenu());
          await open(tester);

          await focus(tester, from);

          await tester.sendKeyEvent(key);
          await tester.pumpAndSettle();
          expect(focused(tester, to), true);
        });
      }

      testWidgets('Down after opening focuses the first item when another widget focused', (tester) async {
        await tester.pumpWidget(
          _contextMenuWithSubmenu(
            sibling: FButton(autofocus: true, onPress: () {}, child: const Text('Button')),
          ),
        );
        await tester.pumpAndSettle();
        await open(tester);
        expect(Focus.of(tester.element(find.text('Cut'))).enclosingScope!.hasFocus, true);

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Cut'), true);
      });

      testWidgets('Down and Up move between items and wrap', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());
        await open(tester);

        await focus(tester, 'Cut');

        for (final expected in ['Share', 'Paste', 'Cut']) {
          await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
          await tester.pumpAndSettle();
          expect(focused(tester, expected), true, reason: 'Down -> $expected');
        }

        for (final expected in ['Paste', 'Share', 'Cut']) {
          await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
          await tester.pumpAndSettle();
          expect(focused(tester, expected), true, reason: 'Up -> $expected');
        }
      });

      testWidgets('Down past an open submenu stays in the root menu', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());
        await open(tester);

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);

        await focus(tester, 'Share');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(focused(tester, 'Paste'), true);
      });

      testWidgets('Down and Up inside submenu stay within submenu', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());
        await open(tester);

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();

        await focus(tester, 'Email');

        for (final expected in ['Messages', 'Email']) {
          await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
          await tester.pumpAndSettle();
          expect(focused(tester, expected), true, reason: 'Down -> $expected');
        }
      });

      testWidgets('open key on a submenu trigger opens it and focuses its first item', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());
        await open(tester);

        await focus(tester, 'Share');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsOneWidget);
        expect(focused(tester, 'Email'), true);
      });

      testWidgets('close key inside a submenu closes it and focuses its trigger', (tester) async {
        await tester.pumpWidget(_contextMenuWithSubmenu());
        await open(tester);

        await tester.tap(find.text('Share'));
        await tester.pumpAndSettle();

        await focus(tester, 'Messages');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
        await tester.pumpAndSettle();
        expect(find.text('Email'), findsNothing);
        expect(focused(tester, 'Share'), true);
      });

      testWidgets('Escape restores focus to the previously focused node', (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpWidget(
          TestScaffold.app(
            child: Column(
              children: [
                FButton(focusNode: focusNode, onPress: () {}, child: const Text('Button')),
                FContextMenu(
                  secondaryPress: true,
                  menu: [
                    FItemGroup(
                      children: [FItem(title: const Text('Cut'), onPress: () {})],
                    ),
                  ],
                  child: const ColoredBox(key: _childKey, color: Colors.yellow, child: SizedBox.square(dimension: 200)),
                ),
              ],
            ),
          ),
        );

        await focus(tester, 'Button');
        await open(tester);

        await focus(tester, 'Cut');

        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();
        expect(find.text('Cut'), findsNothing);
        expect(focusNode.hasFocus, true);
      });
    });
  });
}

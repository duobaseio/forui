import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

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

Widget _contextMenuWithSubmenu({VoidCallback? onSubmenuItemPress}) => TestScaffold.app(
  child: FContextMenu(
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
  ),
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
}

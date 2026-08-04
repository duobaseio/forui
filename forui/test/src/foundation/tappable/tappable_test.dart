import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable/tappable.dart';
import '../../test_scaffold.dart';

// ignore: avoid_positional_boolean_parameters
Set<FTappableVariant> set(bool enabled) => {if (!enabled) .disabled, .android};

class _StubTappable extends AnimatedTappable {
  static void _press() {}

  // ignore: unused_element_parameter
  const _StubTappable({super.onPress = _press, super.child = const Text('stub')});

  @override
  _StubTappableState createState() => _StubTappableState();
}

class _StubTappableState extends AnimatedTappableState {
  @override
  void onPressEnd() {
    Future.delayed(const Duration(seconds: 1)).then((_) => super.onPressEnd());
  }
}

FTappable _tappable(
  List<String> calls, {
  Key? key,
  bool press = true,
  bool longPress = true,
  bool doubleTap = false,
  bool secondary = false,
  bool autofocus = false,
  FocusNode? focusNode,
  bool static = false,
}) => (static ? FTappable.static : FTappable.new)(
  key: key,
  autofocus: autofocus,
  focusNode: focusNode,
  builder: (_, states, _) => Text('$states'),
  onPressDown: press ? (_) => calls.add('onPressDown') : null,
  onPressCancel: press ? () => calls.add('onPressCancel') : null,
  onPressMove: press ? (_) => calls.add('onPressMove') : null,
  onPressUp: press ? (_) => calls.add('onPressUp') : null,
  onPress: press ? () => calls.add('onPress') : null,
  onLongPressDown: longPress ? (_) => calls.add('onLongPressDown') : null,
  onLongPressCancel: longPress ? () => calls.add('onLongPressCancel') : null,
  onLongPressStart: longPress ? (_) => calls.add('onLongPressStart') : null,
  onLongPressMove: longPress ? (_) => calls.add('onLongPressMove') : null,
  onLongPressEnd: longPress ? (_) => calls.add('onLongPressEnd') : null,
  onLongPress: longPress ? () => calls.add('onLongPress') : null,
  onDoubleTapDown: doubleTap ? (_) => calls.add('onDoubleTapDown') : null,
  onDoubleTapCancel: doubleTap ? () => calls.add('onDoubleTapCancel') : null,
  onDoubleTap: doubleTap ? () => calls.add('onDoubleTap') : null,
  onSecondaryPressDown: secondary ? (_) => calls.add('onSecondaryPressDown') : null,
  onSecondaryPressCancel: secondary ? () => calls.add('onSecondaryPressCancel') : null,
  onSecondaryPressUp: secondary ? (_) => calls.add('onSecondaryPressUp') : null,
  onSecondaryPress: secondary ? () => calls.add('onSecondaryPress') : null,
  onSecondaryLongPressDown: secondary ? (_) => calls.add('onSecondaryLongPressDown') : null,
  onSecondaryLongPressCancel: secondary ? () => calls.add('onSecondaryLongPressCancel') : null,
  onSecondaryLongPressStart: secondary ? (_) => calls.add('onSecondaryLongPressStart') : null,
  onSecondaryLongPressMove: secondary ? (_) => calls.add('onSecondaryLongPressMove') : null,
  onSecondaryLongPressEnd: secondary ? (_) => calls.add('onSecondaryLongPressEnd') : null,
  onSecondaryLongPress: secondary ? () => calls.add('onSecondaryLongPress') : null,
);

void main() {
  late FocusNode focusNode;

  setUp(() => focusNode = FocusNode());

  tearDown(() => focusNode.dispose());

  group('FTappable', () {
    testWidgets('focused when enabled', (tester) async {
      FocusManager.instance.highlightStrategy = .alwaysTraditional;
      addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(focusNode: focusNode, builder: (_, states, _) => Text('$states'), onPress: () {}),
        ),
      );
      expect(find.text(set(true).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(
        find.text({...set(true), FTappableVariant.focused, FTappableVariant.primaryFocused}.toString()),
        findsOneWidget,
      );
    });

    testWidgets('cannot focus when disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(focusNode: focusNode, builder: (_, states, _) => Text('$states')),
        ),
      );
      expect(find.text(set(false).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(find.text(set(false).toString()), findsOneWidget);
      expect(focusNode.hasFocus, false);
    });

    for (final enabled in [true, false]) {
      testWidgets('hovered - $enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(builder: (_, states, _) => Text('$states'), onPress: enabled ? () {} : null),
          ),
        );
        expect(find.text(set(enabled).toString()), findsOneWidget);

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(AnimatedTappable)));
        await tester.pumpAndSettle();

        expect(find.text({...set(enabled), FTappableVariant.hovered}.toString()), findsOneWidget);

        await gesture.moveTo(.zero);
        await tester.pumpAndSettle();

        expect(find.text(set(enabled).toString()), findsOneWidget);
      });
    }

    testWidgets('tap fires full lifecycle', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(TestScaffold(child: _tappable(calls)));

      await tester.tap(find.byType(AnimatedTappable));
      await tester.pumpAndSettle();

      expect(calls, contains('onPressDown'));
      expect(calls, contains('onLongPressDown'));
      expect(calls, contains('onLongPressCancel'));
      expect(calls, containsAllInOrder(['onPressDown', 'onPressUp', 'onPress']));
      expect(calls, isNot(contains('onLongPress')));
      expect(calls, isNot(contains('onLongPressStart')));
    });

    testWidgets('long-press fires full lifecycle', (tester) async {
      final calls = <String>[];
      final key = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(TestScaffold(child: _tappable(calls, key: key)));

      final gesture = await tester.press(find.byType(AnimatedTappable));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(key.currentState?.bounce.value, 0.97);

      await tester.pump(kLongPressTimeout);
      await gesture.up();
      await tester.pumpAndSettle();
      expect(key.currentState?.bounce.value, 1);

      expect(calls, contains('onPressDown'));
      expect(calls, contains('onLongPressDown'));
      expect(calls, contains('onPressCancel'));
      expect(calls, isNot(contains('onPress')));
      expect(calls, isNot(contains('onPressUp')));
      expect(calls, isNot(contains('onLongPressCancel')));
    });

    testWidgets('shortcut activates onPress without firing the gesture lifecycle', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(TestScaffold(child: _tappable(calls, autofocus: true)));

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(calls, ['onPress']);
    });

    testWidgets('disabled tappable fires no lifecycle callbacks', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        TestScaffold(child: _tappable(calls, press: false, longPress: false, focusNode: focusNode)),
      );

      await tester.tap(find.byType(AnimatedTappable));
      await tester.pumpAndSettle();

      expect(calls, isEmpty);
    });

    testWidgets('disabled when no press callbacks given', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(focusNode: focusNode, builder: (_, states, _) => Text('$states')),
        ),
      );

      expect(find.text(set(false).toString()), findsOneWidget);
    });

    testWidgets('enabled when secondary press given', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(focusNode: focusNode, builder: (_, states, _) => Text('$states'), onSecondaryPress: () {}),
        ),
      );

      expect(find.text(set(true).toString()), findsOneWidget);
    });

    testWidgets('enabled when only onDoubleTap given', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(focusNode: focusNode, builder: (_, states, _) => Text('$states'), onDoubleTap: () {}),
        ),
      );

      expect(find.text(set(true).toString()), findsOneWidget);
    });

    testWidgets('bounce when onPress set and primary button pressed', (tester) async {
      final key = GlobalKey<AnimatedTappableState>();

      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(key: key, builder: (_, states, _) => Text('$states'), onPress: () {}),
        ),
      );
      expect(key.currentState?.bounce.value, 1);

      final gesture = await tester.press(find.byType(AnimatedTappable));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(find.text({...set(true), FTappableVariant.pressed}.toString()), findsOneWidget);
      expect(key.currentState?.bounce.value, 0.97);

      await gesture.up();
      await tester.pumpAndSettle();
      expect(key.currentState?.bounce.value, 1);
    });

    testWidgets('no bounce when secondary callbacks set and primary button pressed', (tester) async {
      final key = GlobalKey<AnimatedTappableState>();

      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(key: key, builder: (_, states, _) => Text('$states'), onSecondaryPress: () {}),
        ),
      );
      expect(key.currentState?.bounce.value, 1);

      final gesture = await tester.press(find.byType(AnimatedTappable));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      // Pressed variant should still be set, but bounce should NOT animate since primary button
      // was pressed and only secondary callbacks are set.
      expect(find.text({...set(true), FTappableVariant.pressed}.toString()), findsOneWidget);
      expect(key.currentState?.bounce.value, 1.0);

      await gesture.up();
      await tester.pumpAndSettle();
    });

    for (final (name, features, pressed) in [
      ('reduced motion', const FakeAccessibilityFeatures(reduceMotion: true), 0.97),
      ('disabled motion', const FakeAccessibilityFeatures(disableAnimations: true), 1.0),
    ]) {
      testWidgets('bounce gated by $name', (tester) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue = features;
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        final key = GlobalKey<AnimatedTappableState>();
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(key: key, builder: (_, states, _) => Text('$states'), onPress: () {}),
          ),
        );
        expect(key.currentState?.bounce.value, 1);

        final gesture = await tester.press(find.byType(AnimatedTappable));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // The press bounce is small local feedback: reduced motion keeps it (0.97), only disabled removes it (1.0).
        expect(find.text({...set(true), FTappableVariant.pressed}.toString()), findsOneWidget);
        expect(key.currentState?.bounce.value, pressed);

        await gesture.up();
        await tester.pumpAndSettle();
        expect(key.currentState?.bounce.value, 1);
      });
    }

    testWidgets('simulated race condition between animation and unmounting of widget', (tester) async {
      await tester.pumpWidget(TestScaffold(child: const _StubTappable()));

      await tester.tap(find.text('stub'));

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(tester.takeException(), null);
    });

    testWidgets('resets hover and touch states when enabled state changes', (tester) async {
      late StateSetter setState;
      VoidCallback? onPress = () {};

      await tester.pumpWidget(
        TestScaffold(
          child: StatefulBuilder(
            builder: (context, setter) {
              setState = setter;
              return FTappable(builder: (_, states, _) => Text('$states'), onPress: onPress);
            },
          ),
        ),
      );

      expect(find.text(set(true).toString()), findsOneWidget);

      final gesture = await tester.createPointerGesture();

      await gesture.moveTo(tester.getCenter(find.byType(AnimatedTappable)));
      await tester.pumpAndSettle();
      expect(find.text({...set(true), FTappableVariant.hovered}.toString()), findsOneWidget);

      setState(() => onPress = null);
      await tester.pumpAndSettle();
      expect(
        find.text({FTappableVariant.android, FTappableVariant.hovered, FTappableVariant.disabled}.toString()),
        findsOneWidget,
      );
    });

    testWidgets('platform change', (tester) async {
      late StateSetter setState;
      FPlatformVariant platform = .macOS;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (_, setter) {
            setState = setter;
            return TestScaffold(
              platform: platform,
              child: FTappable(builder: (_, states, _) => Text('$states'), onPress: () {}),
            );
          },
        ),
      );
      expect(find.text({FTappableVariant.macOS}.toString()), findsOneWidget);

      setState(() => platform = .iOS);
      await tester.pumpAndSettle();

      expect(find.text({FTappableVariant.iOS}.toString()), findsOneWidget);
    });

    testWidgets('onVariantChange callback called', (tester) async {
      Set<FTappableVariant>? previous;
      Set<FTappableVariant>? current;
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(
            builder: (_, _, _) => const Text('tappable'),
            onVariantChange: (p, c) {
              previous = p;
              current = c;
            },
            onPress: () {},
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('tappable')));
      await tester.pumpAndSettle();

      expect(previous, isNot(contains(FTappableVariant.hovered)));
      expect(current, contains(FTappableVariant.hovered));
    });
  });

  group('FTappable.static', () {
    testWidgets('focused when enabled', (tester) async {
      FocusManager.instance.highlightStrategy = .alwaysTraditional;
      addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(focusNode: focusNode, builder: (_, states, _) => Text('$states'), onPress: () {}),
        ),
      );
      expect(find.text(set(true).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(
        find.text({...set(true), FTappableVariant.focused, FTappableVariant.primaryFocused}.toString()),
        findsOneWidget,
      );
    });

    testWidgets('cannot request focus when disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(focusNode: focusNode, builder: (_, states, _) => Text('$states')),
        ),
      );
      expect(find.text(set(false).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(find.text(set(false).toString()), findsOneWidget);
      expect(focusNode.hasFocus, false);
    });

    for (final enabled in [true, false]) {
      testWidgets('hovered - $enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(builder: (_, states, _) => Text('$states'), onPress: enabled ? () {} : null),
          ),
        );
        expect(find.text(set(enabled).toString()), findsOneWidget);

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FTappable)));
        await tester.pumpAndSettle();

        expect(find.text({...set(enabled), FTappableVariant.hovered}.toString()), findsOneWidget);

        await gesture.moveTo(.zero);
        await tester.pumpAndSettle();

        expect(find.text(set(enabled).toString()), findsOneWidget);
      });
    }

    testWidgets('tap fires full lifecycle', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(TestScaffold(child: _tappable(calls, static: true)));

      await tester.tap(find.byType(FTappable));
      await tester.pumpAndSettle();

      expect(calls, contains('onPressDown'));
      expect(calls, contains('onLongPressDown'));
      expect(calls, contains('onLongPressCancel'));
      expect(calls, containsAllInOrder(['onPressDown', 'onPressUp', 'onPress']));
      expect(calls, isNot(contains('onLongPress')));
    });

    testWidgets('long-press fires full lifecycle', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(TestScaffold(child: _tappable(calls, static: true)));

      await tester.longPress(find.byType(FTappable));
      await tester.pumpAndSettle();

      expect(calls, contains('onPressDown'));
      expect(calls, contains('onLongPressDown'));
      expect(calls, contains('onPressCancel'));
      expect(calls, isNot(contains('onPress')));
    });

    testWidgets('shortcut activates onPress without firing the gesture lifecycle', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(TestScaffold(child: _tappable(calls, static: true, autofocus: true)));

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(calls, ['onPress']);
    });

    testWidgets('disabled when no press callbacks given', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(focusNode: focusNode, builder: (_, states, _) => Text('$states')),
        ),
      );

      expect(find.text(set(false).toString()), findsOneWidget);
    });

    testWidgets('disabled tappable cannot request focus', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(focusNode: focusNode, builder: (_, states, _) => Text('$states')),
        ),
      );
      expect(find.text(set(false).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(find.text(set(false).toString()), findsOneWidget);
      expect(focusNode.hasFocus, false);
    });

    testWidgets('enabled when secondary press given', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(
            focusNode: focusNode,
            builder: (_, states, _) => Text('$states'),
            onSecondaryPress: () {},
          ),
        ),
      );

      expect(find.text(set(true).toString()), findsOneWidget);
    });

    testWidgets('enabled when only onDoubleTap given', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(focusNode: focusNode, builder: (_, states, _) => Text('$states'), onDoubleTap: () {}),
        ),
      );

      expect(find.text(set(true).toString()), findsOneWidget);
    });

    testWidgets('resets hover and touch states when enabled state changes', (tester) async {
      late StateSetter setState;
      VoidCallback? onPress = () {};

      await tester.pumpWidget(
        TestScaffold(
          child: StatefulBuilder(
            builder: (context, setter) {
              setState = setter;
              return FTappable.static(builder: (_, value, _) => Text('$value'), onPress: onPress);
            },
          ),
        ),
      );

      expect(find.text(set(true).toString()), findsOneWidget);

      final gesture = await tester.createPointerGesture();

      await gesture.moveTo(tester.getCenter(find.byType(FTappable)));
      await tester.pumpAndSettle();
      expect(find.text({...set(true), FTappableVariant.hovered}.toString()), findsOneWidget);

      setState(() => onPress = null);
      await tester.pumpAndSettle();
      expect(
        find.text({FTappableVariant.android, FTappableVariant.hovered, FTappableVariant.disabled}.toString()),
        findsOneWidget,
      );
    });

    testWidgets('variants are replaced rather than modified', (tester) async {
      late Set<FTappableVariant> variants;
      late StateSetter setState;
      var selected = false;

      await tester.pumpWidget(
        TestScaffold(
          child: StatefulBuilder(
            builder: (context, setter) {
              setState = setter;
              return FTappable.static(
                selected: selected,
                builder: (_, v, _) {
                  variants = v;
                  return const Text('tappable');
                },
                onPress: () {},
              );
            },
          ),
        ),
      );

      final before = identityHashCode(variants);

      setState(() => selected = true);
      await tester.pumpAndSettle();

      expect(identityHashCode(variants), isNot(before));
    });

    testWidgets('onVariantChange & onHoverChange callback called', (tester) async {
      Set<FTappableVariant>? previous;
      Set<FTappableVariant>? current;
      bool? hovered;
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable.static(
            builder: (_, _, _) => const Text('tappable'),
            onVariantChange: (p, c) {
              previous = p;
              current = c;
            },
            onHoverChange: (v) => hovered = v,
            onPress: () {},
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('tappable')));
      await tester.pumpAndSettle();

      expect(previous, isNot(contains(FTappableVariant.hovered)));
      expect(current, contains(FTappableVariant.hovered));
      expect(hovered, true);

      await gesture.moveTo(.zero);
      await tester.pumpAndSettle();

      expect(previous, contains(FTappableVariant.hovered));
      expect(current, isNot(contains(FTappableVariant.hovered)));
      expect(hovered, false);
    });
  });

  group('onDisabledPress', () {
    testWidgets('fires when disabled tappable is tapped', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(
            builder: (_, states, _) => Text('$states'),
            onDisabledPress: () => calls.add('onDisabledPress'),
          ),
        ),
      );
      expect(find.text(set(false).toString()), findsOneWidget);

      await tester.tap(find.byType(AnimatedTappable));
      await tester.pumpAndSettle();

      expect(calls, ['onDisabledPress']);
    });

    testWidgets('does not fire when enabled', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(
            builder: (_, states, _) => Text('$states'),
            onPress: () => calls.add('onPress'),
            onDisabledPress: () => calls.add('onDisabledPress'),
          ),
        ),
      );
      expect(find.text(set(true).toString()), findsOneWidget);

      await tester.tap(find.byType(AnimatedTappable));
      await tester.pumpAndSettle();

      expect(calls, ['onPress']);
    });

    testWidgets('focusable and activatable via keyboard when disabled', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(
            focusNode: focusNode,
            builder: (_, states, _) => Text('$states'),
            onDisabledPress: () => calls.add('onDisabledPress'),
          ),
        ),
      );
      expect(find.text(set(false).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, true);

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(calls, ['onDisabledPress']);
    });

    testWidgets('no bounce when pressed', (tester) async {
      final key = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(key: key, builder: (_, states, _) => Text('$states'), onDisabledPress: () {}),
        ),
      );

      final gesture = await tester.press(find.byType(AnimatedTappable));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(key.currentState?.bounce.value, 1.0);

      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('in FTappableGroup', () {
    Widget tappables(List<String> calls) => TestScaffold(
      child: FTappableGroup(
        child: Row(
          children: [
            FTappable(
              builder: (_, _, _) => const SizedBox(width: 50, height: 50, child: Text('A')),
              onPress: () => calls.add('A.onPress'),
              onPressDown: (_) => calls.add('A.onPressDown'),
              onPressMove: (_) => calls.add('A.onPressMove'),
              onPressUp: (_) => calls.add('A.onPressUp'),
              onPressCancel: () => calls.add('A.onPressCancel'),
              onLongPress: () => calls.add('A.onLongPress'),
              onLongPressDown: (_) => calls.add('A.onLongPressDown'),
              onLongPressCancel: () => calls.add('A.onLongPressCancel'),
              onLongPressStart: (_) => calls.add('A.onLongPressStart'),
              onLongPressMove: (_) => calls.add('A.onLongPressMove'),
              onLongPressEnd: (_) => calls.add('A.onLongPressEnd'),
            ),
            FTappable(
              builder: (_, _, _) => const SizedBox(width: 50, height: 50, child: Text('B')),
              onPress: () => calls.add('B.onPress'),
              onPressDown: (_) => calls.add('B.onPressDown'),
              onPressMove: (_) => calls.add('B.onPressMove'),
              onPressUp: (_) => calls.add('B.onPressUp'),
              onPressCancel: () => calls.add('B.onPressCancel'),
              onLongPress: () => calls.add('B.onLongPress'),
              onLongPressDown: (_) => calls.add('B.onLongPressDown'),
              onLongPressCancel: () => calls.add('B.onLongPressCancel'),
              onLongPressStart: (_) => calls.add('B.onLongPressStart'),
              onLongPressMove: (_) => calls.add('B.onLongPressMove'),
              onLongPressEnd: (_) => calls.add('B.onLongPressEnd'),
            ),
          ],
        ),
      ),
    );

    testWidgets('tap fires full lifecycle in exact order', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(calls, ['A.onPressDown', 'A.onLongPressDown', 'A.onPressUp', 'A.onPress', 'A.onLongPressCancel']);
    });

    testWidgets('long-press fires full lifecycle in exact order', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      await tester.longPress(find.text('A'));
      await tester.pumpAndSettle();

      expect(calls, [
        'A.onPressDown',
        'A.onLongPressDown',
        'A.onLongPressStart',
        'A.onLongPress',
        'A.onPressCancel',
        'A.onLongPressEnd',
      ]);
    });

    testWidgets('wiggle within A fires onPressMove without re-firing onPressDown', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      final aCenter = tester.getCenter(find.text('A'));
      final gesture = await tester.startGesture(aCenter);
      await tester.pump();
      // Wiggle inside A's bounds (entries are 50x50 — these offsets stay within).
      await gesture.moveTo(aCenter + const Offset(5, 0));
      await tester.pump();
      await gesture.moveTo(aCenter + const Offset(-5, 5));
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      // Down fires exactly once (no cancel/re-down cycle on every move).
      expect(calls.where((c) => c == 'A.onPressDown').length, 1);
      expect(calls.where((c) => c == 'A.onLongPressDown').length, 1);
      // Move callbacks fire for each move within the entry.
      expect(calls.where((c) => c == 'A.onPressMove').length, greaterThanOrEqualTo(2));
      // onPressCancel does NOT fire — tap completed normally.
      expect(calls, isNot(contains('A.onPressCancel')));
      // Completes with onPressUp + onPress + onLongPressCancel (long-press lost the arena).
      expect(calls, containsAllInOrder(['A.onPressUp', 'A.onPress', 'A.onLongPressCancel']));
    });

    testWidgets('slide A to B and release fires both lifecycles', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(calls.first, 'A.onPressDown');
      expect(
        calls,
        containsAllInOrder(['A.onPressDown', 'A.onLongPressDown', 'A.onPressCancel', 'A.onLongPressCancel']),
      );
      expect(
        calls,
        containsAllInOrder(['B.onPressDown', 'B.onLongPressDown', 'B.onPressUp', 'B.onPress', 'B.onLongPressCancel']),
      );
      expect(calls, isNot(contains('A.onPress')));
      expect(calls, isNot(contains('A.onPressUp')));
    });

    testWidgets('long-press A then slide to B and release fires both lifecycles', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump(kLongPressTimeout + const Duration(milliseconds: 50));
      await gesture.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(
        calls,
        containsAllInOrder([
          'A.onPressDown',
          'A.onLongPressDown',
          'A.onLongPressStart',
          'A.onLongPress',
          'A.onPressCancel',
          'A.onLongPressEnd',
        ]),
      );
      expect(
        calls,
        containsAllInOrder(['B.onPressDown', 'B.onLongPressDown', 'B.onPressUp', 'B.onPress', 'B.onLongPressCancel']),
      );
      // The documented both-fire: A.onLongPress AND B.onPress.
      expect(calls, contains('A.onLongPress'));
      expect(calls, contains('B.onPress'));
    });

    testWidgets('slide off into empty space fires cancels only', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.moveTo(.zero);
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(calls, ['A.onPressDown', 'A.onLongPressDown', 'A.onPressCancel', 'A.onLongPressCancel']);
    });

    testWidgets('slide A → B → A and release fires fresh A lifecycle', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(tappables(calls));

      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('B')));
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('A')));
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      // A appears twice — once cancelled, once completed.
      final aDowns = calls.where((c) => c == 'A.onPressDown').length;
      expect(aDowns, 2);
      expect(
        calls,
        containsAllInOrder([
          'A.onPressDown',
          'A.onPressCancel',
          'B.onPressDown',
          'B.onPressCancel',
          'A.onPressDown',
          'A.onPress',
        ]),
      );
    });

    testWidgets('disabled tappable with onDisabledPress fires on tap', (tester) async {
      final calls = <String>[];
      await tester.pumpWidget(
        TestScaffold(
          child: FTappableGroup(
            child: FTappable(
              builder: (_, _, _) => const SizedBox(width: 50, height: 50, child: Text('A')),
              onDisabledPress: () => calls.add('onDisabledPress'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(calls, ['onDisabledPress']);
    });

    testWidgets('entry unmounted mid-gesture does not crash on cancel', (tester) async {
      late StateSetter setState;
      var show = true;

      await tester.pumpWidget(
        TestScaffold(
          child: FTappableGroup(
            child: StatefulBuilder(
              builder: (_, setter) {
                setState = setter;
                return Column(
                  children: [
                    if (show)
                      FTappable(
                        builder: (_, _, _) => const SizedBox(width: 50, height: 50, child: Text('A')),
                        onPress: () {},
                      ),
                    const SizedBox(width: 50, height: 50, child: Text('keepalive')),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Press down on A — the group's recognizer captures A's entry as its current target.
      final gesture = await tester.startGesture(tester.getCenter(find.text('A')));
      await tester.pump();

      // Unmount A while the gesture is in progress. The recognizer (owned by the still-alive group) keeps its
      // reference to A's now-defunct entry.
      setState(() => show = false);
      await tester.pump();

      // Cancelling routes a PointerCancelEvent to the recognizer, which calls entry.exit() (FTappable._cancel) on the
      // defunct State.
      await gesture.cancel();
      await tester.pumpAndSettle();

      expect(tester.takeException(), null);
    });
  });

  group('nested', () {
    Widget nested({
      bool static = false,
      bool inner = true,
      Key? outerKey,
      Key? innerKey,
      List<String>? calls,
      ValueChanged<Set<FTappableVariant>>? onOuter,
      ValueChanged<Set<FTappableVariant>>? onInner,
    }) {
      final constructor = static ? FTappable.static : FTappable.new;
      return TestScaffold(
        child: constructor(
          key: outerKey,
          onPress: () => calls?.add('outer'),
          onVariantChange: onOuter == null ? null : (_, current) => onOuter(current),
          // The ColoredBox makes the padding gutter hit-testable, like a real widget's background.
          builder: (_, _, child) => ColoredBox(
            color: const Color(0x00000000),
            child: Padding(padding: const EdgeInsets.all(30), child: child),
          ),
          child: constructor(
            key: innerKey,
            onPress: inner ? () => calls?.add('inner') : null,
            onVariantChange: onInner == null ? null : (_, current) => onInner(current),
            child: const SizedBox(width: 60, height: 60, child: Text('inner')),
          ),
        ),
      );
    }

    for (final static in [false, true]) {
      testWidgets('pressing inner never presses outer - static: $static', (tester) async {
        final calls = <String>[];
        final outerSeen = <FTappableVariant>{};
        final innerSeen = <FTappableVariant>{};
        await tester.pumpWidget(
          nested(static: static, calls: calls, onOuter: outerSeen.addAll, onInner: innerSeen.addAll),
        );

        final gesture = await tester.startGesture(tester.getCenter(find.text('inner')));
        await tester.pump(const Duration(milliseconds: 200));

        expect(innerSeen.contains(FTappableVariant.pressed), true);
        expect(outerSeen.contains(FTappableVariant.pressed), false);

        await gesture.up();
        await tester.pumpAndSettle();

        expect(outerSeen.contains(FTappableVariant.pressed), false);
        expect(calls, ['inner']);
      });
    }

    testWidgets('pressing inner never bounces outer', (tester) async {
      final outerKey = GlobalKey<AnimatedTappableState>();
      final innerKey = GlobalKey<AnimatedTappableState>();
      await tester.pumpWidget(nested(outerKey: outerKey, innerKey: innerKey));

      final gesture = await tester.startGesture(tester.getCenter(find.text('inner')));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(innerKey.currentState?.bounce.value, 0.97);
      expect(outerKey.currentState?.bounce.value, 1);

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('pressing disabled inner with onDisabledPress does not press outer', (tester) async {
      final calls = <String>[];
      final outerSeen = <FTappableVariant>{};
      await tester.pumpWidget(
        TestScaffold(
          child: FTappable(
            onPress: () => calls.add('outer'),
            onVariantChange: (_, current) => outerSeen.addAll(current),
            builder: (_, _, child) => ColoredBox(
              color: const Color(0x00000000),
              child: Padding(padding: const EdgeInsets.all(30), child: child),
            ),
            child: FTappable(
              onDisabledPress: () => calls.add('inner.onDisabledPress'),
              child: const SizedBox(width: 60, height: 60, child: Text('inner')),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.text('inner')));
      await tester.pump(const Duration(milliseconds: 200));

      expect(outerSeen.contains(FTappableVariant.pressed), false);

      await gesture.up();
      await tester.pumpAndSettle();

      expect(calls, ['inner.onDisabledPress']);
    });

    testWidgets('pressing disabled inner presses outer', (tester) async {
      final calls = <String>[];
      final outerSeen = <FTappableVariant>{};
      await tester.pumpWidget(nested(inner: false, calls: calls, onOuter: outerSeen.addAll));

      final gesture = await tester.startGesture(tester.getCenter(find.text('inner')));
      await tester.pump(const Duration(milliseconds: 200));

      expect(outerSeen.contains(FTappableVariant.pressed), true);

      await gesture.up();
      await tester.pumpAndSettle();

      expect(calls, ['outer']);
    });

    testWidgets('outer presses normally after pressing inner', (tester) async {
      var outerLive = <FTappableVariant>{};
      await tester.pumpWidget(nested(onOuter: (current) => outerLive = current));

      await tester.tap(find.text('inner'));
      await tester.pumpAndSettle();
      expect(outerLive.contains(FTappableVariant.pressed), false);

      // 15px outside the inner tappable's top-left corner is within the outer tappable's padding.
      final gesture = await tester.startGesture(tester.getTopLeft(find.text('inner')) - const Offset(15, 15));
      await tester.pump(const Duration(milliseconds: 200));

      expect(outerLive.contains(FTappableVariant.pressed), true);

      await gesture.up();
      await tester.pumpAndSettle();

      expect(outerLive.contains(FTappableVariant.pressed), false);
    });

    testWidgets("second pointer on inner does not end outer's press", (tester) async {
      var outerLive = <FTappableVariant>{};
      await tester.pumpWidget(nested(onOuter: (current) => outerLive = current));

      final outer = await tester.startGesture(tester.getTopLeft(find.text('inner')) - const Offset(15, 15));
      await tester.pump(const Duration(milliseconds: 200));
      expect(outerLive.contains(FTappableVariant.pressed), true);

      final inner = await tester.startGesture(tester.getCenter(find.text('inner')));
      await tester.pump(const Duration(milliseconds: 50));
      await inner.up();
      await tester.pump(const Duration(milliseconds: 200));

      expect(outerLive.contains(FTappableVariant.pressed), true);

      await outer.up();
      await tester.pumpAndSettle();

      expect(outerLive.contains(FTappableVariant.pressed), false);
    });

    testWidgets('hovering inner also hovers outer', (tester) async {
      var outerLive = <FTappableVariant>{};
      var innerLive = <FTappableVariant>{};
      await tester.pumpWidget(
        nested(onOuter: (current) => outerLive = current, onInner: (current) => innerLive = current),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('inner')));
      await tester.pumpAndSettle();

      expect(innerLive.contains(FTappableVariant.hovered), true);
      expect(outerLive.contains(FTappableVariant.hovered), true);
    });
  });

  testWidgets('returns focused state on primary focus', (tester) async {
    FocusManager.instance.highlightStrategy = .alwaysTraditional;
    addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

    final focus = autoDispose(FocusNode());

    var focused = false;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTappable(
          focusNode: focus,
          onPress: focus.requestFocus,
          onVariantChange: (_, current) => focused = current.contains(FTappableVariant.focused),
          focusedOutlineStyle: FTheme.neutral.light.touch.style.focusedOutlineStyle,
          child: const Text('focus'),
        ),
      ),
    );

    await tester.tap(find.text('focus'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(focus.hasFocus, true);
    expect(focused, true);
  });

  testWidgets('return focused state on non-primary focus', (tester) async {
    FocusManager.instance.highlightStrategy = .alwaysTraditional;
    addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

    final focus = autoDispose(FocusNode());

    var focused = false;
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTappable(
          onVariantChange: (_, current) => focused = current.contains(FTappableVariant.focused),
          focusedOutlineStyle: FTheme.neutral.light.touch.style.focusedOutlineStyle,
          child: FButton(onPress: focus.requestFocus, focusNode: focus, child: const Text('focus')),
        ),
      ),
    );

    await tester.tap(find.text('focus'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(focus.hasFocus, true);
    expect(focused, true);
  });

  group('selectable', () {
    Future<String?> select(WidgetTester tester, {required bool static, required bool selectable}) async {
      String? selection;
      await tester.pumpWidget(
        TestScaffold.app(
          child: SelectionArea(
            onSelectionChanged: (content) => selection = content?.plainText,
            child: (static ? FTappable.static : FTappable.new)(
              selectable: selectable,
              onPress: () {},
              child: const Text('label'),
            ),
          ),
        ),
      );

      final paragraph = tester.renderObject<RenderParagraph>(
        find.descendant(of: find.text('label'), matching: find.byType(RichText)),
      );
      Offset offset(int index) =>
          paragraph.localToGlobal(paragraph.getOffsetForCaret(TextPosition(offset: index), .zero)) +
          Offset(0, paragraph.size.height / 2);

      final gesture = await tester.startGesture(offset(0), kind: .mouse);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(offset('label'.length));
      await gesture.up();
      await tester.pumpAndSettle();

      return selection;
    }

    for (final static in [false, true]) {
      final name = static ? 'FTappable.static' : 'FTappable';

      testWidgets('$name text is not selected by an enclosing SelectionArea by default', (tester) async {
        expect(await select(tester, static: static, selectable: false), null);
      });

      testWidgets('$name text is selected by an enclosing SelectionArea when selectable', (tester) async {
        expect(await select(tester, static: static, selectable: true), 'label');
      });
    }
  });

  group('accessibility', () {
    testWidgets('is a button with no state flags by default', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(onPress: () {}, child: const Text('tappable')),
        ),
      );

      expect(
        tester.getSemantics(find.text('tappable')),
        isSemantics(isButton: true, hasCheckedState: false, hasExpandedState: false),
      );
    });

    testWidgets('forwards button, checked, expanded, and inMutuallyExclusiveGroup', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(
            semanticsButton: false,
            semanticsChecked: true,
            semanticsExpanded: true,
            semanticsInMutuallyExclusiveGroup: true,
            onPress: () {},
            child: const Text('tappable'),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.text('tappable')),
        isSemantics(
          isButton: false,
          hasCheckedState: true,
          isChecked: true,
          hasExpandedState: true,
          isExpanded: true,
          isInMutuallyExclusiveGroup: true,
        ),
      );
    });

    testWidgets('forwards semanticsTooltip onto its own node', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(
            semanticsLabel: 'Save',
            semanticsTooltip: 'Save changes',
            onPress: () {},
            child: const Text('tappable'),
          ),
        ),
      );

      expect(tester.getSemantics(find.text('tappable')).getSemanticsData().tooltip, 'Save changes');

      semantics.dispose();
    });

    testWidgets('has no tooltip by default', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(onPress: () {}, child: const Text('tappable')),
        ),
      );

      expect(tester.getSemantics(find.text('tappable')).getSemanticsData().tooltip, '');

      semantics.dispose();
    });

    testWidgets('suppresses selected flag when checked is set', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(
            selected: true,
            semanticsChecked: true,
            onPress: () {},
            child: const Text('tappable'),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.text('tappable')),
        isSemantics(hasCheckedState: true, isChecked: true, hasSelectedState: false),
      );
    });

    testWidgets('exposes selected flag without checked', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(selected: true, onPress: () {}, child: const Text('tappable')),
        ),
      );

      expect(tester.getSemantics(find.text('tappable')), isSemantics(hasSelectedState: true, isSelected: true));
    });

    testWidgets('disabled with onDisabledPress announced as disabled with tap action', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTappable.static(onDisabledPress: () {}, child: const Text('tappable')),
        ),
      );

      expect(
        tester.getSemantics(find.text('tappable')),
        isSemantics(isButton: true, hasEnabledState: true, isEnabled: false, hasTapAction: true, isFocusable: true),
      );
    });

    testWidgets('disabled without onDisabledPress has no tap action', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: const FTappable.static(child: Text('tappable'))));

      expect(
        tester.getSemantics(find.text('tappable')),
        isSemantics(hasEnabledState: true, isEnabled: false, hasTapAction: false),
      );
    });
  });
}

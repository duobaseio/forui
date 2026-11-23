import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  testWidgets('press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(title: const Text('Bluetooth'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.tap(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 1);
    expect(longPress, 0);
  });

  testWidgets('disabled press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          enabled: false,
          title: const Text('Bluetooth'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.tap(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(title: const Text('Lorem'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.longPress(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 1);
  });

  testWidgets('disabled long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          enabled: false,
          title: const Text('Lorem'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.longPress(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('child hit test', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          title: const Text('Bluetooth'),
          details: FButton(onPress: () => count++, child: const Text('child')),
        ),
      ),
    );

    await tester.tap(find.text('child'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(count, 1);
  });

  for (final (name, theme) in [('touch', FTheme.neutral.light.touch), ('desktop', FTheme.neutral.light.desktop)]) {
    test('$name FTileGroupStyle.inherit(...) uses typography.body.xs2 for description and error', () {
      final typography = theme.typography.copyWith(
        body: theme.typography.body.copyWith(
          xs2: theme.typography.body.xs2.copyWith(fontFamily: 'Custom', fontWeight: .w700, letterSpacing: 2),
        ),
      );

      final style = FTileGroupStyle.inherit(
        colors: theme.colors,
        typography: typography,
        style: theme.style,
        hapticFeedback: theme.hapticFeedback,
      );

      final formField = theme.style.formFieldStyle;
      for (final (actual, expected) in [
        (style.descriptionTextStyle.base, formField.descriptionTextStyle.base),
        (
          style.descriptionTextStyle.resolve({FFormFieldVariant.disabled}),
          formField.descriptionTextStyle.resolve({FFormFieldVariant.disabled}),
        ),
        (style.errorTextStyle.base, formField.errorTextStyle.base),
        (
          style.errorTextStyle.resolve({FFormFieldErrorVariant.disabled}),
          formField.errorTextStyle.resolve({FFormFieldErrorVariant.disabled}),
        ),
      ]) {
        expect(actual.fontFamily, 'Custom');
        expect(actual.fontWeight, FontWeight.w700);
        expect(actual.letterSpacing, 2);
        expect(actual.fontSize, typography.body.xs2.fontSize);
        expect(actual.color, expected.color);
      }
    });
  }

  test('FTileGroupStyle.inherit(...) uses formFieldStyle colors for description and error', () {
    final theme = FTheme.neutral.light.touch;
    const base = TextStyle(color: Color(0xFF000001));
    final style = FTileGroupStyle.inherit(
      colors: theme.colors,
      typography: theme.typography,
      style: theme.style.copyWith(
        formFieldStyle: FFormFieldStyle(
          labelTextStyle: theme.style.formFieldStyle.labelTextStyle,
          descriptionTextStyle: FVariants.from(
            base,
            variants: {
              [.disabled]: const .delta(color: Color(0xFF000002)),
            },
          ),
          errorTextStyle: FVariants.from(
            base,
            variants: {
              [.disabled]: const .delta(color: Color(0xFF000003)),
            },
          ),
        ),
      ),
      hapticFeedback: theme.hapticFeedback,
    );

    expect(style.descriptionTextStyle.base.color, const Color(0xFF000001));
    expect(style.descriptionTextStyle.resolve({FFormFieldVariant.disabled}).color, const Color(0xFF000002));
    expect(style.errorTextStyle.base.color, const Color(0xFF000001));
    expect(style.errorTextStyle.resolve({FFormFieldErrorVariant.disabled}).color, const Color(0xFF000003));
  });

  group('design system', skip: !Platform.isMacOS, () {
    for (final (variant, name) in [(FItemVariant.primary, 'normal'), (FItemVariant.destructive, 'destructive')]) {
      testWidgets('touch $name tile has consistent height', (tester) async {
        final theme = FTheme.neutral.light.touch;
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FTile(key: const Key('tile'), variant: variant, title: const Text('Tile'), onPress: () {}),
          ),
        );

        expect(tester.getSize(find.byKey(const Key('tile'))).height, closeTo(theme.style.sizes.tile, 0.001));
      });
    }
  });

  group('accessibility', () {
    testWidgets('group node is named by the visible label and description', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTileGroup(
            label: const Text('Settings'),
            description: const Text('Device options'),
            children: [FTile(title: const Text('Bluetooth'), onPress: () {})],
          ),
        ),
      );

      final group = tester.getSemantics(find.bySemanticsLabel('Settings'));
      expect(group, isSemantics(label: 'Settings', hint: 'Device options'));

      var ancestor = tester.getSemantics(find.bySemanticsLabel('Bluetooth')).parent;
      while (ancestor != null && ancestor != group) {
        ancestor = ancestor.parent;
      }
      expect(ancestor, group);

      semantics.dispose();
    });

    testWidgets('semanticsLabel names a separate group node', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTileGroup(
            label: const Text('Settings'),
            semanticsLabel: 'Settings group',
            children: [FTile(title: const Text('Bluetooth'), onPress: () {})],
          ),
        ),
      );

      final group = tester.getSemantics(find.bySemanticsLabel('Settings group'));
      expect(group.parent, tester.getSemantics(find.bySemanticsLabel('Settings')));

      semantics.dispose();
    });
  });
}

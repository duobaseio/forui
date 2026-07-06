import 'package:flutter/material.dart' hide VerticalDivider;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/divider.dart';
import '../../test_scaffold.dart';

void main() {
  final style = FResizableDividerStyle(
    color: const Color(0xFF000000),
    width: 2,
    thumbStyle: FResizableDividerThumbStyle(
      decoration: const BoxDecoration(color: Color(0xFF000000)),
      foregroundColor: const Color(0xFF000000),
      icon: FIcons.iconData(FLucideIcons.gripVertical),
      height: 4,
      width: 4,
    ),
    focusedOutlineStyle: FFocusedOutlineStyle(color: const Color(0xFF000000), width: 2, borderRadius: .circular(4)),
    hapticFeedback: FHapticFeedback.noFeedback,
  );

  final left = FResizableRegionData(index: 0, extent: (min: 10, max: 100, total: 100), offset: (min: 0, max: 50));
  final right = FResizableRegionData(index: 1, extent: (min: 10, max: 100, total: 100), offset: (min: 50, max: 100));

  late FResizableController controller;

  setUp(() => controller = FResizableController()..regions.addAll([left, right]));

  for (final (index, constructor) in [
    () => HorizontalDivider(
      controller: controller,
      style: style,
      type: .divider,
      left: -1,
      right: 0,
      crossAxisExtent: null,
      hitRegionExtent: 100,
      cursor: .defer,
      resizePercentage: 0.1,
      semanticFormatterCallback: (l, r) => '',
    ),
    () => HorizontalDivider(
      controller: controller,
      style: style,
      type: .divider,
      left: 0,
      right: 0,
      crossAxisExtent: null,
      hitRegionExtent: 100,
      cursor: .defer,
      resizePercentage: 0.1,
      semanticFormatterCallback: (l, r) => '',
    ),
  ].indexed) {
    test('[$index] constructor throws error', () => expect(constructor, throwsAssertionError));
  }

  group('haptic feedback', () {
    Future<int> run({required WidgetTester tester, required Axis axis, required List<double> steps}) async {
      var feedback = 0;
      final colors = FTheme.neutral.light.touch.colors;

      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          theme: FThemeData(
            colors: colors,
            touch: true,
            hapticFeedback: FHapticFeedback(lightImpact: () async => feedback++),
          ),
          child: Center(
            child: FResizable(
              crossAxisExtent: 50,
              axis: axis,
              children: [
                .fixed(extent: 30, minExtent: 20, builder: (context, snapshot, child) => const Align(child: Text('A'))),
                .fixed(extent: 70, minExtent: 20, builder: (context, snapshot, child) => const Align(child: Text('B'))),
              ],
            ),
          ),
        ),
      );

      final divider = axis == .horizontal ? find.byType(HorizontalDivider) : find.byType(VerticalDivider);
      final gesture = await tester.startGesture(tester.getCenter(divider));
      for (final step in steps) {
        final offset = axis == .horizontal ? Offset(step, 0) : Offset(0, step);
        await gesture.moveBy(offset);
        await tester.pump();
      }
      await gesture.up();
      await tester.pumpAndSettle();
      return feedback;
    }

    for (final axis in [Axis.horizontal, Axis.vertical]) {
      group('$axis', () {
        testWidgets('fast slam fires haptic on collision', (tester) async {
          expect(await run(tester: tester, axis: axis, steps: [60, 20]), 1);
        });

        testWidgets('slow nudge below velocity threshold stays silent', (tester) async {
          expect(await run(tester: tester, axis: axis, steps: [60, 5]), 0);
        });
      });
    }

    testWidgets('FHapticFeedback.none() leaves divider style with no-op haptic', (tester) async {
      final colors = FTheme.neutral.light.touch.colors;
      final theme = FThemeData(colors: colors, touch: true, hapticFeedback: const FHapticFeedback.none());

      expect(theme.resizableStyles.horizontal.hapticFeedback, FHapticFeedback.noFeedback);
      expect(theme.resizableStyles.vertical.hapticFeedback, FHapticFeedback.noFeedback);
    });
  });

  testWidgets('focus outline uses the divider style focusedOutlineStyle', (tester) async {
    const color = Color(0xFFABCDEF);
    final custom = FResizableDividerStyle(
      color: const Color(0xFF000000),
      width: 2,
      thumbStyle: style.thumbStyle,
      focusedOutlineStyle: FFocusedOutlineStyle(color: color, width: 2, borderRadius: .circular(4)),
      hapticFeedback: FHapticFeedback.noFeedback,
    );

    await tester.pumpWidget(
      TestScaffold.app(
        child: Stack(
          children: [
            HorizontalDivider(
              controller: controller,
              style: custom,
              type: .divider,
              left: 0,
              right: 1,
              crossAxisExtent: 50,
              hitRegionExtent: 100,
              cursor: .defer,
              resizePercentage: 0.1,
              semanticFormatterCallback: (l, r) => '',
            ),
          ],
        ),
      ),
    );

    final outline = tester.widget<FFocusedOutline>(find.byType(FFocusedOutline));
    const sentinel = FFocusedOutlineStyle(color: const Color(0xFF111111), width: 9, borderRadius: .zero);
    expect(outline.style(sentinel).color, color);
  });
}

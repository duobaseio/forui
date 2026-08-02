import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('showFDialog', () {
    testWidgets('tap on barrier does not dismiss dialog', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                barrierDismissible: false,
                context: context,
                builder: (context, _, animation) => FDialog.adaptive(
                  animation: animation,
                  horizontalBuilder: _confirmation,
                  verticalBuilder: _confirmation,
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.text('Are you absolutely sure?'), findsOneWidget);
    });

    testWidgets('tap on barrier dismisses dialog', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                context: context,
                builder: (context, _, animation) => FDialog.adaptive(
                  animation: animation,
                  horizontalBuilder: _confirmation,
                  verticalBuilder: _confirmation,
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      expect(find.text('Are you absolutely sure?'), findsOneWidget);

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.text('Are you absolutely sure?'), findsNothing);
    });
  });

  group('FDialog', () {
    testWidgets('infinite sized child', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FDialog(
            builder: (context, style) => SingleChildScrollView(
              child: Text.rich(
                WidgetSpan(
                  child: Stack(
                    children: [Container(height: 200, width: double.infinity, color: Colors.red)],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('scrollable body', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton(
              mainAxisSize: .min,
              onPress: () => showFDialog(
                context: context,
                builder: (context, style, animation) =>
                    FDialog(style: style, animation: animation, builder: _scrollable),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), null);
    });

    group('resizeToAvoidInsets', () {
      // Default style.insetPadding is EdgeInsets.symmetric(horizontal: 40, vertical: 24).
      const styleBottomPadding = 24.0;
      const viewInsetsBottom = 300.0;

      for (final (resize, expectedBottom) in [
        (true, viewInsetsBottom + styleBottomPadding),
        (false, styleBottomPadding),
      ]) {
        testWidgets('resize=$resize -> bottom padding = $expectedBottom', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: MediaQuery(
                data: const MediaQueryData(viewInsets: EdgeInsets.only(bottom: viewInsetsBottom)),
                child: FDialog.adaptive(
                  resizeToAvoidInsets: resize,
                  horizontalBuilder: _emptyBuilder,
                  verticalBuilder: _emptyBuilder,
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          final padding = tester
              .widget<AnimatedPadding>(find.byType(AnimatedPadding).first)
              .padding
              .resolve(TextDirection.ltr);
          expect(padding.bottom, expectedBottom);
        });
      }

      testWidgets('default is true across all constructors', (tester) async {
        expect(const FDialog(builder: _emptyBuilder).resizeToAvoidInsets, true);
        expect(
          FDialog.adaptive(horizontalBuilder: _emptyBuilder, verticalBuilder: _emptyBuilder).resizeToAvoidInsets,
          true,
        );
      });
    });

    testWidgets('restyles when the enclosing theme changes while open', (tester) async {
      Widget app(FThemeData theme) => TestScaffold.app(
        theme: theme,
        child: Builder(
          builder: (context) => FButton(
            onPress: () => showFDialog(
              context: context,
              builder: (context, style, _) => FDialog(style: style, builder: (_, _) => const Text('dialog')),
            ),
            child: const Text('button'),
          ),
        ),
      );

      await tester.pumpWidget(app(FTheme.neutral.light.touch));
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      ShapeDecoration decoration() =>
          tester
                  .widget<DecoratedBox>(
                    find.descendant(of: find.byType(FDialog), matching: find.byType(DecoratedBox)).first,
                  )
                  .decoration
              as ShapeDecoration;

      expect(decoration().color, FTheme.neutral.light.touch.colors.card);

      await tester.pumpWidget(app(FTheme.neutral.dark.touch));
      await tester.pumpAndSettle();

      expect(decoration().color, FTheme.neutral.dark.touch.colors.card);
    });

    group('captured scopes', () {
      ShapeDecoration decoration(WidgetTester tester) =>
          tester
                  .widget<DecoratedBox>(
                    find.descendant(of: find.byType(FDialog), matching: find.byType(DecoratedBox)).first,
                  )
                  .decoration
              as ShapeDecoration;

      testWidgets('uses nested theme below the navigator and observes changes', (tester) async {
        Widget app(FThemeData nested) => TestScaffold.app(
          child: FTheme(
            data: nested,
            child: Builder(
              builder: (context) => FButton(
                onPress: () => showFDialog(
                  context: context,
                  builder: (context, style, _) => FDialog(style: style, builder: (_, _) => const Text('dialog')),
                ),
                child: const Text('button'),
              ),
            ),
          ),
        );

        await tester.pumpWidget(app(TestScaffold.greenOverride));
        await tester.tap(find.text('button'));
        await tester.pumpAndSettle();

        expect(decoration(tester).color, TestScaffold.greenOverride.colors.card);

        await tester.pumpWidget(app(TestScaffold.blueOverride));
        await tester.pumpAndSettle();

        expect(decoration(tester).color, TestScaffold.blueOverride.colors.card);
      });

      testWidgets('observes nested FAccessibilityScope below the navigator', (tester) async {
        const all = FAccessibility(accessibleNavigation: false, motion: .all, focusHighlight: false);
        const disabled = FAccessibility(accessibleNavigation: false, motion: .disabled, focusHighlight: false);

        FAccessibilityMotion? seen;
        Widget app(FAccessibility accessibility) => TestScaffold.app(
          child: FAccessibilityScope(
            data: accessibility,
            child: Builder(
              builder: (context) => FButton(
                onPress: () => showFDialog(
                  context: context,
                  builder: (context, style, _) => FDialog(
                    style: style,
                    builder: (context, _) {
                      seen = context.accessibility.motion;
                      return const Text('dialog');
                    },
                  ),
                ),
                child: const Text('button'),
              ),
            ),
          ),
        );

        await tester.pumpWidget(app(all));
        await tester.tap(find.text('button'));
        await tester.pumpAndSettle();

        expect(seen, FAccessibilityMotion.all);

        await tester.pumpWidget(app(disabled));
        await tester.pumpAndSettle();

        expect(seen, FAccessibilityMotion.disabled);
      });

      testWidgets('observes nested FAdaptiveScope below the navigator', (tester) async {
        FPlatformVariant? seen;
        Widget app(FPlatformVariant platform) => TestScaffold.app(
          child: FAdaptiveScope(
            platform: platform,
            child: Builder(
              builder: (context) => FButton(
                onPress: () => showFDialog(
                  context: context,
                  builder: (context, style, _) => FDialog(
                    style: style,
                    builder: (context, _) {
                      seen = context.platformVariant;
                      return const Text('dialog');
                    },
                  ),
                ),
                child: const Text('button'),
              ),
            ),
          ),
        );

        await tester.pumpWidget(app(.android));
        await tester.tap(find.text('button'));
        await tester.pumpAndSettle();

        expect(seen, FPlatformVariant.android);

        await tester.pumpWidget(app(.iOS));
        await tester.pumpAndSettle();

        expect(seen, FPlatformVariant.iOS);
      });

      testWidgets('retains captured scopes after the call-site is removed', (tester) async {
        Widget app({required bool present}) => TestScaffold.app(
          child: !present
              ? const SizedBox()
              : FTheme(
                  data: TestScaffold.greenOverride,
                  child: Builder(
                    builder: (context) => FButton(
                      onPress: () => showFDialog(
                        context: context,
                        builder: (context, style, _) => FDialog(style: style, builder: (_, _) => const Text('dialog')),
                      ),
                      child: const Text('button'),
                    ),
                  ),
                ),
        );

        await tester.pumpWidget(app(present: true));
        await tester.tap(find.text('button'));
        await tester.pumpAndSettle();

        expect(decoration(tester).color, TestScaffold.greenOverride.colors.card);

        await tester.pumpWidget(app(present: false));
        await tester.pumpAndSettle();

        expect(tester.takeException(), null);
        expect(find.text('dialog'), findsOneWidget);
        expect(decoration(tester).color, TestScaffold.greenOverride.colors.card);
      });
    });
  });
}

Widget _confirmation(BuildContext _, FDialogStyle _) => const Text('Are you absolutely sure?');

Widget _scrollable(BuildContext _, FDialogStyle _) => SingleChildScrollView(child: Container(height: 5000));

Widget _emptyBuilder(BuildContext _, FDialogStyle _) => const SizedBox.shrink();

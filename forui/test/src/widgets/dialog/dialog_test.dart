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
                builder: (context, _, animation) => FDialog(
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
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
                builder: (context, _, animation) => FDialog(
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(variant: .outline, onPress: () {}, child: const Text('Cancel')),
                  ],
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
    for (final direction in Axis.values) {
      testWidgets('$direction infinite sized child', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FDialog(
              direction: direction,
              title: const Text('Are you absolutely sure?'),
              body: SingleChildScrollView(
                child: Text.rich(
                  WidgetSpan(
                    child: Stack(
                      children: [Container(height: 200, width: .infinity, color: Colors.red)],
                    ),
                  ),
                ),
              ),
              actions: [
                FButton(child: const Text('Continue'), onPress: () {}),
                FButton(variant: .outline, child: const Text('Cancel'), onPress: () {}),
              ],
            ),
          ),
        );

        expect(tester.takeException(), null);
      });
    }

    testWidgets('scrollable body', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton(
              mainAxisSize: .min,
              onPress: () => showFDialog(
                context: context,
                builder: (context, style, animation) => FDialog(
                  style: style,
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: SingleChildScrollView(child: Container(height: 5000)),
                  actions: [
                    FButton(variant: .outline, child: const Text('Cancel'), onPress: () {}),
                    FButton(child: const Text('Continue'), onPress: () {}),
                  ],
                ),
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
                child: FDialog(
                  resizeToAvoidInsets: resize,
                  title: const Text('Title'),
                  body: const Text('Body'),
                  actions: [FButton(onPress: () {}, child: const Text('OK'))],
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
        expect(FDialog(actions: const [], title: const Text('x')).resizeToAvoidInsets, true);
        expect(FDialog.adaptive(actions: const []).resizeToAvoidInsets, true);
        expect(const FDialog.raw(builder: _emptyBuilder).resizeToAvoidInsets, true);
      });
    });
  });
}

Widget _emptyBuilder(BuildContext _, FDialogStyle _) => const SizedBox.shrink();

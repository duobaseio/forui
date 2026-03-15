import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTabs Swipe Logic', () {
    testWidgets('swiping switches tabs when expands and swipeablePhysics are true', (tester) async {
      int index = 0;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              Expanded(
                child: FTabs(
                  expands: true,
                  swipeablePhysics: true,
                  control: .managed(onChange: (val) => index = val),
                  children: const [
                    FTabEntry(label: Text('Tab 1'), child: Text('Content 1')),
                    FTabEntry(label: Text('Tab 2'), child: Text('Content 2')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);

      // Drag from right to left to switch to Tab 2
      await tester.drag(find.text('Content 1'), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(index, 1);
      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('swiping does NOT switch tabs when swipeablePhysics is false', (tester) async {
      int index = 0;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              Expanded(
                child: FTabs(
                  expands: true,
                  swipeablePhysics: false,
                  control: .managed(onChange: (val) => index = val),
                  children: const [
                    FTabEntry(label: Text('Tab 1'), child: Text('Content 1')),
                    FTabEntry(label: Text('Tab 2'), child: Text('Content 2')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Attempt to drag from right to left
      await tester.drag(find.text('Content 1'), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(index, 0);
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);
    });

    testWidgets('does not assert when expands: true in bounded height container', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: SizedBox(
            height: 500,
            child: FTabs(
              expands: true,
              children: const [FTabEntry(label: Text('Tab 1'), child: Text('Content 1'))],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('defaults swipeablePhysics to true on mobile', (tester) async {
      int index = 0;
      await tester.pumpWidget(
        TestScaffold.app(
          platform: FPlatformVariant.iOS,
          child: Column(
            children: [
              Expanded(
                child: FTabs(
                  expands: true,
                  control: .managed(onChange: (val) => index = val),
                  children: const [
                    FTabEntry(label: Text('Tab 1'), child: Text('Content 1')),
                    FTabEntry(label: Text('Tab 2'), child: Text('Content 2')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Swipe from right to left
      await tester.drag(find.text('Content 1'), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(index, 1);
    });

    testWidgets('defaults swipeablePhysics to false on desktop', (tester) async {
      int index = 0;
      await tester.pumpWidget(
        TestScaffold.app(
          platform: FPlatformVariant.macOS,
          child: Column(
            children: [
              Expanded(
                child: FTabs(
                  expands: true,
                  control: .managed(onChange: (val) => index = val),
                  children: const [
                    FTabEntry(label: Text('Tab 1'), child: Text('Content 1')),
                    FTabEntry(label: Text('Tab 2'), child: Text('Content 2')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Attempt to swipe
      await tester.drag(find.text('Content 1'), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(index, 0);
    });
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('switches tabs via tapping', (tester) async {
      var index = 0;

      Future<void> rebuild() async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FTabs(
              control: .lifted(index: index, onChange: (value) => index = value),
              children: const [
                FTabEntry(label: Text('foo'), child: Text('foo content')),
                FTabEntry(label: Text('bar'), child: Text('bar content')),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      await rebuild();
      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('bar'));
      await rebuild();
      expect(find.text('foo content'), findsNothing);
      expect(find.text('bar content'), findsOneWidget);

      await tester.tap(find.text('foo'));
      await rebuild();
      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);
    });

    testWidgets('tabs do not change when onChange does nothing', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            control: .lifted(index: 0, onChange: (_) {}),
            children: const [
              FTabEntry(label: Text('foo'), child: Text('foo content')),
              FTabEntry(label: Text('bar'), child: Text('bar content')),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('bar'));
      await tester.pumpAndSettle();

      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);
    });
  });

  group('managed', () {
    testWidgets('onChange', (tester) async {
      var index = -1;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            control: .managed(onChange: (value) => index = value),
            children: const [
              FTabEntry(label: Text('foo'), child: Text('foo content')),
              FTabEntry(label: Text('bar'), child: Text('bar content')),
            ],
          ),
        ),
      );

      await tester.tap(find.text('bar'));
      await tester.pumpAndSettle();
      expect(index, 1);

      await tester.tap(find.text('foo'));
      await tester.pumpAndSettle();
      expect(index, 0);
    });
  });

  testWidgets('embedded in CupertinoApp', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: TestScaffold(
          child: FTabs(
            children: [FTabEntry(label: const Text('Account'), child: Container(height: 100))],
          ),
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  testWidgets('embedded in MaterialApp', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TestScaffold(
          child: FTabs(
            children: [FTabEntry(label: const Text('Account'), child: Container(height: 100))],
          ),
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  testWidgets('not embedded in any App', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FTabs(
          children: [FTabEntry(label: const Text('Account'), child: Container(height: 100))],
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  testWidgets('controller with non-first index', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTabs(
          control: const .managed(initial: 1),
          children: [
            FTabEntry(
              label: const Text('Account'),
              child: FCard(
                title: const Text('Account'),
                subtitle: const Text('Make changes to your account here. Click save when you are done.'),
                child: Container(color: Colors.blue, height: 100),
              ),
            ),
            FTabEntry(
              label: const Text('Password'),
              child: FCard(
                title: const Text('Password'),
                subtitle: const Text('Change your password here. After saving, you will be logged out.'),
                child: Container(color: Colors.red, height: 100),
              ),
            ),
          ],
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  testWidgets('non-English Locale', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('fr', 'FR'),
        delegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        child: TestScaffold(
          child: FTabs(
            children: [FTabEntry(label: const Text('Account'), child: Container(height: 100))],
          ),
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  group('tap', () {
    testWidgets('tap on current entry', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            children: const [
              FTabEntry(label: Text('foo'), child: Text('foo content')),
              FTabEntry(label: Text('bar'), child: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('foo'));
      await tester.pumpAndSettle();

      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);
    });

    testWidgets('tapping on tab switches tab entry', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            children: const [
              FTabEntry(label: Text('foo'), child: Text('foo content')),
              FTabEntry(label: Text('bar'), child: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('bar'));
      await tester.pumpAndSettle();

      expect(find.text('bar content'), findsOneWidget);
    });

    testWidgets('using controller to switch tab entry', (tester) async {
      final controller = autoDispose(FTabController(length: 2, vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            control: .managed(controller: controller),
            children: const [
              FTabEntry(label: Text('foo'), child: Text('foo content')),
              FTabEntry(label: Text('bar'), child: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('bar content'), findsNothing);

      controller.animateTo(1);
      await tester.pumpAndSettle();

      expect(find.text('bar content'), findsOneWidget);
    });

    testWidgets('onPress is triggered when a tab is pressed', (tester) async {
      var index = -1;
      final controller = autoDispose(FTabController(length: 2, vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            control: .managed(controller: controller),
            children: const [
              FTabEntry(label: Text('foo'), child: Text('foo content')),
              FTabEntry(label: Text('bar'), child: Text('bar content')),
            ],
            onPress: (i) => index = i,
          ),
        ),
      );

      await tester.tap(find.text('bar'));
      await tester.pumpAndSettle();

      expect(index, 1);
      expect(controller.index, 1);
      expect(find.text('foo content'), findsNothing);
      expect(find.text('bar content'), findsOneWidget);

      await tester.pumpAndSettle();
    });
  });

  group('swipe', () {
    testWidgets('swiping switches tabs when expands is true', (tester) async {
      int index = 0;
      await tester.pumpWidget(
        TestScaffold.app(
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

      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);

      // Drag from right to left to switch to Tab 2
      await tester.drag(find.text('Content 1'), const Offset(-600, 0));
      await tester.pumpAndSettle();

      expect(index, 1);
      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('swiping does NOT switch tabs when contentPhysics is NeverScrollableScrollPhysics', (tester) async {
      int index = 0;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              Expanded(
                child: FTabs(
                  expands: true,
                  contentPhysics: const NeverScrollableScrollPhysics(),
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
  });
}

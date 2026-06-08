@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FDateField.calendar(style: TestScaffold.blueScreen.dateFieldStyle, key: key),
        ),
      ),
    );

    await tester.tap(find.byKey(key));

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with placeholder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FDateField.calendar(key: key),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/calendar/placeholder.png'),
      );
    });

    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: FDateField.calendar(prefixBuilder: null)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/calendar/no-icon.png'));
    });

    testWidgets('${theme.name} with builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FDateField.calendar(
            key: key,
            builder: (context, _, _, child) => ColoredBox(color: context.theme.colors.destructive, child: child),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime(2025, 4))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/calendar/builder.png'));
    });

    testWidgets('${theme.name} hr locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('hr'),
          alignment: .topCenter,
          child: FDateField.calendar(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/calendar/hr-locale.png'),
      );
    });

    testWidgets('${theme.name} text', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField.calendar(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/calendar/text.png'));
    });

    testWidgets('${theme.name} does not auto hide', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField.calendar(
            key: key,
            calendar: FDateFieldGridCalendarProperties(
              autoHide: false,
              control: FGridCalendarControl(today: .utc(2025, 1, 15)),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/calendar/no-auto-hide.png'),
      );
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FDateField.calendar(enabled: false, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/calendar/disabled.png'));
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topCenter,
          theme: theme.data,
          child: FDateField.calendar(
            forceErrorText: 'Error',
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime(2025, 4))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/calendar/error.png'));
    });

    testWidgets('${theme.name} keyboard navigation', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FDateField.calendar(
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime(2025, 5, 21))),
          ),
        ),
      );

      await tester.sendKeyEvent(.tab);
      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/calendar/keyboard-navigation.png'),
      );
    });

    for (final (name, properties) in [
      ('grid', FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime.utc(2025, 1, 15)))),
      (
        'split-grid',
        FDateFieldGridSplitCalendarProperties(control: FGridSplitCalendarControl(today: DateTime.utc(2025, 1, 15))),
      ),
      ('wheel', FDateFieldWheelCalendarProperties(control: FWheelCalendarControl(today: DateTime.utc(2025, 1, 15)))),
    ]) {
      testWidgets('${theme.name} $name calendar', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            locale: const Locale('en', 'SG'),
            alignment: .topCenter,
            child: FDateField.calendar(key: key, calendar: properties),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('date-field/${theme.name}/calendar/mode-$name.png'),
        );
      });
    }

    testWidgets('${theme.name} wheel month-year picker', (tester) async {
      final controller = autoDispose(FWheelCalendarController(today: DateTime.utc(2025, 1, 15)));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField.calendar(
            key: key,
            calendar: FDateFieldWheelCalendarProperties(control: FWheelCalendarControl(controller: controller)),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      controller.toggleMonthYearPicker();
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/calendar/mode-wheel-picker.png'),
      );
    });
  }

  testWidgets('popover builder', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        child: FDateField.calendar(
          key: key,
          calendar: FDateFieldGridCalendarProperties(
            control: FGridCalendarControl(today: DateTime(2025, 5, 21)),
            popoverBuilder: (context, _, _, content) => SingleChildScrollView(
              child: Column(
                mainAxisSize: .min,
                children: [
                  const Padding(padding: .all(8), child: Text('Before')),
                  content,
                  const Padding(padding: .all(8), child: Text('After')),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/calendar/popover-builder.png'));
  });
}

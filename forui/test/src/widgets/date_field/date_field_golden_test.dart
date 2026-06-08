@Tags(['golden'])
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = Key('field');

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FDateField(style: TestScaffold.blueScreen.dateFieldStyle, key: key),
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
          child: FDateField(key: key),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/placeholder.png'),
      );
    });

    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FDateField(prefixBuilder: null)));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/no-icon.png'),
      );
    });

    // This looks really buggy but it seems like a Flutter issue.
    testWidgets('${theme.name} with builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FDateField(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: DateTime(2025, 4))),
            builder: (context, _, _, child) => ColoredBox(color: context.theme.colors.destructive, child: child),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/builder.png'),
      );
    });

    testWidgets('${theme.name} hr locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('hr'),
          alignment: .topCenter,
          child: FDateField(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/hr-locale.png'),
      );
    });

    testWidgets('${theme.name} click shows calendar', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/show-calendar.png'),
      );
    });

    testWidgets('${theme.name} click shows calendar', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/calendar-updates-field.png'),
      );
    });

    testWidgets('${theme.name} field', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField(
            key: key,
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(key), '15/01/2025');
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/field-updates-calendar.png'),
      );
    });

    testWidgets('${theme.name} does not auto hide', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: FDateField(
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
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/no-auto-hide.png'),
      );
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FDateField(enabled: false, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/disabled.png'),
      );
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FDateField(
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
            forceErrorText: 'Error',
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/error.png'),
      );
    });

    testWidgets('${theme.name} tap outside does not unfocus on Android/iOS', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FDateField(key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/mobile-focused.png'),
      );
    });

    testWidgets('${theme.name} tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = .macOS;

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FDateField(key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input-calendar/desktop-unfocused.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  }

  testWidgets('arrow key traversal works without setState', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        locale: const Locale('en', 'SG'),
        child: FDateField(
          key: key,
          calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
        ),
      ),
    );

    await tester.tapAt(tester.getTopLeft(find.byKey(key)));
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(.arrowRight);
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(.arrowRight);
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(.arrowLeft);
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/arrow-key-traversal.png'));
  });

  testWidgets('popover builder', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        child: FDateField(
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

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/popover-builder.png'));
  });

  group('preserve selection', () {
    testWidgets('managed - short to long', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(initial: .utc(2025)),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 1, 15))),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('12'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/managed-selection-short-long.png'));
    });

    testWidgets('managed - long to short', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            selectionControl: .managedSingle(initial: .utc(2025, 12, 15)),
            calendar: FDateFieldGridCalendarProperties(control: FGridCalendarControl(today: .utc(2025, 12, 15))),
          ),
        ),
      );

      // Focus and select day part (second part)
      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/managed-selection-long-short.png'));
    });
  });
}

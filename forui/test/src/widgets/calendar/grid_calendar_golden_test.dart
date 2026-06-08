@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import '../../test_scaffold.dart';

FGridCalendarControl _control({DateTime? start}) => FGridCalendarControl(
  start: start ?? .utc(2023, 2, 8),
  today: .utc(2024, 7, 14),
  initial: .utc(2024, 7, 14),
  end: .utc(2025, 8, 10),
);

Widget _harness({
  required FThemeData theme,
  FDateSelectionControl? selectionControl,
  FGridCalendarControl? control,
  TextDirection textDirection = .ltr,
}) => TestScaffold.app(
  theme: theme,
  textDirection: textDirection,
  child: FCalendar.grid(
    selectionControl: selectionControl ?? .managedRange(initial: (.utc(2024, 7, 11), .utc(2024, 7, 19))),
    control: control ?? _control(),
  ),
);

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('calendar/grid-calendar/${theme.name}/$name.png'));
    }

    testWidgets('day grid - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await expectGolden(tester, 'day-grid');
    });

    testWidgets('day grid disabled previous - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        _harness(
          theme: theme.data,
          control: _control(start: .utc(2024, 7)),
        ),
      );
      await expectGolden(tester, 'day-grid-disabled-prev');
    });

    testWidgets('month grid - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.text('July 2024'));
      await expectGolden(tester, 'month-grid');
    });

    testWidgets('month grid other year - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      // Page to 2025 so today's month (July 2024) is no longer underlined.
      await tester.tap(find.byType(FButton).last);
      await expectGolden(tester, 'month-grid-other-year');
    });

    testWidgets('year grid - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await expectGolden(tester, 'year-grid');
    });

    testWidgets('day grid RTL - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data, textDirection: TextDirection.rtl));
      await expectGolden(tester, 'day-grid-rtl');
    });
  }

  group('blue screen', () {
    Widget blue() => TestScaffold.blue(
      child: FCalendar.grid(
        selectionControl: .managedRange(initial: (.utc(2024, 7, 11), .utc(2024, 7, 19))),
        control: _control(),
        style: TestScaffold.blueScreen.calendarStyle,
      ),
    );

    testWidgets('day grid', (tester) async {
      await tester.pumpWidget(blue());
      await tester.pumpAndSettle();
      await expectBlueScreen();
    });

    testWidgets('month grid', (tester) async {
      await tester.pumpWidget(blue());
      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await expectBlueScreen();
    });

    testWidgets('year grid', (tester) async {
      await tester.pumpWidget(blue());
      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(Header), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await expectBlueScreen();
    });
  });
}

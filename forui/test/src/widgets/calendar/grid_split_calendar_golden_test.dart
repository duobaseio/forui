@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';
import '../../test_scaffold.dart';

Widget _harness({
  required FThemeData theme,
  FDateSelectionControl? selectionControl,
  FGridSplitCalendarControl? control,
  TextDirection textDirection = .ltr,
}) => TestScaffold.app(
  theme: theme,
  textDirection: textDirection,
  child: FCalendar.splitGrid(
    selectionControl: selectionControl ?? .managedRange(initial: (.utc(2024, 7, 11), .utc(2024, 7, 19))),
    control:
        control ??
        FGridSplitCalendarControl(
          start: .utc(2023, 2, 8),
          today: .utc(2024, 7, 14),
          initial: .utc(2024, 7, 14),
          end: .utc(2025, 8, 10),
        ),
  ),
);

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('calendar/grid-split-calendar/${theme.name}/$name.png'),
      );
    }

    testWidgets('day grid - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await expectGolden(tester, 'day-grid');
    });

    testWidgets('day grid disabled previous - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        _harness(
          theme: theme.data,
          control: FGridSplitCalendarControl(
            start: .utc(2024, 7),
            today: .utc(2024, 7, 14),
            initial: .utc(2024, 7, 14),
            end: .utc(2025, 8, 10),
          ),
        ),
      );
      await expectGolden(tester, 'day-grid-disabled-prev');
    });

    testWidgets('month grid - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await expectGolden(tester, 'month-grid');
    });

    testWidgets('month grid other year - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      // Go to a non-today year (2025) and back to the month grid so today's month is no longer underlined.
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(YearPicker), matching: find.text('2025')));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await expectGolden(tester, 'month-grid-other-year');
    });

    testWidgets('year grid - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await expectGolden(tester, 'year-grid');
    });

    testWidgets('day grid RTL - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data, textDirection: TextDirection.rtl));
      await expectGolden(tester, 'day-grid-rtl');
    });
  }

  group('blue screen', () {
    Widget blue() => TestScaffold.blue(
      child: FCalendar.splitGrid(
        selectionControl: .managedRange(initial: (.utc(2024, 7, 11), .utc(2024, 7, 19))),
        control: FGridSplitCalendarControl(
          start: .utc(2023, 2, 8),
          today: .utc(2024, 7, 14),
          initial: .utc(2024, 7, 14),
          end: .utc(2025, 8, 10),
        ),
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
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('July')));
      await tester.pumpAndSettle();
      await expectBlueScreen();
    });

    testWidgets('year grid', (tester) async {
      await tester.pumpWidget(blue());
      await tester.tap(find.descendant(of: find.byType(SplitHeader), matching: find.text('2024')));
      await tester.pumpAndSettle();
      await expectBlueScreen();
    });
  });
}

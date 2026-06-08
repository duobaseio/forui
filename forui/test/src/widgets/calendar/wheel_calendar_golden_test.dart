@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget _harness({
  required FThemeData theme,
  FDateSelectionControl? selectionControl,
  FWheelCalendarControl? control,
  TextDirection textDirection = .ltr,
}) => TestScaffold.app(
  theme: theme,
  textDirection: textDirection,
  child: FCalendar.wheel(
    selectionControl: selectionControl ?? .managedRange(initial: (.utc(2024, 7, 11), .utc(2024, 7, 19))),
    control:
        control ??
        FWheelCalendarControl(
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
        matchesGoldenFile('calendar/wheel-calendar/${theme.name}/$name.png'),
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
          control: FWheelCalendarControl(
            start: .utc(2024, 7),
            today: .utc(2024, 7, 14),
            initial: .utc(2024, 7, 14),
            end: .utc(2025, 8, 10),
          ),
        ),
      );
      await expectGolden(tester, 'day-grid-disabled-prev');
    });

    testWidgets('wheel - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.text('July 2024'));
      await expectGolden(tester, 'wheel');
    });

    testWidgets('wheel dragged - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data));
      await tester.tap(find.text('July 2024'));
      await tester.pumpAndSettle();
      // Drag the month wheel; the dragged month flows through onChange -> setMonthYear -> currentMonth -> header.
      await tester.drag(find.text('Jul'), const Offset(0, -120));
      await expectGolden(tester, 'wheel-dragged');
    });

    testWidgets('day grid RTL - ${theme.name}', (tester) async {
      await tester.pumpWidget(_harness(theme: theme.data, textDirection: TextDirection.rtl));
      await expectGolden(tester, 'day-grid-rtl');
    });
  }

  group('blue screen', () {
    final base = TestScaffold.blueScreen.calendarStyle;

    Widget blue() => TestScaffold.blue(
      child: FCalendar.wheel(
        selectionControl: .managedRange(initial: (.utc(2024, 7, 11), .utc(2024, 7, 19))),
        control: FWheelCalendarControl(
          start: .utc(2023, 2, 8),
          today: .utc(2024, 7, 14),
          initial: .utc(2024, 7, 14),
          end: .utc(2025, 8, 10),
        ),
        style: base.copyWith(wheelPickerStyle: base.wheelPickerStyle.copyWith(overAndUnderCenterOpacity: 1)),
      ),
    );

    testWidgets('day grid', (tester) async {
      await tester.pumpWidget(blue());
      await tester.pumpAndSettle();
      await expectBlueScreen();
    });

    testWidgets('wheel', (tester) async {
      await tester.pumpWidget(blue());
      await tester.tap(find.text('July 2024'));

      await tester.pumpAndSettle();
      await expectBlueScreen();
    });
  });
}

@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/calendar.dart';
import 'package:forui/src/widgets/calendar/month/month_picker.dart';
import '../../../test_scaffold.dart';

/// 2024 is displayed, showing January through December.
final _initial = DateTime.utc(2024, 6);

FCalendarMonthPickerController _controller({bool Function(DateTime)? selectable}) => autoDispose(
  FCalendarMonthPickerController(
    start: .utc(2020),
    end: .utc(2027, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: _initial,
  ),
);

Widget _harness(FCalendarMonthPickerController controller, {required FThemeData theme, DateTime? today}) =>
    TestScaffold.app(
      theme: theme,
      child: Builder(
        builder: (context) {
          final t = context.theme;
          return MonthPicker(
            controller: controller,
            style: .inherit(colors: t.colors, typography: t.typography, style: t.style),
            localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
            today: today ?? _initial,
            scrollPhysics: null,
            scrollCacheExtent: null,
            scrollBehavior: null,
            onPress: (_) {},
            builder: FCalendar.defaultMonthBuilder,
          );
        },
      ),
    );

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('month-picker/${theme.name}/$name.png'));
    }

    group('${theme.name} resting', () {
      testWidgets('plain', (tester) async {
        await tester.pumpWidget(_harness(_controller(), theme: theme.data, today: .utc(2024, 3)));
        await expectGolden(tester, 'plain');
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            _controller(selectable: (date) => date.month.isOdd),
            theme: theme.data,
            today: .utc(2024, 6),
          ),
        );
        await expectGolden(tester, 'disabled');
      });
    });

    group('${theme.name} focus', () {
      testWidgets('focus-plain', (tester) async {
        final controller = _controller();
        await tester.pumpWidget(_harness(controller, theme: theme.data));
        await tester.pumpAndSettle();

        await controller.focus(.utc(2024, 8));
        await expectGolden(tester, 'focus-plain');
      });
    });

    group('${theme.name} hover', () {
      testWidgets('hover-plain', (tester) async {
        await tester.pumpWidget(_harness(_controller(), theme: theme.data));
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await gesture.moveTo(tester.getCenter(find.text('Aug')));
        await expectGolden(tester, 'hover-plain');
      });
    });
  }
}

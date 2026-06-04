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

bool Function(DateTime) _selected(int month) => (date) => date == .utc(2024, month);

FCalendarMonthPickerController _controller({bool Function(DateTime)? selectable}) => autoDispose(
  FCalendarMonthPickerController(
    start: .utc(2020),
    end: .utc(2027, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: _initial,
  ),
);

Widget _harness(
  FCalendarMonthPickerController controller, {
  required FThemeData theme,
  DateTime? today,
  bool Function(DateTime)? selected,
}) => TestScaffold.app(
  theme: theme,
  child: Builder(
    builder: (context) {
      final t = context.theme;
      return MonthPicker(
        controller: controller,
        style: .inherit(colors: t.colors, typography: t.typography, style: t.style),
        localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
        today: today ?? _initial,
        selected: selected ?? (_) => false,
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

      testWidgets('selected', (tester) async {
        await tester.pumpWidget(
          _harness(_controller(), theme: theme.data, today: .utc(2024, 3), selected: _selected(6)),
        );
        await expectGolden(tester, 'selected');
      });

      testWidgets('selected-today', (tester) async {
        await tester.pumpWidget(
          _harness(_controller(), theme: theme.data, today: .utc(2024, 6), selected: _selected(6)),
        );
        await expectGolden(tester, 'selected-today');
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            _controller(selectable: (date) => date.month.isOdd),
            theme: theme.data,
            today: .utc(2024, 6),
            selected: _selected(6),
          ),
        );
        await expectGolden(tester, 'disabled');
      });
    });

    group('${theme.name} focus', () {
      for (final (name, month, selected) in <(String, int, bool Function(DateTime)?)>[
        ('focus-plain', 8, null),
        ('focus-selected', 6, _selected(6)),
      ]) {
        testWidgets(name, (tester) async {
          final controller = _controller();
          await tester.pumpWidget(_harness(controller, theme: theme.data, selected: selected));
          await tester.pumpAndSettle();

          await controller.focus(.utc(2024, month));
          await expectGolden(tester, name);
        });
      }
    });

    group('${theme.name} hover', () {
      for (final (name, label, selected) in <(String, String, bool Function(DateTime)?)>[
        ('hover-plain', 'Aug', null),
        ('hover-selected', 'Jun', _selected(6)),
      ]) {
        testWidgets(name, (tester) async {
          await tester.pumpWidget(_harness(_controller(), theme: theme.data, selected: selected));
          await tester.pumpAndSettle();

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await gesture.moveTo(tester.getCenter(find.text(label)));
          await expectGolden(tester, name);
        });
      }
    });
  }
}

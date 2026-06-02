@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/calendar.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import '../../../test_scaffold.dart';

/// June 2024 is displayed. June 1 is a Saturday, so the grid also shows trailing May and leading July days as adjacent.
final _initial = DateTime.utc(2024, 6, 15);

bool _weekday(DateTime date) => date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;

bool Function(DateTime) _range(int start, int end) =>
    (date) => !date.isBefore(.utc(2024, 6, start)) && !date.isAfter(.utc(2024, 6, end));

FCalendarDayPickerController _controller({bool Function(DateTime)? selectable}) => autoDispose(
  FCalendarDayPickerController(
    start: .utc(2024),
    end: .utc(2024, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: _initial,
  ),
);

Widget _harness(
  FCalendarDayPickerController controller, {
  required FThemeData theme,
  DateTime? today,
  bool Function(DateTime)? selected,
}) => TestScaffold.app(
  theme: theme,
  child: Builder(
    builder: (context) {
      final t = context.theme;
      return DayPicker(
        controller: controller,
        style: .inherit(colors: t.colors, typography: t.typography, style: t.style, touch: false),
        localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
        today: today ?? _initial,
        selected: selected ?? (_) => false,
        onPress: (_) {},
        onLongPress: (_) {},
        builder: FCalendar.defaultDayBuilder,
      );
    },
  ),
);

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('day-picker/${theme.name}/$name.png'));
    }

    group('${theme.name} resting', () {
      testWidgets('range', (tester) async {
        await tester.pumpWidget(
          _harness(
            _controller(),
            theme: theme.data,
            today: .utc(2024, 6, 5),
            selected: (date) => _range(10, 14)(date) || date == .utc(2024, 6, 21),
          ),
        );
        await expectGolden(tester, 'range');
      });

      testWidgets('today-as-start', (tester) async {
        await tester.pumpWidget(
          _harness(_controller(), theme: theme.data, today: .utc(2024, 6, 10), selected: _range(10, 14)),
        );
        await expectGolden(tester, 'today-as-start');
      });

      testWidgets('today-in-range', (tester) async {
        await tester.pumpWidget(
          _harness(_controller(), theme: theme.data, today: .utc(2024, 6, 12), selected: _range(10, 14)),
        );
        await expectGolden(tester, 'today-in-range');
      });

      testWidgets('single-today', (tester) async {
        await tester.pumpWidget(
          _harness(
            _controller(),
            theme: theme.data,
            today: .utc(2024, 6, 17),
            selected: (date) => date == .utc(2024, 6, 17),
          ),
        );
        await expectGolden(tester, 'single-today');
      });

      testWidgets('disabled-in-range', (tester) async {
        // Explicit disabled coverage: weekends (plain + adjacent disabled) and specific selected days (start/middle/end
        // + single disabled).
        const disabled = {10, 12, 14, 21};
        await tester.pumpWidget(
          _harness(
            _controller(selectable: (date) => _weekday(date) && !(date.month == 6 && disabled.contains(date.day))),
            theme: theme.data,
            today: .utc(2024, 6, 5),
            selected: (date) => _range(10, 14)(date) || date == .utc(2024, 6, 21),
          ),
        );
        await expectGolden(tester, 'disabled-in-range');
      });

      testWidgets('adjacent-today', (tester) async {
        // today is a trailing-May day shown as adjacent within the June grid.
        await tester.pumpWidget(_harness(_controller(), theme: theme.data, today: .utc(2024, 5, 31)));
        await expectGolden(tester, 'adjacent-today');
      });
    });

    group('${theme.name} focus', () {
      // Focusing an adjacent-month day pages to that month by design, so adjacent+focused is unreachable and omitted.
      for (final (name, day, selected) in <(String, int, bool Function(DateTime)?)>[
        ('focus-plain', 17, null),
        ('focus-single', 17, _range(17, 17)),
        ('focus-start', 10, _range(10, 14)),
        ('focus-middle', 12, _range(10, 14)),
      ]) {
        testWidgets(name, (tester) async {
          final controller = _controller();
          await tester.pumpWidget(_harness(controller, theme: theme.data, selected: selected));
          await tester.pumpAndSettle();

          await controller.focus(.utc(2024, 6, day));
          await expectGolden(tester, name);
        });
      }
    });

    group('${theme.name} hover', () {
      for (final (name, day, selected) in <(String, int, bool Function(DateTime)?)>[
        ('hover-plain', 17, null),
        ('hover-middle', 12, _range(10, 14)),
      ]) {
        testWidgets(name, (tester) async {
          await tester.pumpWidget(_harness(_controller(), theme: theme.data, selected: selected));
          await tester.pumpAndSettle();

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await gesture.moveTo(tester.getCenter(find.text('$day')));
          await expectGolden(tester, name);
        });
      }
    });
  }
}

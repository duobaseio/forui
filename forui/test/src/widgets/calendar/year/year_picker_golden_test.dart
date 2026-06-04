@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/calendar.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';
import '../../../test_scaffold.dart';

/// The 2020s decade is displayed, showing 2020 through 2029.
final _initial = DateTime.utc(2024);

bool Function(DateTime) _selected(int year) => (date) => date == .utc(year);

FCalendarYearPickerController _controller({bool Function(DateTime)? selectable}) => autoDispose(
  FCalendarYearPickerController(
    start: .utc(2000),
    end: .utc(2049, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: _initial,
  ),
);

Widget _harness(
  FCalendarYearPickerController controller, {
  required FThemeData theme,
  DateTime? today,
  bool Function(DateTime)? selected,
}) => TestScaffold.app(
  theme: theme,
  child: Builder(
    builder: (context) {
      final t = context.theme;
      return YearPicker(
        controller: controller,
        style: .inherit(colors: t.colors, typography: t.typography, style: t.style),
        localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
        today: today ?? _initial,
        selected: selected ?? (_) => false,
        onPress: (_) {},
        builder: FCalendar.defaultYearBuilder,
      );
    },
  ),
);

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('year-picker/${theme.name}/$name.png'));
    }

    group('${theme.name} resting', () {
      testWidgets('plain', (tester) async {
        await tester.pumpWidget(_harness(_controller(), theme: theme.data, today: .utc(2023)));
        await expectGolden(tester, 'plain');
      });

      testWidgets('selected', (tester) async {
        await tester.pumpWidget(
          _harness(_controller(), theme: theme.data, today: .utc(2023), selected: _selected(2024)),
        );
        await expectGolden(tester, 'selected');
      });

      testWidgets('selected-today', (tester) async {
        await tester.pumpWidget(
          _harness(_controller(), theme: theme.data, today: .utc(2024), selected: _selected(2024)),
        );
        await expectGolden(tester, 'selected-today');
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            _controller(selectable: (date) => date.year.isOdd),
            theme: theme.data,
            today: .utc(2024),
            selected: _selected(2024),
          ),
        );
        await expectGolden(tester, 'disabled');
      });
    });

    group('${theme.name} focus', () {
      for (final (name, year, selected) in <(String, int, bool Function(DateTime)?)>[
        ('focus-plain', 2028, null),
        ('focus-selected', 2024, _selected(2024)),
      ]) {
        testWidgets(name, (tester) async {
          final controller = _controller();
          await tester.pumpWidget(_harness(controller, theme: theme.data, selected: selected));
          await tester.pumpAndSettle();

          await controller.focus(.utc(year));
          await expectGolden(tester, name);
        });
      }
    });

    group('${theme.name} hover', () {
      for (final (name, label, selected) in <(String, String, bool Function(DateTime)?)>[
        ('hover-plain', '2028', null),
        ('hover-selected', '2024', _selected(2024)),
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

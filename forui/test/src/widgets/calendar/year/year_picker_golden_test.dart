@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/year/year_picker.dart';
import '../../../test_scaffold.dart';

/// The 2020s decade is displayed, showing 2020 through 2029.
final _initial = DateTime.utc(2024);

FCalendarYearPickerController _controller({bool Function(DateTime)? selectable}) => autoDispose(
  FCalendarYearPickerController(
    start: .utc(2000),
    end: .utc(2049, 12, 31),
    selectable: selectable ?? (_) => true,
    initial: _initial,
  ),
);

Widget _harness(FCalendarYearPickerController controller, {required FThemeData theme, DateTime? today}) =>
    TestScaffold.app(
      theme: theme,
      child: Builder(
        builder: (context) => YearPicker(
          controller: controller,
          style: context.theme.calendarStyle.yearPickerStyle,
          localization: FLocalizations.of(context) ?? FDefaultLocalizations(),
          today: today ?? _initial,
          scrollPhysics: null,
          scrollCacheExtent: null,
          scrollBehavior: null,
          onPress: (_) {},
          builder: FCalendar.defaultYearBuilder,
        ),
      ),
    );

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('calendar/year-picker/${theme.name}/$name.png'));
    }

    group('${theme.name} resting', () {
      testWidgets('plain', (tester) async {
        await tester.pumpWidget(_harness(_controller(), theme: theme.data, today: .utc(2023)));
        await expectGolden(tester, 'plain');
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            _controller(selectable: (date) => date.year.isOdd),
            theme: theme.data,
            today: .utc(2024),
          ),
        );
        await expectGolden(tester, 'disabled');
      });
    });

    group('${theme.name} focus', () {
      testWidgets('focus-plain', (tester) async {
        FocusManager.instance.highlightStrategy = .alwaysTraditional;
        addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

        final controller = _controller();
        await tester.pumpWidget(_harness(controller, theme: theme.data));
        await tester.pumpAndSettle();

        await controller.focus(.utc(2028));
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
        await gesture.moveTo(tester.getCenter(find.text('2028')));
        await expectGolden(tester, 'hover-plain');
      });
    });
  }
}

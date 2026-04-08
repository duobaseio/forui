import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/date_time/date_time_picker_controller.dart';
import 'package:forui/src/widgets/picker/picker_controller.dart';
import 'package:forui/src/widgets/picker/picker_wheel.dart';
import '../../../test_scaffold.dart';

void main() {
  setUpAll(initializeDateFormatting);

  group('lifted', () {
    testWidgets('basic', (tester) async {
      var value = DateTime(2026, 4, 8, 10, 30);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: StatefulBuilder(
            builder: (_, setState) => SizedBox(
              width: 400,
              height: 300,
              child: FDateTimePicker(
                control: .lifted(dateTime: value, onChange: (v) => setState(() => value = v)),
              ),
            ),
          ),
        ),
      );
      expect(value, DateTime(2026, 4, 8, 10, 30));

      // Drag the hour wheel (second BuilderWheel after the date wheel).
      await tester.drag(find.byType(BuilderWheel).at(1), const Offset(0, -50));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(value, isNot(DateTime(2026, 4, 8, 10, 30)));
    });
  });

  group('managed', () {
    testWidgets('onChange callback called', (tester) async {
      DateTime? changedValue;

      final controller = autoDispose(FDateTimePickerController(dateTime: DateTime(2026, 4, 8, 10, 30)));
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(
              control: .managed(controller: controller, onChange: (value) => changedValue = value),
            ),
          ),
        ),
      );

      controller.value = DateTime(2026, 4, 8, 14, 45);
      await tester.pump();

      expect(changedValue, DateTime(2026, 4, 8, 14, 45));
    });
  });

  group('state', () {
    testWidgets('swap external controller', (tester) async {
      final initial = autoDispose(FDateTimePickerController(dateTime: DateTime(2026, 4, 8, 10, 30)));
      final current = autoDispose(FDateTimePickerController(dateTime: DateTime(2026, 4, 8, 14, 45)));

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(control: .managed(controller: initial)),
          ),
        ),
      );
      expect(initial.value, DateTime(2026, 4, 8, 10, 30));
      expect(initial.picker?.value, [0, 10, 30, 0]);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(control: .managed(controller: current)),
          ),
        ),
      );

      expect(current.value, DateTime(2026, 4, 8, 10, 30));
      expect(current.picker?.value, [0, 10, 30, 0]);
    });

    testWidgets('change 12-hour format', (tester) async {
      final controller = autoDispose(FDateTimePickerController());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        ),
      );
      expect(controller.hours24, false);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
          ),
        ),
      );
      expect(controller.hours24, true);
    });

    testWidgets('change intervals', (tester) async {
      final controller = autoDispose(FDateTimePickerController(dateTime: DateTime(2026, 4, 8, 10, 31)));

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        ),
      );
      expect(controller.dayInterval, 1);
      expect(controller.hourInterval, 1);
      expect(controller.minuteInterval, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 400,
            height: 300,
            child: FDateTimePicker(
              control: .managed(controller: controller),
              dayInterval: 2,
              hourInterval: 2,
              minuteInterval: 15,
            ),
          ),
        ),
      );
      // TODO: Change unexpected values once https://github.com/flutter/flutter/issues/162972 is resolved.
      expect(controller.dayInterval, 2);
      expect(controller.hourInterval, 2);
      expect(controller.minuteInterval, 15);
    });
  });
}

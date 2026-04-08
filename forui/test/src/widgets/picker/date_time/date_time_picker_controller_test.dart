import 'dart:async';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker_controller.dart';
import 'package:forui/src/widgets/picker/date_time/date_time_picker_controller.dart';
import '../../../test_scaffold.dart';

void main() {
  late FDateTimePickerController controller;

  setUp(() {
    System.currentDateTime = () => DateTime(2026, 4, 8);
    controller = FDateTimePickerController(dateTime: DateTime(2026, 4, 8, 10, 30));
  });

  tearDown(() {
    controller.dispose();
    System.currentDateTime = DateTime.now;
  });

  for (final (grouping, function) in [
    ('animateTo(...)', (DateTime time) => unawaited(controller.animateTo(time))),
    ('set value', (DateTime time) => controller.value = time),
  ]) {
    group(grouping, () {
      testWidgets('does nothing', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        function(DateTime(2026, 4, 8, 10, 30));
        await tester.pumpAndSettle();

        expect(controller.value, DateTime(2026, 4, 8, 10, 30));
        expect(controller.mutating, false);
      });

      testWidgets('set to different date', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
          ),
        );

        function(DateTime(2026, 4, 10, 13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 10, 13, 30));
        expect(controller.picker?.value, [2, 13, 30]);
        expect(controller.mutating, false);
      });

      testWidgets('set to rounded day', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true, dayInterval: 2),
          ),
        );

        function(DateTime(2026, 4, 11, 13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 12, 13, 30));
        expect(controller.picker?.value, [2, 13, 30]);
        expect(controller.mutating, false);
      });

      testWidgets('set to rounded hour', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hourInterval: 2),
          ),
        );

        function(DateTime(2026, 4, 8, 13, 31));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 8, 14, 31));
        expect(controller.picker?.value, [0, 7, 31, 1]);
        expect(controller.mutating, false);
      });

      testWidgets('set to rounded minute', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), minuteInterval: 5),
          ),
        );

        function(DateTime(2026, 4, 8, 13, 31));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 8, 13, 30));
        expect(controller.picker?.value, [0, 13, 6, 1]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 12-hour time before noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        function(DateTime(2026, 4, 8, 5, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 8, 5, 30));
        expect(controller.picker?.value, [0, 5, 30, 0]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 12-hour time after noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        function(DateTime(2026, 4, 8, 13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 8, 13, 30));
        expect(controller.picker?.value, [0, 13, 30, 1]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 12-hour time after noon with period-first locale', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        function(DateTime(2026, 4, 8, 13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 8, 13, 30));
        expect(controller.picker?.value, [0, 1, 13, 30]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 24-hour time', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
          ),
        );

        function(DateTime(2026, 4, 8, 13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, DateTime(2026, 4, 8, 13, 30));
        expect(controller.picker?.value, [0, 13, 30]);
        expect(controller.mutating, false);
      });
    });
  }

  group('encode()', () {
    testWidgets('different date', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
        ),
      );

      expect(controller.encode(DateTime(2026, 4, 11, 10, 30)), [3, 10, 30]);
    });

    testWidgets('negative date index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
        ),
      );

      expect(controller.encode(DateTime(2026, 4, 5, 10, 30)), [-3, 10, 30]);
    });

    testWidgets('day interval', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateTimePicker(control: .managed(controller: controller), hour24: true, dayInterval: 2),
        ),
      );

      expect(controller.encode(DateTime(2026, 4, 12, 10, 30)), [2, 10, 30]);
    });

    group('period first', () {
      testWidgets('12-hour time after noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        expect(controller.encode(DateTime(2026, 4, 8, 13, 30)), [0, 1, 13, 30]);
      });

      testWidgets('12-hour time before noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        expect(controller.encode(DateTime(2026, 4, 8, 5, 30)), [0, 0, 5, 30]);
      });

      testWidgets('24-hour time', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
          ),
        );

        expect(controller.encode(DateTime(2026, 4, 8, 13, 30)), [0, 13, 30]);
      });
    });
  });

  group('decode()', () {
    group('period first', () {
      testWidgets('12-hour time after noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 1, 13, 30])
          ..decode();

        expect(controller.value.hour, 13);
        expect(controller.value.minute, 30);
      });

      testWidgets('12-hour time before noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 0, 5, 30])
          ..decode();

        expect(controller.value.hour, 5);
        expect(controller.value.minute, 30);
      });
    });

    group('period last', () {
      testWidgets('12-hour time after noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 13, 30, 1])
          ..decode();

        expect(controller.value.hour, 13);
        expect(controller.value.minute, 30);
      });

      testWidgets('12-hour time before noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller)),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 5, 30, 0])
          ..decode();

        expect(controller.value.hour, 5);
        expect(controller.value.minute, 30);
      });
    });

    group('24 hours', () {
      testWidgets('24-hour time', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 14, 30])
          ..decode();

        expect(controller.value.hour, 14);
        expect(controller.value.minute, 30);
      });

      testWidgets('different date index', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [3, 14, 30])
          ..decode();

        expect(controller.value, DateTime(2026, 4, 11, 14, 30));
      });

      testWidgets('rounded day', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true, dayInterval: 2),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [3, 14, 30])
          ..decode();

        expect(controller.value, DateTime(2026, 4, 14, 14, 30));
      });

      testWidgets('rounded hour', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true, hourInterval: 6),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 2, 30])
          ..decode();

        expect(controller.value.hour, 12);
        expect(controller.value.minute, 30);
      });

      testWidgets('rounded minute', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FDateTimePicker(control: .managed(controller: controller), hour24: true, minuteInterval: 5),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(indexes: [0, 14, 7])
          ..decode();

        expect(controller.value.hour, 14);
        expect(controller.value.minute, 35);
      });
    });
  });
}

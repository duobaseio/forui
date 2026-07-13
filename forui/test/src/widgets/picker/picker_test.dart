import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  Widget picker([FPickerController? controller, ValueChanged<List<int>>? onChange]) => TestScaffold(
    child: FPicker(
      control: .managed(controller: controller, onChange: onChange),
      children: [
        for (var i = 0; i < (controller?.value.length ?? 2); i++)
          FPickerWheel(children: [Text('${i}A'), Text('${i}B'), Text('${i}C')]),
      ],
    ),
  );

  testWidgets('different controller size', (tester) async {
    final initialController = autoDispose(FPickerController(indexes: [1, 1]));

    await tester.pumpWidget(picker(initialController));

    await tester.drag(find.text('0A'), const Offset(0, -100));
    await tester.pumpAndSettle();

    expect(initialController.value, [2, 1]);
    expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1]);

    final newController = autoDispose(FPickerController(indexes: [1, 2, 0]));

    await tester.pumpWidget(picker(newController));
    await tester.pumpAndSettle();

    expect(newController.value, [2, 1, 0]);
    expect(newController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 0]);

    await tester.drag(find.text('0A'), const Offset(0, 100));
    await tester.pumpAndSettle();

    expect(newController.wheels[0].selectedItem, isNot(2));
    expect(newController.value[0], newController.wheels[0].selectedItem);
  });

  testWidgets('placeholders does not cause errors', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPicker(
          children: [
            FPickerWheel.builder(builder: (context, index) => const Text('a')),
            const Text(':'),
            FPickerWheel.builder(builder: (context, index) => const Text('b')),
          ],
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  testWidgets('same controller size', (tester) async {
    final initialController = autoDispose(FPickerController(indexes: [1, 1, 1]));

    await tester.pumpWidget(picker(initialController));

    await tester.drag(find.text('0A'), const Offset(0, -100));
    await tester.pumpAndSettle();

    expect(initialController.value, [2, 1, 1]);
    expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 1]);

    final newController = autoDispose(FPickerController(indexes: [1, 2, 0]));

    await tester.pumpWidget(picker(newController));
    await tester.pumpAndSettle();

    expect(newController.value, [2, 1, 1]);
    expect(newController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 1]);

    await tester.drag(find.text('0A'), const Offset(0, 100));
    await tester.pumpAndSettle();

    expect(newController.wheels[0].selectedItem, isNot(2));
    expect(newController.value[0], newController.wheels[0].selectedItem);
  });

  testWidgets('null to explicit controller', (tester) async {
    await tester.pumpWidget(picker());
    await tester.drag(find.text('0A'), const Offset(0, -100));
    await tester.pumpAndSettle();

    final newController = autoDispose(FPickerController(indexes: [0, 1]));
    await tester.pumpWidget(picker(newController));
    await tester.pumpAndSettle();

    expect(newController.value, [2, 0]);
    expect(newController.wheels.map((w) => w.selectedItem), [2, 0]);
  });

  group('lifted', () {
    testWidgets('onChange receives correct indexes', (tester) async {
      var value = <int>[0, 0];

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (_, setState) => TestScaffold(
            child: FPicker(
              control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
              children: const [
                FPickerWheel(key: ValueKey('first'), children: [Text('0A'), Text('0B'), Text('0C')]),
                FPickerWheel(key: ValueKey('second'), children: [Text('1A'), Text('1B'), Text('1C')]),
              ],
            ),
          ),
        ),
      );
      expect(value, [0, 0]);

      await tester.drag(find.byKey(const ValueKey('first')), const Offset(0, -100));
      await tester.pumpAndSettle();
      expect(value, isNot([0, 0]));
      expect(value[0], isNot(0));

      final firstWheelValue = value[0];
      await tester.drag(find.byKey(const ValueKey('second')), const Offset(0, -100));
      await tester.pumpAndSettle();
      expect(value[0], firstWheelValue);
      expect(value[1], isNot(0));

      final secondWheelValue = value[1];
      await tester.drag(find.byKey(const ValueKey('first')), const Offset(0, 100));
      await tester.pumpAndSettle();
      expect(value[0], isNot(firstWheelValue));
      expect(value[1], secondWheelValue);
    });
  });

  testWidgets('adding wheels and indexes dynamically', (tester) async {
    var value = <int>[0];

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (_, setState) => TestScaffold(
          child: FPicker(
            control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
            children: const [
              FPickerWheel(children: [Text('0A'), Text('0B'), Text('0C')]),
            ],
          ),
        ),
      ),
    );

    expect(value, [0]);

    value = [value[0], 0];

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (_, setState) => TestScaffold(
          child: FPicker(
            key: const ValueKey('expanded'),
            control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
            children: const [
              FPickerWheel(children: [Text('0A'), Text('0B'), Text('0C')]),
              FPickerWheel(children: [Text('1A'), Text('1B'), Text('1C')]),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
    expect(find.text('0A'), findsOneWidget);
    expect(find.text('1A'), findsOneWidget);

    await tester.drag(find.text('1A'), const Offset(0, -50));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
    expect(value.length, 2);
  });

  group('accessibility', () {
    testWidgets('wheel with semanticsValueBuilder is adjustable', (tester) async {
      final semantics = tester.ensureSemantics();
      final controller = autoDispose(FPickerController(indexes: [1]));

      await tester.pumpWidget(
        TestScaffold(
          child: FPicker(
            control: .managed(controller: controller),
            children: [
              FPickerWheel(
                semanticsLabel: 'Letter',
                semanticsValueBuilder: (index) => const ['A', 'B', 'C'][index],
                children: const [Text('A'), Text('B'), Text('C')],
              ),
            ],
          ),
        ),
      );

      expect(find.semantics.byLabel('Letter'), findsOne);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Letter')),
        isSemantics(
          label: 'Letter',
          value: 'B',
          increasedValue: 'C',
          decreasedValue: 'A',
          isFocusable: true,
          hasIncreaseAction: true,
          hasDecreaseAction: true,
        ),
      );

      final node = tester.getSemantics(find.bySemanticsLabel('Letter'));
      node.owner!.performAction(node.id, SemanticsAction.decrease);
      await tester.pumpAndSettle();

      expect(controller.value, [0]);

      semantics.dispose();
    });

    testWidgets('wheel without semanticsValueBuilder keeps default item semantics', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: const FPicker(
            children: [
              FPickerWheel(children: [Text('A'), Text('B'), Text('C')]),
            ],
          ),
        ),
      );

      expect(tester.getSemantics(find.text('A')), isSemantics(isInMutuallyExclusiveGroup: true));
      expect(find.semantics.byAction(SemanticsAction.increase), findsNothing);

      semantics.dispose();
    });

    testWidgets('wheel with only semanticsLabel names the group and keeps items readable', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: const FPicker(
            children: [
              FPickerWheel(semanticsLabel: 'Letters', children: [Text('A'), Text('B'), Text('C')]),
            ],
          ),
        ),
      );

      expect(tester.getSemantics(find.bySemanticsLabel('Letters')), isSemantics(label: 'Letters'));
      expect(tester.getSemantics(find.text('A')), isSemantics(isInMutuallyExclusiveGroup: true));
      expect(find.semantics.byAction(SemanticsAction.increase), findsNothing);

      semantics.dispose();
    });
  });
}

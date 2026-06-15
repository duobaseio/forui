import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('forwards focus to label', (tester) async {
    final focus = autoDispose(FocusNode());
    bool focused() => tester
        .widget<FLabel>(find.ancestor(of: find.text('Label'), matching: find.byType(FLabel)))
        .variants
        .contains(FFormFieldVariant.focused);

    await tester.pumpWidget(TestScaffold.app(child: FSwitch(focusNode: focus, label: const Text('Label'))));
    expect(focused(), false);

    focus.requestFocus();

    await tester.pumpAndSettle();

    expect(focused(), true);
  });

  testWidgets('has single focus node', (tester) async {
    final before = autoDispose(FocusNode());
    final node = autoDispose(FocusNode());
    final after = autoDispose(FocusNode());

    await tester.pumpWidget(
      TestScaffold.app(
        child: Column(
          children: [
            Focus(focusNode: before, child: const SizedBox.square(dimension: 10)),
            FSwitch(focusNode: node, label: const Text('Label')),
            Focus(focusNode: after, child: const SizedBox.square(dimension: 10)),
          ],
        ),
      ),
    );

    before.requestFocus();
    await tester.pump();

    before.nextFocus();
    await tester.pump();
    expect(node.hasPrimaryFocus, true);

    node.nextFocus();
    await tester.pump();
    expect(after.hasPrimaryFocus, true);
  });
}

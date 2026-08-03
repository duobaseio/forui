import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('boxes are flush with the edges without label, description, and error', (tester) async {
    await tester.pumpWidget(TestScaffold.app(child: FOtpField()));

    final field = tester.getRect(find.byType(FOtpField));
    final boxes = tester.getRect(find.descendant(of: find.byType(FOtpField), matching: find.byType(IntrinsicWidth)));
    expect(boxes.top, field.top);
    expect(boxes.bottom, field.bottom);
    expect(boxes.left, field.left);
  });

  testWidgets('forwards focus to label', (tester) async {
    final focus = autoDispose(FocusNode());
    bool focused() => tester
        .widget<FLabel>(find.ancestor(of: find.text('Label'), matching: find.byType(FLabel)))
        .variants
        .contains(FFormFieldVariant.focused);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FOtpField(focusNode: focus, label: const Text('Label')),
      ),
    );
    expect(focused(), false);

    focus.requestFocus();

    await tester.pumpAndSettle();

    expect(focused(), true);
  });
}

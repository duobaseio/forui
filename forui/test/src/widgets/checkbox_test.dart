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

    await tester.pumpWidget(
      TestScaffold.app(
        child: FCheckbox(focusNode: focus, label: const Text('Label')),
      ),
    );
    expect(focused(), false);

    focus.requestFocus();

    await tester.pumpAndSettle();

    expect(focused(), true);
  });
}

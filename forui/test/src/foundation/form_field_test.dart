import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

void main() {
  const key = ValueKey('select');

  testWidgets('lifted control inside Form', (tester) async {
    final formKey = GlobalKey<FormState>();
    String? value;
    String? saved;

    await tester.pumpWidget(
      TestScaffold.app(
        child: StatefulBuilder(
          builder: (context, setState) => Form(
            key: formKey,
            child: FSelect<String>(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              items: letters,
              onSaved: (v) => saved = v,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('A'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
    expect(value, 'A');

    formKey.currentState!.save();
    expect(saved, 'A');

    await tester.pumpWidget(const SizedBox());
  });
}

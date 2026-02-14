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
    Set<String> value = {};

    await tester.pumpWidget(
      TestScaffold.app(
        child: StatefulBuilder(
          builder: (context, setState) => Form(
            child: FMultiSelect<String>(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              items: letters,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('A'));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(tester.takeException(), null);
    expect(value, {'A'});
  });
}

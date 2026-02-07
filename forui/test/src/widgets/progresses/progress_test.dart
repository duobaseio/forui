import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('ticker provider', (tester) async {
    await tester.pumpWidget(TestScaffold(theme: FThemes.neutral.light, child: const FProgress()));
    await tester.pump();

    await tester.pumpWidget(TestScaffold(theme: FThemes.neutral.dark, child: const FProgress()));
    await tester.pump();

    expect(tester.takeException(), null);
  });
}

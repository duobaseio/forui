import 'package:flutter_test/flutter_test.dart';

import 'package:create/main.dart';

void main() {
  testWidgets('renders the placeholder button', (tester) async {
    await tester.pumpWidget(const Application());

    expect(find.text('Placeholder'), findsOneWidget);
  });
}

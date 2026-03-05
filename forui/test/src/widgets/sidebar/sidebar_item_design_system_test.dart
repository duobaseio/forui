@TestOn('mac-os')
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = ValueKey('sidebar-item');

  for (final (theme, name, height) in [
    (FThemes.neutral.light.desktop, 'desktop', 30.0),
    (FThemes.neutral.light.touch, 'touch', 44.0),
  ]) {
    testWidgets('$name sidebar item has consistent height ($height)', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme,
          child: FSidebar(children: const [FSidebarItem(label: Text('Item'), key: key)]),
        ),
      );

      expect(tester.getSize(find.byKey(key)).height, closeTo(height, 0.001));
    });
  }
}

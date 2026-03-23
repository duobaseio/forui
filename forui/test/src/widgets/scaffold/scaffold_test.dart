import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FScaffold', () {
    testWidgets('apply IconTheme from FStyle', (tester) async {
      const testIconColor = Colors.red;
      const testIconSize = 30.0;
      final base = FThemeData(touch: true, colors: FColors.neutral.light);

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemeData(
            colors: base.colors,
            typography: base.typography,
            style: base.style.copyWith(
              iconStyle: const .value(IconThemeData(color: testIconColor, size: testIconSize)),
            ),
            touch: true,
          ),
          child: const FScaffold(child: Center(child: Icon(FIcons.star))),
        ),
      );

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      final iconTheme = IconTheme.of(tester.element(iconFinder));
      expect(iconTheme.color, testIconColor);
      expect(iconTheme.size, testIconSize);
    });
  });
}

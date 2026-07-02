import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FScaffold', () {
    testWidgets('apply IconTheme from FStyle', (tester) async {
      const testIconColor = Colors.red;
      const testIconSize = 30.0;

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemeData(
            colors: FTheme.neutral.light.touch.colors,
            typography: FTheme.neutral.light.touch.typography,
            style: FTheme.neutral.light.touch.style.copyWith(
              iconStyle: const .value(IconThemeData(color: testIconColor, size: testIconSize)),
            ),
            touch: true,
          ),
          child: const FScaffold(child: Center(child: Icon(FLucideIcons.star))),
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

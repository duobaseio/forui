import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:forui/forui.dart';

import '../test_scaffold.dart';

void main() {
  group('FFocusedOutline', () {
    testWidgets('hit test', (tester) async {
      var count = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FFocusedOutline(
            focused: true,
            child: GestureDetector(
              onTap: () => count++,
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Container).last);
      await tester.pumpAndSettle();

      expect(count, 1);
    });

    testWidgets('hit test spacing', (tester) async {
      var count = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FFocusedOutline(
            focused: true,
            child: GestureDetector(
              onTap: () => count++,
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.tapAt(tester.getCenter(find.byType(Container).last).translate(51, 0));
      await tester.pumpAndSettle();

      expect(count, 0);
    });

    for (final spacing in [-3.0, -50.0, -1000.0]) {
      testWidgets('paints without crashing for negative spacing $spacing', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FFocusedOutline(
              focused: true,
              style: FFocusedOutlineStyle(color: const Color(0xFF000000), borderRadius: .circular(4), spacing: spacing),
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        );

        expect(tester.takeException(), null);
      });
    }

    group('accessibility', () {
      bool outlined(WidgetTester tester) => tester
          .renderObject(find.byType(FFocusedOutline))
          .toDiagnosticsNode()
          .getProperties()
          .whereType<FlagProperty>()
          .singleWhere((property) => property.name == 'focused')
          .value!;

      for (final (strategy, expected) in [
        (FocusHighlightStrategy.alwaysTraditional, true),
        (FocusHighlightStrategy.alwaysTouch, false),
      ]) {
        testWidgets('focused outline follows focus highlight - $strategy', (tester) async {
          FocusManager.instance.highlightStrategy = strategy;
          addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

          await tester.pumpWidget(
            TestScaffold(child: const FFocusedOutline(focused: true, child: SizedBox(width: 100, height: 100))),
          );

          expect(outlined(tester), expected);
        });
      }

      testWidgets('unfocused outline ignores focus highlight', (tester) async {
        FocusManager.instance.highlightStrategy = .alwaysTraditional;
        addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

        await tester.pumpWidget(
          TestScaffold(child: const FFocusedOutline(focused: false, child: SizedBox(width: 100, height: 100))),
        );

        expect(outlined(tester), false);
      });

      testWidgets('outline updates when focus highlight changes', (tester) async {
        FocusManager.instance.highlightStrategy = .alwaysTouch;
        addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

        await tester.pumpWidget(
          TestScaffold(child: const FFocusedOutline(focused: true, child: SizedBox(width: 100, height: 100))),
        );
        expect(outlined(tester), false);

        FocusManager.instance.highlightStrategy = .alwaysTraditional;
        await tester.pump();
        expect(outlined(tester), true);

        FocusManager.instance.highlightStrategy = .alwaysTouch;
        await tester.pump();
        expect(outlined(tester), false);
      });
    });
  });
}

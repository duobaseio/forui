import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:create/selection.dart';
import 'package:create/sidebar/dialogs.dart';

import 'utils/shell.dart';

void main() {
  group('LoadPresetDialog', () {
    late Future<Selection?> result;

    Future<void> open(WidgetTester tester) async {
      await tester.pumpWidget(
        shell(
          child: Builder(
            builder: (context) => FButton(
              onPress: () => result = showFDialog<Selection>(
                context: context,
                builder: (context, _, animation) => LoadPresetDialog(animation: animation),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
    }

    testWidgets('loads a valid preset code', (tester) async {
      await open(tester);

      await tester.enterText(find.byKey(const ValueKey('load-preset-code')), 'cdefba');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Load'));
      await tester.pumpAndSettle();

      expect(find.byType(LoadPresetDialog), findsNothing);
      expect((await result)?.encode(), 'cdefba');
    });

    testWidgets('strips the --preset prefix and surrounding whitespace', (tester) async {
      await open(tester);

      await tester.enterText(find.byKey(const ValueKey('load-preset-code')), '  --preset cdefba  ');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Load'));
      await tester.pumpAndSettle();

      expect(find.byType(LoadPresetDialog), findsNothing);
      expect((await result)?.encode(), 'cdefba');
    });

    testWidgets('rejects an unrecognised code', (tester) async {
      await open(tester);

      await tester.enterText(find.byKey(const ValueKey('load-preset-code')), 'zzzzzz');
      await tester.pumpAndSettle();
      // The load button is disabled; both tapping it and submitting the field should keep the dialog open.
      await tester.tap(find.text('Load'));
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.byType(LoadPresetDialog), findsOneWidget);
    });
  });
}

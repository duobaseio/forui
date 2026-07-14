import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('forwards focus to label', (tester) async {
    FocusManager.instance.highlightStrategy = .alwaysTraditional;
    addTearDown(() => FocusManager.instance.highlightStrategy = .automatic);

    final focus = autoDispose(FocusNode());
    bool focused() => tester
        .widget<FLabel>(find.ancestor(of: find.text('Label'), matching: find.byType(FLabel)))
        .variants
        .contains(FFormFieldVariant.focused);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FSwitch(focusNode: focus, label: const Text('Label')),
      ),
    );
    expect(focused(), false);

    focus.requestFocus();

    await tester.pumpAndSettle();

    expect(focused(), true);
  });

  testWidgets('has single focus node', (tester) async {
    final before = autoDispose(FocusNode());
    final node = autoDispose(FocusNode());
    final after = autoDispose(FocusNode());

    await tester.pumpWidget(
      TestScaffold.app(
        child: Column(
          children: [
            Focus(focusNode: before, child: const SizedBox.square(dimension: 10)),
            FSwitch(focusNode: node, label: const Text('Label')),
            Focus(focusNode: after, child: const SizedBox.square(dimension: 10)),
          ],
        ),
      ),
    );

    before.requestFocus();
    await tester.pump();

    before.nextFocus();
    await tester.pump();
    expect(node.hasPrimaryFocus, true);

    node.nextFocus();
    await tester.pump();
    expect(after.hasPrimaryFocus, true);
  });

  group('accessibility', () {
    for (final value in [true, false]) {
      testWidgets('announces toggle role and state - $value', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSwitch(value: value, semanticsLabel: 'switch'),
          ),
        );

        expect(
          tester.getSemantics(find.bySemanticsLabel('switch')),
          isSemantics(
            label: 'switch',
            hasToggledState: true,
            isToggled: value,
            hasEnabledState: true,
            isEnabled: true,
            isFocusable: true,
          ),
        );
      });
    }

    testWidgets('merges label and description into a single toggle node', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const FSwitch(value: true, label: Text('Wi-Fi'), description: Text('Nearby networks.')),
        ),
      );

      // The label and description merge into the toggle node instead of forming detached sibling nodes.
      final node = find.bySemanticsLabel(RegExp('Wi-Fi'));
      expect(node, findsOne);
      expect(
        tester.getSemantics(node),
        isSemantics(label: 'Wi-Fi\nNearby networks.', hasToggledState: true, isToggled: true),
      );
    });

    testWidgets('disabled switch is not enabled or tappable', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(child: const FSwitch(enabled: false, value: true, semanticsLabel: 'switch')),
      );

      expect(
        tester.getSemantics(find.bySemanticsLabel('switch')),
        isSemantics(
          label: 'switch',
          hasEnabledState: true,
          isEnabled: false,
          hasTapAction: false,
          hasToggledState: true,
          isToggled: true,
          isFocusable: false,
        ),
      );
    });
  });
}

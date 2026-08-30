import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  testWidgets('vertical and expands', (tester) async {
    expect(
      () => TestScaffold(
        child: const FLabel(layout: .vertical, expands: true, child: Text('Child')),
      ),
      returnsNormally,
    );
  });

  testWidgets('horizontal and expands', (tester) async {
    expect(
      () => TestScaffold(
        child: FLabel(layout: .horizontalTrailing, expands: true, child: const Text('Child')),
      ),
      throwsAssertionError,
    );
  });

  testWidgets('renders child only when label, description, and error are null', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FLabel(layout: .horizontalTrailing, child: Text('Child')),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
  });

  testWidgets('horizontal layouts do not pad child when label, description, and error are null', (tester) async {
    for (final layout in [FLabelLayout.horizontalLeading, FLabelLayout.horizontalTrailing]) {
      await tester.pumpWidget(
        TestScaffold(
          child: Center(
            child: FLabel(layout: layout, child: const SizedBox(width: 20, height: 20)),
          ),
        ),
      );

      expect(tester.getSize(find.byType(FLabel)), const Size(20, 20));
    }
  });

  testWidgets('horizontal leading child is flush with the end edge', (tester) async {
    for (final width in [null, 320.0]) {
      await tester.pumpWidget(
        TestScaffold(
          child: Align(
            alignment: .topLeft,
            child: SizedBox(
              width: width,
              child: const FLabel(
                layout: .horizontalLeading,
                label: Text('Label'),
                description: Text('Description'),
                child: SizedBox(key: Key('child'), width: 20, height: 20),
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopRight(find.byKey(const Key('child'))).dx, tester.getTopRight(find.byType(FLabel)).dx);
    }
  });

  testWidgets('horizontal trailing child is flush with the start edge', (tester) async {
    for (final width in [null, 320.0]) {
      await tester.pumpWidget(
        TestScaffold(
          child: Align(
            alignment: .topLeft,
            child: SizedBox(
              width: width,
              child: const FLabel(
                layout: .horizontalTrailing,
                label: Text('Label'),
                description: Text('Description'),
                child: SizedBox(key: Key('child'), width: 20, height: 20),
              ),
            ),
          ),
        ),
      );

      expect(tester.getTopLeft(find.byKey(const Key('child'))).dx, tester.getTopLeft(find.byType(FLabel)).dx);
    }
  });

  testWidgets('renders error even when label and description are null', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FLabel(
          layout: .horizontalTrailing,
          variants: {.error},
          error: const Text('Error'),
          child: const Text('Child'),
        ),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('renders horizontal label with label, description, and error', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FLabel(
          layout: .horizontalTrailing,
          label: const Text('Label'),
          description: const Text('Description'),
          error: const Text('Error'),
          variants: {.error},
          child: const Text('Child'),
        ),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Label'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('renders vertical label with label, description, and error', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FLabel(
          layout: .vertical,
          label: const Text('Label'),
          description: const Text('Description'),
          error: const Text('Error'),
          variants: {.error},
          child: const Text('Child'),
        ),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Label'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('does not render error when state is not error', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FLabel(layout: .horizontalTrailing, error: Text('Error'), child: Text('Child')),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Error'), findsNothing);
  });

  testWidgets('updates error when error changes', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FLabel(layout: .vertical, variants: {.error}, error: const Text('Error A'), child: const Text('Child')),
      ),
    );

    expect(find.text('Error A'), findsOneWidget);
    expect(find.text('Error B'), findsNothing);

    await tester.pumpWidget(
      TestScaffold(
        child: FLabel(layout: .vertical, variants: {.error}, error: const Text('Error B'), child: const Text('Child')),
      ),
    );

    expect(find.text('Error A'), findsNothing);
    expect(find.text('Error B'), findsOneWidget);
  });

  testWidgets('error text style reflects the focused variant', (tester) async {
    const focused = Color(0xFF00FF00);
    Color? error() => tester
        .widget<AnimatedDefaultTextStyle>(
          find.ancestor(of: find.text('Error'), matching: find.byType(AnimatedDefaultTextStyle)).first,
        )
        .style
        .color;

    Widget build(Set<FFormFieldVariant> variants) => TestScaffold(
      child: FLabel(
        layout: .vertical,
        variants: variants,
        error: const Text('Error'),
        style: .delta(
          errorTextStyle: .delta([
            .exact({FFormFieldErrorVariant.focused}, const .delta(color: focused)),
          ]),
        ),
        child: const Text('Child'),
      ),
    );

    await tester.pumpWidget(build({.error}));
    await tester.pumpAndSettle();
    expect(error(), isNot(focused));

    await tester.pumpWidget(build({.error, .focused}));
    await tester.pumpAndSettle();
    expect(error(), focused);
  });

  group('accessibility', () {
    testWidgets('error marks the field as invalid', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: FLabel(layout: .vertical, variants: {.error}, error: const Text('Error'), child: const Text('Child')),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('Child')),
        isSemantics(label: 'Child', hint: 'Error', validationResult: SemanticsValidationResult.invalid),
      );

      semantics.dispose();
    });

    testWidgets('is not marked invalid without an error', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: const FLabel(layout: .vertical, description: Text('Description'), child: Text('Child')),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('Child')),
        isSemantics(label: 'Child', hint: 'Description', validationResult: SemanticsValidationResult.none),
      );

      semantics.dispose();
    });

    for (final layout in FLabelLayout.values) {
      testWidgets('merges label into child and description & error into hint - $layout', (tester) async {
        final semantics = tester.ensureSemantics();

        Widget build(Set<FFormFieldVariant> variants) => TestScaffold(
          child: FLabel(
            layout: layout,
            variants: variants,
            label: const Text('Label'),
            description: const Text('Description'),
            error: const Text('Error'),
            child: Semantics(textField: true, child: const SizedBox.square(dimension: 10)),
          ),
        );

        await tester.pumpWidget(build({.error}));
        await tester.pumpAndSettle();

        expect(find.bySemanticsLabel('Description'), findsNothing);
        expect(find.bySemanticsLabel('Error'), findsNothing);
        expect(
          tester.getSemantics(find.bySemanticsLabel('Label')),
          isSemantics(
            label: 'Label',
            hint: 'Description\nError',
            isTextField: true,
            validationResult: SemanticsValidationResult.invalid,
          ),
        );

        await tester.pumpWidget(build({}));
        await tester.pumpAndSettle();

        expect(
          tester.getSemantics(find.bySemanticsLabel('Label')),
          isSemantics(label: 'Label', hint: 'Description', isTextField: true),
        );

        semantics.dispose();
      });
    }

    testWidgets('merges a lone label into the child', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: FLabel(
            layout: .vertical,
            label: const Text('Label'),
            child: Semantics(textField: true, child: const SizedBox.square(dimension: 10)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.getSemantics(find.bySemanticsLabel('Label')), isSemantics(label: 'Label', isTextField: true));

      semantics.dispose();
    });

    testWidgets("announces the label before the child's own text", (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: FLabel(
            layout: .vertical,
            label: const Text('Label'),
            child: Semantics(textField: true, label: 'Child', child: const SizedBox.square(dimension: 10)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel(RegExp('Label'))),
        isSemantics(label: 'Label\nChild', isTextField: true),
      );

      semantics.dispose();
    });

    for (final supportsAnnounce in [true, false]) {
      testWidgets('exposes error as a live region only without announce support - $supportsAnnounce', (tester) async {
        final semantics = tester.ensureSemantics();
        tester.platformDispatcher.accessibilityFeaturesTestValue = FakeAccessibilityFeatures(
          supportsAnnounce: supportsAnnounce,
        );
        addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

        await tester.pumpWidget(
          TestScaffold.app(
            child: FLabel(
              layout: .vertical,
              variants: {.error},
              label: const Text('Label'),
              error: const Text('Error'),
              child: Semantics(textField: true, child: const SizedBox.square(dimension: 10)),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // The error is always merged into the field's hint.
        expect(
          tester.getSemantics(find.bySemanticsLabel('Label')),
          isSemantics(label: 'Label', hint: 'Error', isTextField: true),
        );
        // It is additionally kept as a live region node where announcements aren't supported.
        expect(find.bySemanticsLabel('Error'), supportsAnnounce ? findsNothing : findsOne);
        if (!supportsAnnounce) {
          expect(tester.getSemantics(find.bySemanticsLabel('Error')), isSemantics(label: 'Error', isLiveRegion: true));
        }

        semantics.dispose();
      });
    }

    testWidgets('keeps a child that forms its own semantics node separate', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold(
          child: FLabel(
            layout: .vertical,
            label: const Text('Label'),
            description: const Text('Description'),
            child: Semantics(
              container: true,
              button: true,
              label: 'Button',
              child: const SizedBox.square(dimension: 10),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.getSemantics(find.bySemanticsLabel('Label')), isSemantics(label: 'Label', hint: 'Description'));
      expect(tester.getSemantics(find.bySemanticsLabel('Button')), isSemantics(label: 'Button', isButton: true));
      expect(
        tester.getSemantics(find.bySemanticsLabel('Button')).parent,
        tester.getSemantics(find.bySemanticsLabel('Label')),
      );

      semantics.dispose();
    });
  });
}

import 'package:flutter/widgets.dart' hide Action;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('lifted', (tester) async {
      var page = 0;

      Future<void> rebuild() => tester.pumpWidget(
        TestScaffold(
          child: FPagination(
            control: .lifted(page: page, pages: 10, onChange: (value) => page = value),
          ),
        ),
      );

      await rebuild();
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(page, 4);

      await rebuild();
      await tester.tap(find.text('10'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(page, 9);

      await rebuild();
      await tester.tap(find.text('7'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(page, 6);
    });

    testWidgets('pages, siblings, showEdges update on rebuild', (tester) async {
      var page = 0;
      var pages = 1;
      var siblings = 1;
      var showEdges = true;

      Future<void> rebuild() => tester.pumpWidget(
        TestScaffold(
          child: FPagination(
            control: .lifted(
              page: page,
              pages: pages,
              siblings: siblings,
              showEdges: showEdges,
              onChange: (value) => page = value,
            ),
          ),
        ),
      );

      await rebuild();
      expect(find.text('10'), findsNothing);

      pages = 10;
      await rebuild();
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);

      page = 4;
      siblings = 2;
      await rebuild();
      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);

      showEdges = false;
      page = 5;
      await rebuild();
      await tester.pumpAndSettle();
      expect(find.text('1'), findsNothing);
      expect(find.text('10'), findsNothing);
    });
  });

  group('managed', () {
    testWidgets('onChange called', (tester) async {
      var value = -1;

      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(pages: 10, onChange: (v) => value = v)),
        ),
      );

      await tester.tap(find.text('3'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, 2);

      await tester.tap(find.text('10'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, 9);
    });
  });

  group('Actions', () {
    testWidgets('previous', (tester) async {
      final controller = autoDispose(FPaginationController(pages: 10));

      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(controller: controller)),
        ),
      );
      expect(controller.value, 0);

      await tester.tap(find.byType(Action).first);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 0);

      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 1);

      await tester.tap(find.text('10'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 9);

      await tester.tap(find.byType(Action).first);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 8);
    });

    testWidgets('next', (tester) async {
      final controller = autoDispose(FPaginationController(pages: 10, page: 9));

      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(controller: controller)),
        ),
      );
      expect(controller.value, 9);

      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 9);

      await tester.tap(find.byType(Action).first);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 8);
    });
  });

  testWidgets('select page', (tester) async {
    final controller = autoDispose(FPaginationController(pages: 10, page: 2));

    await tester.pumpWidget(
      TestScaffold(
        child: FPagination(control: .managed(controller: controller)),
      ),
    );
    expect(controller.value, 2);

    await tester.tap(find.text('5'));
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
    expect(controller.value, 4);
  });

  for (final (name, page, highlights) in [('disabled', 0, false), ('enabled', 5, true)]) {
    testWidgets('$name previous action highlights on hover: $highlights', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(initial: page, pages: 10)),
        ),
      );

      Color? color() =>
          (tester
                      .widget<DecoratedBox>(
                        find.descendant(of: find.byType(Action).first, matching: find.byType(DecoratedBox)).first,
                      )
                      .decoration
                  as ShapeDecoration)
              .color;

      final resting = color();

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(Action).first));
      await tester.pumpAndSettle();

      expect(color() != resting, highlights);
    });
  }

  testWidgets('notifyListener', (tester) async {
    var notifyCount = 0;
    final controller = autoDispose(
      FPaginationController(pages: 10)..addListener(() {
        notifyCount++;
      }),
    );

    await tester.pumpWidget(
      TestScaffold(
        child: FPagination(control: .managed(controller: controller)),
      ),
    );

    controller.value = 6;
    await tester.pumpAndSettle();
    controller.previous();
    await tester.pumpAndSettle();
    controller.next();
    await tester.pumpAndSettle();

    expect(notifyCount, 3);
  });

  group('accessibility', () {
    for (final (label, edge, inside) in [('Previous', 0, 1), ('Next', 9, 8)]) {
      testWidgets('$label is disabled at its edge', (tester) async {
        final handle = tester.ensureSemantics();
        final controller = autoDispose(FPaginationController(pages: 10, page: edge));

        await tester.pumpWidget(
          TestScaffold.app(
            child: FPagination(control: .managed(controller: controller)),
          ),
        );

        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(label: label, isButton: true, hasEnabledState: true, isEnabled: false, hasTapAction: false),
        );

        controller.value = inside;
        await tester.pumpAndSettle();

        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(label: label, isButton: true, hasEnabledState: true, isEnabled: true, hasTapAction: true),
        );

        handle.dispose();
      });
    }

    testWidgets('both actions are disabled when there is a single page', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(TestScaffold.app(child: const FPagination(control: .managed(pages: 1))));

      for (final label in ['Previous', 'Next']) {
        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(label: label, isButton: true, hasEnabledState: true, isEnabled: false, hasTapAction: false),
        );
      }

      handle.dispose();
    });

    testWidgets('ellipsis is excluded from semantics', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(TestScaffold.app(child: const FPagination(control: .managed(initial: 5, pages: 20))));

      expect(find.text('...'), findsNWidgets(2), reason: 'the ellipsis should still be painted');
      expect(find.bySemanticsLabel('...'), findsNothing);

      handle.dispose();
    });

    testWidgets('custom previous and next are left untouched at the edges', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPagination(
            control: const .managed(pages: 1),
            previous: FButton(onPress: () {}, child: const Text('Custom previous')),
            next: FButton(onPress: () {}, child: const Text('Custom next')),
          ),
        ),
      );

      for (final label in ['Custom previous', 'Custom next']) {
        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(label: label, hasEnabledState: true, isEnabled: true, hasTapAction: true),
        );
      }

      handle.dispose();
    });

    testWidgets('pages are labelled with their page number', (tester) async {
      final handle = tester.ensureSemantics();
      final controller = autoDispose(FPaginationController(pages: 10, page: 4));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPagination(control: .managed(controller: controller)),
        ),
      );

      expect(
        tester.getSemantics(find.bySemanticsLabel('Page 5')),
        isSemantics(label: 'Page 5', isButton: true, isSelected: true, hasSelectedState: true, hasTapAction: true),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Page 6')),
        isSemantics(label: 'Page 6', isButton: true, isSelected: false, hasSelectedState: true, hasTapAction: true),
      );
      expect(find.bySemanticsLabel('5'), findsNothing, reason: 'the bare number should not be announced separately');

      handle.dispose();
    });
  });
}

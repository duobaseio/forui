import 'package:flutter/material.dart' hide VerticalDivider;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/divider.dart';
import 'package:forui/src/widgets/resizable/resizable_region.dart';
import '../../test_scaffold.dart';

void main() {
  final top = FResizableRegion.fixed(
    extent: 30,
    minExtent: 20,
    builder: (context, snapshot, child) => const Align(child: Text('A')),
  );

  final bottom = FResizableRegion.fixed(
    extent: 70,
    minExtent: 20,
    builder: (context, snapshot, child) => const Align(child: Text('B')),
  );

  for (final (index, constructor) in [
    () => FResizable(crossAxisExtent: 0, axis: .vertical, children: [top, bottom]),
  ].indexed) {
    test('[$index] constructor throws error', () => expect(constructor, throwsAssertionError));
  }

  testWidgets('vertical drag downwards', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        platform: .macOS,
        child: Center(
          child: FResizable(crossAxisExtent: 50, axis: .vertical, children: [top, bottom]),
        ),
      ),
    );

    await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(50, 80));
    expect(tester.getSize(find.byType(FixedResizableRegion).last), const Size(50, 20));
  });

  testWidgets('vertical drag upwards', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        platform: .macOS,
        child: Center(
          child: FResizable(crossAxisExtent: 50, axis: .vertical, children: [top, bottom]),
        ),
      ),
    );

    await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, -100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(50, 20));
    expect(tester.getSize(find.byType(FixedResizableRegion).last), const Size(50, 80));
  });

  testWidgets('horizontal drag right', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        platform: .macOS,
        child: Center(
          child: FResizable(crossAxisExtent: 50, axis: .horizontal, children: [top, bottom]),
        ),
      ),
    );

    await tester.timedDrag(find.byType(HorizontalDivider), const Offset(100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(80, 50));
    expect(tester.getSize(find.byType(FixedResizableRegion).last), const Size(20, 50));
  });

  testWidgets('horizontal drag left', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        platform: .macOS,
        child: Center(
          child: FResizable(crossAxisExtent: 50, axis: .horizontal, children: [top, bottom]),
        ),
      ),
    );

    await tester.timedDrag(find.byType(HorizontalDivider), const Offset(-100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(20, 50));
    expect(tester.getSize(find.byType(FixedResizableRegion).last), const Size(80, 50));
  });

  testWidgets('rtl horizontal drag right shrinks first region', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        platform: .macOS,
        textDirection: .rtl,
        child: Center(
          child: FResizable(crossAxisExtent: 50, axis: .horizontal, children: [top, bottom]),
        ),
      ),
    );

    await tester.timedDrag(find.byType(HorizontalDivider), const Offset(100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(20, 50));
    expect(tester.getSize(find.byType(FixedResizableRegion).last), const Size(80, 50));
  });

  testWidgets('rtl horizontal drag left expands first region', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        platform: .macOS,
        textDirection: .rtl,
        child: Center(
          child: FResizable(crossAxisExtent: 50, axis: .horizontal, children: [top, bottom]),
        ),
      ),
    );

    await tester.timedDrag(find.byType(HorizontalDivider), const Offset(-100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(80, 50));
    expect(tester.getSize(find.byType(FixedResizableRegion).last), const Size(20, 50));
  });

  group('flex', () {
    Widget stub(BuildContext context, FResizableRegionData data, Widget? child) => const Align(child: Text('R'));

    testWidgets('equal flex regions split evenly', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 100,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .flex(builder: stub),
                  .flex(builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(FlexResizableRegion).first), const Size(50, 50));
      expect(tester.getSize(find.byType(FlexResizableRegion).last), const Size(50, 50));
    });

    testWidgets('weighted flex regions split proportionally', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 150,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .flex(builder: stub),
                  .flex(flex: 2, builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(FlexResizableRegion).first), const Size(50, 50));
      expect(tester.getSize(find.byType(FlexResizableRegion).last), const Size(50, 100));
    });

    testWidgets('mixed fixed + flex', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 100,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .fixed(extent: 40, builder: stub),
                  .flex(builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(50, 40));
      expect(tester.getSize(find.byType(FlexResizableRegion).first), const Size(50, 60));
    });

    testWidgets('mixed fixed + multiple flex', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 160,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .fixed(extent: 40, builder: stub),
                  .flex(builder: stub),
                  .flex(flex: 2, builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(50, 40));
      expect(tester.getSize(find.byType(FlexResizableRegion).first), const Size(50, 40));
      expect(tester.getSize(find.byType(FlexResizableRegion).last), const Size(50, 80));
    });

    testWidgets('drag between flex regions', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 100,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .flex(builder: stub),
                  .flex(builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(tester.getSize(find.byType(FlexResizableRegion).first), const Size(50, 90));
      expect(tester.getSize(find.byType(FlexResizableRegion).last), const Size(50, 10));
    });

    testWidgets('drag between fixed and flex regions', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 100,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .fixed(extent: 40, minExtent: 20, builder: stub),
                  .flex(builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, -100), const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(tester.getSize(find.byType(FixedResizableRegion).first), const Size(50, 20));
      expect(tester.getSize(find.byType(FlexResizableRegion).first), const Size(50, 80));
    });

    testWidgets('minFlex constrains shrinking', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          platform: .macOS,
          child: Center(
            child: SizedBox(
              height: 100,
              child: FResizable(
                crossAxisExtent: 50,
                axis: .vertical,
                children: [
                  .flex(minFlex: 1, builder: stub),
                  .flex(builder: stub),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, -100), const Duration(seconds: 1));
      await tester.pumpAndSettle();

      final firstHeight = tester.getSize(find.byType(FlexResizableRegion).first).height;
      expect(firstHeight, greaterThanOrEqualTo(50));
    });
  });
}

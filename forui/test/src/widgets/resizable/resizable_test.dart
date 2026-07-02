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

  group('resize', () {
    Widget stub(BuildContext context, FResizableRegionData data, Widget? child) => const Align(child: Text('R'));

    Finder divider(Axis axis) => find.byType(axis == Axis.vertical ? VerticalDivider : HorizontalDivider);
    Offset drag(Axis axis, double delta) => axis == Axis.vertical ? Offset(0, delta) : Offset(delta, 0);
    double main(Size size, Axis axis) => axis == Axis.vertical ? size.height : size.width;

    Widget build(
      Axis axis,
      double extent,
      List<FResizableRegion> children, {
      TextDirection textDirection = TextDirection.ltr,
    }) => TestScaffold.app(
      platform: .macOS,
      textDirection: textDirection,
      child: Center(
        child: SizedBox(
          width: axis == Axis.vertical ? 50 : extent,
          height: axis == Axis.vertical ? extent : 50,
          child: FResizable(crossAxisExtent: 50, axis: axis, children: children),
        ),
      ),
    );

    for (final axis in [Axis.vertical, Axis.horizontal]) {
      testWidgets('$axis flex scales proportionally without a prior drag', (tester) async {
        await tester.pumpWidget(build(axis, 100, [.flex(builder: stub), .flex(builder: stub)]));
        expect(main(tester.getSize(find.byType(FlexResizableRegion).first), axis), 50);
        expect(main(tester.getSize(find.byType(FlexResizableRegion).last), axis), 50);

        await tester.pumpWidget(build(axis, 200, [.flex(builder: stub), .flex(builder: stub)]));
        expect(main(tester.getSize(find.byType(FlexResizableRegion).first), axis), 100);
        expect(main(tester.getSize(find.byType(FlexResizableRegion).last), axis), 100);

        await tester.pumpWidget(build(axis, 60, [.flex(builder: stub), .flex(builder: stub)]));
        expect(main(tester.getSize(find.byType(FlexResizableRegion).first), axis), 30);
        expect(main(tester.getSize(find.byType(FlexResizableRegion).last), axis), 30);
      });

      testWidgets('$axis flex preserves the drag proportions across a resize', (tester) async {
        await tester.pumpWidget(build(axis, 100, [.flex(builder: stub), .flex(builder: stub)]));
        await tester.timedDrag(divider(axis), drag(axis, 100), const Duration(seconds: 1));
        await tester.pumpAndSettle();
        expect(main(tester.getSize(find.byType(FlexResizableRegion).first), axis), 90);
        expect(main(tester.getSize(find.byType(FlexResizableRegion).last), axis), 10);

        await tester.pumpWidget(build(axis, 200, [.flex(builder: stub), .flex(builder: stub)]));
        expect(main(tester.getSize(find.byType(FlexResizableRegion).first), axis), 180);
        expect(main(tester.getSize(find.byType(FlexResizableRegion).last), axis), 20);
      });
    }

    testWidgets('rtl horizontal flex preserves the drag proportions across a resize', (tester) async {
      List<FResizableRegion> children() => [.flex(builder: stub), .flex(builder: stub)];
      await tester.pumpWidget(build(Axis.horizontal, 100, children(), textDirection: .rtl));
      await tester.timedDrag(find.byType(HorizontalDivider), const Offset(100, 0), const Duration(seconds: 1));
      await tester.pumpAndSettle();
      final first = tester.getSize(find.byType(FlexResizableRegion).first).width;
      final last = tester.getSize(find.byType(FlexResizableRegion).last).width;

      await tester.pumpWidget(build(Axis.horizontal, 200, children(), textDirection: .rtl));
      expect(tester.getSize(find.byType(FlexResizableRegion).first).width, first * 2);
      expect(tester.getSize(find.byType(FlexResizableRegion).last).width, last * 2);
    });

    testWidgets('mixed fixed + flex keeps the fixed pixel size and lets flex absorb the resize', (tester) async {
      List<FResizableRegion> children() => [.fixed(extent: 40, minExtent: 20, builder: stub), .flex(builder: stub)];
      await tester.pumpWidget(build(Axis.vertical, 100, children()));
      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, -100), const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 20);
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 80);

      await tester.pumpWidget(build(Axis.vertical, 150, children()));
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 20);
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 130);
    });

    testWidgets('mixed fixed + flex fresh build keeps the fixed region at its declared extent', (tester) async {
      List<FResizableRegion> children() => [.fixed(extent: 40, minExtent: 20, builder: stub), .flex(builder: stub)];
      await tester.pumpWidget(build(Axis.vertical, 100, children()));
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 40);
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 60);

      await tester.pumpWidget(build(Axis.vertical, 150, children()));
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 40);
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 110);
    });

    testWidgets('all-fixed preserves the drag when the constraint changes', (tester) async {
      List<FResizableRegion> children() => [
        .fixed(extent: 30, minExtent: 20, builder: stub),
        .fixed(extent: 70, minExtent: 20, builder: stub),
      ];
      await tester.pumpWidget(build(Axis.vertical, 100, children()));
      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 80);
      expect(tester.getSize(find.byType(FixedResizableRegion).last).height, 20);

      await tester.pumpWidget(build(Axis.vertical, 150, children()));
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 80);
      expect(tester.getSize(find.byType(FixedResizableRegion).last).height, 20);
    });

    testWidgets('shrinking past the flex minimum pins flex and shrinks fixed, preserving the total', (tester) async {
      List<FResizableRegion> children() => [.fixed(extent: 40, minExtent: 20, builder: stub), .flex(builder: stub)];
      await tester.pumpWidget(build(Axis.vertical, 100, children()));
      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(FixedResizableRegion).first).height, 90);
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 10);

      await tester.pumpWidget(build(Axis.vertical, 70, children()));
      final fixed = tester.getSize(find.byType(FixedResizableRegion).first).height;
      final flex = tester.getSize(find.byType(FlexResizableRegion).first).height;
      expect(flex, 10);
      expect(fixed, 60);
      expect(fixed + flex, 70);
    });

    testWidgets('a same-size parent rebuild preserves the drag', (tester) async {
      await tester.pumpWidget(build(Axis.vertical, 100, [.flex(builder: stub), .flex(builder: stub)]));
      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 90);

      await tester.pumpWidget(
        build(Axis.vertical, 100, [
          .flex(builder: (_, _, _) => const Align(child: Text('X'))),
          .flex(builder: (_, _, _) => const Align(child: Text('Y'))),
        ]),
      );
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 90);
      expect(tester.getSize(find.byType(FlexResizableRegion).last).height, 10);
    });

    testWidgets('a structural change rebuilds from the new configuration', (tester) async {
      await tester.pumpWidget(build(Axis.vertical, 100, [.flex(builder: stub), .flex(builder: stub)]));
      await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, 90);

      await tester.pumpWidget(build(Axis.vertical, 100, [.flex(builder: stub), .flex(flex: 2, builder: stub)]));
      expect(tester.getSize(find.byType(FlexResizableRegion).first).height, closeTo(100 / 3, 0.01));
      expect(tester.getSize(find.byType(FlexResizableRegion).last).height, closeTo(200 / 3, 0.01));

      await tester.pumpWidget(
        build(Axis.vertical, 90, [.flex(builder: stub), .flex(builder: stub), .flex(builder: stub)]),
      );
      expect(find.byType(FlexResizableRegion), findsNWidgets(3));
      expect(tester.getSize(find.byType(FlexResizableRegion).at(1)).height, 30);
    });
  });
}

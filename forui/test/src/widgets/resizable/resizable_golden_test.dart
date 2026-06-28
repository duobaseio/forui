@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FResizable', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FResizable(
            style: TestScaffold.blueScreen.resizableStyles.resolve({FResizableAxisVariant.vertical}),
            axis: .vertical,
            crossAxisExtent: 100,
            children: [
              .fixed(
                extent: 150,
                builder: (_, _, child) => child!,
                child: const Align(child: Text('')),
              ),
              .fixed(
                extent: 300,
                builder: (_, _, child) => child!,
                child: const Align(child: Text('')),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });

    for (final theme in TestScaffold.themes) {
      for (final divider in FResizableDivider.values) {
        testWidgets('${theme.name} - horizontal - $divider - rtl', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              textDirection: .rtl,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: .all(color: theme.data.colors.border),
                  borderRadius: .circular(8),
                ),
                child: FResizable(
                  axis: .horizontal,
                  divider: divider,
                  crossAxisExtent: 100,
                  children: [
                    .fixed(
                      extent: 150,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('A')),
                    ),
                    .fixed(
                      extent: 300,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('B')),
                    ),
                  ],
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(FResizable),
            matchesGoldenFile('resizable/${theme.name}/horizontal-$divider-rtl.png'),
          );
        });
      }
    }

    for (final theme in TestScaffold.themes) {
      for (final axis in Axis.values) {
        for (final divider in FResizableDivider.values) {
          testWidgets('${theme.name} - $axis - $divider', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: .all(color: theme.data.colors.border),
                    borderRadius: .circular(8),
                  ),
                  child: FResizable(
                    axis: axis,
                    divider: divider,
                    crossAxisExtent: 100,
                    children: [
                      .fixed(
                        extent: 150,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('A')),
                      ),
                      .fixed(
                        extent: 300,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('B')),
                      ),
                    ],
                  ),
                ),
              ),
            );

            await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/${theme.name}/$axis-$divider.png'));
          });

          testWidgets('${theme.name} - $axis - $divider - focused', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: .all(color: theme.data.colors.border),
                    borderRadius: .circular(8),
                  ),
                  child: FResizable(
                    axis: axis,
                    divider: divider,
                    crossAxisExtent: 100,
                    children: [
                      .fixed(
                        extent: 150,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('A')),
                      ),
                      .fixed(
                        extent: 300,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('B')),
                      ),
                    ],
                  ),
                ),
              ),
            );

            await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/${theme.name}/$axis-$divider.png'));
          });
        }
      }
    }

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} - flex-only - horizontal', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: .all(color: theme.data.colors.border),
                borderRadius: .circular(8),
              ),
              child: SizedBox(
                width: 450,
                child: FResizable(
                  axis: .horizontal,
                  crossAxisExtent: 100,
                  children: [
                    .flex(
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('A')),
                    ),
                    .flex(
                      flex: 2,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('B')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/${theme.name}/flex-horizontal.png'));
      });

      testWidgets('${theme.name} - mixed - vertical', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: .all(color: theme.data.colors.border),
                borderRadius: .circular(8),
              ),
              child: SizedBox(
                height: 450,
                child: FResizable(
                  axis: .vertical,
                  crossAxisExtent: 100,
                  children: [
                    .fixed(
                      extent: 150,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('Fixed')),
                    ),
                    .flex(
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('Flex')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/${theme.name}/mixed-vertical.png'));
      });
    }

    for (final axis in Axis.values) {
      testWidgets('expanded - $axis', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FScaffold(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: .all(color: FTheme.neutral.light.touch.colors.border),
                  borderRadius: .circular(8),
                ),
                child: FResizable(
                  axis: axis,
                  children: [
                    .fixed(
                      extent: 150,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('A')),
                    ),
                    .fixed(
                      extent: 300,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('B')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/expanded-$axis.png'));
      });
    }
  });
}

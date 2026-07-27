import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget _collapsed({String? semanticsLabel, String? menuSemanticsLabel}) => FBreadcrumbItem.collapsed(
  semanticsLabel: semanticsLabel,
  menuSemanticsLabel: menuSemanticsLabel,
  menu: [
    FItemGroup(
      children: [FItem(onPress: () {}, title: const Text('Item'))],
    ),
  ],
);

Widget _collapsedTiles({String? semanticsLabel, String? menuSemanticsLabel}) => FBreadcrumbItem.collapsedTiles(
  semanticsLabel: semanticsLabel,
  menuSemanticsLabel: menuSemanticsLabel,
  menu: [
    FTileGroup(
      children: [FTile(onPress: () {}, title: const Text('Item'))],
    ),
  ],
);

void main() {
  group('lifted', () {
    testWidgets('FBreadcrumbItem.collapsed', (tester) async {
      var shown = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FBreadcrumb(
              children: [
                FBreadcrumbItem.collapsed(
                  popoverControl: .lifted(shown: shown, onChange: (v) => setState(() => shown = v)),
                  menu: [
                    .group(
                      children: [.item(onPress: () {}, title: const Text('Item'))],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(shown, true);
    });

    testWidgets('FBreadcrumbItem.collapsedTiles', (tester) async {
      var shown = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FBreadcrumb(
              children: [
                FBreadcrumbItem.collapsedTiles(
                  popoverControl: .lifted(shown: shown, onChange: (v) => setState(() => shown = v)),
                  menu: [
                    FTileGroup(
                      children: [.tile(onPress: () {}, title: const Text('Item'))],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(shown, true);
    });
  });

  group('managed', () {
    testWidgets('FBreadcrumbItem.collapsed onChange callback', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsed(
                popoverControl: .managed(onChange: (value) => changedValue = value),
                menu: [
                  FItemGroup(
                    children: [FItem(onPress: () {}, title: const Text('Item'))],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(changedValue, true);
    });

    testWidgets('FBreadcrumbItem.collapsedTiles onChange callback', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsedTiles(
                popoverControl: .managed(onChange: (value) => changedValue = value),
                menu: [
                  FTileGroup(
                    children: [FTile(onPress: () {}, title: const Text('Item'))],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(FLucideIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(changedValue, true);
    });
  });

  group('accessibility', () {
    for (final (name, collapsed) in [
      ('FBreadcrumbItem.collapsed', _collapsed),
      ('FBreadcrumbItem.collapsedTiles', _collapsedTiles),
    ]) {
      testWidgets('$name trigger has a default label', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(TestScaffold.app(child: FBreadcrumb(children: [collapsed()])));

        expect(tester.getSemantics(find.byIcon(FLucideIcons.ellipsis)), isSemantics(label: 'More', isButton: true));

        handle.dispose();
      });

      testWidgets('$name trigger label is overridable', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestScaffold.app(
            child: FBreadcrumb(children: [collapsed(semanticsLabel: 'Show hidden pages')]),
          ),
        );

        expect(
          tester.getSemantics(find.byIcon(FLucideIcons.ellipsis)),
          isSemantics(label: 'Show hidden pages', isButton: true),
        );

        handle.dispose();
      });

      testWidgets('$name menu is labelled separately from its trigger', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestScaffold.app(
            child: FBreadcrumb(
              children: [collapsed(semanticsLabel: 'Show hidden pages', menuSemanticsLabel: 'Hidden pages')],
            ),
          ),
        );

        await tester.tap(find.byIcon(FLucideIcons.ellipsis));
        await tester.pumpAndSettle();

        expect(
          tester.getSemantics(find.byIcon(FLucideIcons.ellipsis)),
          isSemantics(label: 'Show hidden pages', isButton: true, isExpanded: true),
        );
        expect(find.bySemanticsLabel('Hidden pages'), findsOne);

        handle.dispose();
      });
    }
  });
}

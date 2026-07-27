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

  group('callbacks', () {
    testWidgets('FBreadcrumbItem onVariantChange & onHoverChange called', (tester) async {
      Set<FTappableVariant>? previous;
      Set<FTappableVariant>? current;
      bool? hovered;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem(
                onHoverChange: (value) => hovered = value,
                onVariantChange: (p, c) {
                  previous = p;
                  current = c;
                },
                onPress: () {},
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('Home')));
      await tester.pumpAndSettle();

      expect(hovered, true);
      expect(previous, isNot(contains(FTappableVariant.hovered)));
      expect(current, contains(FTappableVariant.hovered));
    });

    testWidgets('FBreadcrumbItem without onPress does not respond to hover', (tester) async {
      Color? color() => tester
          .widget<DefaultTextStyle>(
            find.ancestor(of: find.text('Widgets'), matching: find.byType(DefaultTextStyle)).first,
          )
          .style
          .color;

      bool? hovered;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem(current: true, onHoverChange: (value) => hovered = value, child: const Text('Widgets')),
            ],
          ),
        ),
      );

      final resting = color();

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('Widgets')));
      await tester.pumpAndSettle();

      expect(hovered, null);
      expect(color(), resting);
    });
  });

  group('accessibility', () {
    testWidgets('FBreadcrumbItem without onPress is not announced as a disabled button', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: const FBreadcrumb(children: [FBreadcrumbItem(current: true, child: Text('Widgets'))]),
        ),
      );

      expect(
        tester.getSemantics(find.text('Widgets')),
        isSemantics(label: 'Widgets', isButton: false, hasEnabledState: false, isSelected: true),
      );

      handle.dispose();
    });

    testWidgets('FBreadcrumbItem with onPress is announced as an enabled button', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [FBreadcrumbItem(onPress: () {}, child: const Text('Forui'))],
          ),
        ),
      );

      expect(
        tester.getSemantics(find.text('Forui')),
        isSemantics(label: 'Forui', isButton: true, hasEnabledState: true, isEnabled: true),
      );

      handle.dispose();
    });

    testWidgets('FBreadcrumbItem focuses via an external focus node', (tester) async {
      final focus = FocusNode();
      addTearDown(focus.dispose);
      bool? focused;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem(
                focusNode: focus,
                onFocusChange: (value) => focused = value,
                onPress: () {},
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      );

      expect(focus.hasFocus, false);

      focus.requestFocus();
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
      expect(focused, true);
    });

    testWidgets('FBreadcrumbItem autofocuses', (tester) async {
      final focus = FocusNode();
      addTearDown(focus.dispose);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [FBreadcrumbItem(autofocus: true, focusNode: focus, onPress: () {}, child: const Text('Home'))],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

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

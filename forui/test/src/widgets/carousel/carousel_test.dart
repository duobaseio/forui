import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('changes slide on dot tap', (tester) async {
      var index = 0;

      Future<void> rebuild() => tester.pumpWidget(
        TestScaffold(
          child: FCarousel(
            control: .lifted(length: 3, index: index, onChange: (value) => index = value),
            autoPlay: null,
            children: const [
              ColoredBox(color: Color(0xFFFF0000)),
              ColoredBox(color: Color(0xFF00FF00)),
              ColoredBox(color: Color(0xFF0000FF)),
            ],
          ),
        ),
      );

      await rebuild();
      expect(index, 0);

      await tester.tap(find.byType(AnimatedContainer).at(1));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(index, 1);

      await tester.pumpWidget(const SizedBox.shrink());
    });
  });

  group('managed', () {
    testWidgets('updates length when children change', (tester) async {
      var length = 2;

      Future<void> rebuild() => tester.pumpWidget(
        TestScaffold(
          child: FCarousel(
            control: .managed(length: length),
            autoPlay: null,
            children: List.generate(length, (i) => ColoredBox(color: Color(0xFF000000 | (i + 1) * 0x111111))),
          ),
        ),
      );

      await rebuild();
      expect(find.byType(AnimatedContainer), findsNWidgets(2));

      length = 3;
      await rebuild();
      await tester.pumpAndSettle();
      expect(find.byType(AnimatedContainer), findsNWidgets(3));

      await tester.pumpWidget(const SizedBox.shrink());
    });
  });

  testWidgets('hides indicator for a single slide', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FCarousel(
          autoPlay: null,
          children: const [ColoredBox(color: Color(0xFFFF0000))],
        ),
      ),
    );

    expect(find.byType(AnimatedContainer), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

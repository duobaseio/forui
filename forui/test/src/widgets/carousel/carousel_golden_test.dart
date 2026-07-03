@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/carousel/carousel.dart';
import '../../test_scaffold.dart';

void main() {
  final children = List.generate(
    3,
    (index) => ColoredBox(color: Color(0xFF000000 | (index + 1) * 0x333333)),
  );

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FCarousel(
          style: TestScaffold.blueScreen.carouselStyle,
          autoPlay: null,
          children: children,
        ),
      ),
    );

    await expectBlueScreen();
    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('default - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FCarousel(autoPlay: null, children: children),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('carousel/${theme.name}/default.png'));
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('no indicator - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FCarousel(autoPlay: null, showIndicator: false, children: children),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('carousel/${theme.name}/no-indicator.png'));
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}

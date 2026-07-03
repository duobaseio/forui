import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FCarouselController', () {
    test('next wraps around', () {
      final controller = FCarouselController(length: 3, index: 2);
      addTearDown(controller.dispose);

      controller.next();
      expect(controller.value, 0);
    });

    test('previous wraps around', () {
      final controller = FCarouselController(length: 3);
      addTearDown(controller.dispose);

      controller.previous();
      expect(controller.value, 2);
    });

    test('length clamps value', () {
      final controller = FCarouselController(length: 4, index: 3);
      addTearDown(controller.dispose);

      controller.length = 2;
      expect(controller.value, 1);
    });
  });
}

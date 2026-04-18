import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/pagination/pagination_controller.dart';

void main() {
  test('next', () {
    final controller = FPaginationController(pages: 10, page: 8)..next();
    expect(controller.value, 9);

    controller.next();
    expect(controller.value, 9);
  });

  test('previous', () {
    final controller = FPaginationController(pages: 10, page: 1)..previous();
    expect(controller.value, 0);

    controller.previous();
    expect(controller.value, 0);
  });

  test('value', () {
    final controller = FPaginationController(pages: 10, page: 8)..value = 5;
    expect(controller.value, 5);
  });

  group('calculateSiblingRange(...)', () {
    for (final (currentPage, expected) in [
      (0, (0, 4)),
      (1, (0, 4)),
      (2, (0, 4)),
      (3, (0, 4)),
      (4, (3, 5)),
      (5, (4, 6)),
      (6, (5, 9)),
      (7, (5, 9)),
      (8, (5, 9)),
      (9, (5, 9)),
    ]) {
      test('siblings = 1', () {
        final controller = FPaginationController(pages: 10)..value = currentPage;
        expect(controller.siblingRange, expected);
      });
    }

    for (final (currentPage, expected) in [
      (0, (0, 2)),
      (1, (0, 2)),
      (2, (0, 2)),
      (3, (3, 3)),
      (4, (4, 4)),
      (5, (5, 5)),
      (6, (6, 6)),
      (7, (7, 9)),
      (8, (7, 9)),
      (9, (7, 9)),
    ]) {
      test('siblings = 0', () {
        final controller = FPaginationController(siblings: 0, pages: 10)..value = currentPage;
        expect(controller.siblingRange, expected);
      });
    }
  });

  for (final (length, siblingLength, expected) in [
    (6, 1, 6),
    (7, 1, 7),
    (8, 1, 3),
    (9, 2, 9),
    (10, 2, 10),
    (11, 2, 4),
    (12, 3, 12),
    (13, 3, 13),
    (14, 3, 5),
  ]) {
    test('minPagesDisplayedAtEdges', () {
      final controller = FPaginationController(pages: length, siblings: siblingLength);
      expect(controller.minPagesDisplayedAtEdges, expected);
    });
  }

  for (final (length, siblingLength, expected) in [
    (6, 1, 6),
    (7, 1, 2),
    (9, 2, 9),
    (10, 2, 3),
    (12, 3, 12),
    (13, 3, 4),
  ]) {
    test('minPagesDisplayedAtEnds with showEdges set to false', () {
      final controller = FPaginationController(pages: length, siblings: siblingLength, showEdges: false);
      expect(controller.minPagesDisplayedAtEdges, expected);
    });
  }

  group('pages setter', () {
    test('grows and notifies', () {
      var notifyCount = 0;
      final controller = FPaginationController(pages: 5, page: 2)
        ..addListener(() => notifyCount++)
        ..pages = 10;

      expect(controller.pages, 10);
      expect(controller.value, 2);
      expect(notifyCount, 1);
    });

    test('shrinks and clamps value', () {
      var notifyCount = 0;
      final controller = FPaginationController(pages: 10, page: 8)
        ..addListener(() => notifyCount++)
        ..pages = 5;

      expect(controller.pages, 5);
      expect(controller.value, 4);
      expect(notifyCount, 1);
    });

    test('no-op when unchanged', () {
      var notifyCount = 0;
      FPaginationController(pages: 5)
        ..addListener(() => notifyCount++)
        ..pages = 5;

      expect(notifyCount, 0);
    });

    test('asserts pages > 0', () {
      final controller = FPaginationController(pages: 5);
      expect(() => controller.pages = 0, throwsA(isA<AssertionError>()));
    });
  });

  group('siblings setter', () {
    test('changes and notifies', () {
      var notifyCount = 0;
      final controller = FPaginationController(pages: 10)
        ..addListener(() => notifyCount++)
        ..siblings = 2;

      expect(controller.siblings, 2);
      expect(notifyCount, 1);
    });

    test('no-op when unchanged', () {
      var notifyCount = 0;
      FPaginationController(pages: 10)
        ..addListener(() => notifyCount++)
        ..siblings = 1;

      expect(notifyCount, 0);
    });

    test('asserts siblings >= 0', () {
      final controller = FPaginationController(pages: 10);
      expect(() => controller.siblings = -1, throwsA(isA<AssertionError>()));
    });
  });

  group('showEdges setter', () {
    test('changes and notifies', () {
      var notifyCount = 0;
      final controller = FPaginationController(pages: 10)
        ..addListener(() => notifyCount++)
        ..showEdges = false;

      expect(controller.showEdges, false);
      expect(notifyCount, 1);
    });

    test('no-op when unchanged', () {
      var notifyCount = 0;
      FPaginationController(pages: 10)
        ..addListener(() => notifyCount++)
        ..showEdges = true;

      expect(notifyCount, 0);
    });
  });
}

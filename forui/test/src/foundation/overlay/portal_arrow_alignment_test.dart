import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

/// Every axis and direction, and whether the edge's start and end are swapped.
const combos = [
  (Axis.horizontal, TextDirection.ltr, false),
  (Axis.horizontal, TextDirection.rtl, true),
  (Axis.vertical, TextDirection.ltr, false),
  (Axis.vertical, TextDirection.rtl, false),
];

void main() {
  group('FPortalArrowAlignment', () {
    // A 200 long edge whose corners exclude the first and last 24.
    double? resolve(
      FPortalArrowAlignment alignment, {
      Axis axis = .horizontal,
      TextDirection direction = .ltr,
      double length = 200,
      double min = 24,
      double max = 176,
      double childStart = 80,
      double childEnd = 120,
    }) => alignment(
      axis: axis,
      direction: direction,
      length: length,
      min: min,
      max: max,
      childStart: childStart,
      childEnd: childEnd,
    );

    group('childCenter', () {
      const alignment = FPortalArrowAlignment.childCenter;

      for (final (axis, direction, _) in combos) {
        test('${axis.name} ${direction.name} ignores axis and direction', () {
          expect(resolve(alignment, axis: axis, direction: direction), 100);
          expect(resolve(alignment, axis: axis, direction: direction, childStart: 0, childEnd: 60), 30);
        });
      }

      test('centered on child', () => expect(resolve(alignment), 100));

      test('centered on child exactly at min', () => expect(resolve(alignment, childStart: 8, childEnd: 40), 24));

      test('centered on child exactly at max', () => expect(resolve(alignment, childStart: 160, childEnd: 192), 176));

      test('clamped to min', () => expect(resolve(alignment, childStart: 0, childEnd: 60), 30));

      test('clamped to max', () => expect(resolve(alignment, childStart: 140, childEnd: 200), 170));

      test('clamped to child edge', () {
        expect(resolve(alignment, childStart: 0, childEnd: 24), 24);
        expect(resolve(alignment, childStart: 176, childEnd: 200), 176);
      });

      test('hidden when clamped off child', () {
        expect(resolve(alignment, childStart: 0, childEnd: 20), null);
        expect(resolve(alignment, childStart: 180, childEnd: 200), null);
      });

      test('zero-width child', () {
        expect(resolve(alignment, childStart: 100, childEnd: 100), 100);
        expect(resolve(alignment, childStart: 24, childEnd: 24), 24);
        expect(resolve(alignment, childStart: 10, childEnd: 10), null);
      });

      test('child larger than edge', () => expect(resolve(alignment, childStart: -50, childEnd: 250), 100));

      test('child partially off edge', () {
        expect(resolve(alignment, childStart: -100, childEnd: 100), 24);
        expect(resolve(alignment, childStart: 100, childEnd: 300), 176);
        expect(resolve(alignment, childStart: -100, childEnd: 20), null);
      });

      test('min equals max', () {
        expect(resolve(alignment, min: 100, max: 100), 100);
        expect(resolve(alignment, min: 100, max: 100, childStart: 120, childEnd: 160), null);
      });

      test('hidden when no room', () => expect(resolve(alignment, min: 110, max: 90), null));
    });

    group('start', () {
      // (offset, expected, expected when flipped)
      const cases = [
        (30.0, 30.0, 170.0),
        (24.0, 24.0, 176.0),
        (176.0, 176.0, 24.0),
        (0.0, 24.0, 176.0),
        (-10.0, 24.0, 176.0),
        (300.0, 176.0, 24.0),
      ];

      for (final (axis, direction, flipped) in combos) {
        for (final (offset, unflipped, mirrored) in cases) {
          test('${axis.name} ${direction.name} start($offset)', () {
            expect(
              resolve(FPortalArrowAlignment.start(offset), axis: axis, direction: direction),
              flipped ? mirrored : unflipped,
            );
          });
        }
      }

      test('scales with length', () {
        expect(resolve(const FPortalArrowAlignment.start(30), length: 100, max: 76), 30);
        expect(resolve(const FPortalArrowAlignment.start(30), length: 100, max: 76, direction: .rtl), 70);
      });

      test('ignores child', () {
        expect(resolve(const FPortalArrowAlignment.start(30), childStart: 150, childEnd: 200), 30);
        expect(resolve(const FPortalArrowAlignment.start(30), childStart: 0, childEnd: 10), 30);
      });

      test('min equals max', () => expect(resolve(const FPortalArrowAlignment.start(30), min: 100, max: 100), 100));

      test('hidden when no room', () {
        expect(resolve(const FPortalArrowAlignment.start(30), min: 110, max: 90), null);
        expect(resolve(const FPortalArrowAlignment.start(100), min: 110, max: 90), null);
      });
    });

    group('end', () {
      // (offset, expected, expected when flipped)
      const cases = [
        (30.0, 170.0, 30.0),
        (24.0, 176.0, 24.0),
        (176.0, 24.0, 176.0),
        (0.0, 176.0, 24.0),
        (-10.0, 176.0, 24.0),
        (300.0, 24.0, 176.0),
      ];

      for (final (axis, direction, flipped) in combos) {
        for (final (offset, unflipped, mirrored) in cases) {
          test('${axis.name} ${direction.name} end($offset)', () {
            expect(
              resolve(FPortalArrowAlignment.end(offset), axis: axis, direction: direction),
              flipped ? mirrored : unflipped,
            );
          });
        }
      }

      test('scales with length', () {
        expect(resolve(const FPortalArrowAlignment.end(30), length: 100, max: 76), 70);
        expect(resolve(const FPortalArrowAlignment.end(30), length: 100, max: 76, direction: .rtl), 30);
      });

      test('ignores child', () {
        expect(resolve(const FPortalArrowAlignment.end(30), childStart: 0, childEnd: 50), 170);
        expect(resolve(const FPortalArrowAlignment.end(30), childStart: 190, childEnd: 200), 170);
      });

      test('min equals max', () => expect(resolve(const FPortalArrowAlignment.end(30), min: 100, max: 100), 100));

      test('hidden when no room', () {
        expect(resolve(const FPortalArrowAlignment.end(30), min: 110, max: 90), null);
        expect(resolve(const FPortalArrowAlignment.end(100), min: 110, max: 90), null);
      });
    });

    group('fraction', () {
      // (fraction, expected, expected when flipped)
      const cases = [
        (0.0, 24.0, 176.0),
        (0.125, 25.0, 175.0),
        (0.25, 50.0, 150.0),
        (0.5, 100.0, 100.0),
        (0.875, 175.0, 25.0),
        (1.0, 176.0, 24.0),
        (-0.5, 24.0, 176.0),
        (1.5, 176.0, 24.0),
      ];

      for (final (axis, direction, flipped) in combos) {
        for (final (fraction, unflipped, mirrored) in cases) {
          test('${axis.name} ${direction.name} fraction($fraction)', () {
            expect(
              resolve(FPortalArrowAlignment.fraction(fraction), axis: axis, direction: direction),
              flipped ? mirrored : unflipped,
            );
          });
        }
      }

      test('scales with length', () {
        expect(resolve(const FPortalArrowAlignment.fraction(0.25), length: 100, max: 76), 25);
        expect(resolve(const FPortalArrowAlignment.fraction(0.25), length: 100, max: 76, direction: .rtl), 75);
      });

      test('ignores child', () {
        expect(resolve(const FPortalArrowAlignment.fraction(0.25), childStart: 150, childEnd: 200), 50);
        expect(resolve(const FPortalArrowAlignment.fraction(0.25), childStart: 0, childEnd: 10), 50);
      });

      test(
        'min equals max',
        () => expect(resolve(const FPortalArrowAlignment.fraction(0.25), min: 100, max: 100), 100),
      );

      test('hidden when no room', () {
        expect(resolve(const FPortalArrowAlignment.fraction(0.25), min: 110, max: 90), null);
        expect(resolve(const FPortalArrowAlignment.fraction(0.5), min: 110, max: 90), null);
      });
    });

    group('equality', () {
      // Non-const so that instances aren't canonicalized.
      final thirty = double.parse('30');
      final forty = double.parse('40');

      test('start', () {
        expect(FPortalArrowAlignment.start(thirty), FPortalArrowAlignment.start(thirty));
        expect(FPortalArrowAlignment.start(thirty).hashCode, FPortalArrowAlignment.start(thirty).hashCode);
        expect(FPortalArrowAlignment.start(thirty), isNot(FPortalArrowAlignment.start(forty)));
        expect(FPortalArrowAlignment.start(thirty), isNot(FPortalArrowAlignment.end(thirty)));
        expect(FPortalArrowAlignment.start(thirty), isNot(FPortalArrowAlignment.fraction(thirty)));
      });

      test('end', () {
        expect(FPortalArrowAlignment.end(thirty), FPortalArrowAlignment.end(thirty));
        expect(FPortalArrowAlignment.end(thirty).hashCode, FPortalArrowAlignment.end(thirty).hashCode);
        expect(FPortalArrowAlignment.end(thirty), isNot(FPortalArrowAlignment.end(forty)));
        expect(FPortalArrowAlignment.end(thirty), isNot(FPortalArrowAlignment.start(thirty)));
        expect(FPortalArrowAlignment.end(thirty), isNot(FPortalArrowAlignment.fraction(thirty)));
      });

      test('fraction', () {
        expect(FPortalArrowAlignment.fraction(thirty), FPortalArrowAlignment.fraction(thirty));
        expect(FPortalArrowAlignment.fraction(thirty).hashCode, FPortalArrowAlignment.fraction(thirty).hashCode);
        expect(FPortalArrowAlignment.fraction(thirty), isNot(FPortalArrowAlignment.fraction(forty)));
        expect(FPortalArrowAlignment.fraction(thirty), isNot(FPortalArrowAlignment.start(thirty)));
        expect(FPortalArrowAlignment.fraction(thirty), isNot(FPortalArrowAlignment.end(thirty)));
      });

      test('childCenter', () {
        expect(FPortalArrowAlignment.childCenter, FPortalArrowAlignment.childCenter);
        expect(FPortalArrowAlignment.childCenter, isNot(FPortalArrowAlignment.start(thirty)));
      });
    });

    group('debugFillProperties', () {
      DoubleProperty property(FPortalArrowAlignment alignment) =>
          (alignment as Diagnosticable).toDiagnosticsNode().getProperties().whereType<DoubleProperty>().single;

      test('start', () {
        final offset = property(const FPortalArrowAlignment.start(30));
        expect(offset.name, 'offset');
        expect(offset.value, 30);
      });

      test('end', () {
        final offset = property(const FPortalArrowAlignment.end(30));
        expect(offset.name, 'offset');
        expect(offset.value, 30);
      });

      test('fraction', () {
        final fraction = property(const FPortalArrowAlignment.fraction(0.25));
        expect(fraction.name, 'fraction');
        expect(fraction.value, 0.25);
      });

      test('childCenter', () => expect(FPortalArrowAlignment.childCenter.toString, returnsNormally));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  const marks = [
    FSliderMark(value: 0),
    FSliderMark(value: 0.25),
    FSliderMark(value: 0.5),
    FSliderMark(value: 0.6),
    FSliderMark(value: 0.75),
    FSliderMark(value: 1),
  ];

  for (final constructor in [
    (selection, [FSliderInteraction interaction = .tapAndSlideThumb, FSliderActiveThumb thumb = .max]) =>
        FContinuousSliderController(value: selection, interaction: interaction, thumb: thumb),
    (selection, [FSliderInteraction interaction = .tapAndSlideThumb, FSliderActiveThumb thumb = .max]) =>
        FDiscreteSliderController(value: selection, interaction: interaction, thumb: thumb),
  ]) {
    group('FSlider', () {
      final value = FSliderValue(max: 0.75);
      final range = FSliderValue(min: 0.25, max: 0.75);

      late FSliderController controller;

      setUp(() {
        controller = constructor(value);
      });

      group('attach', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..attach(1000, marks);

          expect(calls, 0);
          expect(controller.value.constraints, (min: 0, max: 1));
          expect(controller.value.pixelConstraints, (min: 0.0, max: 1000.0, extent: 1000.0));
          expect((controller.value.min, controller.value.max), (0, 0.75));
          expect(controller.value.pixels, (min: 0, max: 750));
        });

        test('existing selection', () {
          controller
            ..attach(1000, marks)
            ..step(min: false, expand: true);

          final selection = controller.value;
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..attach(100, marks);

          expect(calls, 1);
          expect(controller.value.constraints, (min: 0, max: 1));
          expect(controller.value.pixelConstraints, (min: 0.0, max: 100.0, extent: 100.0));
          expect((controller.value.min, controller.value.max), (selection.min, selection.max));
          expect(controller.value.pixels, (min: 0, max: selection.max * 100));
        });
      });

      group('step', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..step(min: false, expand: true);

          expect(calls, 0);
          expect(controller.value, value);
        });
      });

      group('slide', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 0);
          expect(controller.value, value);
        });

        test('move', () {
          var calls = 0;
          controller
            ..attach(100, marks)
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 1);
          expect((controller.value.min, controller.value.max), (0, 0.5));
          expect(controller.value.pixels, (min: 0, max: 50));
        });

        test('tap only', () {
          var calls = 0;
          controller = constructor(range, .tap)
            ..attach(100, marks)
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 0);
          expect((controller.value.min, controller.value.max), (range.min, range.max));
        });
      });

      group('tap', () {
        for (final interaction in [FSliderInteraction.slide, FSliderInteraction.slideThumb]) {
          test('slide only - $interaction', () {
            var calls = 0;
            controller = constructor(value, interaction)
              ..attach(100, marks)
              ..addListener(() => calls++);

            expect(controller.tap(50).thumb, null);
            expect(calls, 0);
            expect((controller.value.min, controller.value.max), (value.min, value.max));
          });
        }

        for (final (offset, expected, activeThumb, thumb) in [
          (0.0, (min: 0.0, max: 0.75), FSliderActiveThumb.min, FSliderActiveThumb.min),
          (50.0, (min: 0.5, max: 0.75), FSliderActiveThumb.min, FSliderActiveThumb.min),
          (100.0, (min: 0.25, max: 1.0), FSliderActiveThumb.max, FSliderActiveThumb.max),
          (50.0, (min: 0.25, max: 0.5), FSliderActiveThumb.max, FSliderActiveThumb.max),
        ]) {
          test('tap value', () {
            var calls = 0;
            controller = constructor(range, .tap, activeThumb)
              ..attach(100, marks)
              ..addListener(() => calls++);

            expect(controller.tap(offset).thumb, thumb);
            expect(calls, 1);
            expect((controller.value.min, controller.value.max), (expected.min, expected.max));
            expect(controller.value.pixels, (min: expected.min * 100, max: expected.max * 100));
          });
        }

        test('initial selection', () {
          var calls = 0;
          controller = constructor(range, .tap)..addListener(() => calls++);

          expect(controller.tap(50).thumb, null);
          expect(calls, 0);
          expect(controller.value, range);
        });
      });

      group('reset', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..reset();

          expect(calls, 0);
          expect(controller.value.constraints, (min: 0, max: 1));
          expect((controller.value.min, controller.value.max), (0, 0.75));
        });

        test('existing selection', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..step(min: false, expand: true)
            ..addListener(() => calls++)
            ..reset();

          expect(calls, 1);
          expect(controller.value.constraints, (min: 0, max: 1));
          expect(controller.value.pixelConstraints, (min: 0.0, max: 1000.0, extent: 1000.0));
          expect((controller.value.min, controller.value.max), (0, 0.75));
          expect(controller.value.pixels, (min: 0, max: 750));
        });
      });

      group('set selection', () {
        test('null', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..addListener(() => calls++)
            ..value = null;

          expect(calls, 0);
          expect((controller.value.min, controller.value.max), (value.min, value.max));
        });

        test('same', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..addListener(() => calls++)
            ..value = controller.value;

          expect(calls, 0);
        });

        test('other', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..addListener(() => calls++)
            ..value = FSliderValue(max: 0.6);

          expect(calls, 1);
          expect((controller.value.min, controller.value.max), (0, 0.6));
        });
      });
    });
  }

  group('FContinuousSlider', () {
    final selection = FSliderValue(max: 0.75);
    late FContinuousSliderController controller;

    setUp(() {
      controller = FContinuousSliderController(value: selection);
    });

    for (final constructor in [
      () => FContinuousSliderController(value: selection, stepPercentage: -0.1),
      () => FContinuousSliderController(value: selection, stepPercentage: 1.1),
      () => FContinuousSliderController.range(value: selection, stepPercentage: -0.1),
      () => FContinuousSliderController.range(value: selection, stepPercentage: 1.1),
    ]) {
      test('constructor', () => expect(constructor, throwsAssertionError));
    }

    for (final (min, extend, expected) in [
      (true, true, (min: 0.2, max: 0.75)),
      (true, false, (min: 0.3, max: 0.75)),
      (false, true, (min: 0.25, max: 0.8)),
      (false, false, (min: 0.25, max: 0.7)),
    ]) {
      test('step ${min ? 'min' : 'max'} edge - ${extend ? 'extend' : 'shrink'}', () {
        var calls = 0;
        controller = .range(value: FSliderValue(min: 0.25, max: 0.75))
          ..attach(100, [])
          ..addListener(() => calls++)
          ..step(min: min, expand: extend);

        expect(calls, 1);
        expect((controller.value.min, controller.value.max), (expected.min, expected.max));
        expect(controller.value.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }

    for (final (offset, expected, times, thumb) in [
      (0.0, (min: 0.0, max: 0.75), 1, FSliderActiveThumb.min),
      (100.0, (min: 0.25, max: 1.0), 1, FSliderActiveThumb.max),
      (50.0, (min: 0.25, max: 0.75), 0, null),
    ]) {
      test('tap range', () {
        var calls = 0;
        controller = .range(value: FSliderValue(min: 0.25, max: 0.75))
          ..attach(100, [])
          ..addListener(() => calls++);

        expect(controller.tap(offset).thumb, thumb);
        expect(calls, times);
        expect((controller.value.min, controller.value.max), (expected.min, expected.max));
        expect(controller.value.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }
  });

  group('FDiscreteSlider', () {
    final selection = FSliderValue(max: 0.75);
    late FDiscreteSliderController controller;

    setUp(() {
      controller = FDiscreteSliderController(value: selection);
    });

    test('attach', () => expect(() => controller.attach(1000, []), throwsAssertionError));

    for (final (min, extend, expected) in [
      (true, true, (min: 0.0, max: 0.75)),
      (true, false, (min: 0.5, max: 0.75)),
      (false, true, (min: 0.25, max: 1.0)),
      (false, false, (min: 0.25, max: 0.6)),
    ]) {
      test('step ${min ? 'min' : 'max'} edge - ${extend ? 'extend' : 'shrink'}', () {
        var calls = 0;
        controller = .range(value: FSliderValue(min: 0.25, max: 0.75))
          ..attach(100, marks)
          ..addListener(() => calls++)
          ..step(min: min, expand: extend);

        expect(calls, 1);
        expect((controller.value.min, controller.value.max), (expected.min, expected.max));
        expect(controller.value.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }

    for (final (offset, expected, times, thumb) in [
      (0.0, (min: 0.0, max: 0.75), 1, FSliderActiveThumb.min),
      (100.0, (min: 0.25, max: 1.0), 1, FSliderActiveThumb.max),
      (50.0, (min: 0.25, max: 0.75), 0, null),
    ]) {
      test('tap range', () {
        var calls = 0;
        controller = .range(value: FSliderValue(min: 0.25, max: 0.75))
          ..attach(100, marks)
          ..addListener(() => calls++);

        expect(controller.tap(offset).thumb, thumb);
        expect(calls, times);
        expect((controller.value.min, controller.value.max), (expected.min, expected.max));
        expect(controller.value.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }
  });

  group('haptic feedback', () {
    group('slide', () {
      test('returns null when interaction is tap-only', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.5), interaction: .tap)
          ..attach(100, []);
        expect(controller.slide(100, min: false, velocity: 50), null);
      });

      test('hapticFeedbackVelocity = 0 fires collision on any movement', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.5), hapticFeedbackVelocity: 0)
          ..attach(100, []);
        expect(controller.slide(100, min: false, velocity: 0.1), FSliderHaptic.collision);
      });

      group('single-value continuous', () {
        test('drag with no collision and no ticks returns null', () {
          final controller = FContinuousSliderController(value: FSliderValue(max: 0.25))..attach(100, []);
          expect(controller.slide(60, min: false, velocity: 20), null);
        });

        test('drag crossing a tick mark returns tick', () {
          final controller = FContinuousSliderController(value: FSliderValue(max: 0.25))..attach(100, marks);
          expect(controller.slide(55, min: false, velocity: 20), FSliderHaptic.tick);
        });

        test('drag between two tick marks without crossing returns null', () {
          final controller = FContinuousSliderController(value: FSliderValue(max: 0.3))..attach(100, marks);
          expect(controller.slide(40, min: false, velocity: 20), null);
        });

        test('fast drag past upper limit returns collision', () {
          final controller = FContinuousSliderController(value: FSliderValue(max: 0.5))..attach(100, []);
          expect(controller.slide(100, min: false, velocity: 50), FSliderHaptic.collision);
        });

        test('slow drag past upper limit returns null', () {
          final controller = FContinuousSliderController(value: FSliderValue(max: 0.5))..attach(100, []);
          expect(controller.slide(100, min: false, velocity: 1), null);
        });
      });

      group('single-value discrete', () {
        test('drag landing on new tick returns tick', () {
          final controller = FDiscreteSliderController(value: FSliderValue(max: 0.25))..attach(100, marks);
          expect(controller.slide(50, min: false, velocity: 20), FSliderHaptic.tick);
        });

        test('drag rounding to same tick returns null', () {
          final controller = FDiscreteSliderController(value: FSliderValue(max: 0.5))..attach(100, marks);
          expect(controller.slide(51, min: false, velocity: 20), null);
        });

        test('fast drag past upper limit returns collision', () {
          final controller = FDiscreteSliderController(value: FSliderValue(max: 0.75))..attach(100, marks);
          expect(controller.slide(100, min: false, velocity: 50), FSliderHaptic.collision);
        });

        test('slow drag landing on a tick returns tick even at the upper limit', () {
          final controller = FDiscreteSliderController(value: FSliderValue(max: 0.75))..attach(100, marks);
          expect(controller.slide(100, min: false, velocity: 1), FSliderHaptic.tick);
        });
      });

      group('range continuous', () {
        test('fast drag of min edge into max edge returns collision', () {
          final controller = FContinuousSliderController.range(value: FSliderValue(min: 0.25, max: 0.75))
            ..attach(100, []);
          expect(controller.slide(80, min: true, velocity: 50), FSliderHaptic.collision);
        });

        test('fast drag of max edge into min edge returns collision', () {
          final controller = FContinuousSliderController.range(value: FSliderValue(min: 0.25, max: 0.75))
            ..attach(100, []);
          expect(controller.slide(20, min: false, velocity: 50), FSliderHaptic.collision);
        });

        test('slow drag into other edge returns null', () {
          final controller = FContinuousSliderController.range(value: FSliderValue(min: 0.25, max: 0.75))
            ..attach(100, []);
          expect(controller.slide(80, min: true, velocity: 1), null);
        });
      });

      group('range discrete', () {
        test('fast drag of min edge into max edge returns collision', () {
          final controller = FDiscreteSliderController.range(value: FSliderValue(min: 0.25, max: 0.75))
            ..attach(100, marks);
          expect(controller.slide(80, min: true, velocity: 50), FSliderHaptic.collision);
        });
      });
    });

    group('step', () {
      test('continuous returns false', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.5))..attach(100, []);
        expect(controller.step(min: false, expand: true), false);
      });

      test('continuous landing on a limit returns false (keyboard step is intentional, not a collision)', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.95))..attach(100, []);
        expect(controller.step(min: false, expand: true), false);
      });

      test('discrete returns true', () {
        final controller = FDiscreteSliderController(value: FSliderValue(max: 0.5))..attach(100, marks);
        expect(controller.step(min: false, expand: true), true);
      });
    });

    group('tap', () {
      test('discrete landing on new tick returns true', () {
        final controller = FDiscreteSliderController(value: FSliderValue(max: 0.25))..attach(100, marks);
        expect(controller.tap(50).haptic, true);
      });

      test('discrete landing on same tick returns false', () {
        final controller = FDiscreteSliderController(value: FSliderValue(max: 0.5))..attach(100, marks);
        expect(controller.tap(51).haptic, false);
      });

      test('continuous tapping exactly on a tick mark returns true', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.25))..attach(100, marks);
        expect(controller.tap(60).haptic, true);
      });

      test('continuous without ticks returns false', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.25))..attach(100, []);
        expect(controller.tap(80).haptic, false);
      });

      test('tap at limit returns false (intentional placement)', () {
        final controller = FContinuousSliderController(value: FSliderValue(max: 0.5))..attach(100, []);
        expect(controller.tap(100).haptic, false);
      });
    });
  });
}

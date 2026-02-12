import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/theme/variants.dart';

class _Add with Delta {
  final int value;

  const _Add(this.value);

  @override
  int call(covariant int base) => base + value;
}

class _NullableDelta with Delta {
  const _NullableDelta();

  @override
  Object call(covariant double? base) => base ?? 0.0;
}

double? _lerpNullableDouble(double? a, double? b, double t) => lerpDouble(a, b, t);

void main() {
  const a = FVariant(1, 'a');
  const b = FVariant(1, 'b');
  const c = FVariant(1, 'c');
  const ab = And(a, b);
  const ac = And(a, c);

  group('FVariants', () {
    test('lerpBoxDecoration', () {
      final first = createVariants<FVariant, BoxDecoration, Delta>(const BoxDecoration(color: Color(0xFF000000)), {
        a: const BoxDecoration(color: Color(0xFF000000)),
      });
      final second = createVariants<FVariant, BoxDecoration, Delta>(const BoxDecoration(color: Color(0xFFFFFFFF)), {
        a: const BoxDecoration(color: Color(0xFFFFFFFF)),
      });

      final result = FVariants.lerpBoxDecoration(first, second, 0.5);

      expect(result.base.color?.r, closeTo(0.5, 0.01));
      expect(result.variants[a]?.color?.r, closeTo(0.5, 0.01));
    });

    test('lerpDecoration', () {
      final first = createVariants<FVariant, Decoration, Delta>(const BoxDecoration(color: Color(0xFF000000)), {
        a: const BoxDecoration(color: Color(0xFF000000)),
      });
      final second = createVariants<FVariant, Decoration, Delta>(const BoxDecoration(color: Color(0xFFFFFFFF)), {
        a: const BoxDecoration(color: Color(0xFFFFFFFF)),
      });

      final result = FVariants.lerpDecoration(first, second, 0.5);

      expect((result.base as BoxDecoration).color?.r, closeTo(0.5, 0.01));
      expect((result.variants[a] as BoxDecoration?)?.color?.r, closeTo(0.5, 0.01));
    });

    test('lerpColor', () {
      final first = createVariants<FVariant, Color, Delta>(const Color(0xFF000000), {a: const Color(0xFF000000)});
      final second = createVariants<FVariant, Color, Delta>(const Color(0xFFFFFFFF), {a: const Color(0xFFFFFFFF)});

      final result = FVariants.lerpColor(first, second, 0.5);

      expect(result.base.r, closeTo(0.5, 0.01));
      expect(result.variants[a]?.r, closeTo(0.5, 0.01));
    });

    test('lerpIconThemeData', () {
      final first = createVariants<FVariant, IconThemeData, Delta>(const IconThemeData(size: 10), {
        a: const IconThemeData(size: 15),
      });
      final second = createVariants<FVariant, IconThemeData, Delta>(const IconThemeData(size: 20), {
        a: const IconThemeData(size: 25),
      });

      final result = FVariants.lerpIconThemeData(first, second, 0.5);

      expect(result.base.size, 15);
      expect(result.variants[a]?.size, 20);
    });

    test('lerpTextStyle', () {
      final first = createVariants<FVariant, TextStyle, Delta>(const TextStyle(fontSize: 10), {
        a: const TextStyle(fontSize: 15),
      });
      final second = createVariants<FVariant, TextStyle, Delta>(const TextStyle(fontSize: 20), {
        a: const TextStyle(fontSize: 25),
      });

      final result = FVariants.lerpTextStyle(first, second, 0.5);

      expect(result.base.fontSize, 15);
      expect(result.variants[a]?.fontSize, 20);
    });

    group('lerpWhere', () {
      group('non-nullable V', () {
        for (final (description, firstVariants, secondVariants, expected) in [
          ('keys in both', {a: 2.0, b: 4.0}, {a: 6.0, b: 8.0}, {a: 4.0, b: 6.0}),
          ('keys only in first', {a: 2.0, b: 4.0}, {a: 6.0}, {a: 4.0}),
          ('keys only in second', {a: 2.0}, {a: 6.0, b: 8.0}, {a: 4.0}),
        ]) {
          test(description, () {
            final first = createVariants<FVariant, double, Delta>(1.0, firstVariants);
            final second = createVariants<FVariant, double, Delta>(3.0, secondVariants);

            final result = FVariants.lerpWhere(first, second, 0.5, lerpDouble);

            expect(result.base, 2.0);
            expect(result.variants, expected);
          });
        }

        for (final (t, expected) in [(0.4, 1.0), (0.5, 3.0)]) {
          test('base fallback at t=$t', () {
            final first = createVariants<FVariant, double, Delta>(1.0, {});
            final second = createVariants<FVariant, double, Delta>(3.0, {});

            final result = FVariants.lerpWhere(first, second, t, (a, b, t) => null);

            expect(result.base, expected);
            expect(result.variants, <FVariant, double>{});
          });
        }
      });

      group('nullable V', () {
        for (final (description, firstVariants, secondVariants, expected) in [
          ('keys in both', {a: 2.0, b: 4.0}, {a: 6.0, b: 8.0}, {a: 4.0, b: 6.0}),
          ('keys only in first', {a: 2.0, b: 4.0}, {a: 6.0}, {a: 4.0}),
          ('keys only in second', {a: 2.0}, {a: 6.0, b: 8.0}, {a: 4.0}),
          ('null values in both', <FVariant, double?>{a: null}, <FVariant, double?>{a: null}, {a: null}),
        ]) {
          test(description, () {
            final first = createVariants<FVariant, double?, _NullableDelta>(1.0, firstVariants);
            final second = createVariants<FVariant, double?, _NullableDelta>(3.0, secondVariants);

            final result = FVariants.lerpWhere<FVariant, double?, _NullableDelta>(
              first,
              second,
              0.5,
              _lerpNullableDouble,
            );

            expect(result.base, 2.0);
            expect(result.variants, expected);
          });
        }

        test('lerp returning null includes key with null value', () {
          final first = createVariants<FVariant, double?, _NullableDelta>(1.0, {a: 2.0});
          final second = createVariants<FVariant, double?, _NullableDelta>(3.0, {a: 6.0});

          final result = FVariants.lerpWhere<FVariant, double?, _NullableDelta>(first, second, 0.5, (a, b, t) => null);

          expect(result.base, null);
          expect(result.variants, {a: null});
        });
      });
    });

    for (final (values, active, expected) in [
      (<FVariantConstraint, int>{}, {a}, 0), // no variants → base
      (<FVariantConstraint, int>{a: 1}, {a}, 1), // single match
      (<FVariantConstraint, int>{a: 1}, {b}, 0), // no match → base
      (<FVariantConstraint, int>{a: 1, ab: 2}, {a, b}, 2), // more specific wins
      (<FVariantConstraint, int>{a: 1, b: 2}, {a, b}, 1), // tie → lexicographic (a < b)
    ]) {
      test('resolve($active)', () => expect(createVariants(0, values).resolve(active), expected));
    }

    test('cast', () {
      final variants = createVariants<FTextFieldVariantConstraint, int, Delta>(0, {.disabled: 1});
      expect(() => variants.cast<FFormFieldVariantConstraint>(), returnsNormally);
    });

    test('apply', () {
      final variants = createVariants<FVariant, int, _Add>(0, {a: 1, b: 2});
      final result = variants.apply([
        .on({c}, const _Add(3)),
        .onAll(const _Add(10)),
      ]);

      expect(result.base, 10);
      expect(result.variants, {a: 11, b: 12, c: 13});
    });

    test('applyValues', () {
      final variants = createVariants<FVariant, int, Delta>(0, {a: 1, b: 2});
      final result = variants.applyValues([
        .on({c}, 3),
        .onAll(10),
      ]);

      expect(result.base, 10);
      expect(result.variants, {a: 10, b: 10, c: 10});
    });
  });

  group('FVariantsDelta', () {
    test('replaces entire FVariants', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.value(createVariants(10, {c: 30}));
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {c: 30});
    });

    group('apply(...)', () {
      test('in order', () {
        final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([
          .on({c}, const _Add(3)),
          .onAll(const _Add(10)),
        ]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 10);
        expect(result.variants, {a: 11, b: 12, c: 13});
      });

      test('no operations', () {
        final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([]);
        final result = delta(createVariants(0, {a: 1}));

        expect(result.base, 0);
        expect(result.variants, {a: 1});
      });
    });
  });

  group('FVariantOperation', () {
    const a = FVariant(1, 'a');
    const b = FVariant(1, 'b');
    const c = FVariant(1, 'c');
    const d = FVariant(1, 'd');

    test('onBase(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([.onBase(const _Add(10))]);
      final result = delta(createVariants(5, {a: 1}));

      expect(result.base, 15);
      expect(result.variants, {a: 1});
    });

    test('on(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([
        .on({b, c}, const _Add(10)),
      ]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, {a: 1, b: 10, c: 10});
    });

    for (final (description, variants, expected) in [
      ('many', {a, b}, {a: 11, b: 12, c: 3}),
      ('none', {d}, {a: 1, b: 2, c: 3}),
      ('single', {b}, {a: 1, b: 12, c: 3}),
    ]) {
      test('onMatching - $description', () {
        final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([.onMatching(variants, const _Add(10))]);
        final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onAll(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([.onAll(const _Add(10))]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {a: 11, b: 12});
    });

    test('remove(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([
        .remove({a, b, d}),
      ]);
      final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

      expect(result.base, 0);
      expect(result.variants, {c: 3});
    });

    test('removeMatching(...)', () {
      final delta = FVariantsDelta<FVariantConstraint, FVariant, int, _Add>.delta([
        .removeMatching({a, b}),
      ]);
      final result = delta(createVariants(0, <FVariantConstraint, int>{a: 1, b: 2, c: 3, ab: 4, ac: 5}));

      expect(result.base, 0);
      expect(result.variants, {c: 3, ac: 5});
    });

    test('removeAll(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.delta([.removeAll()]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, <FVariant, int>{});
    });
  });

  group('FVariantsValueDelta', () {
    test('replaces entire FVariants', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.value(createVariants(10, {c: 30}));
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {c: 30});
    });

    group('apply(...)', () {
      test('in order', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([
          .on({c}, 3),
          .onAll(10),
        ]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 10);
        expect(result.variants, {a: 10, b: 10, c: 10});
      });

      test('no operations', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([]);
        final result = delta(createVariants(0, {a: 1}));

        expect(result.base, 0);
        expect(result.variants, {a: 1});
      });
    });
  });

  group('FVariantValueDeltaOperation', () {
    const a = FVariant(1, 'a');
    const b = FVariant(1, 'b');
    const c = FVariant(1, 'c');
    const d = FVariant(1, 'd');

    test('onBase(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([.onBase(5)]);
      final result = delta(createVariants(0, {a: 1}));

      expect(result.base, 5);
      expect(result.variants, {a: 1});
    });

    for (final (description, constraints, expected) in [
      (' new', {c}, {a: 1, b: 2, c: 10}),
      ('overwrite', {b}, {a: 1, b: 10}),
    ]) {
      test('on(...) - $description', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([.on(constraints, 10)]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    for (final (description, variants, expected) in [
      ('many', {a, b}, {a: 10, b: 10, c: 3}),
      ('none', {d}, {a: 1, b: 2, c: 3}),
      ('single', {b}, {a: 1, b: 10, c: 3}),
    ]) {
      test('onMatching(...) - $description', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([.onMatching(variants, 10)]);
        final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    for (final (description, initial, expected) in [
      ('empty', <FVariant, int>{}, <FVariant, int>{}),
      ('single', {a: 1}, {a: 10}),
      ('many', {a: 1, b: 2, c: 3}, {a: 10, b: 10, c: 10}),
    ]) {
      test('onVariants(...) - $description', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([.onVariants(10)]);
        final result = delta(createVariants(0, initial));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onAll(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([.onAll(10)]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {a: 10, b: 10});
    });

    test('remove(...)', () {
      final delta = FVariantsValueDelta<FVariantConstraint, FVariant, int>.delta([
        .remove({a, b, d}),
      ]);
      final result = delta(createVariants(0, <FVariantConstraint, int>{a: 1, b: 2, c: 3, ab: 4}));

      expect(result.base, 0);
      expect(result.variants, {c: 3, ab: 4});
    });

    test('removeMatching(...)', () {
      final delta = FVariantsValueDelta<FVariantConstraint, FVariant, int>.delta([
        .removeMatching({a, b}),
      ]);
      final result = delta(createVariants(0, <FVariantConstraint, int>{a: 1, b: 2, c: 3, ab: 4, ac: 5}));

      expect(result.base, 0);
      expect(result.variants, {c: 3, ac: 5});
    });

    test('removeAll(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.delta([.removeAll()]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, <FVariant, int>{});
    });
  });
}

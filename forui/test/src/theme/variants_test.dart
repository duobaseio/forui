import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/theme/variants.dart';

class _Add with Delta<int> {
  final int value;

  const _Add(this.value);

  @override
  int call(int base) => base + value;
}

void main() {
  const a = FVariant(1, 'a');
  const b = FVariant(1, 'b');
  const c = FVariant(1, 'c');
  const ab = And(a, b);

  group('FVariants', () {
    for (final (values, active, expected) in [
      (<FVariant, int>{}, {a}, 0), // no variants → base
      ({a: 1}, {a}, 1), // single match
      ({a: 1}, {b}, 0), // no match → base
      ({a: 1, ab: 2}, {a, b}, 2), // more specific wins
      ({a: 1, b: 2}, {a, b}, 1), // tie → lexicographic (a < b)
    ]) {
      test('resolve($active)', () => expect(createVariants(0, values).resolve(active), expected));
    }

    test('cast', () {
      final variants = FVariants<FTextFieldVariantConstraint, int, Delta<int>>.raw(0, {.disabled: 1});
      expect(() => variants.cast<FFormFieldVariantConstraint>(), returnsNormally);
    });
  });

  group('FVariantsDelta', () {
    test('replaces entire FVariants', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.replace(createVariants(10, {c: 30}));
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {c: 30});
    });

    group('apply(...)', () {
      test('in order', () {
        final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([
          .add({c}, const _Add(3)),
          .onAll(const _Add(10)),
        ]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 0);
        expect(result.variants, {a: 11, b: 12, c: 13});
      });

      test('no operations', () {
        final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([]);
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

    test('add(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([
        .add({b, c}, const _Add(10)),
      ]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, {a: 1, b: 10, c: 10});
    });

    test('onBase(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([.onBase(const _Add(10))]);
      final result = delta(createVariants(5, {a: 1}));

      expect(result.base, 15);
      expect(result.variants, {a: 1});
    });

    for (final (description, variants, expected) in [
      ('many', {a, b}, {a: 11, b: 12, c: 3}),
      ('none', {d}, {a: 1, b: 2, c: 3}),
      ('single', {b}, {a: 1, b: 12, c: 3}),
    ]) {
      test('onVariants - $description', () {
        final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([.on(variants, const _Add(10))]);
        final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onAll(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([.onAll(const _Add(10))]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {a: 11, b: 12});
    });

    test('remove(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([
        .remove({a, b}),
      ]);
      final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

      expect(result.base, 0);
      expect(result.variants, {c: 3});
    });

    test('removeAll(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, int, _Add>.apply([.removeAll()]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, <FVariant, int>{});
    });
  });

  group('FVariantsValueDelta', () {
    test('replaces entire FVariants', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.replace(createVariants(10, {c: 30}));
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {c: 30});
    });

    group('apply(...)', () {
      test('in order', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([
          .add({c}, 3),
          .onAll(10),
        ]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 0);
        expect(result.variants, {a: 10, b: 10, c: 10});
      });

      test('no operations', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([]);
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

    for (final (description, constraints, expected) in [
      (' new', {c}, {a: 1, b: 2, c: 10}),
      ('overwrite', {b}, {a: 1, b: 10}),
    ]) {
      test('add(...) - $description', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.add(constraints, 10)]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onBase(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.onBase(5)]);
      final result = delta(createVariants(0, {a: 1}));

      expect(result.base, 5);
      expect(result.variants, {a: 1});
    });

    for (final (description, variants, expected) in [
      ('many', {a, b}, {a: 10, b: 10, c: 3}),
      ('none', {d}, {a: 1, b: 2, c: 3}),
      ('single', {b}, {a: 1, b: 10, c: 3}),
    ]) {
      test('on(...) - $description', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.on(variants, 10)]);
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
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.onVariants(10)]);
        final result = delta(createVariants(0, initial));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onAll(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.onAll(10)]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {a: 10, b: 10});
    });

    for (final (description, variants, expected) in [
      ('many', {a, b}, {c: 3}),
      ('all', {a, b, c}, <FVariant, int>{}),
      ('none', {d}, {a: 1, b: 2, c: 3}),
      ('single', {b}, {a: 1, c: 3}),
    ]) {
      test('remove - $description', () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.remove(variants)]);
        final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('removeAll(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.removeAll()]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, <FVariant, int>{});
    });
  });
}

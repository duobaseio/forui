import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/theme/variants.dart';
import 'package:forui/src/theme/variant.dart';

class _Add with Delta<int> {
  final int value;

  const _Add(this.value);

  @override
  int call(int base) => base + value;
}

void main() {
  const a = FVariant('a');
  const b = FVariant('b');
  const c = FVariant('c');
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
  });

  group('FVariantsDelta', () {
    test('replaces entire FVariants', () {
      final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.replace(createVariants(10, {c: 30}));
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 10);
      expect(result.variants, {c: 30});
    });

    group('apply(...)', () {
      test('in order', () {
        final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([
          .add({c}, const _Add(3)),
          .onAll(const _Add(10)),
        ]);
        final result = delta(createVariants(0, {a: 1, b: 2}));

        expect(result.base, 0);
        expect(result.variants, {a: 11, b: 12, c: 13});
      });

      test('no operations', () {
        final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([]);
        final result = delta(createVariants(0, {a: 1}));

        expect(result.base, 0);
        expect(result.variants, {a: 1});
      });
    });
  });

  group('FVariantOperation', () {
    const a = FVariant('a');
    const b = FVariant('b');
    const c = FVariant('c');
    const d = FVariant('d');

    test('add(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([
        .add({b, c}, const _Add(10)),
      ]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, {a: 1, b: 10, c: 10});
    });

    test('onBase(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([.onBase(const _Add(10))]);
      final result = delta(createVariants(5, {a: 1}));

      expect(result.base, 15);
      expect(result.variants, {a: 1});
    });

    for (final (description, variants, expected) in [
      ('on(...) - many', {a, b}, {a: 11, b: 12, c: 3}),
      ('on(...) - none', {d}, {a: 1, b: 2, c: 3}),
      ('on(...) - single', {b}, {a: 1, b: 12, c: 3}),
    ]) {
      test(description, () {
        final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([.on(variants, const _Add(10))]);
        final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onAll(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([.onAll(const _Add(10))]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, {a: 11, b: 12});
    });

    test('remove(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([
        .remove({a, b}),
      ]);
      final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

      expect(result.base, 0);
      expect(result.variants, {c: 3});
    });

    test('removeAll(...)', () {
      final delta = FVariantsDelta<FVariant, FVariant, _Add, int>.apply([.removeAll()]);
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
    const a = FVariant('a');
    const b = FVariant('b');
    const c = FVariant('c');
    const d = FVariant('d');

    for (final (description, constraints, expected) in [
      ('add(...) - new', {c}, {a: 1, b: 2, c: 10}),
      ('add(...) - overwrite', {b}, {a: 1, b: 10}),
    ]) {
      test(description, () {
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
      ('on(...) - many', {a, b}, {a: 10, b: 10, c: 3}),
      ('on(...) - none', {d}, {a: 1, b: 2, c: 3}),
      ('on(...) - single', {b}, {a: 1, b: 10, c: 3}),
    ]) {
      test(description, () {
        final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.on(variants, 10)]);
        final result = delta(createVariants(0, {a: 1, b: 2, c: 3}));

        expect(result.base, 0);
        expect(result.variants, expected);
      });
    }

    test('onAll(...)', () {
      final delta = FVariantsValueDelta<FVariant, FVariant, int>.apply([.onAll(10)]);
      final result = delta(createVariants(0, {a: 1, b: 2}));

      expect(result.base, 0);
      expect(result.variants, {a: 10, b: 10});
    });

    for (final (description, variants, expected) in [
      ('remove - many', {a, b}, {c: 3}),
      ('remove - all', {a, b, c}, <FVariant, int>{}),
      ('remove - none', {d}, {a: 1, b: 2, c: 3}),
      ('remove - single', {b}, {a: 1, c: 3}),
    ]) {
      test(description, () {
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

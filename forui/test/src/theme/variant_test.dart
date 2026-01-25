import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/theme/variant.dart';

void main() {
  group('FVariantConstraint', () {
    const a = FVariant('a');
    const b = FVariant('b');
    const c = FVariant('c');
    const ab = And(a, b);
    const ac = And(a, c);
    const bc = And(b, c);

    for (final (x, y, expected) in [
      // Operand count
      (a, ab, ab), // 1 vs 2 → 2 wins
      (ab, a, ab), // 2 vs 1 → 2 wins
      (a, const And(ab, c), const And(ab, c)), // 1 vs 3 → 3 wins
      // Lexicographic
      (ab, ac, ab), // "a" + "b" < "a" + "c"
      (ac, ab, ab), // "a" + "c" > "a" + "b"
      (ab, bc, ab), // "a" + "b" < "b" + "c"
      (a, b, a), // "a" < "b"
      (b, a, a), // "b" > "a"
      (a, a, a), // equal
    ]) {
      test('max($x, $y)', () => expect(FVariantConstraint.max(x, y), expected));
    }
  });

  group('FVariant', () {
    const a = FVariant('a');
    const b = FVariant('b');

    for (final (variants, expected) in [
      ({a}, true),
      ({a, b}, true),
      ({b}, false),
      (<FVariant>{}, false),
    ]) {
      test('satisfiedBy $variants', () => expect(a.satisfiedBy(variants), expected));
    }

    for (final (other, expected) in [(a, true), (b, false)]) {
      test('== $other', () => expect(a == other, expected));
    }

    test('toString', () => expect(a.toString(), 'a'));
  });

  group('And', () {
    const a = FVariant('a');
    const b = FVariant('b');
    const c = FVariant('c');
    const and = And(a, b);

    for (final (variants, expected) in [
      ({a, b}, true),
      ({a, b, c}, true),
      ({a}, false),
      ({b}, false),
      ({c}, false),
      (<FVariant>{}, false),
    ]) {
      test('satisfiedBy $variants', () => expect(and.satisfiedBy(variants), expected));
    }

    for (final (other, expected) in [(and, true), (const And(a, c), false), (const And(b, a), false)]) {
      test('== $other', () => expect(and == other, expected));
    }

    test('toString', () => expect(and.toString(), '(a & b)'));
  });

  group('Not', () {
    const a = FVariant('a');
    const b = FVariant('b');
    final not = Not(a);

    for (final (variants, expected) in [
      ({a}, false),
      ({b}, true),
      ({a, b}, false),
      (<FVariant>{}, true),
    ]) {
      test('satisfiedBy $variants', () => expect(not.satisfiedBy(variants), expected));
    }

    for (final (other, expected) in [(not, true), (Not(b), false)]) {
      test('== $other', () => expect(not == other, expected));
    }

    test('toString', () => expect(not.toString(), '!a'));
  });
}

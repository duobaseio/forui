import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/theme/theme_data.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:forui/src/theme/variants.dart';

class _AddDelta with Delta<int> {
  final int value;

  const _AddDelta(this.value);

  @override
  int apply(int base) => base + value;
}

void main() {
  group('FVariants', () {
    const a = FVariant('a');
    const b = FVariant('b');
    const ab = And(a, b);

    for (final (deltas, active, expected) in [
      (<Set<FVariant>, _AddDelta>{}, {a}, 0), // no deltas → base
      (
        {
          {a}: const _AddDelta(1),
        },
        {a},
        1,
      ), // single match
      (
        {
          {a}: const _AddDelta(1),
        },
        {b},
        0,
      ), // no match → base
      (
        {
          {a}: const _AddDelta(1),
          {ab}: const _AddDelta(2),
        },
        {a, b},
        2,
      ), // more specific wins
      (
        {
          {a}: const _AddDelta(1),
          {b}: const _AddDelta(2),
        },
        {a, b},
        1,
      ), // tie → lexicographic (a < b)
    ]) {
      test('resolve($active)', () => expect(FVariants(0, deltas: deltas).resolve(active), expected));
    }
  });

  group('FLiteralVariants', () {
    const a = FVariant('a');
    const b = FVariant('b');
    const ab = And(a, b);

    for (final (values, active, expected) in [
      (<Set<FVariant>, int>{}, {a}, 0), // no variants → base
      (
        {
          {a}: 1,
        },
        {a},
        1,
      ), // single match
      (
        {
          {a}: 1,
        },
        {b},
        0,
      ), // no match → base
      (
        {
          {a}: 1,
          {ab}: 2,
        },
        {a, b},
        2,
      ), // more specific wins
      (
        {
          {a}: 1,
          {b}: 2,
        },
        {a, b},
        1,
      ), // tie → lexicographic (a < b)
    ]) {
      test('resolve($active)', () => expect(FLiteralVariants(0, values: values).resolve(active), expected));
    }
  });
}

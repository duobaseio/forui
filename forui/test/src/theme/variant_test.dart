import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/theme/variant.dart';

void main() {
  group('toVariants', () {
    for (final (states, expected) in [
      (<WidgetState>{}, <FVariant>{}),
      ({WidgetState.disabled}, {const FVariant(2, 'disabled')}),
      ({WidgetState.error}, {const FVariant(2, 'error')}),
      ({WidgetState.selected}, {const FVariant(2, 'selected')}),
      ({WidgetState.focused}, {const FVariant(1, 'focused')}),
      ({WidgetState.hovered}, {const FVariant(1, 'hovered')}),
      ({WidgetState.pressed}, {const FVariant(1, 'pressed')}),
      ({WidgetState.dragged}, {const FVariant(1, 'dragged')}),
      ({WidgetState.disabled, WidgetState.focused}, {const FVariant(2, 'disabled'), const FVariant(1, 'focused')}),
      (
        {WidgetState.error, WidgetState.hovered, WidgetState.pressed},
        {const FVariant(2, 'error'), const FVariant(1, 'hovered'), const FVariant(1, 'pressed')},
      ),
    ]) {
      test('$states', () => expect(toVariants(states), expected));
    }
  });
  group('FVariantConstraint', () {
    // Tier 1 variants (interaction)
    const a = FVariant(1, 'a');
    const b = FVariant(1, 'b');
    const c = FVariant(1, 'c');
    // Tier 2 variant (semantic)
    const d = FVariant(2, 'd');

    const ab = And(a, b);
    const ac = And(a, c);
    const bc = And(b, c);

    // Tier 1 variant with different name for cross-tier tests
    const e = FVariant(1, 'e');
    // Second tier 2 variant
    const f = FVariant(2, 'f');

    const da = And(d, a); // tier 2 + tier 1
    const df = And(d, f); // tier 2 + tier 2
    const ae = And(a, e); // tier 1 + tier 1

    for (final (x, y, expected) in [
      // Tier comparison (single variants)
      (a, d, d), // tier 1 vs tier 2 → tier 2 wins
      (d, a, d), // tier 2 vs tier 1 → tier 2 wins
      // Cross-tier compound: tier-by-tier comparison
      (df, da, df), // {2: 2} vs {2: 1, 1: 1} → 2 tier-2 operands > 1 tier-2 operand
      (da, df, df), // symmetric
      (da, ae, da), // {2: 1, 1: 1} vs {1: 2} → has tier-2 operand, other doesn't
      (ae, da, da), // symmetric
      // Operand count (same tier)
      (a, ab, ab), // 1 vs 2 → 2 wins
      (ab, a, ab), // 2 vs 1 → 2 wins
      (a, const And(ab, c), const And(ab, c)), // 1 vs 3 → 3 wins
      // Lexicographic (same tier, same operand count)
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
    const a = FVariant(1, 'a');
    const b = FVariant(1, 'b');

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
    const a = FVariant(1, 'a');
    const b = FVariant(1, 'b');
    const c = FVariant(1, 'c');
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

    for (final (other, expected) in [(and, true), (const And(a, c), false), (const And(b, a), true)]) {
      test('== $other', () => expect(and == other, expected));
    }

    test('toString', () => expect(and.toString(), '(a & b)'));
  });

  group('Not', () {
    const a = FVariant(1, 'a');
    const b = FVariant(1, 'b');
    const not = Not(a);

    for (final (variants, expected) in [
      ({a}, false),
      ({b}, true),
      ({a, b}, false),
      (<FVariant>{}, true),
    ]) {
      test('satisfiedBy $variants', () => expect(not.satisfiedBy(variants), expected));
    }

    for (final (other, expected) in [(not, true), (const Not(b), false)]) {
      test('== $other', () => expect(not == other, expected));
    }

    test('toString', () => expect(not.toString(), '!a'));
  });
}

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FBorderRadius', () {
    test('default constructor', () {
      const borderRadius = FBorderRadius();

      expect(borderRadius.xs2, const BorderRadius.all(.circular(4)));
      expect(borderRadius.xs, const BorderRadius.all(.circular(6)));
      expect(borderRadius.sm, const BorderRadius.all(.circular(8)));
      expect(borderRadius.md, const BorderRadius.all(.circular(10)));
      expect(borderRadius.lg, const BorderRadius.all(.circular(14)));
      expect(borderRadius.xl, const BorderRadius.all(.circular(18)));
      expect(borderRadius.xl2, const BorderRadius.all(.circular(22)));
      expect(borderRadius.xl3, const BorderRadius.all(.circular(26)));
      expect(borderRadius.pill, const BorderRadius.all(.circular(100)));
    });

    test('lerp', () {
      const a = FBorderRadius();
      final b = a.scale(2);
      final result = a.lerp(b, 0.5);

      expect(result.md, BorderRadius.lerp(a.md, b.md, 0.5));
    });

    test('copyWith', () {
      const original = FBorderRadius();
      final modified = original.copyWith(md: .circular(20));

      expect(modified.xs, original.xs);
      expect(modified.md, BorderRadius.circular(20));
      expect(modified.xl, original.xl);
    });

    test('equality', () {
      const a = FBorderRadius();
      const b = FBorderRadius();
      final c = b.scale(1.2);

      expect(a, b);
      expect(a, isNot(c));
      expect(a.hashCode, b.hashCode);
    });
  });
}

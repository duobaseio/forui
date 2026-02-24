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
      expect(borderRadius.base, const BorderRadius.all(.circular(10)));
      expect(borderRadius.lg, const BorderRadius.all(.circular(14)));
      expect(borderRadius.xl, const BorderRadius.all(.circular(18)));
      expect(borderRadius.xl2, const BorderRadius.all(.circular(22)));
      expect(borderRadius.xl3, const BorderRadius.all(.circular(26)));
      expect(borderRadius.pill, const BorderRadius.all(.circular(100)));
    });

    test('inherit', () {
      final borderRadius = FBorderRadius.inherit(12);

      expect(borderRadius.xs2, BorderRadius.circular(6));
      expect(borderRadius.xs, BorderRadius.circular(8));
      expect(borderRadius.sm, BorderRadius.circular(10));
      expect(borderRadius.base, BorderRadius.circular(12));
      expect(borderRadius.lg, BorderRadius.circular(16));
      expect(borderRadius.xl, BorderRadius.circular(20));
      expect(borderRadius.xl2, BorderRadius.circular(24));
      expect(borderRadius.xl3, BorderRadius.circular(28));
    });

    test('lerp', () {
      final a = FBorderRadius.inherit(10);
      final b = FBorderRadius.inherit(20);
      final result = a.lerp(b, 0.5);

      expect(result.base, BorderRadius.lerp(a.base, b.base, 0.5));
    });

    test('copyWith', () {
      final original = FBorderRadius.inherit(10);
      final modified = original.copyWith(base: .circular(20));

      expect(modified.xs, original.xs);
      expect(modified.base, BorderRadius.circular(20));
      expect(modified.xl, original.xl);
    });

    test('equality', () {
      final a = FBorderRadius.inherit(10);
      final b = FBorderRadius.inherit(10);
      final c = FBorderRadius.inherit(12);

      expect(a, b);
      expect(a, isNot(c));
      expect(a.hashCode, b.hashCode);
    });
  });
}

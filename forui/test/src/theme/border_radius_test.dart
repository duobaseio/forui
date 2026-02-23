import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FLerpBorderRadius', () {
    for (final (Rect rect, RRect expected) in [
      (const .fromLTWH(0, 0, 30, 30), .fromLTRBR(0.0, 0.0, 30.0, 30.0, const .circular(10))),
      (const .fromLTWH(0, 0, 15, 35), .fromLTRBR(0.0, 0.0, 15.0, 35.0, const .circular(5))),
    ]) {
      test('toRRect', () {
        const radius = FLerpBorderRadius.all(.circular(10), min: 30);
        expect(radius.toRRect(rect), expected);
      });
    }
  });

  group('FBorderRadius', () {
    test('default constructor', () {
      const borderRadius = FBorderRadius(
        xs: FLerpBorderRadius.all(.circular(6), min: 18),
        sm: FLerpBorderRadius.all(.circular(8), min: 24),
        base: FLerpBorderRadius.all(.circular(10), min: 30),
        lg: FLerpBorderRadius.all(.circular(14), min: 42),
        xl: FLerpBorderRadius.all(.circular(18), min: 54),
        xl2: FLerpBorderRadius.all(.circular(22), min: 66),
        xl3: FLerpBorderRadius.all(.circular(26), min: 78),
      );

      expect(borderRadius.xs, const FLerpBorderRadius.all(.circular(6), min: 18));
      expect(borderRadius.sm, const FLerpBorderRadius.all(.circular(8), min: 24));
      expect(borderRadius.base, const FLerpBorderRadius.all(.circular(10), min: 30));
      expect(borderRadius.lg, const FLerpBorderRadius.all(.circular(14), min: 42));
      expect(borderRadius.xl, const FLerpBorderRadius.all(.circular(18), min: 54));
      expect(borderRadius.xl2, const FLerpBorderRadius.all(.circular(22), min: 66));
      expect(borderRadius.xl3, const FLerpBorderRadius.all(.circular(26), min: 78));
    });

    test('inherit', () {
      final borderRadius = FBorderRadius.inherit(10);

      expect(borderRadius.xs, FLerpBorderRadius.circular(6));
      expect(borderRadius.sm, FLerpBorderRadius.circular(8));
      expect(borderRadius.base, FLerpBorderRadius.circular(10));
      expect(borderRadius.lg, FLerpBorderRadius.circular(14));
      expect(borderRadius.xl, FLerpBorderRadius.circular(18));
      expect(borderRadius.xl2, FLerpBorderRadius.circular(22));
      expect(borderRadius.xl3, FLerpBorderRadius.circular(26));
    });

    test('lerp', () {
      final a = FBorderRadius.inherit(10);
      final b = FBorderRadius.inherit(20);
      final result = a.lerp(b, 0.5);

      expect(result.base, BorderRadius.lerp(a.base, b.base, 0.5));
    });

    test('copyWith', () {
      final original = FBorderRadius.inherit(10);
      final modified = original.copyWith(base: BorderRadius.circular(20));

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

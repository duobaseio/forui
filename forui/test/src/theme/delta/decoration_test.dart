import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('BoxDecorationDelta', () {
    group('delta(...)', () {
      test('no arguments provided', () {
        const original = BoxDecoration(
          color: Color(0xFF000000),
          border: .fromBorderSide(BorderSide()),
          borderRadius: .all(.circular(8)),
          boxShadow: [BoxShadow(blurRadius: 4)],
          gradient: LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
          backgroundBlendMode: .srcOver,
        );

        const delta = BoxDecorationDelta.delta();
        final result = delta(original);

        expect(result.color, original.color);
        expect(result.border, original.border);
        expect(result.borderRadius, original.borderRadius);
        expect(result.boxShadow, original.boxShadow);
        expect(result.gradient, original.gradient);
        expect(result.backgroundBlendMode, original.backgroundBlendMode);
        expect(result.shape, original.shape);
      });

      test('sets all fields to null', () {
        const original = BoxDecoration(
          color: Color(0xFF000000),
          border: .fromBorderSide(BorderSide()),
          borderRadius: .all(.circular(8)),
          boxShadow: [BoxShadow(blurRadius: 4)],
          gradient: LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
          backgroundBlendMode: .srcOver,
        );

        final delta = BoxDecorationDelta.delta(
          color: null,
          image: null,
          border: null,
          borderRadius: null,
          gradient: null,
          backgroundBlendMode: () => null,
        );

        final result = delta(original);

        expect(result.color, null);
        expect(result.image, null);
        expect(result.border, null);
        expect(result.borderRadius, null);
        expect(result.gradient, null);
        expect(result.backgroundBlendMode, null);
      });
    });

    test('value(...)', () {
      const original = BoxDecoration(color: Color(0xFF000000), borderRadius: .all(.circular(8)));

      const replacement = BoxDecoration(color: Color(0xFFFF0000));

      const delta = BoxDecorationDelta.value(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.borderRadius, null);
    });

    test('creates from null', () {
      const delta = BoxDecorationDelta.delta(color: Color(0xFF000000));
      final result = delta(null);

      expect(result.color, const Color(0xFF000000));
      expect(result.border, null);
      expect(result.borderRadius, null);
      expect(result.boxShadow, null);
      expect(result.gradient, null);
      expect(result.backgroundBlendMode, null);
      expect(result.shape, BoxShape.rectangle);
    });
  });
}

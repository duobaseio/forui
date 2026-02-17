import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('IconThemeDataDelta', () {
    group('delta(...)', () {
      test('no arguments provided', () {
        const original = IconThemeData(
          color: Color(0xFF000000),
          opacity: 0.8,
          size: 24,
          fill: 0.5,
          weight: 400,
          grade: 0.25,
          opticalSize: 48,
          shadows: [Shadow(blurRadius: 2)],
          applyTextScaling: true,
        );
        const delta = IconThemeDataDelta.delta();
        final result = delta(original);

        expect(result.color, original.color);
        expect(result.opacity, original.opacity);
        expect(result.size, original.size);
        expect(result.fill, original.fill);
        expect(result.weight, original.weight);
        expect(result.grade, original.grade);
        expect(result.opticalSize, original.opticalSize);
        expect(result.shadows, original.shadows);
        expect(result.applyTextScaling, original.applyTextScaling);
      });

      test('sets all fields to null', () {
        const original = IconThemeData(
          color: Color(0xFF000000),
          opacity: 0.8,
          size: 24,
          fill: 0.5,
          weight: 400,
          grade: 0.25,
          opticalSize: 48,
        );
        const delta = IconThemeDataDelta.delta(
          color: null,
          opacity: null,
          size: null,
          fill: null,
          weight: null,
          grade: null,
          opticalSize: null,
        );
        final result = delta(original);

        expect(result.color, null);
        expect(result.opacity, null);
        expect(result.size, null);
        expect(result.fill, null);
        expect(result.weight, null);
        expect(result.grade, null);
        expect(result.opticalSize, null);
      });
    });

    test('value(...)', () {
      const original = IconThemeData(color: Color(0xFF000000), size: 24);
      const replacement = IconThemeData(color: Color(0xFFFF0000));

      const delta = IconThemeDataDelta.value(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.size, null);
    });

    test('creates from null', () {
      const delta = IconThemeDataDelta.delta(color: Color(0xFF000000));
      final result = delta(null);

      expect(result.color, const Color(0xFF000000));
      expect(result.opacity, null);
      expect(result.size, null);
      expect(result.fill, null);
      expect(result.weight, null);
      expect(result.grade, null);
      expect(result.opticalSize, null);
      expect(result.shadows, null);
      expect(result.applyTextScaling, null);
    });
  });
}

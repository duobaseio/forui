import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('BoxDecorationDelta', () {
    group('merge(...)', () {
      test('no arguments provided', () {
        const original = BoxDecoration(
          color: Color(0xFF000000),
          border: .fromBorderSide(BorderSide()),
          borderRadius: .all(.circular(8)),
          boxShadow: [BoxShadow(blurRadius: 4)],
          gradient: LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
          backgroundBlendMode: .srcOver,
        );

        const delta = BoxDecorationDelta.merge();
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

        final delta = BoxDecorationDelta.merge(
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

    test('replace(...)', () {
      const original = BoxDecoration(color: Color(0xFF000000), borderRadius: .all(.circular(8)));

      const replacement = BoxDecoration(color: Color(0xFFFF0000));

      const delta = BoxDecorationDelta.replace(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.borderRadius, null);
    });
  });

  group('IconThemeDataDelta', () {
    group('merge(...)', () {
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
        const delta = IconThemeDataDelta.merge();
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
        const delta = IconThemeDataDelta.merge(
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

    test('replace(...)', () {
      const original = IconThemeData(color: Color(0xFF000000), size: 24);
      const replacement = IconThemeData(color: Color(0xFFFF0000));

      const delta = IconThemeDataDelta.replace(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.size, null);
    });
  });

  group('TextStyleDelta', () {
    group('merge(...)', () {
      test('no arguments provided', () {
        const original = TextStyle(
          inherit: false,
          color: Color(0xFF000000),
          backgroundColor: Color(0xFFFFFFFF),
          fontSize: 16,
          fontWeight: .bold,
          fontStyle: .italic,
          letterSpacing: 1.5,
          wordSpacing: 2.0,
          textBaseline: .alphabetic,
          height: 1.2,
          leadingDistribution: .even,
          decoration: .underline,
          decorationColor: Color(0xFF0000FF),
          decorationStyle: .dashed,
          decorationThickness: 2.0,
          debugLabel: 'test',
          fontFamily: 'Roboto',
          overflow: .ellipsis,
        );

        const delta = TextStyleDelta.merge();
        final result = delta(original);

        expect(result.inherit, original.inherit);
        expect(result.color, original.color);
        expect(result.backgroundColor, original.backgroundColor);
        expect(result.fontSize, original.fontSize);
        expect(result.fontWeight, original.fontWeight);
        expect(result.fontStyle, original.fontStyle);
        expect(result.letterSpacing, original.letterSpacing);
        expect(result.wordSpacing, original.wordSpacing);
        expect(result.textBaseline, original.textBaseline);
        expect(result.height, original.height);
        expect(result.leadingDistribution, original.leadingDistribution);
        expect(result.decoration, original.decoration);
        expect(result.decorationColor, original.decorationColor);
        expect(result.decorationStyle, original.decorationStyle);
        expect(result.decorationThickness, original.decorationThickness);
        expect(result.debugLabel, original.debugLabel);
        expect(result.fontFamily, original.fontFamily);
        expect(result.overflow, original.overflow);
      });

      test('sets all fields to null', () {
        final paint = Paint()..color = const Color(0xFFFF0000);
        final original = TextStyle(
          inherit: false,
          fontSize: 14,
          fontWeight: .bold,
          fontStyle: .italic,
          letterSpacing: 1.5,
          wordSpacing: 2.0,
          textBaseline: .alphabetic,
          height: 1.2,
          leadingDistribution: .even,
          locale: const Locale('en'),
          foreground: paint,
          background: paint,
          shadows: const [Shadow(blurRadius: 1)],
          fontFeatures: const [.tabularFigures()],
          fontVariations: const [FontVariation('wght', 400)],
          decoration: .underline,
          decorationColor: const Color(0xFF000000),
          decorationStyle: .dashed,
          decorationThickness: 2.0,
          debugLabel: 'test',
          fontFamily: 'Roboto',
          fontFamilyFallback: const ['Arial'],
          overflow: .ellipsis,
        );

        final delta = TextStyleDelta.merge(
          fontSize: null,
          fontWeight: null,
          fontStyle: () => null,
          letterSpacing: null,
          wordSpacing: null,
          textBaseline: () => null,
          height: null,
          leadingDistribution: () => null,
          locale: null,
          foreground: () => null,
          background: () => null,
          decoration: null,
          decorationColor: null,
          decorationStyle: () => null,
          decorationThickness: null,
          debugLabel: null,
          fontFamily: null,
          overflow: () => null,
        );

        final result = delta(original);

        expect(result.fontSize, null);
        expect(result.fontWeight, null);
        expect(result.fontStyle, null);
        expect(result.letterSpacing, null);
        expect(result.wordSpacing, null);
        expect(result.textBaseline, null);
        expect(result.height, null);
        expect(result.leadingDistribution, null);
        expect(result.locale, null);
        expect(result.foreground, null);
        expect(result.background, null);
        expect(result.decoration, null);
        expect(result.decorationColor, null);
        expect(result.decorationStyle, null);
        expect(result.decorationThickness, null);
        expect(result.debugLabel, null);
        expect(result.fontFamily, null);
        expect(result.overflow, null);
      });
    });

    test('replace(...)', () {
      const original = TextStyle(color: Color(0xFF000000), fontSize: 14, decoration: .underline);

      const replacement = TextStyle(color: Color(0xFFFF0000));

      const delta = TextStyleDelta.replace(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.fontSize, null);
      expect(result.decoration, null);
    });
  });
}

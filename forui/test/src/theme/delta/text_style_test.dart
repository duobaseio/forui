import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('TextStyleDelta', () {
    group('delta(...)', () {
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

        const delta = TextStyleDelta.delta();
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

        final delta = TextStyleDelta.delta(
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

    test('value(...)', () {
      const original = TextStyle(color: Color(0xFF000000), fontSize: 14, decoration: .underline);

      const replacement = TextStyle(color: Color(0xFFFF0000));

      const delta = TextStyleDelta.value(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.fontSize, null);
      expect(result.decoration, null);
    });

    test('creates from null', () {
      const delta = TextStyleDelta.delta(color: Color(0xFF000000));
      final result = delta(null);

      expect(result.color, const Color(0xFF000000));
      expect(result.inherit, true);
      expect(result.backgroundColor, null);
      expect(result.fontSize, null);
      expect(result.fontWeight, null);
      expect(result.fontStyle, null);
      expect(result.letterSpacing, null);
      expect(result.decoration, null);
    });
  });
}

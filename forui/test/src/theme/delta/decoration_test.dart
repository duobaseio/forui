import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

class _CustomDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => throw UnimplementedError();
}

void main() {
  group('DecorationDelta', () {
    group('shapeDelta(...)', () {
      test('on ShapeDecoration base', () {
        const base = ShapeDecoration(
          color: Color(0xFF000000),
          shadows: [BoxShadow(blurRadius: 4)],
          shape: RoundedRectangleBorder(borderRadius: .all(.circular(12))),
        );

        const delta = DecorationDelta.shapeDelta(color: Color(0xFFFF0000));
        final result = delta(base) as ShapeDecoration;

        expect(result.color, const Color(0xFFFF0000));
        expect(result.shadows, base.shadows);
        expect(result.shape, base.shape);
      });

      test('on BoxDecoration base', () {
        const base = BoxDecoration(
          color: Color(0xFF000000),
          border: .fromBorderSide(BorderSide(color: Color(0xFF111111))),
          borderRadius: .all(.circular(8)),
          boxShadow: [BoxShadow(blurRadius: 4)],
        );

        const delta = DecorationDelta.shapeDelta(color: Color(0xFFFF0000));
        final result = delta(base) as ShapeDecoration;

        expect(result.color, const Color(0xFFFF0000));
        expect(result.shadows, base.boxShadow);
        expect(result.shape, isA<RoundedRectangleBorder>());
      });

      test('on null', () {
        const delta = DecorationDelta.shapeDelta(color: Color(0xFF000000));
        final result = delta(null) as ShapeDecoration;

        expect(result.color, const Color(0xFF000000));
        expect(result.image, null);
        expect(result.gradient, null);
        expect(result.shadows, null);
        expect(result.shape, const RoundedRectangleBorder());
      });

      test('throws on unsupported type', () {
        final decoration = _CustomDecoration();
        const delta = DecorationDelta.shapeDelta();

        expect(() => delta(decoration), throwsUnsupportedError);
      });
    });

    group('boxDelta(...)', () {
      test('on BoxDecoration base', () {
        const base = BoxDecoration(
          color: Color(0xFF000000),
          border: .fromBorderSide(BorderSide()),
          borderRadius: .all(.circular(8)),
        );

        const delta = DecorationDelta.boxDelta(color: Color(0xFFFF0000));
        final result = delta(base) as BoxDecoration;

        expect(result.color, const Color(0xFFFF0000));
        expect(result.border, base.border);
        expect(result.borderRadius, base.borderRadius);
      });

      test('on ShapeDecoration base with CircleBorder', () {
        const base = ShapeDecoration(
          color: Color(0xFF000000),
          shape: CircleBorder(side: BorderSide(color: Color(0xFF111111))),
        );

        const delta = DecorationDelta.boxDelta();
        final result = delta(base) as BoxDecoration;

        expect(result.color, const Color(0xFF000000));
        expect(result.border, const Border.fromBorderSide(BorderSide(color: Color(0xFF111111))));
        expect(result.borderRadius, null);
        expect(result.shape, BoxShape.circle);
      });

      test('on ShapeDecoration base with RoundedRectangleBorder', () {
        const base = ShapeDecoration(
          color: Color(0xFF000000),
          shadows: [BoxShadow(blurRadius: 4)],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF111111)),
            borderRadius: .all(.circular(12)),
          ),
        );

        const delta = DecorationDelta.boxDelta();
        final result = delta(base) as BoxDecoration;

        expect(result.color, const Color(0xFF000000));
        expect(result.border, const Border.fromBorderSide(BorderSide(color: Color(0xFF111111))));
        expect(result.borderRadius, const BorderRadius.all(Radius.circular(12)));
        expect(result.boxShadow, const [BoxShadow(blurRadius: 4)]);
        expect(result.shape, BoxShape.rectangle);
      });

      test('on ShapeDecoration base with non-coercible shape', () {
        const base = ShapeDecoration(
          gradient: LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
          shape: StarBorder(),
        );

        const delta = DecorationDelta.boxDelta();
        final result = delta(base) as BoxDecoration;

        expect(result.color, null);
        expect(result.gradient, const LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]));
        expect(result.border, null);
        expect(result.borderRadius, null);
        expect(result.shape, BoxShape.rectangle);
      });

      test('delta fields take priority over coerced fields', () {
        const base = ShapeDecoration(
          color: Color(0xFF000000),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF111111)),
            borderRadius: .all(.circular(12)),
          ),
        );

        const delta = DecorationDelta.boxDelta(
          border: .fromBorderSide(BorderSide(color: Color(0xFFFF0000), width: 2)),
          borderRadius: .all(.circular(4)),
          shape: BoxShape.circle,
        );
        final result = delta(base) as BoxDecoration;

        expect(result.border, const Border.fromBorderSide(BorderSide(color: Color(0xFFFF0000), width: 2)));
        expect(result.borderRadius, const BorderRadius.all(Radius.circular(4)));
        expect(result.shape, BoxShape.circle);
      });

      test('on null', () {
        const delta = DecorationDelta.boxDelta(color: Color(0xFF000000));
        final result = delta(null) as BoxDecoration;

        expect(result.color, const Color(0xFF000000));
        expect(result.border, null);
        expect(result.borderRadius, null);
        expect(result.boxShadow, null);
        expect(result.gradient, null);
        expect(result.backgroundBlendMode, null);
        expect(result.shape, BoxShape.rectangle);
      });

      test('throws on unsupported type', () {
        final decoration = _CustomDecoration();
        const delta = DecorationDelta.boxDelta();

        expect(() => delta(decoration), throwsUnsupportedError);
      });
    });

    test('value(...)', () {
      const base = BoxDecoration(color: Color(0xFF000000), borderRadius: .all(.circular(8)));

      const replacement = ShapeDecoration(color: Color(0xFFFF0000), shape: CircleBorder());

      const delta = DecorationDelta.value(replacement);
      final result = delta(base);

      expect(result, replacement);
    });
  });

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

  group('ShapeDecorationDelta', () {
    group('delta(...)', () {
      test('no arguments provided', () {
        const original = ShapeDecoration(
          color: Color(0xFF000000),
          shadows: [BoxShadow(blurRadius: 4)],
          shape: RoundedRectangleBorder(borderRadius: .all(.circular(12))),
        );

        const delta = ShapeDecorationDelta.delta();
        final result = delta(original);

        expect(result.color, original.color);
        expect(result.image, original.image);
        expect(result.gradient, original.gradient);
        expect(result.shadows, original.shadows);
        expect(result.shape, original.shape);
      });

      test('sets all fields to null', () {
        const original = ShapeDecoration(
          color: Color(0xFF000000),
          shadows: [BoxShadow(blurRadius: 4)],
          shape: RoundedRectangleBorder(borderRadius: .all(.circular(12))),
        );

        const delta = ShapeDecorationDelta.delta(color: null, image: null, gradient: null);

        final result = delta(original);

        expect(result.color, null);
        expect(result.image, null);
        expect(result.gradient, null);
        expect(result.shadows, original.shadows);
        expect(result.shape, original.shape);
      });
    });

    test('value(...)', () {
      const original = ShapeDecoration(
        color: Color(0xFF000000),
        shape: RoundedRectangleBorder(borderRadius: .all(.circular(12))),
      );

      const replacement = ShapeDecoration(color: Color(0xFFFF0000), shape: CircleBorder());

      const delta = ShapeDecorationDelta.value(replacement);
      final result = delta(original);

      expect(result, replacement);
      expect(result.shape, const CircleBorder());
    });

    test('creates from null', () {
      const delta = ShapeDecorationDelta.delta(color: Color(0xFF000000));
      final result = delta(null);

      expect(result.color, const Color(0xFF000000));
      expect(result.image, null);
      expect(result.gradient, null);
      expect(result.shadows, null);
      expect(result.shape, const RoundedRectangleBorder());
    });
  });
}

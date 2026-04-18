import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

class _Marker extends FTypographyExtension<_Marker> {
  final String id;
  final double size;

  _Marker(this.id, {this.size = 1});

  @override
  _Marker copyWith({String? id, double? size}) => _Marker(id ?? this.id, size: size ?? this.size);

  @override
  _Marker lerp(ThemeExtension<_Marker>? other, double t) =>
      t < 0.5 ? this : (other as _Marker? ?? this);

  @override
  _Marker scale({double sizeScalar = 1.0}) => _Marker(id, size: size * sizeScalar);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Marker && id == other.id && size == other.size;

  @override
  int get hashCode => id.hashCode ^ size.hashCode;
}

void main() {
  group('FTypography', () {
    FTypography typography = FTypography();

    setUp(() {
      typography = FTypography(
        fontFamily: 'Roboto',
        xs3: const TextStyle(fontSize: 1),
        xs2: const TextStyle(fontSize: 2),
        xs: const TextStyle(fontSize: 3),
        sm: const TextStyle(fontSize: 4),
        md: const TextStyle(fontSize: 5),
        lg: const TextStyle(fontSize: 6),
        xl: const TextStyle(fontSize: 7),
        xl2: const TextStyle(fontSize: 8),
        xl3: const TextStyle(fontSize: 9),
        xl4: const TextStyle(fontSize: 10),
        xl5: const TextStyle(fontSize: 11),
        xl6: const TextStyle(fontSize: 12),
        xl7: const TextStyle(fontSize: 13),
        xl8: const TextStyle(fontSize: 14),
      );
    });

    group('constructor', () {
      test('no arguments', () {
        final typography = FTypography();
        const font = FTypography.defaultFontFamily;

        expect(typography.fontFamily, font);
        expect(typography.xs3, const TextStyle(fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even));
        expect(typography.xs2, const TextStyle(fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even));
        expect(
          typography.xs,
          const TextStyle(fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        );
        expect(typography.sm, const TextStyle(fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even));
        expect(
          typography.md,
          const TextStyle(fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.lg,
          const TextStyle(fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        );
        expect(typography.xl, const TextStyle(fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even));
        expect(
          typography.xl2,
          const TextStyle(fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        );
        expect(
          typography.xl3,
          const TextStyle(fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        );
        expect(typography.xl4, const TextStyle(fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even));
        expect(typography.xl5, const TextStyle(fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even));
        expect(typography.xl6, const TextStyle(fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even));
        expect(typography.xl7, const TextStyle(fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even));
        expect(typography.xl8, const TextStyle(fontFamily: font, fontSize: 108, height: 1, leadingDistribution: .even));
      });

      test('blank font family', () => expect(() => FTypography(fontFamily: ''), throwsAssertionError));
    });

    group('inherit', () {
      final colors = FColors(
        brightness: .light,
        systemOverlayStyle: .dark,
        barrier: Colors.black12,
        background: Colors.black,
        foreground: Colors.black12,
        primary: Colors.black26,
        primaryForeground: Colors.black38,
        secondary: Colors.black45,
        secondaryForeground: Colors.black54,
        muted: Colors.black87,
        mutedForeground: Colors.blue,
        destructive: Colors.blueAccent,
        destructiveForeground: Colors.blueGrey,
        error: Colors.red,
        errorForeground: Colors.redAccent,
        card: Colors.cyan,
        border: Colors.lightBlue,
      );

      test('touch', () {
        typography = FTypography.inherit(colors: colors, touch: true);
        final font = typography.fontFamily;
        final color = colors.foreground;

        expect(typography.fontFamily, 'packages/forui/Inter');
        expect(
          typography.xs3,
          TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xs2,
          TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xs,
          TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        );
        expect(
          typography.sm,
          TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
        );
        expect(
          typography.md,
          TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.lg,
          TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.xl,
          TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
        );
        expect(
          typography.xl2,
          TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        );
        expect(
          typography.xl3,
          TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        );
        expect(
          typography.xl4,
          TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl5,
          TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl6,
          TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl7,
          TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl8,
          TextStyle(color: color, fontFamily: font, fontSize: 108, height: 1, leadingDistribution: .even),
        );
      });

      test('desktop', () {
        typography = FTypography.inherit(colors: colors, touch: false);
        final font = typography.fontFamily;
        final color = colors.foreground;

        expect(typography.fontFamily, 'packages/forui/Inter');
        expect(
          typography.xs3,
          TextStyle(color: color, fontFamily: font, fontSize: 8, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xs2,
          TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xs,
          TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.sm,
          TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        );
        expect(
          typography.md,
          TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
        );
        expect(
          typography.lg,
          TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.xl,
          TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.xl2,
          TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
        );
        expect(
          typography.xl3,
          TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        );
        expect(
          typography.xl4,
          TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        );
        expect(
          typography.xl5,
          TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl6,
          TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl7,
          TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl8,
          TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
        );
      });
    });

    group('scale(...)', () {
      test('no arguments', () {
        typography = typography.scale();

        expect(typography.fontFamily, 'Roboto');
        expect(typography.xs3, const TextStyle(fontSize: 1));
        expect(typography.xs2, const TextStyle(fontSize: 2));
        expect(typography.xs, const TextStyle(fontSize: 3));
        expect(typography.sm, const TextStyle(fontSize: 4));
        expect(typography.md, const TextStyle(fontSize: 5));
        expect(typography.lg, const TextStyle(fontSize: 6));
        expect(typography.xl, const TextStyle(fontSize: 7));
        expect(typography.xl2, const TextStyle(fontSize: 8));
        expect(typography.xl3, const TextStyle(fontSize: 9));
        expect(typography.xl4, const TextStyle(fontSize: 10));
        expect(typography.xl5, const TextStyle(fontSize: 11));
        expect(typography.xl6, const TextStyle(fontSize: 12));
        expect(typography.xl7, const TextStyle(fontSize: 13));
        expect(typography.xl8, const TextStyle(fontSize: 14));
      });

      test('all arguments', () {
        typography = typography.scale(sizeScalar: 10);

        expect(typography.fontFamily, 'Roboto');
        expect(typography.xs3, const TextStyle(fontSize: 10));
        expect(typography.xs2, const TextStyle(fontSize: 20));
        expect(typography.xs, const TextStyle(fontSize: 30));
        expect(typography.sm, const TextStyle(fontSize: 40));
        expect(typography.md, const TextStyle(fontSize: 50));
        expect(typography.lg, const TextStyle(fontSize: 60));
        expect(typography.xl, const TextStyle(fontSize: 70));
        expect(typography.xl2, const TextStyle(fontSize: 80));
        expect(typography.xl3, const TextStyle(fontSize: 90));
        expect(typography.xl4, const TextStyle(fontSize: 100));
        expect(typography.xl5, const TextStyle(fontSize: 110));
        expect(typography.xl6, const TextStyle(fontSize: 120));
        expect(typography.xl7, const TextStyle(fontSize: 130));
        expect(typography.xl8, const TextStyle(fontSize: 140));
      });
    });

    group('copyWith(...)', () {
      test('no arguments', () {
        typography = FTypography(fontFamily: 'Roboto');
        typography = typography.copyWith();

        expect(typography.fontFamily, 'Roboto');
        expect(
          typography.xs3,
          const TextStyle(fontFamily: 'Roboto', fontSize: 10, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xs2,
          const TextStyle(fontFamily: 'Roboto', fontSize: 12, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xs,
          const TextStyle(fontFamily: 'Roboto', fontSize: 14, height: 1.25, leadingDistribution: .even),
        );
        expect(
          typography.sm,
          const TextStyle(fontFamily: 'Roboto', fontSize: 16, height: 1.5, leadingDistribution: .even),
        );
        expect(
          typography.md,
          const TextStyle(fontFamily: 'Roboto', fontSize: 18, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.lg,
          const TextStyle(fontFamily: 'Roboto', fontSize: 20, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typography.xl,
          const TextStyle(fontFamily: 'Roboto', fontSize: 22, height: 2, leadingDistribution: .even),
        );
        expect(
          typography.xl2,
          const TextStyle(fontFamily: 'Roboto', fontSize: 30, height: 2.25, leadingDistribution: .even),
        );
        expect(
          typography.xl3,
          const TextStyle(fontFamily: 'Roboto', fontSize: 36, height: 2.5, leadingDistribution: .even),
        );
        expect(
          typography.xl4,
          const TextStyle(fontFamily: 'Roboto', fontSize: 48, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl5,
          const TextStyle(fontFamily: 'Roboto', fontSize: 60, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl6,
          const TextStyle(fontFamily: 'Roboto', fontSize: 72, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl7,
          const TextStyle(fontFamily: 'Roboto', fontSize: 96, height: 1, leadingDistribution: .even),
        );
        expect(
          typography.xl8,
          const TextStyle(fontFamily: 'Roboto', fontSize: 108, height: 1, leadingDistribution: .even),
        );
      });

      test('all arguments', () {
        final typography = FTypography().copyWith(
          xs3: const TextStyle(fontSize: 1),
          xs2: const TextStyle(fontSize: 2),
          xs: const TextStyle(fontSize: 3),
          sm: const TextStyle(fontSize: 4),
          md: const TextStyle(fontSize: 5),
          lg: const TextStyle(fontSize: 6),
          xl: const TextStyle(fontSize: 7),
          xl2: const TextStyle(fontSize: 8),
          xl3: const TextStyle(fontSize: 9),
          xl4: const TextStyle(fontSize: 10),
          xl5: const TextStyle(fontSize: 11),
          xl6: const TextStyle(fontSize: 12),
          xl7: const TextStyle(fontSize: 13),
          xl8: const TextStyle(fontSize: 14),
        );

        expect(typography.fontFamily, 'packages/forui/Inter');
        expect(typography.xs3, const TextStyle(fontSize: 1));
        expect(typography.xs2, const TextStyle(fontSize: 2));
        expect(typography.xs, const TextStyle(fontSize: 3));
        expect(typography.sm, const TextStyle(fontSize: 4));
        expect(typography.md, const TextStyle(fontSize: 5));
        expect(typography.lg, const TextStyle(fontSize: 6));
        expect(typography.xl, const TextStyle(fontSize: 7));
        expect(typography.xl2, const TextStyle(fontSize: 8));
        expect(typography.xl3, const TextStyle(fontSize: 9));
        expect(typography.xl4, const TextStyle(fontSize: 10));
        expect(typography.xl5, const TextStyle(fontSize: 11));
        expect(typography.xl6, const TextStyle(fontSize: 12));
        expect(typography.xl7, const TextStyle(fontSize: 13));
        expect(typography.xl8, const TextStyle(fontSize: 14));
      });
    });

    test('debugFillProperties', () {
      final builder = DiagnosticPropertiesBuilder();
      typography.debugFillProperties(builder);

      expect(
        builder.properties.map((p) => p.toString()),
        [
          StringProperty('fontFamily', 'Roboto'),
          DiagnosticsProperty('xs3', const TextStyle(fontSize: 1)),
          DiagnosticsProperty('xs2', const TextStyle(fontSize: 2)),
          DiagnosticsProperty('xs', const TextStyle(fontSize: 3)),
          DiagnosticsProperty('sm', const TextStyle(fontSize: 4)),
          DiagnosticsProperty('md', const TextStyle(fontSize: 5)),
          DiagnosticsProperty('lg', const TextStyle(fontSize: 6)),
          DiagnosticsProperty('xl', const TextStyle(fontSize: 7)),
          DiagnosticsProperty('xl2', const TextStyle(fontSize: 8)),
          DiagnosticsProperty('xl3', const TextStyle(fontSize: 9)),
          DiagnosticsProperty('xl4', const TextStyle(fontSize: 10)),
          DiagnosticsProperty('xl5', const TextStyle(fontSize: 11)),
          DiagnosticsProperty('xl6', const TextStyle(fontSize: 12)),
          DiagnosticsProperty('xl7', const TextStyle(fontSize: 13)),
          DiagnosticsProperty('xl8', const TextStyle(fontSize: 14)),
          IterableProperty('extensions', const <ThemeExtension<dynamic>>{}),
        ].map((p) => p.toString()),
      );
    });

    group('equality and hashcode', () {
      test('equal', () {
        final copy = typography.copyWith();
        expect(copy, typography);
        expect(copy.hashCode, typography.hashCode);
      });

      test('not equal', () {
        final copy = typography.copyWith(xs3: const TextStyle(fontSize: 100));
        expect(copy, isNot(typography));
        expect(copy.hashCode, isNot(typography.hashCode));
      });
    });

    group('lerp(...)', () {
      final typographyB = FTypography(
        fontFamily: 'Arial',
        xs3: const TextStyle(fontSize: 6, height: 1, color: Colors.cyan),
        xs2: const TextStyle(fontSize: 8, height: 1.25, color: Colors.amber),
        xs: const TextStyle(fontSize: 10, height: 1.5, color: Colors.red),
        sm: const TextStyle(fontSize: 12, height: 1.75, color: Colors.green),
        md: const TextStyle(fontSize: 14, height: 2.0, color: Colors.blue),
        lg: const TextStyle(fontSize: 16, height: 2.25, color: Colors.yellow),
        xl: const TextStyle(fontSize: 18, height: 2.5, color: Colors.orange),
        xl2: const TextStyle(fontSize: 20, height: 2.75, color: Colors.purple),
        xl3: const TextStyle(fontSize: 22, height: 3.0, color: Colors.pink),
        xl4: const TextStyle(fontSize: 24, height: 3.25, color: Colors.brown),
        xl5: const TextStyle(fontSize: 26, height: 3.5, color: Colors.grey),
        xl6: const TextStyle(fontSize: 28, height: 3.75, color: Colors.teal),
        xl7: const TextStyle(fontSize: 30, height: 4.0, color: Colors.indigo),
        xl8: const TextStyle(fontSize: 32, height: 4.25, color: Colors.lime),
      );

      test('interpolation at t=0', () {
        final result = FTypography.lerp(typography, typographyB, 0.0);
        expect(result.fontFamily, typography.fontFamily);
        expect(result.xs3, TextStyle.lerp(typography.xs3, typographyB.xs3, 0));
        expect(result.xs, TextStyle.lerp(typography.xs, typographyB.xs, 0));
        expect(result.sm, TextStyle.lerp(typography.sm, typographyB.sm, 0));
        expect(result.md, TextStyle.lerp(typography.md, typographyB.md, 0));
      });

      test('interpolation at t=1', () {
        final result = FTypography.lerp(typography, typographyB, 1.0);
        expect(result.fontFamily, typographyB.fontFamily);
        expect(result.xs3, TextStyle.lerp(typography.xs3, typographyB.xs3, 1));
        expect(result.xs, TextStyle.lerp(typography.xs, typographyB.xs, 1));
        expect(result.sm, TextStyle.lerp(typography.sm, typographyB.sm, 1));
        expect(result.md, TextStyle.lerp(typography.md, typographyB.md, 1));
      });

      test('interpolation at t=0.5', () {
        final result = FTypography.lerp(typography, typographyB, 0.5);
        expect(result.fontFamily, typographyB.fontFamily);
        expect(result.xs3, TextStyle.lerp(typography.xs3, typographyB.xs3, 0.5));
        expect(result.xs, TextStyle.lerp(typography.xs, typographyB.xs, 0.5));
        expect(result.sm, TextStyle.lerp(typography.sm, typographyB.sm, 0.5));
        expect(result.md, TextStyle.lerp(typography.md, typographyB.md, 0.5));
      });
    });

    group('extensions', () {
      test('defaults to empty', () {
        expect(FTypography().extensions, <ThemeExtension<dynamic>>{});
      });

      test('retrieved via extension<T>()', () {
        final typography = FTypography(extensions: [_Marker('a')]);
        expect(typography.extension<_Marker>(), _Marker('a'));
        expect(typography.extensions, {_Marker('a')});
      });

      test('copyWith replaces extensions', () {
        final original = FTypography(extensions: [_Marker('a')]);
        final copy = original.copyWith(extensions: [_Marker('b')]);
        expect(copy.extension<_Marker>(), _Marker('b'));
      });

      test('copyWith without extensions preserves them', () {
        final original = FTypography(extensions: [_Marker('a')]);
        final copy = original.copyWith(xs3: const TextStyle(fontSize: 99));
        expect(copy.extension<_Marker>(), _Marker('a'));
      });

      test('scale forwards sizeScalar to extensions', () {
        final original = FTypography(extensions: [_Marker('a')]);
        final scaled = original.scale(sizeScalar: 2);
        expect(scaled.extension<_Marker>(), _Marker('a', size: 2));
      });

      test('lerp interpolates extensions', () {
        final a = FTypography(extensions: [_Marker('a')]);
        final b = FTypography(extensions: [_Marker('b')]);
        expect(FTypography.lerp(a, b, 0).extension<_Marker>(), _Marker('a'));
        expect(FTypography.lerp(a, b, 1).extension<_Marker>(), _Marker('b'));
      });

      test('lerp retains extensions present in only one side', () {
        final a = FTypography(extensions: [_Marker('a')]);
        final b = FTypography();
        expect(FTypography.lerp(a, b, 0.5).extension<_Marker>(), _Marker('a'));
      });

      test('equality includes extensions', () {
        final a = FTypography(extensions: [_Marker('a')]);
        final b = FTypography(extensions: [_Marker('a')]);
        final c = FTypography(extensions: [_Marker('b')]);
        expect(a, b);
        expect(a.hashCode, b.hashCode);
        expect(a, isNot(c));
      });
    });
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

class _Styles extends FScalableExtension<_Styles> {
  final TextStyle code;

  const _Styles(this.code);

  @override
  _Styles copyWith({TextStyle? code}) => _Styles(code ?? this.code);

  @override
  _Styles lerp(covariant _Styles? other, double t) =>
      other == null ? this : _Styles(TextStyle.lerp(code, other.code, t)!);

  @override
  _Styles scale({double sizeScalar = 1.0}) => _Styles(code.copyWith(fontSize: (code.fontSize ?? 14) * sizeScalar));

  @override
  bool operator ==(Object other) => identical(this, other) || other is _Styles && code == other.code;

  @override
  int get hashCode => code.hashCode;
}

class _Marker extends FScalableExtension<_Marker> {
  final String id;
  final double size;

  _Marker(this.id, {this.size = 1});

  @override
  _Marker copyWith({String? id, double? size}) => _Marker(id ?? this.id, size: size ?? this.size);

  @override
  _Marker lerp(ThemeExtension<_Marker>? other, double t) => t < 0.5 ? this : (other as _Marker? ?? this);

  @override
  _Marker scale({double sizeScalar = 1.0}) => _Marker(id, size: size * sizeScalar);

  @override
  bool operator ==(Object other) => identical(this, other) || other is _Marker && id == other.id && size == other.size;

  @override
  int get hashCode => id.hashCode ^ size.hashCode;
}

void main() {
  group('FTypography', () {
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

    const code = TextStyle(fontFamily: 'Mono');

    test('constructor assigns display and body', () {
      final display = FTypeface(fontFamily: 'Display');
      final body = FTypeface(fontFamily: 'Body');
      final typography = FTypography(display: display, body: body);

      expect(typography.display, display);
      expect(typography.body, body);
    });

    test('inherit sets display equal to body', () {
      final typography = FTypography.inherit(colors: colors, touch: true);

      expect(typography.body, FTypeface.inherit(colors: colors, touch: true));
      expect(typography.display, typography.body);
    });

    group('extensions', () {
      test('defaults to empty', () {
        expect(FTypography(display: FTypeface(), body: FTypeface()).extensions, <ThemeExtension<dynamic>>{});
      });

      test('retrieved via extension<T>()', () {
        final typography = FTypography(display: FTypeface(), body: FTypeface(), extensions: [const _Styles(code)]);
        expect(typography.extension<_Styles>(), const _Styles(code));
        expect(typography.extension<_Styles>().code, code);
        expect(typography.extensions, {const _Styles(code)});
      });

      test('passed through inherit', () {
        final typography = FTypography.inherit(colors: colors, touch: true, extensions: [const _Styles(code)]);
        expect(typography.extension<_Styles>().code, code);
      });
    });

    test('scale scales display, body, and extensions', () {
      final typography = FTypography(
        display: FTypeface(sm: const TextStyle(fontSize: 6)),
        body: FTypeface(sm: const TextStyle(fontSize: 4)),
        extensions: [const _Styles(TextStyle(fontSize: 5))],
      ).scale(sizeScalar: 2);

      expect(typography.display.sm.fontSize, 12);
      expect(typography.body.sm.fontSize, 8);
      expect(typography.extension<_Styles>().code.fontSize, 10);
    });

    test('copyWith replaces display, body, and extensions independently', () {
      final typography = FTypography(
        display: FTypeface(fontFamily: 'D'),
        body: FTypeface(fontFamily: 'B'),
      );
      final newDisplay = FTypeface(fontFamily: 'D2');
      final newBody = FTypeface(fontFamily: 'B2');

      expect(typography.copyWith(display: newDisplay).display, newDisplay);
      expect(typography.copyWith(body: newBody).body, newBody);
      expect(typography.copyWith().body, typography.body);
      expect(typography.copyWith(extensions: [const _Styles(code)]).extension<_Styles>().code, code);
    });

    group('lerp(...)', () {
      final a = FTypography(
        display: FTypeface(fontFamily: 'AD'),
        body: FTypeface(fontFamily: 'A'),
        extensions: [const _Styles(TextStyle(fontFamily: 'MonoA'))],
      );
      final b = FTypography(
        display: FTypeface(fontFamily: 'BD'),
        body: FTypeface(fontFamily: 'B'),
        extensions: [const _Styles(TextStyle(fontFamily: 'MonoB'))],
      );

      test('interpolation at t=0', () {
        final result = FTypography.lerp(a, b, 0);
        expect(result.display.fontFamily, 'AD');
        expect(result.body.fontFamily, 'A');
        expect(result.extension<_Styles>().code.fontFamily, 'MonoA');
      });

      test('interpolation at t=1', () {
        final result = FTypography.lerp(a, b, 1);
        expect(result.display.fontFamily, 'BD');
        expect(result.body.fontFamily, 'B');
        expect(result.extension<_Styles>().code.fontFamily, 'MonoB');
      });

      test('retains extensions present in only one side', () {
        final withExt = FTypography(display: FTypeface(), body: FTypeface(), extensions: [const _Styles(code)]);
        final without = FTypography(display: FTypeface(), body: FTypeface());
        expect(FTypography.lerp(withExt, without, 0.5).extension<_Styles>().code, code);
      });
    });

    group('equality and hashcode', () {
      test('equal', () {
        final a = FTypography(
          display: FTypeface(fontFamily: 'D'),
          body: FTypeface(fontFamily: 'B'),
        );
        final b = FTypography(
          display: FTypeface(fontFamily: 'D'),
          body: FTypeface(fontFamily: 'B'),
        );
        expect(a, b);
        expect(a.hashCode, b.hashCode);
      });

      test('not equal on display', () {
        final base = FTypography(
          display: FTypeface(fontFamily: 'D'),
          body: FTypeface(fontFamily: 'B'),
        );
        expect(
          base,
          isNot(
            FTypography(
              display: FTypeface(fontFamily: 'X'),
              body: FTypeface(fontFamily: 'B'),
            ),
          ),
        );
      });

      test('not equal on body', () {
        final base = FTypography(
          display: FTypeface(fontFamily: 'D'),
          body: FTypeface(fontFamily: 'B'),
        );
        expect(
          base,
          isNot(
            FTypography(
              display: FTypeface(fontFamily: 'D'),
              body: FTypeface(fontFamily: 'X'),
            ),
          ),
        );
      });

      test('not equal on extensions', () {
        final base = FTypography(display: FTypeface(), body: FTypeface());
        final other = FTypography(display: FTypeface(), body: FTypeface(), extensions: [const _Styles(code)]);
        expect(base, isNot(other));
      });
    });

    test('debugFillProperties', () {
      final typography = FTypography(
        display: FTypeface(fontFamily: 'D'),
        body: FTypeface(fontFamily: 'B'),
      );
      final builder = DiagnosticPropertiesBuilder();
      typography.debugFillProperties(builder);

      expect(builder.properties.map((p) => p.name), ['display', 'body', 'extensions']);
    });
  });

  group('FTypeface', () {
    var typeface = FTypeface();

    setUp(() {
      typeface = FTypeface(
        fontFamily: 'Roboto',
        fontFamilyFallback: const ['Arial'],
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
        final typeface = FTypeface();
        const font = FTypeface.defaultFontFamily;

        expect(typeface.fontFamily, font);
        expect(typeface.fontFamilyFallback, const <String>[]);
        expect(typeface.xs3, const TextStyle(fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even));
        expect(typeface.xs2, const TextStyle(fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even));
        expect(typeface.xs, const TextStyle(fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even));
        expect(typeface.sm, const TextStyle(fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even));
        expect(typeface.md, const TextStyle(fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even));
        expect(typeface.lg, const TextStyle(fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even));
        expect(typeface.xl, const TextStyle(fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even));
        expect(typeface.xl2, const TextStyle(fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even));
        expect(typeface.xl3, const TextStyle(fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even));
        expect(typeface.xl4, const TextStyle(fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even));
        expect(typeface.xl5, const TextStyle(fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even));
        expect(typeface.xl6, const TextStyle(fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even));
        expect(typeface.xl7, const TextStyle(fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even));
        expect(typeface.xl8, const TextStyle(fontFamily: font, fontSize: 108, height: 1, leadingDistribution: .even));
      });

      test('fontFamilyFallback threaded into default tokens', () {
        final typeface = FTypeface(fontFamily: 'Roboto', fontFamilyFallback: const ['Arial', 'Helvetica']);

        expect(typeface.fontFamilyFallback, const ['Arial', 'Helvetica']);
        expect(typeface.sm.fontFamilyFallback, const ['Arial', 'Helvetica']);
        expect(typeface.xl8.fontFamilyFallback, const ['Arial', 'Helvetica']);
      });

      test('blank font family', () => expect(() => FTypeface(fontFamily: ''), throwsAssertionError));
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
        typeface = FTypeface.inherit(colors: colors, touch: true);
        final font = typeface.fontFamily;
        final color = colors.foreground;

        expect(typeface.fontFamily, 'packages/forui/Inter');
        expect(
          typeface.xs3,
          TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xs2,
          TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xs,
          TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        );
        expect(
          typeface.sm,
          TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
        );
        expect(
          typeface.md,
          TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typeface.lg,
          TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typeface.xl,
          TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
        );
        expect(
          typeface.xl2,
          TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        );
        expect(
          typeface.xl3,
          TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        );
        expect(
          typeface.xl4,
          TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl5,
          TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl6,
          TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl7,
          TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl8,
          TextStyle(color: color, fontFamily: font, fontSize: 108, height: 1, leadingDistribution: .even),
        );
      });

      test('desktop', () {
        typeface = FTypeface.inherit(colors: colors, touch: false);
        final font = typeface.fontFamily;
        final color = colors.foreground;

        expect(typeface.fontFamily, 'packages/forui/Inter');
        expect(
          typeface.xs3,
          TextStyle(color: color, fontFamily: font, fontSize: 8, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xs2,
          TextStyle(color: color, fontFamily: font, fontSize: 10, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xs,
          TextStyle(color: color, fontFamily: font, fontSize: 12, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.sm,
          TextStyle(color: color, fontFamily: font, fontSize: 14, height: 1.25, leadingDistribution: .even),
        );
        expect(
          typeface.md,
          TextStyle(color: color, fontFamily: font, fontSize: 16, height: 1.5, leadingDistribution: .even),
        );
        expect(
          typeface.lg,
          TextStyle(color: color, fontFamily: font, fontSize: 18, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typeface.xl,
          TextStyle(color: color, fontFamily: font, fontSize: 20, height: 1.75, leadingDistribution: .even),
        );
        expect(
          typeface.xl2,
          TextStyle(color: color, fontFamily: font, fontSize: 22, height: 2, leadingDistribution: .even),
        );
        expect(
          typeface.xl3,
          TextStyle(color: color, fontFamily: font, fontSize: 30, height: 2.25, leadingDistribution: .even),
        );
        expect(
          typeface.xl4,
          TextStyle(color: color, fontFamily: font, fontSize: 36, height: 2.5, leadingDistribution: .even),
        );
        expect(
          typeface.xl5,
          TextStyle(color: color, fontFamily: font, fontSize: 48, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl6,
          TextStyle(color: color, fontFamily: font, fontSize: 60, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl7,
          TextStyle(color: color, fontFamily: font, fontSize: 72, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl8,
          TextStyle(color: color, fontFamily: font, fontSize: 96, height: 1, leadingDistribution: .even),
        );
      });

      test('threads fontFamilyFallback into tokens', () {
        typeface = FTypeface.inherit(colors: colors, touch: true, fontFamilyFallback: const ['Arial']);

        expect(typeface.fontFamilyFallback, const ['Arial']);
        expect(typeface.sm.fontFamilyFallback, const ['Arial']);
        expect(typeface.xl8.fontFamilyFallback, const ['Arial']);
      });
    });

    group('scale(...)', () {
      test('no arguments', () {
        typeface = typeface.scale();

        expect(typeface.fontFamily, 'Roboto');
        expect(typeface.xs3, const TextStyle(fontSize: 1));
        expect(typeface.sm, const TextStyle(fontSize: 4));
        expect(typeface.xl8, const TextStyle(fontSize: 14));
      });

      test('all arguments', () {
        typeface = typeface.scale(sizeScalar: 10);

        expect(typeface.fontFamily, 'Roboto');
        expect(typeface.fontFamilyFallback, const ['Arial']);
        expect(typeface.xs3, const TextStyle(fontSize: 10));
        expect(typeface.sm, const TextStyle(fontSize: 40));
        expect(typeface.xl8, const TextStyle(fontSize: 140));
      });
    });

    group('copyWith(...)', () {
      test('no arguments', () {
        typeface = FTypeface(fontFamily: 'Roboto').copyWith();

        expect(typeface.fontFamily, 'Roboto');
        expect(
          typeface.xs3,
          const TextStyle(fontFamily: 'Roboto', fontSize: 10, height: 1, leadingDistribution: .even),
        );
        expect(
          typeface.xl8,
          const TextStyle(fontFamily: 'Roboto', fontSize: 108, height: 1, leadingDistribution: .even),
        );
      });

      test('preserves fontFamilyFallback', () {
        final copy = FTypeface(
          fontFamily: 'Roboto',
          fontFamilyFallback: const ['Arial'],
        ).copyWith(xs3: const TextStyle(fontSize: 99));

        expect(copy.fontFamilyFallback, const ['Arial']);
        expect(copy.xs3, const TextStyle(fontSize: 99));
      });

      test('all arguments', () {
        final typeface = FTypeface().copyWith(
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

        expect(typeface.fontFamily, 'packages/forui/Inter');
        expect(typeface.xs3, const TextStyle(fontSize: 1));
        expect(typeface.xl8, const TextStyle(fontSize: 14));
      });
    });

    test('debugFillProperties', () {
      final builder = DiagnosticPropertiesBuilder();
      typeface.debugFillProperties(builder);

      expect(
        builder.properties.map((p) => p.toString()),
        [
          StringProperty('fontFamily', 'Roboto'),
          IterableProperty('fontFamilyFallback', const ['Arial']),
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
        final copy = typeface.copyWith();
        expect(copy, typeface);
        expect(copy.hashCode, typeface.hashCode);
      });

      test('not equal on token', () {
        final copy = typeface.copyWith(xs3: const TextStyle(fontSize: 100));
        expect(copy, isNot(typeface));
        expect(copy.hashCode, isNot(typeface.hashCode));
      });

      test('not equal on fontFamilyFallback', () {
        final a = FTypeface(fontFamily: 'Roboto', fontFamilyFallback: const ['Arial']);
        final b = FTypeface(fontFamily: 'Roboto', fontFamilyFallback: const ['Helvetica']);
        expect(a, isNot(b));
      });
    });

    group('lerp(...)', () {
      final typefaceB = FTypeface(
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
        final result = typeface.lerp(typefaceB, 0.0);
        expect(result.fontFamily, typeface.fontFamily);
        expect(result.xs3, TextStyle.lerp(typeface.xs3, typefaceB.xs3, 0));
        expect(result.sm, TextStyle.lerp(typeface.sm, typefaceB.sm, 0));
      });

      test('interpolation at t=1', () {
        final result = typeface.lerp(typefaceB, 1.0);
        expect(result.fontFamily, typefaceB.fontFamily);
        expect(result.xs3, TextStyle.lerp(typeface.xs3, typefaceB.xs3, 1));
        expect(result.sm, TextStyle.lerp(typeface.sm, typefaceB.sm, 1));
      });

      test('interpolation at t=0.5', () {
        final result = typeface.lerp(typefaceB, 0.5);
        expect(result.fontFamily, typefaceB.fontFamily);
        expect(result.xs3, TextStyle.lerp(typeface.xs3, typefaceB.xs3, 0.5));
        expect(result.sm, TextStyle.lerp(typeface.sm, typefaceB.sm, 0.5));
      });
    });

    group('extensions', () {
      test('defaults to empty', () {
        expect(FTypeface().extensions, <ThemeExtension<dynamic>>{});
      });

      test('retrieved via extension<T>()', () {
        final typeface = FTypeface(extensions: {_Marker('a')});
        expect(typeface.extension<_Marker>(), _Marker('a'));
        expect(typeface.extensions, {_Marker('a')});
      });

      test('copyWith replaces extensions', () {
        final original = FTypeface(extensions: {_Marker('a')});
        final copy = original.copyWith(extensions: {_Marker('b')});
        expect(copy.extension<_Marker>(), _Marker('b'));
      });

      test('copyWith without extensions preserves them', () {
        final original = FTypeface(extensions: {_Marker('a')});
        final copy = original.copyWith(xs3: const TextStyle(fontSize: 99));
        expect(copy.extension<_Marker>(), _Marker('a'));
      });

      test('scale forwards sizeScalar to extensions', () {
        final original = FTypeface(extensions: {_Marker('a')});
        final scaled = original.scale(sizeScalar: 2);
        expect(scaled.extension<_Marker>(), _Marker('a', size: 2));
      });

      test('lerp interpolates extensions', () {
        final a = FTypeface(extensions: {_Marker('a')});
        final b = FTypeface(extensions: {_Marker('b')});
        expect(a.lerp(b, 0).extension<_Marker>(), _Marker('a'));
        expect(a.lerp(b, 1).extension<_Marker>(), _Marker('b'));
      });

      test('lerp retains extensions present in only one side', () {
        final a = FTypeface(extensions: {_Marker('a')});
        final b = FTypeface();
        expect(a.lerp(b, 0.5).extension<_Marker>(), _Marker('a'));
      });

      test('equality includes extensions', () {
        final a = FTypeface(extensions: {_Marker('a')});
        final b = FTypeface(extensions: {_Marker('a')});
        final c = FTypeface(extensions: {_Marker('b')});
        expect(a, b);
        expect(a.hashCode, b.hashCode);
        expect(a, isNot(c));
      });
    });
  });
}

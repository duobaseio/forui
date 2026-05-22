import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

class _Marker extends ThemeExtension<_Marker> {
  final String id;

  const _Marker(this.id);

  @override
  _Marker copyWith({String? id}) => _Marker(id ?? this.id);

  @override
  _Marker lerp(ThemeExtension<_Marker>? other, double t) => t < 0.5 ? this : (other as _Marker? ?? this);

  @override
  bool operator ==(Object other) => identical(this, other) || other is _Marker && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

void main() {
  group('FStyle', () {
    final style = FStyle.inherit(colors: FColors.neutralLight, typography: FTypography(), touch: false);

    group('extensions', () {
      FStyle withExtensions(List<ThemeExtension<dynamic>> extensions) => style.copyWith(extensions: extensions);

      test('defaults to empty', () {
        expect(style.extensions, <ThemeExtension<dynamic>>{});
      });

      test('retrieved via extension<T>()', () {
        final updated = withExtensions(const [_Marker('a')]);
        expect(updated.extension<_Marker>(), const _Marker('a'));
        expect(updated.extensions, {const _Marker('a')});
      });

      test('copyWith replaces extensions', () {
        final original = withExtensions(const [_Marker('a')]);
        final copy = original.copyWith(extensions: const [_Marker('b')]);
        expect(copy.extension<_Marker>(), const _Marker('b'));
      });

      test('copyWith without extensions preserves them', () {
        final original = withExtensions(const [_Marker('a')]);
        final copy = original.copyWith();
        expect(copy.extension<_Marker>(), const _Marker('a'));
      });

      test('lerp interpolates extensions', () {
        final a = withExtensions(const [_Marker('a')]);
        final b = withExtensions(const [_Marker('b')]);
        expect(a.lerp(b, 0).extension<_Marker>(), const _Marker('a'));
        expect(a.lerp(b, 1).extension<_Marker>(), const _Marker('b'));
      });

      test('lerp retains extensions present in only one side', () {
        final a = withExtensions(const [_Marker('a')]);
        expect(a.lerp(style, 0.5).extension<_Marker>(), const _Marker('a'));
      });

      test('equality includes extensions', () {
        expect(withExtensions(const [_Marker('a')]), withExtensions(const [_Marker('a')]));
        expect(withExtensions(const [_Marker('a')]) == withExtensions(const [_Marker('b')]), false);
      });

      test('debugFillProperties exposes extensions', () {
        final builder = DiagnosticPropertiesBuilder();
        withExtensions(const [_Marker('a')]).debugFillProperties(builder);
        expect(builder.properties.whereType<IterableProperty<ThemeExtension<dynamic>>>().single.value, {
          const _Marker('a'),
        });
      });
    });
  });

  group('Decorations', () {
    group('color', () {
      for (final (String name, Decoration decoration, Color? expected) in [
        ('BoxDecoration', const BoxDecoration(color: Color(0xFF000000)), const Color(0xFF000000)),
        ('BoxDecoration - null', const BoxDecoration(), null),
        (
          'ShapeDecoration',
          const ShapeDecoration(color: Color(0xFFFF0000), shape: CircleBorder()),
          const Color(0xFFFF0000),
        ),
        ('ShapeDecoration - null', const ShapeDecoration(shape: CircleBorder()), null),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.color, expected));
      }
    });

    group('image', () {
      final image = DecorationImage(image: MemoryImage(Uint8List(0)));

      for (final (String name, Decoration decoration, DecorationImage? expected) in [
        ('BoxDecoration', BoxDecoration(image: image), image),
        ('BoxDecoration - null', const BoxDecoration(), null),
        ('ShapeDecoration', ShapeDecoration(image: image, shape: const CircleBorder()), image),
        ('ShapeDecoration - null', const ShapeDecoration(shape: CircleBorder()), null),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.image, expected));
      }
    });

    group('border', () {
      for (final (String name, Decoration decoration, ShapeBorder? expected) in [
        (
          'BoxDecoration - circle',
          const BoxDecoration(shape: BoxShape.circle, border: .fromBorderSide(BorderSide())),
          const CircleBorder(side: BorderSide()),
        ),
        ('BoxDecoration - circle without border', const BoxDecoration(shape: BoxShape.circle), const CircleBorder()),
        (
          'BoxDecoration - rectangle with borderRadius',
          const BoxDecoration(borderRadius: .all(.circular(8))),
          const RoundedRectangleBorder(borderRadius: .all(.circular(8))),
        ),
        (
          'BoxDecoration - rectangle with border',
          const BoxDecoration(border: .fromBorderSide(BorderSide(color: Color(0xFFFF0000), width: 2))),
          const RoundedRectangleBorder(side: BorderSide(color: Color(0xFFFF0000), width: 2)),
        ),
        ('BoxDecoration - empty', const BoxDecoration(), const RoundedRectangleBorder()),
        ('ShapeDecoration', const ShapeDecoration(shape: StadiumBorder()), const StadiumBorder()),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.border, expected));
      }
    });

    group('borderRadius', () {
      for (final (String name, Decoration decoration, BorderRadiusGeometry? expected) in [
        ('BoxDecoration', const BoxDecoration(borderRadius: .all(.circular(8))), const .all(.circular(8))),
        ('BoxDecoration - null', const BoxDecoration(), null),
        (
          'ShapeDecoration - RoundedRectangleBorder',
          const ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: .all(.circular(12)))),
          const .all(.circular(12)),
        ),
        (
          'ShapeDecoration - ContinuousRectangleBorder',
          const ShapeDecoration(shape: ContinuousRectangleBorder(borderRadius: .all(.circular(10)))),
          const .all(.circular(10)),
        ),
        (
          'ShapeDecoration - BeveledRectangleBorder',
          const ShapeDecoration(shape: BeveledRectangleBorder(borderRadius: .all(.circular(6)))),
          const .all(.circular(6)),
        ),
        (
          'ShapeDecoration - RoundedSuperellipseBorder',
          const ShapeDecoration(shape: RoundedSuperellipseBorder(borderRadius: .all(.circular(14)))),
          const .all(.circular(14)),
        ),
        ('ShapeDecoration - CircleBorder', const ShapeDecoration(shape: CircleBorder()), null),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.borderRadius, expected));
      }
    });

    group('shadows', () {
      for (final (String name, Decoration decoration, List<BoxShadow>? expected) in [
        ('BoxDecoration', const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 4)]), const [BoxShadow(blurRadius: 4)]),
        ('BoxDecoration - null', const BoxDecoration(), null),
        (
          'ShapeDecoration',
          const ShapeDecoration(
            shadows: [BoxShadow(color: Color(0xFFFF0000))],
            shape: CircleBorder(),
          ),
          const [BoxShadow(color: Color(0xFFFF0000))],
        ),
        ('ShapeDecoration - null', const ShapeDecoration(shape: CircleBorder()), null),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.shadows, expected));
      }
    });

    group('gradient', () {
      for (final (String name, Decoration decoration, Gradient? expected) in [
        (
          'BoxDecoration',
          const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)])),
          const LinearGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
        ),
        ('BoxDecoration - null', const BoxDecoration(), null),
        (
          'ShapeDecoration',
          const ShapeDecoration(
            gradient: RadialGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
            shape: CircleBorder(),
          ),
          const RadialGradient(colors: [Color(0xFF000000), Color(0xFFFFFFFF)]),
        ),
        ('ShapeDecoration - null', const ShapeDecoration(shape: CircleBorder()), null),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.gradient, expected));
      }
    });

    group('backgroundBlendMode', () {
      for (final (String name, Decoration decoration, BlendMode? expected) in [
        (
          'BoxDecoration',
          const BoxDecoration(color: Color(0xFF000000), backgroundBlendMode: BlendMode.multiply),
          BlendMode.multiply,
        ),
        ('BoxDecoration - null', const BoxDecoration(), null),
        ('ShapeDecoration', const ShapeDecoration(shape: CircleBorder()), null),
        ('unsupported', const FlutterLogoDecoration(), null),
      ]) {
        test(name, () => expect(decoration.backgroundBlendMode, expected));
      }
    });
  });
}

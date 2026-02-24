import 'dart:typed_data';

import 'package:flutter/painting.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
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

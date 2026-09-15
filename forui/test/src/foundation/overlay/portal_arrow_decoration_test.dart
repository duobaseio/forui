import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FPortalArrowDecoration', () {
    const decoration = ShapeDecoration(
      shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(10))),
      color: Color(0xFFFFFFFF),
    );
    const rect = Rect.fromLTWH(0, 0, 200, 100);
    late ValueNotifier<FPortalGeometry?> geometry;

    setUp(() => geometry = ValueNotifier(null));
    tearDown(() => geometry.dispose());

    Path clip({FPortalArrowAlignment alignment = FPortalArrowAlignment.childCenter, TextDirection direction = .ltr}) =>
        FPortalArrowDecoration(
          decoration: decoration,
          style: const FPortalArrowStyle(),
          alignment: alignment,
          geometry: geometry,
        ).getClipPath(rect, direction);

    test('no geometry', () {
      expect(clip().contains(const Offset(100, -3)), false);
      expect(clip().contains(const Offset(100, 50)), true);
    });

    for (final (name, child, inside, outside) in [
      ('top', const Rect.fromLTWH(50, -50, 100, 50), const Offset(100, -3), const Offset(100, -9)),
      ('bottom', const Rect.fromLTWH(50, 110, 100, 50), const Offset(100, 103), const Offset(100, 109)),
      ('left', const Rect.fromLTWH(-60, 20, 50, 60), const Offset(-3, 50), const Offset(-9, 50)),
      ('right', const Rect.fromLTWH(210, 20, 50, 60), const Offset(203, 50), const Offset(209, 50)),
    ]) {
      test(name, () {
        geometry.value = (child: child, portal: rect.size);
        expect(clip().contains(inside), true);
        expect(clip().contains(outside), false);
      });
    }

    test('arrow clamped off the corner', () {
      // Child center is 10; min center = radius 10 + width / 2 + base fillet 3 * 7 / (9.9 + 7) + cornerSpacing 0 ≈ 18.2.
      geometry.value = (child: const Rect.fromLTWH(0, -50, 20, 50), portal: rect.size);
      expect(clip().contains(const Offset(18.2, -3)), true);
      expect(clip().contains(const Offset(11, -3)), false);
    });

    test('arrow hidden when clamped off the child', () {
      geometry.value = (child: const Rect.fromLTWH(300, -50, 20, 50), portal: rect.size);
      expect(clip().contains(const Offset(176, -3)), false);
    });

    test('overlapping child has no arrow', () {
      geometry.value = (child: const Rect.fromLTWH(50, 50, 100, 100), portal: rect.size);
      expect(clip().getBounds(), rect);
    });

    test('alignment', () {
      geometry.value = (child: const Rect.fromLTWH(50, -50, 100, 50), portal: rect.size);
      expect(clip(alignment: const FPortalArrowAlignment.start(30)).contains(const Offset(30, -3)), true);
      expect(
        clip(alignment: const FPortalArrowAlignment.start(30), direction: .rtl).contains(const Offset(170, -3)),
        true,
      );
    });

    test('unsupported decoration paints without an arrow', () {
      geometry.value = (child: const Rect.fromLTWH(50, -50, 100, 50), portal: rect.size);
      for (final unsupported in [
        const BoxDecoration(
          border: Border(top: BorderSide(width: 2), bottom: BorderSide()),
        ),
        const ShapeDecoration(
          shape: RoundedRectangleBorder(side: BorderSide(strokeAlign: BorderSide.strokeAlignOutside)),
        ),
      ]) {
        final clip = FPortalArrowDecoration(
          decoration: unsupported,
          style: const FPortalArrowStyle(),
          geometry: geometry,
        ).getClipPath(rect, .ltr);
        expect(clip.contains(const Offset(100, -3)), false);
        expect(clip.getBounds(), unsupported.getClipPath(rect, .ltr).getBounds());
      }
    });

    test('equality', () {
      const style = FPortalArrowStyle();
      final a = FPortalArrowDecoration(decoration: decoration, style: style, geometry: geometry);
      final b = FPortalArrowDecoration(decoration: decoration, style: style, geometry: geometry);
      final other = ValueNotifier<FPortalGeometry?>(null);
      addTearDown(other.dispose);
      final c = FPortalArrowDecoration(decoration: decoration, style: style, geometry: other);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
    });
  });
}

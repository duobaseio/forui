import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'portal_arrow_decoration.design.dart';

/// A [FPortal]'s geometry after all transformations.
///
/// `child` is the linked child's rectangle relative to the portal's top-left corner.
typedef FPortalGeometry = ({Rect child, Size portal});

/// A [Decoration] that combines a portal's existing [decoration] with an arrow.
///
/// The arrow's direction and positioning is derived from [geometry] and painted outside of the decorated box.
///
/// ## Contract
/// The decorated box must be positioned at the portal's origin, e.g. no [Padding] around the portal's [DecoratedBox].
///
/// [decoration] must be a [ShapeDecoration] with an [OutlinedBorder] shape, or a [BoxDecoration] with a uniform border.
/// In addition, [decoration] must not have an image and the border must be [BorderSide.strokeAlignInside].
///
/// See:
/// * [FPortalArrowAlignment] for positioning the arrow along the edge.
class FPortalArrowDecoration extends Decoration {
  /// The arrow's style.
  final FPortalArrowStyle style;

  /// The wrapped decoration.
  final Decoration decoration;

  /// The arrow's position along the edge facing the child. Defaults to [FPortalArrowAlignment.childCenter].
  final FPortalArrowAlignment alignment;

  /// The portal's geometry.
  final ValueListenable<FPortalGeometry?> geometry;

  /// Creates a [FPortalArrowDecoration].
  factory({
    required FPortalArrowStyle style,
    required Decoration decoration,
    required ValueListenable<FPortalGeometry?> geometry,
    FPortalArrowAlignment alignment = .childCenter,
  }) {
    if (decoration.image != null) {
      return ._(style, decoration, geometry, alignment);
    }

    if (decoration case BoxDecoration(:final border?) when !border.isUniform) {
      return ._(style, decoration, geometry, alignment);
    }

    if (decoration.border case final OutlinedBorder shape when shape.side.strokeAlign == BorderSide.strokeAlignInside) {
      return _Arrow(shape, style, decoration, geometry, alignment);
    }

    return ._(style, decoration, geometry, alignment);
  }

  const new _(this.style, this.decoration, this.geometry, this.alignment);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      onChanged == null ? decoration.createBoxPainter() : decoration.createBoxPainter(onChanged);

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) => decoration.getClipPath(rect, textDirection);

  @override
  bool hitTest(Size size, Offset position, {TextDirection? textDirection}) =>
      decoration.hitTest(size, position, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get padding => decoration.padding;

  @override
  bool get isComplex => true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPortalArrowDecoration &&
          decoration == other.decoration &&
          style == other.style &&
          alignment == other.alignment &&
          identical(geometry, other.geometry);

  @override
  int get hashCode => Object.hash(decoration, style, alignment, identityHashCode(geometry));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('geometry', geometry));
  }
}

class const _Arrow(final OutlinedBorder shape, super.style, super.decoration, super.geometry, super.alignment)
    extends FPortalArrowDecoration {
  this : super._();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _Painter(this, onChanged);

  @override
  Path getClipPath(Rect rect, TextDirection direction, [double spread = 0]) {
    final outline = shape.getOuterPath(rect.inflate(spread), textDirection: direction);

    if (geometry.value case (:final child, :final portal)) {
      final box = Offset.zero & portal;
      final radius = decoration.borderRadius?.resolve(direction) ?? .zero;
      final inset = style.cornerSpacing + style.baseRadius + style.width / 2;

      double? along(Axis axis, double length, double start, double end, double childStart, double childEnd) =>
          alignment(
            axis: axis,
            direction: direction,
            length: length,
            min: start + inset,
            max: length - end - inset,
            childStart: childStart,
            childEnd: childEnd,
          );

      final (side, center) = switch (box) {
        _ when child.bottom <= box.top => (
          AxisDirection.up,
          along(.horizontal, box.width, radius.topLeft.x, radius.topRight.x, child.left, child.right),
        ),
        _ when box.bottom <= child.top => (
          AxisDirection.down,
          along(.horizontal, box.width, radius.bottomLeft.x, radius.bottomRight.x, child.left, child.right),
        ),
        _ when child.right <= box.left => (
          AxisDirection.left,
          along(.vertical, box.height, radius.topLeft.y, radius.bottomLeft.y, child.top, child.bottom),
        ),
        _ when box.right <= child.left => (
          AxisDirection.right,
          along(.vertical, box.height, radius.topRight.y, radius.bottomRight.y, child.top, child.bottom),
        ),
        _ => (null, null),
      };

      if (side != null && center != null) {
        return .combine(.union, outline, _arrow(rect, side, center, spread));
      }
    }

    return outline;
  }

  Path _arrow(Rect rect, AxisDirection side, double center, double spread) {
    const overlap = 1.0;

    final FPortalArrowStyle(:baseRadius, :tipRadius) = style;
    final (w, h) = (style.width / 2, style.height);
    final hyp = math.sqrt(w * w + h * h);
    // Offsetting both sides outwards by spread yields a similar triangle whose base sits on the inflated edge.
    final scale = 1 + spread * (hyp - w) / (w * h);
    final (half, height, hypotenuse) = (w * scale, h * scale, hyp * scale);

    // Built pointing up with the base centered on the origin, then rotated and translated onto the edge.
    final apex = Offset(0, -height);
    // Unit vector along the left side, from the base corner towards the apex.
    final up = Offset(half, -height) / hypotenuse;

    // Tip: r / tan(half-angle at apex) from the apex to where the arc meets each side.
    final tipTangent = tipRadius * height / half;
    final tipLeft = apex - up * tipTangent;
    final tipRight = Offset(-tipLeft.dx, tipLeft.dy);

    // Base: a circle of radius f tangent to both the edge (y = 0) and the side, centered outside the arrow. Both tangent
    // points are f * tan(corner angle / 2) from the base corner.
    final baseTangent = baseRadius * height / (hypotenuse + half);
    final baseLeft = Offset(-half, 0) + up * baseTangent;
    final baseRight = Offset(-baseLeft.dx, baseLeft.dy);
    final edgeLeft = Offset(-half - baseTangent, 0);
    final edgeRight = Offset(-edgeLeft.dx, 0);

    // A zero radius arc degenerates to a line, so no special-casing is needed when either radius is 0.
    final path = Path()
      ..moveTo(edgeLeft.dx, overlap)
      ..lineTo(edgeLeft.dx, edgeLeft.dy)
      ..arcToPoint(baseLeft, radius: .circular(baseRadius), clockwise: false)
      ..lineTo(tipLeft.dx, tipLeft.dy)
      ..arcToPoint(tipRight, radius: .circular(tipRadius))
      ..lineTo(baseRight.dx, baseRight.dy)
      ..arcToPoint(edgeRight, radius: .circular(baseRadius), clockwise: false)
      ..lineTo(edgeRight.dx, overlap)
      ..close();

    // The center is measured along the uninflated edge, so only the edge itself moves outwards by spread.
    final (angle, origin) = switch (side) {
      .up => (0.0, Offset(rect.left + center, rect.top - spread)),
      .right => (math.pi / 2, Offset(rect.right + spread, rect.top + center)),
      .down => (math.pi, Offset(rect.left + center, rect.bottom + spread)),
      .left => (3 * math.pi / 2, Offset(rect.left - spread, rect.top + center)),
    };

    return path.transform((Matrix4.translationValues(origin.dx, origin.dy, 0)..rotateZ(angle)).storage);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('shape', shape));
  }
}

class _Painter extends BoxPainter {
  final _Arrow _decoration;

  new(this._decoration, super.onChanged) {
    _decoration.geometry.addListener(_onChange);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final direction = configuration.textDirection ?? .ltr;
    final decoration = _decoration.decoration;
    final side = _decoration.shape.side;
    final outline = _decoration.getClipPath(rect, direction);

    for (final shadow in decoration.shadows ?? const <BoxShadow>[]) {
      final path = shadow.spreadRadius == 0 ? outline : _decoration.getClipPath(rect, direction, shadow.spreadRadius);
      canvas.drawPath(path.shift(shadow.offset), shadow.toPaint());
    }

    // Gradient shaders are created from the box's rect, so the arrow continues the gradient seamlessly.
    final fill = Paint();
    if (decoration.gradient case final gradient?) {
      fill.shader = gradient.createShader(rect, textDirection: direction);
    } else {
      fill.color = decoration.color ?? const Color(0x00000000);
    }
    canvas.drawPath(outline, fill);

    if (side case BorderSide(style: .solid, :final width) when 0 < width) {
      // Clipping to the outline and stroking at double width yields a uniform inside-aligned border.
      canvas
        ..save()
        ..clipPath(outline)
        ..drawPath(outline, side.toPaint()..strokeWidth = width * 2)
        ..restore();
    }
  }

  void _onChange() => onChanged?.call();

  @override
  void dispose() {
    _decoration.geometry.removeListener(_onChange);
    super.dispose();
  }
}

@internal
class GeometryNotifier([var FPortalGeometry? _value]) extends ValueNotifier<FPortalGeometry?> {
  this : super(null);

  @override
  FPortalGeometry? get value => _value;

  @override
  set value(FPortalGeometry? value) {
    if (_value == value) {
      return;
    }

    _value = value;
    SchedulerBinding.instance.addPostFrameCallback((_) => notifyListeners(), debugLabel: 'FPortalGeometry.notify');
  }
}


/// An arrow's shape.
///
/// ```diagram
///                 tipRadius
///                     ╭╮                  ▲
///                    ╱  ╲                 │
///                   ╱    ╲                │ height
///                  ╱      ╲               │
///                 ╱        ╲              │
/// ╭──────────────╯          ╰────────     ▼
/// │◄────────────► ◄────────►│
/// │ cornerSpacing   width   ╰ baseRadius
/// ```
class const FPortalArrowStyle({
  /// The minimum spacing between the arrow and the decoration's rounded corners. Defaults to 4.
  ///
  /// ## Contract
  /// Must be >= 0.
  @override final double cornerSpacing = 4,

  /// The radius of the rounded corners where the arrow's sides meet the decoration's edge. Defaults to 3.
  ///
  /// ## Contract
  /// Must be >= 0.
  @override final double baseRadius = 3,

  /// The base's width. Defaults to 14.
  ///
  /// ## Contract
  /// Must be > 0.
  @override final double width = 14,

  /// The height from base to tip. Defaults to 7.
  ///
  /// ## Contract
  /// Must be > 0.
  @override final double height = 7,

  /// The tip's radius. Defaults to 2.
  ///
  /// ## Contract
  /// Must be >= 0.
  @override final double tipRadius = 2,
}) with Diagnosticable, _$FPortalArrowStyleFunctions {
  /// Creates a [FPortalArrowStyle].
  this
    : assert(0 <= cornerSpacing, 'cornerSpacing ($cornerSpacing) must be >= 0.'),
      assert(0 <= baseRadius, 'baseRadius ($baseRadius) must be >= 0.'),
      assert(0 < width, 'width ($width) must be > 0.'),
      assert(0 < height, 'height ($height) must be > 0.'),
      assert(0 <= tipRadius, 'tipRadius ($tipRadius) must be >= 0.');
}

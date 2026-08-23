import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/overlay/composited_overlay.dart';

/// A `CompositedPointPortal` positions itself relative to a point inside a `CompositedChild`.
///
/// Unlike `CompositedPortal`, the anchor is a single [point] rather than a rectangle.
@internal
class const CompositedPointPortal({
  /// The portal's constraints.
  required final BoxConstraints constraints,

  /// The anchor point on the portal.
  required final Alignment anchor,

  /// The point within the linked `CompositedChild`'s local coordinate space at which to anchor the portal.
  required final Offset point,

  /// The padding.
  required final EdgeInsets padding,

  /// The spacing between the [point] and the [anchor] in the direction the portal extends.
  required final double spacing,

  /// The callback used to shift a portal when it overflows out of the viewport.
  ///
  /// Applied after [spacing] and before [offset].
  required final FPortalOverflow overflow,

  /// Additional translation to apply to the portal's position.
  ///
  /// It is applied after [overflow].
  required final Offset offset,
  required super.notifier,
  required super.link,
  super.showWhenUnlinked,
  super.key,
  super.child,
}) extends CompositedOverlay {
  @override
  RenderPointPortalLayer createRenderObject(BuildContext context) => RenderPointPortalLayer(
    notifier: notifier,
    link: link,
    viewSize: MediaQuery.sizeOf(context),
    showWhenUnlinked: showWhenUnlinked,
    portalConstraints: constraints,
    anchor: anchor,
    point: point,
    padding: padding,
    spacing: spacing,
    overflow: overflow,
    offset: offset,
  );

  @override
  void updateRenderObject(BuildContext context, RenderPointPortalLayer renderObject) => renderObject
    ..notifier = notifier
    ..link = link
    ..viewSize = MediaQuery.sizeOf(context)
    ..showWhenUnlinked = showWhenUnlinked
    ..portalConstraints = constraints
    ..anchor = anchor
    ..point = point
    ..padding = padding
    ..spacing = spacing
    ..overflow = overflow
    ..offset = offset;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('point', point))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset));
  }
}

/// A point-anchored sibling of `RenderPortalLayer`.
@internal
class RenderPointPortalLayer({
  required var BoxConstraints _portalConstraints,
  required var Alignment _anchor,
  required var Offset _point,
  required var EdgeInsets _padding,
  required var double _spacing,
  required var FPortalOverflow _overflow,
  required var Offset _offset,
  required super.notifier,
  required super.link,
  required super.viewSize,
  required super.showWhenUnlinked,
  super.child,
}) extends RenderOverlayLayer {
  @override
  void performLayout() {
    if (child case final child?) {
      child.layout(portalConstraints, parentUsesSize: true);
    }
    size = constraints.biggest;
  }

  @override
  Offset onPaint(PaintingContext _, Offset _) {
    final childOffset = link.childRenderBox?.localToGlobal(.zero);
    if (childOffset == null || child == null) {
      return .zero;
    }

    return offset +
        point +
        overflow(
          // There is NO guarantee that this render box's size is the window's size. Always use viewSize.
          // It's okay to use viewSize even though it's larger than the render box's size as we override paintBounds.
          Size(viewSize.width - padding.horizontal, viewSize.height - padding.vertical),
          (
            offset: Offset(childOffset.dx + point.dx - padding.left, childOffset.dy + point.dy - padding.top),
            size: .zero,
            anchor: .center,
          ),
          (offset: Offset(-anchor.x * spacing, -anchor.y * spacing), size: child!.size, anchor: anchor),
        );
  }

  /// The portal's constraints.
  BoxConstraints get portalConstraints => _portalConstraints;

  set portalConstraints(BoxConstraints value) {
    if (_portalConstraints == value) {
      return;
    }
    _portalConstraints = value;
    markNeedsLayout();
  }

  /// The anchor point on this render layer that lines up with [point] on the linked child.
  Alignment get anchor => _anchor;

  set anchor(Alignment value) {
    if (_anchor == value) {
      return;
    }
    _anchor = value;
    markNeedsPaint();
  }

  /// The point within the linked child's local coordinate space at which to anchor the portal.
  Offset get point => _point;

  set point(Offset value) {
    if (_point == value) {
      return;
    }
    _point = value;
    markNeedsPaint();
  }

  EdgeInsets get padding => _padding;

  set padding(EdgeInsets value) {
    if (_padding == value) {
      return;
    }
    _padding = value;
    markNeedsPaint();
  }

  double get spacing => _spacing;

  set spacing(double value) {
    if (_spacing == value) {
      return;
    }
    _spacing = value;
    markNeedsPaint();
  }

  FPortalOverflow get overflow => _overflow;

  set overflow(FPortalOverflow value) {
    if (_overflow == value) {
      return;
    }
    _overflow = value;
    markNeedsPaint();
  }

  /// Additional translation applied after [overflow].
  Offset get offset => _offset;

  set offset(Offset value) {
    if (_offset == value) {
      return;
    }
    _offset = value;
    markNeedsPaint();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('portalConstraints', portalConstraints))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('point', point))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset));
  }
}

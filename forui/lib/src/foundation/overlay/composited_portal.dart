import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/overlay/composited_child.dart';
import 'package:forui/src/foundation/overlay/composited_overlay.dart';
import 'package:forui/src/foundation/overlay/portal_constraints.dart';

/// A [CompositedPortal] positions itself relative to a [CompositedChild].
///
/// Unlike [CompositedOverlay], it additionally performs anchor alignment, overflow handling, and constraint switching.
@internal
class CompositedPortal extends CompositedOverlay {
  /// The portal's constraints.
  final FPortalConstraints constraints;

  /// The anchor point on the portal used for positioning relative to the [childAnchor].
  final Alignment portalAnchor;

  /// The anchor point on the [child] used for positioning relative to the [portalAnchor].
  final Alignment childAnchor;

  /// The padding.
  final EdgeInsets padding;

  /// The spacing between the [portalAnchor] and [childAnchor].
  final Offset spacing;

  /// The callback used to shift a portal when it overflows out of the viewport.
  ///
  /// Applied after [spacing] and before [offset].
  final FPortalOverflow overflow;

  /// Additional translation to apply to the portal's position.
  ///
  /// It is applied after [overflow].
  final Offset offset;

  const CompositedPortal({
    required this.constraints,
    required this.portalAnchor,
    required this.childAnchor,
    required this.padding,
    required this.spacing,
    required this.overflow,
    required this.offset,
    required super.notifier,
    required super.link,
    super.showWhenUnlinked,
    super.key,
    super.child,
  });

  @override
  RenderPortalLayer createRenderObject(BuildContext context) => RenderPortalLayer(
    notifier: notifier,
    link: link,
    viewSize: MediaQuery.sizeOf(context),
    showWhenUnlinked: showWhenUnlinked,
    portalConstraints: constraints,
    portalAnchor: portalAnchor,
    childAnchor: childAnchor,
    padding: padding,
    spacing: spacing,
    overflow: overflow,
    offset: offset,
  );

  @override
  void updateRenderObject(BuildContext context, RenderPortalLayer renderObject) => renderObject
    ..notifier = notifier
    ..link = link
    ..viewSize = MediaQuery.sizeOf(context)
    ..showWhenUnlinked = showWhenUnlinked
    ..portalConstraints = constraints
    ..portalAnchor = portalAnchor
    ..childAnchor = childAnchor
    ..padding = padding
    ..spacing = spacing
    ..overflow = overflow
    ..offset = offset;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset));
  }
}

/// Unlike [RenderOverlayLayer], this additionally performs anchor alignment, overflow handling, and constraint switching.
@internal
class RenderPortalLayer extends RenderOverlayLayer {
  FPortalConstraints _portalConstraints;
  Alignment _portalAnchor;
  Alignment _childAnchor;
  EdgeInsets _padding;
  Offset _spacing;
  FPortalOverflow _overflow;
  Offset _offset;

  RenderPortalLayer({
    required FPortalConstraints portalConstraints,
    required Alignment portalAnchor,
    required Alignment childAnchor,
    required EdgeInsets padding,
    required Offset spacing,
    required FPortalOverflow overflow,
    required Offset offset,
    required super.notifier,
    required super.link,
    required super.viewSize,
    required super.showWhenUnlinked,
    super.child,
  }) : _portalConstraints = portalConstraints,
       _portalAnchor = portalAnchor,
       _childAnchor = childAnchor,
       _padding = padding,
       _spacing = spacing,
       _overflow = overflow,
       _offset = offset;

  @override
  void performLayout() {
    if (child case final child?) {
      final size = link.childSize;
      final constraints = switch (portalConstraints) {
        final FixedConstraints constraints => constraints,
        FAutoHeightPortalConstraints(:final minWidth, :final maxWidth) => BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: size?.height ?? 0,
          maxHeight: size?.height ?? .infinity,
        ),
        FAutoWidthPortalConstraints(:final minHeight, :final maxHeight) => BoxConstraints(
          minWidth: size?.width ?? 0,
          maxWidth: size?.width ?? .infinity,
          minHeight: minHeight,
          maxHeight: maxHeight,
        ),
      };

      child.layout(constraints.normalize(), parentUsesSize: true);
    }

    size = constraints.biggest;
  }

  @override
  Offset onPaint(PaintingContext context, Offset offset) {
    assert(
      link.childSize != null || link.childLayer == null || childAnchor == .topLeft,
      '$link: layer is linked to ${link.childLayer} but a valid childSize is not set. '
      'childSize is required when childAnchor is not Alignment.topLeft '
      '(current value is $childAnchor).',
    );

    return this.offset +
        switch ((link.childRenderBox?.localToGlobal(.zero), link.childSize, child)) {
          (final childOffset?, final childSize?, final portal?) => overflow(
            // There is NO guarantee that this render box's size is the window's size. Always use viewSize.
            // It's okay to use viewSize even though it's larger than the render box's size as we override paintBounds.
            Size(viewSize.width - (padding.left + padding.right), viewSize.height - (padding.top + padding.bottom)),
            (
              offset: Offset(childOffset.dx - padding.left, childOffset.dy - padding.top),
              size: childSize,
              anchor: childAnchor,
            ),
            (offset: spacing, size: portal.size, anchor: portalAnchor),
          ),
          _ => Offset.zero,
        };
  }

  /// The portal's constraints.
  FPortalConstraints get portalConstraints => _portalConstraints;

  set portalConstraints(FPortalConstraints value) {
    if (_portalConstraints == value) {
      return;
    }
    _portalConstraints = value;
    markNeedsLayout();
  }

  /// The anchor point on this [RenderPortalLayer] that will line up with [portalAnchor] on the linked [RenderChildLayer].
  ///
  /// Defaults to [Alignment.topLeft].
  Alignment get portalAnchor => _portalAnchor;

  set portalAnchor(Alignment value) {
    if (_portalAnchor == value) {
      return;
    }
    _portalAnchor = value;
    markNeedsPaint();
  }

  /// The anchor point on the linked [RenderChildLayer] that [portalAnchor] will line up with.
  ///
  /// Defaults to [Alignment.topLeft].
  Alignment get childAnchor => _childAnchor;

  set childAnchor(Alignment value) {
    if (_childAnchor == value) {
      return;
    }
    _childAnchor = value;
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

  Offset get spacing => _spacing;

  set spacing(Offset value) {
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

  /// The offset to apply to the origin of the linked [RenderChildLayer] to obtain this render object's origin.
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
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset));
  }
}

// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/overlay/composited_child.dart';
import 'package:forui/src/foundation/overlay/layer.dart';

/// A [CompositedOverlay] positions itself at the origin of a [CompositedChild].
///
/// ## Implementation details:
/// This class is a copy of [CompositedTransformFollower] with the following enhancements:
/// * Receives the global position of a linked [CompositedChild].
@internal
class CompositedOverlay extends SingleChildRenderObjectWidget {
  /// The notifier that is updated whenever the linked [CompositedChild] changes its global position.
  final FChangeNotifier notifier;

  /// The link object that connects this [CompositedOverlay] with a [CompositedChild].
  final ChildLayerLink link;

  /// Whether to show the widget's contents when there is no corresponding [CompositedChild] with the same [link].
  final bool showWhenUnlinked;

  const CompositedOverlay({
    required this.notifier,
    required this.link,
    this.showWhenUnlinked = false,
    super.key,
    super.child,
  });

  @override
  RenderOverlayLayer createRenderObject(BuildContext context) => RenderOverlayLayer(
    notifier: notifier,
    link: link,
    viewSize: MediaQuery.sizeOf(context),
    showWhenUnlinked: showWhenUnlinked,
  );

  @override
  void updateRenderObject(BuildContext context, RenderOverlayLayer renderObject) => renderObject
    ..notifier = notifier
    ..link = link
    ..viewSize = MediaQuery.sizeOf(context)
    ..showWhenUnlinked = showWhenUnlinked;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('notifier', notifier))
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('showWhenUnlinked', showWhenUnlinked));
  }
}

/// A simplified version of `RenderPortalLayer` that composites at the child's origin without any positioning logic.
///
/// ## Implementation details:
/// This class is a copy of [RenderFollowerLayer] with the following differences/enhancements:
/// * Repaints whenever the linked [CompositedChild]'s globalOffset changes.
/// * Contains a [ChildLayerLink] instead of a [LayerLink].
/// * Changes the [paintBounds] to be the entire viewport.
@internal
class RenderOverlayLayer extends RenderProxyBox {
  FChangeNotifier _notifier;
  ChildLayerLink _link;
  Size _viewSize;
  bool _showWhenUnlinked;

  RenderOverlayLayer({
    required FChangeNotifier notifier,
    required ChildLayerLink link,
    required Size viewSize,
    required bool showWhenUnlinked,
    RenderBox? child,
  }) : _notifier = notifier,
       _link = link,
       _viewSize = viewSize,
       _showWhenUnlinked = showWhenUnlinked,
       super(child);

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    notifier.addListener(_schedule);
  }

  // Defers markNeedsLayout via scheduleTask because this is called during the child's paint, where calling
  // markNeedsLayout directly is not allowed. This means the overlay's layout may lag one frame behind the child's
  // size — see FOverlay's "Overlay positioning & child resizing" doc for details.
  void _schedule() => SchedulerBinding.instance.scheduleTask(markNeedsLayout, .touch);

  @override
  void performLayout() {
    if (child case final child?) {
      final childSize = link.childSize;
      final childConstraints = childSize != null ? BoxConstraints.tight(childSize) : constraints;
      child.layout(childConstraints, parentUsesSize: true);
    }
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final linkedOffset = onPaint(context, offset);

    if (layer == null) {
      layer = OverlayLayer(
        link: link,
        showWhenUnlinked: showWhenUnlinked,
        linkedOffset: linkedOffset,
        unlinkedOffset: offset,
      )..overlayRenderBox = this;
    } else {
      layer
        ?..link = link
        ..showWhenUnlinked = showWhenUnlinked
        ..linkedOffset = linkedOffset
        ..unlinkedOffset = offset
        ..overlayRenderBox = this;
    }

    context.pushLayer(
      layer!,
      super.paint,
      .zero,
      // We don't know where we'll end up, so we have no idea what our cull rect should be.
      childPaintBounds: const .fromLTRB(.negativeInfinity, .negativeInfinity, .infinity, .infinity),
    );

    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());
  }

  @protected
  Offset onPaint(PaintingContext context, Offset offset) => .zero;

  @override
  Rect get paintBounds => globalToLocal(Offset.zero) & viewSize;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // Disables the hit testing if this render object is hidden.
    if (link.childLayer == null && !showWhenUnlinked) {
      return false;
    }
    // RenderPortalLayer objects don't check if they are themselves hit, because it's confusing to think about how the
    // untransformed size and the child's transformed position interact.
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) => result.addWithPaintTransform(
    transform: _currentTransform,
    position: position,
    hitTest: (result, position) => super.hitTestChildren(result, position: position),
  );

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) => transform.multiply(_currentTransform);

  /// Return the transform that was used in the last composition phase, if any.
  ///
  /// If the [OverlayLayer] has not yet been created, was never composited, or was unable to determine the transform (see
  /// [OverlayLayer.getLastTransform]), this returns the identity matrix (see [Matrix4.identity]).
  Matrix4 get _currentTransform => layer?.getLastTransform() ?? .identity();

  @override
  void detach() {
    notifier.removeListener(_schedule);
    layer = null;
    super.detach();
  }

  @override
  bool get alwaysNeedsCompositing => true;

  /// The layer we created when we were last painted.
  @override
  OverlayLayer? get layer => super.layer as OverlayLayer?;

  FChangeNotifier get notifier => _notifier;

  set notifier(FChangeNotifier value) {
    if (_notifier == value) {
      return;
    }

    _notifier.removeListener(_schedule);
    _notifier = value;
    _notifier.addListener(_schedule);
  }

  ChildLayerLink get link => _link;

  set link(ChildLayerLink value) {
    if (_link == value) {
      return;
    }
    _link = value;
    markNeedsPaint();
  }

  Size get viewSize => _viewSize;

  set viewSize(Size value) {
    if (_viewSize == value) {
      return;
    }

    _viewSize = value;
    markNeedsPaint();
  }

  /// Whether to show the render object's contents when there is no corresponding [RenderChildLayer] with the same [link].
  ///
  /// When the render object is linked, the child is positioned such that it has the same global position as the linked
  /// [RenderChildLayer].
  ///
  /// When the render object is not linked, then: if [showWhenUnlinked] is true, the child is visible and not
  /// repositioned; if it is false, then child is hidden, and its hit testing is also disabled.
  bool get showWhenUnlinked => _showWhenUnlinked;

  set showWhenUnlinked(bool value) {
    if (_showWhenUnlinked == value) {
      return;
    }
    _showWhenUnlinked = value;
    markNeedsPaint();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('notifier', notifier))
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('viewSize', viewSize))
      ..add(DiagnosticsProperty('showWhenUnlinked', showWhenUnlinked));
  }
}

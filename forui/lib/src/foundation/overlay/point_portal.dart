import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/overlay/composited_child.dart';
import 'package:forui/src/foundation/overlay/composited_point_portal.dart';
import 'package:forui/src/foundation/overlay/layer.dart';
import 'package:forui/src/foundation/overlay/overlay_controller.dart';

/// A portal that "floats" on top of a child widget, anchored at a specific [point] within the child's local coordinate
/// space.
///
/// Use this when the anchor is a single point such as a cursor location for a context menu, a glyph position for a
/// tooltip, or a touch position. For bounds-anchored overlays, use [FPortal] instead.
///
/// See:
/// * https://forui.dev/docs/widgets/foundation/point-portal for working examples.
/// * [FOverlay] for an overlay without built-in positioning and overflow handling.
/// * [FPortal] for a portal that anchors relative to the child's bounds.
/// * [FPortalOverflow] for handling viewport overflow.
/// * [OverlayPortalController] for controlling the portal's visibility.
class FPointPortal extends StatefulWidget {
  /// The control.
  final FOverlayControl control;

  /// The portal's size constraints. Defaults to no constraints.
  final BoxConstraints constraints;

  /// The point within the [child]'s local coordinate space at which to anchor the portal.
  final Offset point;

  /// The anchor point on the portal used for positioning relative to [point].
  ///
  /// For example, with `anchor: Alignment.topLeft`, the portal's top-left corner lines up with [point].
  ///
  /// ```diagram
  ///   • point
  ///    ┌────────┐
  ///    │ portal │
  ///    └────────┘
  /// ```
  ///
  /// Defaults to [Alignment.topLeft].
  final AlignmentGeometry anchor;

  /// The gap, in logical pixels, between [point] and the portal's [anchor].
  ///
  /// The direction is implied by [anchor]. For example, given a spacing of 4 and a [Alignment.topLeft] [anchor],
  /// the portal will be positioned 4 pixels down and to the right of [point].
  ///
  /// ```diagram
  ///   • point
  ///     ↘ 4px
  ///       ┌────────┐
  ///       │ portal │
  ///       └────────┘
  /// ```
  ///
  /// Applied before [overflow].
  ///
  /// Defaults to `0`.
  final double spacing;

  /// The callback used to shift a portal when it overflows out of the viewport.
  ///
  /// Applied after [spacing] and before [offset].
  ///
  /// Defaults to [FPortalOverflow.flip].
  /// See [FPortalOverflow] for the different overflow strategies.
  final FPortalOverflow overflow;

  /// Additional translation to apply to the portal's position.
  ///
  /// Applied after [overflow].
  ///
  /// Defaults to [Offset.zero].
  final Offset offset;

  /// {@macro forui.foundation.FPortal.useViewPadding}
  ///
  /// Defaults to true.
  final bool useViewPadding;

  /// {@macro forui.foundation.FPortal.useViewInsets}
  ///
  /// Defaults to true.
  final bool useViewInsets;

  /// {@macro forui.foundation.FPortal.padding}
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry padding;

  /// An optional barrier builder that is displayed behind the portal.
  final Widget Function(RenderBox? cutout)? barrier;

  /// The portal builder which returns the floating content.
  final Widget Function(BuildContext context, OverlayPortalController controller) portalBuilder;

  /// {@macro forui.foundation.overlay.builder}
  final ValueWidgetBuilder<OverlayPortalController> builder;

  /// The child which the portal is anchored within.
  final Widget? child;

  /// Creates a point-anchored portal.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const FPointPortal({
    required this.portalBuilder,
    required this.point,
    this.control = const .managed(),
    this.constraints = const BoxConstraints(),
    this.anchor = .topLeft,
    this.spacing = 0,
    this.overflow = .flip,
    this.offset = .zero,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.padding = .zero,
    this.barrier,
    this.builder = FOverlay.defaultBuilder,
    this.child,
    super.key,
  }) : assert(builder != FOverlay.defaultBuilder || child != null, 'Either builder or child must be provided');

  @override
  State<FPointPortal> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('point', point))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DoubleProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ObjectFlagProperty.has('barrier', barrier))
      ..add(ObjectFlagProperty.has('portalBuilder', portalBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FPointPortal> with WidgetsBindingObserver {
  final _notifier = FChangeNotifier();
  final _link = ChildLayerLink();
  late OverlayPortalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant FPointPortal old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller).$1;
  }

  @override
  void didChangeMetrics() {
    // A portal shown under an ancestor that absorbs the view insets (e.g. a Material Scaffold with
    // resizeToAvoidBottomInset removes the bottom inset via MediaQuery.removeViewInsets) is not notified when the
    // keyboard opens, as the absorbed MediaQuery no longer changes. Rebuild on metrics changes so
    // MediaQuery.viewInsetsOf is re-read and the portal stays clear of the keyboard.
    if (_controller.isShowing) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => CompositedChild(
    notifier: _notifier,
    link: _link,
    child: OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) {
        final direction = Directionality.maybeOf(context) ?? .ltr;

        final view = View.of(context);
        final EdgeInsets padding = widget.useViewPadding
            ? .fromViewPadding(view.viewPadding, view.devicePixelRatio)
            : .zero;

        final insets = widget.useViewInsets ? MediaQuery.viewInsetsOf(context) : EdgeInsets.zero;

        Widget portal = CompositedPointPortal(
          notifier: _notifier,
          link: _link,
          constraints: widget.constraints,
          anchor: widget.anchor.resolve(direction),
          point: widget.point,
          padding:
              EdgeInsets.only(
                left: math.max(padding.left, insets.left),
                top: math.max(padding.top, insets.top),
                right: math.max(padding.right, insets.right),
                bottom: math.max(padding.bottom, insets.bottom),
              ) +
              widget.padding.resolve(direction),
          spacing: widget.spacing,
          overflow: widget.overflow,
          offset: widget.offset,
          child: widget.portalBuilder(context, _controller),
        );

        if (widget.barrier case final barrier?) {
          // Known limitation: semantics blocking does not work correctly here. The barrier and portal content share the
          // same parent semantics container in the overlay. BlockSemantics(blocking: true) in FModalBarrier affects all
          // siblings in the same container, which blocks portal content semantics too. Wrapping in
          // Semantics(container: true) contains the blocking effect but also disables it for page content. Both
          // restructuring approaches (widget tree and separate overlay entries) were explored but are impractical.
          portal = BlockSemantics(
            blocking: false,
            child: Stack(
              children: [
                Semantics(container: true, child: barrier(_link.childRenderBox)),
                portal,
              ],
            ),
          );
        }

        // Prevents the portal from inheriting FTappableGroups in the widget.builder/widget.child since FTappableGroup
        // does not hit test across layers.
        return FTappableGroup.isolate(child: portal);
      },
      child: RepaintBoundary(child: widget.builder(context, _controller, widget.child)),
    ),
  );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notifier.dispose();
    super.dispose();
  }
}

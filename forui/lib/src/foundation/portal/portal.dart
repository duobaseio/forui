import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/portal/composited_child.dart';
import 'package:forui/src/foundation/portal/composited_portal.dart';
import 'package:forui/src/foundation/portal/layer.dart';

/// A portal that "floats" on top of and relative to a [child] widget.
///
/// See:
/// * [FPortalOverflow] for handling viewport overflow.
/// * [OverlayPortalController] for controlling the portal's visibility.
/// * [Visualization](http://forui.dev/docs/foundation/portal#visualization) for a visual demonstration of how
///   portals work.
class FPortal extends StatefulWidget {
  /// The default builder that returns the child as-is.
  static Widget defaultBuilder(BuildContext _, OverlayPortalController _, Widget? child) => child!;

  /// The controller.
  final OverlayPortalController? controller;

  /// The portal's size constraints.
  final FPortalConstraints constraints;

  /// The anchor point on the portal used for positioning relative to the [childAnchor].
  ///
  /// For example, with `portalAnchor: Alignment.topCenter` and `childAnchor: Alignment.bottomCenter`,
  /// the portal's top edge will align with the child's bottom edge.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry portalAnchor;

  /// The anchor point on the [child] used for positioning relative to the [portalAnchor].
  ///
  /// For example, with `childAnchor: Alignment.bottomCenter` and `portalAnchor: Alignment.topCenter`,
  /// the child's bottom edge will align with the portal's top edge.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

  /// The spacing between the [portalAnchor] and [childAnchor].
  ///
  /// Applied before [overflow].
  ///
  /// Defaults to [FPortalSpacing.zero].
  final FPortalSpacing spacing;

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

  /// {@template forui.foundation.FPortal.useViewPadding}
  /// Whether to avoid [MediaQueryData.viewPadding] (static safe areas like the notch and status bar).
  /// {@endtemplate}
  ///
  /// Defaults to true.
  final bool useViewPadding;

  /// {@template forui.foundation.FPortal.useViewInsets}
  /// Whether to avoid [MediaQueryData.viewInsets] (the soft keyboard).
  /// {@endtemplate}
  ///
  /// Defaults to true.
  final bool useViewInsets;

  /// {@template forui.foundation.FPortal.padding}
  /// The additional padding between the edges of the view and the edges of the portal.
  ///
  /// This is applied on top of any padding from [useViewPadding] and [useViewInsets].
  /// {@endtemplate}
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry padding;

  /// An optional barrier widget that is displayed behind the portal.
  final Widget? barrier;

  /// The portal builder which returns the floating content.
  final Widget Function(BuildContext context, OverlayPortalController controller) portalBuilder;

  /// An optional builder which returns the child widget that the portal is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [builder] builds doest not require the controller.
  final ValueWidgetBuilder<OverlayPortalController> builder;

  /// The child which the portal is aligned to.
  final Widget? child;

  /// Creates a portal.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const FPortal({
    required this.portalBuilder,
    this.controller,
    this.constraints = const FPortalConstraints(),
    this.portalAnchor = .topCenter,
    this.childAnchor = .bottomCenter,
    this.spacing = .zero,
    this.overflow = .flip,
    this.offset = .zero,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.padding = .zero,
    this.barrier,
    this.builder = defaultBuilder,
    this.child,
    super.key,
  }) : assert(builder != defaultBuilder || child != null, 'Either builder or child must be provided');

  @override
  State<FPortal> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ObjectFlagProperty.has('portalBuilder', portalBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FPortal> {
  final _notifier = FChangeNotifier();
  final _link = ChildLayerLink();
  late OverlayPortalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? .new();
  }

  @override
  void didUpdateWidget(covariant FPortal old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller = widget.controller ?? .new();
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
        final portalAnchor = widget.portalAnchor.resolve(direction);
        final childAnchor = widget.childAnchor.resolve(direction);

        final padding = widget.useViewPadding ? MediaQuery.viewPaddingOf(context) : EdgeInsets.zero;
        final insets = widget.useViewInsets ? MediaQuery.viewInsetsOf(context) : EdgeInsets.zero;

        Widget portal = CompositedPortal(
          notifier: _notifier,
          link: _link,
          constraints: widget.constraints,
          portalAnchor: portalAnchor,
          childAnchor: childAnchor,
          padding:
              EdgeInsets.only(
                left: math.max(padding.left, insets.left),
                top: math.max(padding.top, insets.top),
                right: math.max(padding.right, insets.right),
                bottom: math.max(padding.bottom, insets.bottom),
              ) +
              widget.padding.resolve(direction),
          spacing: widget.spacing(childAnchor, portalAnchor),
          overflow: widget.overflow,
          offset: widget.offset,
          child: widget.portalBuilder(context, _controller),
        );

        if (widget.barrier case final barrier?) {
          portal = Stack(children: [barrier, portal]);
        }

        // Prevents the portal from inheriting FTappableGroups in the widget.builder/widget.child since
        // FTappableGroup does not hit test across layers.
        return FTappableGroup.isolate(child: portal);
      },
      child: RepaintBoundary(child: widget.builder(context, _controller, widget.child)),
    ),
  );

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}

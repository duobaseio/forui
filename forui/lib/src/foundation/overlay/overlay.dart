import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/overlay/composited_child.dart';
import 'package:forui/src/foundation/overlay/composited_overlay.dart';
import 'package:forui/src/foundation/overlay/layer.dart';

/// The signature for [FOverlay.overlayBuilder].
typedef FOverlayBuilder =
    List<Widget> Function(
      BuildContext context,
      OverlayPortalController controller,
      RenderBox? childRenderBox,
      List<Widget> overlay,
    );

/// A low-level overlay primitive that composites content relative to a child widget using [Positioned]/
/// [AnimatedPositioned]s similar to a [Stack].
///
/// Unlike a [Stack], its children can overflow outside of the bounds and still receive hit events. Since the children
/// are rendered in an overlay, they will not be painted over by widgets in the same layer as the [builder]/[child].
///
/// ```dart
/// FOverlay(
///   controller: controller,
///   overlay: [
///     Positioned(
///       top: -40, // 40px above the child's top edge
///       left: 0,
///       child: Text('Overlay'),
///     ),
///   ],
///   child: const SizedBox.square(dimension: 40),
/// )
/// ```
///
/// ## Overlay positioning & child resizing
/// As the overlay is laid out before the child, it will be positioned based on the previous frame's child size. Resizing
/// a child while showing the [Positioned] overlay widgets may cause them to flicker. To avoid this, do not use
/// [Positioned.right] and [Positioned.bottom] in conjunction with a resizing child.
///
/// ```dart
/// // Bad - bottom depends on stale child height, causing flicker.
/// FOverlay(
///   overlay: [
///     Positioned(
///       bottom: -22,
///       child: handle,
///     ),
///   ],
///   child: child,
/// )
/// ```
///
/// ```dart
/// // Good - use top with a known child height since the overlay's origin tracks the child.
/// FOverlay(
///   overlay: [
///     Positioned(
///       top: childHeight - 22,
///       child: handle,
///     ),
///   ],
///   child: SizedBox(height: childHeight, child: child),
/// )
/// ```
///
/// See:
/// * [FPortal] for a higher-level overlay with anchor alignment, overflow handling, and spacing.
/// * [OverlayPortalController] for controlling the overlay's visibility.
class FOverlay extends StatefulWidget {
  /// The default overlay builder that returns the overlay widgets as-is.
  static List<Widget> defaultOverlayBuilder(
    BuildContext _,
    OverlayPortalController _,
    RenderBox? _,
    List<Widget> overlay,
  ) => overlay;

  /// The default builder that returns the child as-is.
  static Widget defaultBuilder(BuildContext _, OverlayPortalController _, Widget? child) => child!;

  /// The controller for showing/hiding the overlay.
  final OverlayPortalController? controller;

  /// The widgets to overlay on the child.
  ///
  /// Works like [Stack.children] — use [Positioned] widgets to position content relative to the child's bounds.
  /// Content can overflow the child's bounds and still receive hit events.
  final List<Widget> overlay;

  /// A builder that transforms [overlay] widgets before they are displayed.
  ///
  /// Receives the [BuildContext], the [OverlayPortalController], the child's [RenderBox] (or null if not yet laid out),
  /// and the [overlay] widgets. Returns the final list of widgets to display in the overlay [Stack].
  ///
  /// Defaults to returning [overlay] as-is.
  final FOverlayBuilder overlayBuilder;

  /// {@template forui.foundation.overlay.builder}
  /// An optional builder for the child widget.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// The [child] can be null if the entire widget subtree the [builder] builds does not require the controller.
  /// {@endtemplate}
  final ValueWidgetBuilder<OverlayPortalController> builder;

  /// The child widget that the overlay is relative to.
  final Widget? child;

  /// Creates a low-level overlay.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const FOverlay({
    required this.overlay,
    this.controller,
    this.overlayBuilder = defaultOverlayBuilder,
    this.builder = defaultBuilder,
    this.child,
    super.key,
  }) : assert(builder != defaultBuilder || child != null, 'Either builder or child must be provided');

  @override
  State<FOverlay> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(ObjectFlagProperty.has('overlayBuilder', overlayBuilder))
      ..add(IterableProperty('overlay', overlay))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FOverlay> {
  final _notifier = FChangeNotifier();
  final _link = ChildLayerLink();
  late OverlayPortalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? .new();
  }

  @override
  void didUpdateWidget(covariant FOverlay old) {
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
      // Prevents the portal from inheriting FTappableGroups in the widget.builder/widget.child since FTappableGroup
      // does not hit test across layers.
      overlayChildBuilder: (context) => FTappableGroup.isolate(
        child: CompositedOverlay(
          notifier: _notifier,
          link: _link,
          child: _UnclippedStack(
            children: widget.overlayBuilder(context, _controller, _link.childRenderBox, widget.overlay),
          ),
        ),
      ),
      child: RepaintBoundary(child: widget.builder(context, _controller, widget.child)),
    ),
  );

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}

/// A [Stack] that does not clip hit testing to its own bounds.
///
/// This is fine since the [Stack] is rendered in an overlay layer that is hit tested independently of the child widget.
/// It is a simple way to implement positioning relative to the child widget without re-inventing the stack protocol.
class _UnclippedStack extends Stack {
  const _UnclippedStack({super.children}) : super(clipBehavior: .none);

  @override
  RenderStack createRenderObject(BuildContext context) =>
      _RenderUnclippedStack(textDirection: Directionality.maybeOf(context), clipBehavior: .none);
}

class _RenderUnclippedStack extends RenderStack {
  _RenderUnclippedStack({super.textDirection, super.clipBehavior});

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) => hitTestChildren(result, position: position);
}

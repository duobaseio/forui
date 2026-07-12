import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/inner_path_clipper.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';
import 'package:forui/src/widgets/popover_menu/popover_menu.dart';

/// A context menu displays a menu at the user's pointer.
///
/// ## Note
/// [BrowserContextMenu.disableContextMenu] needs to be called manually on web platforms to prevent the browser's native
/// context menu from appearing.
///
/// See:
/// * https://forui.dev/docs/widgets/overlay/context-menu for working examples.
/// * [FPopoverMenu] for a menu that is toggled by a child widget.
/// * [FPopoverMenuStyle] for customizing the menu's appearance.
class FContextMenu extends StatefulWidget {
  /// Defines how the context menu's shown state is controlled.
  ///
  /// Defaults to [FPopoverControl.managed] which creates an internal [FPopoverController].
  final FPopoverControl control;

  /// The context menu's style.
  final FPopoverMenuStyleDelta style;

  /// {@macro forui.widgets.FTileGroup.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.widgets.FTileGroup.scrollCacheExtent}
  final ScrollCacheExtent? scrollCacheExtent;

  /// {@macro forui.widgets.FTileGroup.maxHeight}
  final double maxHeight;

  /// Whether the menu should intrinsically size to the widest child. Defaults to true.
  final bool intrinsicWidth;

  /// {@macro forui.widgets.FTileGroup.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.widgets.FTileGroup.divider}
  ///
  /// Defaults to [FItemDivider.full].
  final FItemDivider divider;

  /// The anchor point on the menu used for positioning relative to the gesture point.
  ///
  /// Defaults to [Alignment.topLeft].
  final AlignmentGeometry menuAnchor;

  /// The gap between the gesture point and the menu's [menuAnchor]. Defaults to 0.
  final double spacing;

  /// {@macro forui.widgets.FPopover.overflow}
  ///
  /// Defaults to [FPortalOverflow.flip].
  final FPortalOverflow overflow;

  /// {@macro forui.foundation.FPortal.useViewPadding}
  ///
  /// Defaults to true.
  final bool useViewPadding;

  /// {@macro forui.foundation.FPortal.useViewInsets}
  ///
  /// Defaults to true.
  final bool useViewInsets;

  /// {@macro forui.widgets.FPopover.offset}
  ///
  /// Defaults to [Offset.zero].
  ///
  /// Defaults to [Offset.zero].
  final Offset offset;

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? groupId;

  /// {@macro forui.widgets.FPopover.hideRegion}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  final FPopoverHideRegion hideRegion;

  /// {@macro forui.widgets.FPopover.onTapHide}
  ///
  /// This is only called if [hideRegion] is set to [FPopoverHideRegion.anywhere] or [FPopoverHideRegion.excludeChild].
  final VoidCallback? onTapHide;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool? autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.widgets.FPopover.traversalEdgeBehavior}
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@macro forui.widgets.FPopover.barrierSemanticsLabel}
  final String? barrierSemanticsLabel;

  /// {@macro forui.widgets.FPopover.barrierSemanticsDismissible}
  final bool barrierSemanticsDismissible;

  /// {@macro forui.widgets.FPopover.cutout}
  final bool cutout;

  /// {@macro forui.widgets.FPopover.cutoutBuilder}
  final void Function(Path path, Rect bounds) cutoutBuilder;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// Whether the parent menu fades when a submenu is active.
  ///
  /// Defaults to true on touch platforms and false on desktop.
  final bool? faded;

  /// Whether a long press triggers the context menu.
  ///
  /// Defaults to true on touch platforms and false on desktop.
  final bool? longPress;

  /// Whether a secondary press (e.g. right-click) triggers the context menu.
  ///
  /// Defaults to true on desktop platforms and false on touch.
  final bool? secondaryPress;

  /// {@macro forui.widgets.FPopover.builder}
  final ValueWidgetBuilder<FPopoverController> builder;

  /// The child that acts as the trigger region.
  ///
  /// Passed to [builder] if provided.
  final Widget? child;

  final Widget Function(BuildContext context, FPopoverController controller, FPopoverMenuStyle style) _menuBuilder;

  /// Creates a context menu of [FItem]s.
  ///
  /// ## Contract
  /// Throws [AssertionError] if neither [menuBuilder] nor [menu] is provided.
  FContextMenu({
    this.control = const .managed(),
    this.style = const .context(),
    this.scrollController,
    this.scrollCacheExtent,
    this.maxHeight = .infinity,
    this.intrinsicWidth = true,
    this.dragStartBehavior = .start,
    this.divider = .full,
    this.menuAnchor = .topLeft,
    this.spacing = 0,
    this.overflow = .flip,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.offset = .zero,
    this.groupId,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.cutout = false,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.faded,
    this.longPress,
    this.secondaryPress,
    this.builder = FPopover.defaultBuilder,
    this.child,
    List<FItemGroupMixin> Function(BuildContext context, FPopoverController controller, List<FItemGroupMixin>? menu)
        menuBuilder =
        FPopoverMenu.defaultItemBuilder,
    List<FItemGroupMixin>? menu,
    super.key,
  }) : assert(builder != FPopover.defaultBuilder || child != null, 'Either builder or child must be provided'),
       _menuBuilder = ((context, controller, style) => FItemGroup.merge(
         scrollController: scrollController,
         scrollCacheExtent: scrollCacheExtent,
         maxHeight: maxHeight,
         intrinsicWidth: intrinsicWidth,
         dragStartBehavior: dragStartBehavior,
         semanticsLabel: semanticsLabel,
         style: style.itemGroupStyle,
         divider: divider,
         children: menuBuilder(context, controller, menu),
       )),
       assert(
         menuBuilder != FPopoverMenu.defaultItemBuilder || menu != null,
         'Either menuBuilder or menu must be provided',
       );

  /// Creates a context menu of [FTile]s.
  ///
  /// ## Contract
  /// Throws [AssertionError] if neither [menuBuilder] nor [menu] is provided.
  FContextMenu.tiles({
    this.control = const .managed(),
    this.style = const .context(),
    this.scrollController,
    this.scrollCacheExtent,
    this.maxHeight = .infinity,
    this.intrinsicWidth = true,
    this.dragStartBehavior = .start,
    this.divider = .full,
    this.menuAnchor = .topLeft,
    this.spacing = 0,
    this.overflow = .flip,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.offset = .zero,
    this.groupId,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.cutout = false,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.faded,
    this.longPress,
    this.secondaryPress,
    this.builder = FPopover.defaultBuilder,
    this.child,
    List<FTileGroupMixin> Function(BuildContext context, FPopoverController controller, List<FTileGroupMixin>? menu)
        menuBuilder =
        FPopoverMenu.defaultTileBuilder,
    List<FTileGroupMixin>? menu,
    super.key,
  }) : assert(builder != FPopover.defaultBuilder || child != null, 'Either builder or child must be provided'),
       _menuBuilder = ((context, controller, style) => FTileGroup.merge(
         scrollController: scrollController,
         scrollCacheExtent: scrollCacheExtent,
         maxHeight: maxHeight,
         intrinsicWidth: intrinsicWidth,
         dragStartBehavior: dragStartBehavior,
         semanticsLabel: semanticsLabel,
         style: style.tileGroupStyle,
         divider: divider,
         children: menuBuilder(context, controller, menu),
       )),
       assert(
         menuBuilder != FPopoverMenu.defaultTileBuilder || menu != null,
         'Either menuBuilder or menu must be provided',
       );

  @override
  State<FContextMenu> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('scrollCacheExtent', scrollCacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(FlagProperty('intrinsicWidth', value: intrinsicWidth, ifTrue: 'intrinsicWidth'))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DoubleProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(StringProperty('barrierSemanticsLabel', barrierSemanticsLabel))
      ..add(FlagProperty('barrierSemanticsDismissible', value: barrierSemanticsDismissible, ifTrue: 'dismissible'))
      ..add(FlagProperty('cutout', value: cutout, ifTrue: 'cutout'))
      ..add(ObjectFlagProperty.has('cutoutBuilder', cutoutBuilder))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(FlagProperty('faded', value: faded, ifTrue: 'faded'))
      ..add(FlagProperty('longPress', value: longPress, ifTrue: 'longPress'))
      ..add(FlagProperty('secondaryPress', value: secondaryPress, ifTrue: 'secondaryPress'))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FContextMenu> with TickerProviderStateMixin {
  final ValueNotifier<(Key?, bool)> _active = ValueNotifier((null, false));
  late Object _groupId = widget.groupId ?? UniqueKey();
  late FPopoverController _controller;
  FocusScopeNode? _focusNode;
  Offset _point = .zero;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange, this);
    _focusNode =
        widget.focusNode ??
        .new(debugLabel: 'FContextMenu', traversalEdgeBehavior: widget.traversalEdgeBehavior ?? .closedLoop);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.updateMotion(_style.motion);
  }

  FPopoverMenuStyle get _style => widget.style(context.theme.popoverMenuStyle);

  @override
  void didUpdateWidget(covariant FContextMenu old) {
    super.didUpdateWidget(old);
    if (widget.groupId != old.groupId) {
      _groupId = widget.groupId ?? UniqueKey();
    }

    if (widget.focusNode != old.focusNode || widget.traversalEdgeBehavior != old.traversalEdgeBehavior) {
      if (old.focusNode == null) {
        _focusNode?.dispose();
      }

      _focusNode =
          widget.focusNode ??
          .new(debugLabel: 'FContextMenu', traversalEdgeBehavior: widget.traversalEdgeBehavior ?? .closedLoop);
    }

    _controller = widget.control.update(old.control, _controller, _handleOnChange, this).$1;
    _controller.updateMotion(_style.motion);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    widget.control.dispose(_controller, _handleOnChange);
    _active.dispose();
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FPopoverManagedControl(:final onChange?)) {
      onChange(_controller.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _style;
    final direction = Directionality.maybeOf(context) ?? .ltr;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final touch = context.platformVariant.touch;
    final menuAnchor = widget.menuAnchor.resolve(direction);
    final motion = context.accessibility.motion;
    final fade = widget.faded ?? touch;
    final secondaryPress = widget.secondaryPress ?? !touch;
    final longPress = widget.longPress ?? touch;

    Widget child = widget.builder(context, _controller, widget.child);

    child = Listener(
      onPointerDown: (e) {
        if (secondaryPress && e.buttons & kSecondaryButton != 0) {
          _show((context.findRenderObject()! as RenderBox).globalToLocal(e.position));
        } else if (e.buttons & kPrimaryButton != 0) {
          _hide();
        }
      },
      child: child,
    );

    if (longPress) {
      child = GestureDetector(
        onLongPressStart: (d) {
          unawaited(style.hapticFeedback());
          _show(d.localPosition);
        },
        behavior: .translucent,
        child: child,
      );
    }

    if (widget.hideRegion == .excludeChild) {
      child = TapRegion(
        groupId: _groupId,
        onTapOutside: style.barrierFilter != null ? null : (_) => _hide(),
        child: child,
      );
    }

    return BackdropGroup(
      child: FPointPortal(
        control: .managed(controller: _controller.overlay),
        point: _point,
        anchor: menuAnchor,
        constraints: BoxConstraints(minWidth: style.minWidth, maxWidth: style.maxWidth),
        spacing: widget.spacing,
        overflow: widget.overflow,
        offset: widget.offset,
        useViewPadding: widget.useViewPadding,
        useViewInsets: widget.useViewInsets,
        padding: style.popoverPadding,
        barrier: style.barrierFilter == null
            ? null
            : (cutout) => TapRegion(
                groupId: widget.groupId,
                child: FAnimatedModalBarrier(
                  cutout: widget.cutout ? cutout : null,
                  cutoutBuilder: widget.cutoutBuilder,
                  animation: _controller.fade,
                  filter: style.barrierFilter!,
                  semanticsLabel: widget.barrierSemanticsLabel ?? localizations.barrierLabel,
                  barrierSemanticsDismissible: widget.barrierSemanticsDismissible,
                  semanticsOnTapHint: localizations.barrierOnTapHint(localizations.contextMenuSemanticsLabel),
                  onDismiss: widget.hideRegion == .none ? null : _hide,
                ),
              ),
        portalBuilder: (context, _) {
          Widget popover = Semantics(
            label: widget.semanticsLabel,
            container: true,
            child: FocusScope(
              autofocus: widget.autofocus ?? (style.barrierFilter != null),
              node: _focusNode,
              onFocusChange: widget.onFocusChange,
              child: TapRegion(
                groupId: _groupId,
                onTapOutside: widget.hideRegion == .none || style.barrierFilter != null ? null : (_) => _hide(),
                child: DecoratedBox(
                  decoration: style.decoration,
                  child: ClipPath(
                    clipper: InnerPathClipper(decoration: style.decoration, direction: direction),
                    child: PopoverMenuScope(
                      controller: _controller,
                      style: style,
                      groupId: _groupId,
                      active: _active,
                      // The default behavior for non-submenu trigger items.
                      child: FInheritedItemCallbacks(
                        onHoverEnter: () => _active.value = (null, false),
                        onPress: () => _active.value = (null, false),
                        onLongPress: () => _active.value = (null, false),
                        // We explicitly wrap this in a `FInheritedItemData` to prevent any ancestor data from
                        // accidentally leaking into the popover menu's items.
                        //
                        // ItemGroupStyles and ItemStyles are inherited by explicitly passing the style to _menuBuilder.
                        child: FInheritedItemData(
                          child: ValueListenableBuilder(
                            valueListenable: _active,
                            builder: (_, value, child) => AnimatedOpacity(
                              opacity: (!fade || value.$1 == null) ? 1.0 : style.menuMotion.fade,
                              duration: style.menuMotion.fadeDuration,
                              curve: style.menuMotion.fadeCurve,
                              child: child,
                            ),
                            child: widget._menuBuilder(context, _controller, style),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          if (motion != .disabled) {
            popover = FadeTransition(opacity: _controller.fade, child: popover);
          }

          if (motion == .all) {
            popover = ScaleTransition(alignment: menuAnchor, scale: _controller.scale, child: popover);
          }

          // The background filter cannot be nested in a FadeTransition because of https://github.com/flutter/flutter/issues/31706.
          if (style.backgroundFilter case final filter?) {
            // Confine the filter to the decoration: `.passthrough` matches its size, `ClipPath` its rounded shape.
            popover = Stack(
              fit: .passthrough,
              children: [
                Positioned.fill(
                  child: ClipPath(
                    clipper: InnerPathClipper(decoration: style.decoration, direction: direction),
                    child: AnimatedBuilder(
                      animation: _controller.fade,
                      builder: (_, _) => BackdropFilter(filter: filter(_controller.fade.value), child: Container()),
                    ),
                  ),
                ),
                popover,
              ],
            );
          }

          return CallbackShortcuts(bindings: {const SingleActivator(.escape): _hide}, child: popover);
        },
        child: child,
      ),
    );
  }

  void _show(Offset localPosition) {
    setState(() => _point = localPosition);
    _controller.show();
  }

  void _hide() {
    if (_controller.status.isForwardOrCompleted) {
      _controller.hide();
      widget.onTapHide?.call();
    }
  }
}

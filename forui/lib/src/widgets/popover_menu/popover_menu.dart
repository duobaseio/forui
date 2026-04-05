import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'popover_menu.design.dart';

@internal
class PopoverMenuScope extends InheritedWidget {
  static PopoverMenuScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PopoverMenuScope>();

  final FPopoverMenuStyle style;

  final Object? groupId;

  final ValueNotifier<Key?> active;

  const PopoverMenuScope({
    required this.style,
    required this.groupId,
    required this.active,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(PopoverMenuScope old) => style != old.style || groupId != old.groupId || active != old.active;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('active', active));
  }
}

/// A popover menu displays a menu in a portal aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover-menu for working examples.
/// * [FPopoverController] for controlling a popover menu.
/// * [FPopoverMenuStyle] for customizing a popover menu's appearance.
/// * [FTileGroup] for customizing the items in the menu.
class FPopoverMenu extends StatefulWidget {
  /// The default item menu builder that returns the menu as-is.
  static List<FItemGroupMixin> defaultItemBuilder(
    BuildContext context,
    FPopoverController controller,
    List<FItemGroupMixin>? menu,
  ) => menu!;

  /// The default tile menu builder that returns the menu as-is.
  static List<FTileGroupMixin> defaultTileBuilder(
    BuildContext context,
    FPopoverController controller,
    List<FTileGroupMixin>? menu,
  ) => menu!;

  /// The popover menu's style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FPopoverMenuStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover-menu
  /// ```
  final FPopoverMenuStyleDelta style;

  /// Defines how the popover menu's shown state is controlled.
  ///
  /// Defaults to [FPopoverControl.managed] which creates an internal [FPopoverController].
  final FPopoverControl control;

  /// {@macro forui.widgets.FTileGroup.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.widgets.FTileGroup.cacheExtent}
  final double? cacheExtent;

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

  /// The anchor point on the menu used for positioning relative to the [childAnchor].
  ///
  /// For example, with `menuAnchor: .topCenter` and `childAnchor: .bottomCenter`,
  /// the menu's top edge will align with the child's bottom edge.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry menuAnchor;

  /// The anchor point on the child used for positioning relative to the [menuAnchor].
  ///
  /// For example, with `childAnchor: .bottomCenter` and `menuAnchor: .topCenter`,
  /// the child's bottom edge will align with the menu's top edge.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow overflow;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? groupId;

  /// {@macro forui.widgets.FPopover.hideRegion}
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

  /// {@macro forui.foundation.FPortal.useViewPadding}
  ///
  /// Defaults to true.
  final bool useViewPadding;

  /// {@macro forui.foundation.FPortal.useViewInsets}
  ///
  /// Defaults to true.
  final bool useViewInsets;

  /// {@macro forui.widgets.FPopover.builder}
  final ValueWidgetBuilder<FPopoverController> builder;

  /// The child.
  ///
  /// Passed to [builder] if provided.
  final Widget? child;

  final Widget Function(BuildContext context, FPopoverController controller, FPopoverMenuStyle style) _menuBuilder;

  /// Creates a menu of [FItem]s that is only shown when toggled.
  ///
  /// Recommended for desktops & web.
  ///
  /// [menuBuilder] is an optional builder which returns the menu that the popover is aligned to. It can incorporate a
  /// value-independent widget subtree from the [menu] into the returned widget tree. It can be null if the entire
  /// widget subtree the [menuBuilder] builds doest not require the controller.
  ///
  /// [menu] is an optional list of [FItemMixin]s that will be used as the menu items. If provided, it will be
  /// passed to [menuBuilder].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * neither [builder] nor [child] is provided.
  /// * neither [menuBuilder] nor [menu] is provided.
  FPopoverMenu({
    this.control = const .managed(),
    this.scrollController,
    this.style = const .context(),
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.intrinsicWidth = true,
    this.dragStartBehavior = .start,
    this.divider = .full,
    this.menuAnchor = .topCenter,
    this.childAnchor = .bottomCenter,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.groupId,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.cutout = true,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.useViewPadding = true,
    this.useViewInsets = true,
    List<FItemGroupMixin> Function(BuildContext context, FPopoverController controller, List<FItemGroupMixin>? menu)
        menuBuilder =
        defaultItemBuilder,
    List<FItemGroupMixin>? menu,
    this.builder = FPopover.defaultBuilder,
    this.child,
    super.key,
  }) : _menuBuilder = ((context, controller, style) => FItemGroup.merge(
         scrollController: scrollController,
         cacheExtent: cacheExtent,
         maxHeight: maxHeight,
         intrinsicWidth: intrinsicWidth,
         dragStartBehavior: dragStartBehavior,
         semanticsLabel: semanticsLabel,
         style: style.itemGroupStyle,
         divider: divider,

         children: menuBuilder(context, controller, menu),
       )),
       assert(builder != FPopover.defaultBuilder || child != null, 'Either builder or child must be provided'),
       assert(menuBuilder != defaultItemBuilder || menu != null, 'Either menuBuilder or menu must be provided');

  /// Creates a menu of [FTile]s that is only shown when toggled.
  ///
  /// Recommended for touch devices.
  ///
  /// [menuBuilder] is an optional builder which returns the menu that the popover is aligned to. It can incorporate a
  /// value-independent widget subtree from the [menu] into the returned widget tree. It can be null if the entire
  /// widget subtree the [menuBuilder] builds doest not require the controller.
  ///
  /// [menu] is an optional list of [FTileGroupMixin]s that will be used as the menu items. If provided, it will be
  /// passed to [menuBuilder].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * neither [builder] nor [child] is provided.
  /// * neither [menuBuilder] nor [menu] is provided.
  FPopoverMenu.tiles({
    this.control = const .managed(),
    this.scrollController,
    this.style = const .context(),
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.intrinsicWidth = true,
    this.dragStartBehavior = .start,
    this.divider = .full,
    this.menuAnchor = .topCenter,
    this.childAnchor = .bottomCenter,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.groupId,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.cutout = true,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.useViewPadding = true,
    this.useViewInsets = true,
    List<FTileGroupMixin> Function(BuildContext context, FPopoverController controller, List<FTileGroupMixin>? menu)
        menuBuilder =
        defaultTileBuilder,
    List<FTileGroupMixin>? menu,
    this.builder = FPopover.defaultBuilder,
    this.child,
    super.key,
  }) : _menuBuilder = ((context, controller, style) => FTileGroup.merge(
         scrollController: scrollController,
         cacheExtent: cacheExtent,
         maxHeight: maxHeight,
         intrinsicWidth: intrinsicWidth,
         dragStartBehavior: dragStartBehavior,
         semanticsLabel: semanticsLabel,
         style: style.tileGroupStyle,
         divider: divider,
         children: menuBuilder(context, controller, menu),
       )),
       assert(builder != FPopover.defaultBuilder || child != null, 'Either builder or child must be provided'),
       assert(menuBuilder != defaultTileBuilder || menu != null, 'Either menuBuilder or menu must be provided');

  @override
  State<FPopoverMenu> createState() => _FPopoverMenuState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(FlagProperty('intrinsicWidth', value: intrinsicWidth, ifTrue: 'intrinsicWidth'))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('popoverAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(StringProperty('barrierSemanticsLabel', barrierSemanticsLabel))
      ..add(
        FlagProperty(
          'barrierSemanticsDismissible',
          value: barrierSemanticsDismissible,
          ifTrue: 'barrier semantics dismissible',
        ),
      )
      ..add(FlagProperty('cutout', value: cutout, ifTrue: 'cutout'))
      ..add(ObjectFlagProperty.has('cutoutBuilder', cutoutBuilder))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _FPopoverMenuState extends State<FPopoverMenu> {
  final Key _groupId = UniqueKey();
  final ValueNotifier<Key?> _active = ValueNotifier(null);

  @override
  void dispose() {
    _active.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = PopoverMenuScope.maybeOf(context);
    final style = widget.style(scope == null ? context.theme.popoverMenuStyle : scope.style);
    // groupId can only be provided if hideRegion is excludeChild since the popover. We pass widget.groupId through to
    // improve the diagnostics when the popover menu is misused.
    final groupId = widget.hideRegion == .excludeChild
        ? (widget.groupId ?? scope?.groupId ?? _groupId)
        : widget.groupId;
    return FPopover(
      control: widget.control,
      style: style,
      constraints: FPortalConstraints(minWidth: style.minWidth, maxWidth: style.maxWidth),
      popoverAnchor: widget.menuAnchor,
      childAnchor: widget.childAnchor,
      spacing: widget.spacing,
      overflow: widget.overflow,
      offset: widget.offset,
      groupId: groupId,
      hideRegion: widget.hideRegion,
      onTapHide: widget.onTapHide,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      traversalEdgeBehavior: widget.traversalEdgeBehavior,
      barrierSemanticsLabel: widget.barrierSemanticsLabel,
      barrierSemanticsDismissible: widget.barrierSemanticsDismissible,
      cutout: widget.cutout,
      cutoutBuilder: widget.cutoutBuilder,
      useViewPadding: widget.useViewPadding,
      useViewInsets: widget.useViewInsets,
      popoverBuilder: (context, controller) => PopoverMenuScope(
        style: style,
        groupId: groupId,
        active: _active,
        // The default behavior for non-submenu trigger items.
        child: FInheritedItemCallbacks(
          onHoverEnter: () => _active.value = null,
          onPress: () => _active.value = null,
          onLongPress: () => _active.value = null,
          // We explicitly wrap this in a `FInheritedItemData` to prevent any ancestor data from accidentally leaking
          // into the popover menu's items.
          //
          // ItemGroupStyles and ItemStyles are inherited by explicitly passing the style to _menuBuilder.
          child: FInheritedItemData(child: widget._menuBuilder(context, controller, style)),
        ),
      ),
      builder: widget.builder,
      child: widget.child,
    );
  }
}

/// A [FPopoverMenuStyle]'s style.
class FPopoverMenuStyle extends FPopoverStyle with _$FPopoverMenuStyleFunctions {
  /// The item group's style.
  @override
  final FItemGroupStyle itemGroupStyle;

  /// The tile group's style.
  @override
  final FTileGroupStyle tileGroupStyle;

  /// The menu's min width. Defaults to 150.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the width is not positive.
  @override
  final double minWidth;

  /// The menu's max width. Defaults to 250.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the width is not positive.
  @override
  final double maxWidth;

  /// The hover motion configuration for submenus. Controls the delay before showing/hiding submenus on hover.
  @override
  final FPopoverMenuMotion motion;

  /// The haptic feedback for when a submenu is shown via long press.
  @override
  final Future<void> Function() hapticFeedback;

  /// Creates a [FPopoverMenuStyle].
  const FPopoverMenuStyle({
    required this.itemGroupStyle,
    required this.tileGroupStyle,
    required super.decoration,
    required this.hapticFeedback,
    this.minWidth = 150,
    this.maxWidth = 250,
    this.motion = const FPopoverMenuMotion(),
    super.barrierFilter,
    super.backgroundFilter,
    super.popoverPadding,
  }) : assert(0 < minWidth, 'minWidth ($minWidth) must be > 0'),
       assert(0 < maxWidth, 'maxWidth ($maxWidth) must be > 0'),
       assert(minWidth <= maxWidth, 'minWidth ($minWidth) must be <= maxWidth ($maxWidth)');

  /// Creates a [FPopoverMenuStyle] that inherits its properties.
  FPopoverMenuStyle.inherit({
    required super.colors,
    required super.style,
    required FTypography typography,
    required bool touch,
  }) : itemGroupStyle = .inherit(colors: colors, style: style, typography: typography, touch: touch).copyWith(
         decoration: .value(
           ShapeDecoration(
             shape: RoundedSuperellipseBorder(
               side: BorderSide(color: colors.border, width: style.borderWidth),
               borderRadius: style.borderRadius.md,
             ),
           ),
         ),
         itemStyles: .delta([
           .base(
             .delta(
               backgroundColor: FVariants.all(colors.card),
               decoration: .delta([.base(.shapeDelta(color: colors.card))]),
               contentStyle: FItemContentStyle.inherit(
                 colors: colors,
                 typography: typography,
                 prefix: colors.foreground,
                 foreground: colors.foreground,
                 mutedForeground: colors.mutedForeground,
                 suffixedPadding: FItemStyle.menuInsets(touch: touch).suffixedPadding,
                 unsuffixedPadding: FItemStyle.menuInsets(touch: touch).unsuffixedPadding,
               ),
               rawItemContentStyle: FRawItemContentStyle.inherit(
                 colors: colors,
                 typography: typography,
                 prefix: colors.foreground,
                 color: colors.foreground,
                 padding: FItemStyle.menuInsets(touch: touch).unsuffixedPadding,
               ),
             ),
           ),
         ]),
       ),
       tileGroupStyle = .inherit(colors: colors, style: style, typography: typography).copyWith(
         tileStyles: .delta([
           .base(
             .delta(
               contentStyle: .delta(
                 prefixIconStyle: FVariants.from(
                   IconThemeData(color: colors.foreground, size: typography.md.fontSize),
                   variants: {
                     [.disabled]: .delta(color: colors.disable(colors.foreground)),
                   },
                 ),
               ),
               rawItemContentStyle: .delta(
                 prefixIconStyle: FVariants.from(
                   IconThemeData(color: colors.foreground, size: typography.md.fontSize),
                   variants: {
                     [.disabled]: .delta(color: colors.disable(colors.foreground)),
                   },
                 ),
               ),
             ),
           ),
         ]),
       ),
       minWidth = 150,
       maxWidth = 250,
       motion = const FPopoverMenuMotion(),
       hapticFeedback = style.hapticFeedback.mediumImpact,
       super.inherit();
}

/// Controls the hover timing for submenu show/hide in a [FPopoverMenu].
class FPopoverMenuMotion with Diagnosticable, _$FPopoverMenuMotionFunctions {
  /// The delay before showing a submenu when the pointer enters an item. Defaults to 150ms.
  @override
  final Duration hoverEnterDuration;

  /// Creates a [FPopoverMenuMotion].
  const FPopoverMenuMotion({this.hoverEnterDuration = const Duration(milliseconds: 150)});
}

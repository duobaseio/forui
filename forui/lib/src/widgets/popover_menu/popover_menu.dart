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

  final FPopoverController controller;

  final FPopoverMenuStyle style;

  final Object? groupId;

  final ValueNotifier<(Key?, bool)> active;

  const PopoverMenuScope({
    required this.controller,
    required this.style,
    required this.groupId,
    required this.active,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(PopoverMenuScope old) =>
      controller != old.controller || style != old.style || groupId != old.groupId || active != old.active;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
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

  /// Whether the parent menu fades when a submenu is active.
  ///
  /// Defaults to true on touch platforms and false on desktop.
  final bool? faded;

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
    this.faded,
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
    this.faded,
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
      ..add(FlagProperty('faded', value: faded, ifTrue: 'faded'))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _FPopoverMenuState extends State<FPopoverMenu> {
  final Key _groupId = UniqueKey();
  final ValueNotifier<(Key? key, bool hovered)> _active = ValueNotifier((null, false));

  @override
  void dispose() {
    _active.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = PopoverMenuScope.maybeOf(context);
    final style = widget.style(scope == null ? context.theme.popoverMenuStyle : scope.style);
    final fade = widget.faded ?? context.platformVariant.touch;
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
        controller: controller,
        style: style,
        groupId: groupId,
        active: _active,
        // The default behavior for non-submenu trigger items.
        child: FInheritedItemCallbacks(
          onHoverEnter: () => _active.value = (null, false),
          onPress: () => _active.value = (null, false),
          onLongPress: () => _active.value = (null, false),
          // We explicitly wrap this in a `FInheritedItemData` to prevent any ancestor data from accidentally leaking
          // into the popover menu's items.
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
              child: widget._menuBuilder(context, controller, style),
            ),
          ),
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

  /// The delay before showing a submenu when the pointer enters an item. Defaults to 150ms.
  @override
  final Duration hoverEnterDuration;

  /// The popover menu's motion configuration.
  @override
  final FPopoverMenuMotion menuMotion;

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
    this.hoverEnterDuration = const Duration(milliseconds: 150),
    this.menuMotion = const FPopoverMenuMotion(),
    super.barrierFilter,
    super.backgroundFilter,
    super.popoverPadding,
    super.motion,
  }) : assert(0 < minWidth, 'minWidth ($minWidth) must be > 0'),
       assert(0 < maxWidth, 'maxWidth ($maxWidth) must be > 0'),
       assert(minWidth <= maxWidth, 'minWidth ($minWidth) must be <= maxWidth ($maxWidth)');

  /// Creates a [FPopoverMenuStyle] that inherits its properties.
  FPopoverMenuStyle.inherit({
    required super.colors,
    required super.style,
    required FTypography typography,
    required FHapticFeedback hapticFeedback,
    required bool touch,
  }) : itemGroupStyle = .inherit(colors: colors, style: style, typography: typography, hapticFeedback: hapticFeedback, touch: touch).copyWith(
         decoration: .value(
           ShapeDecoration(
             color: colors.card,
             shape: RoundedSuperellipseBorder(
               side: BorderSide(color: colors.border, width: style.borderWidth),
               borderRadius: style.borderRadius.md,
             ),
           ),
         ),
         itemStyles: .delta([
           .all(
             .delta(
               backgroundColor: FVariants.all(colors.card),
               contentDecoration: .delta([.base(.shapeDelta(color: colors.card))]),
             ),
           ),
           .base(
             .delta(
               contentStyle: FItemContentStyle.inherit(
                 colors: colors,
                 typography: typography,
                 prefix: colors.foreground,
                 foreground: colors.foreground,
                 mutedForeground: colors.mutedForeground,
                 touch: touch,
               ),
               rawContentStyle: FRawItemContentStyle.inherit(
                 colors: colors,
                 typography: typography,
                 prefix: colors.foreground,
                 color: colors.foreground,
                 touch: touch,
               ),
             ),
           ),
         ]),
       ),
       tileGroupStyle = .inherit(colors: colors, style: style, typography: typography, hapticFeedback: hapticFeedback).copyWith(
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
               rawContentStyle: .delta(
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
       hoverEnterDuration = const Duration(milliseconds: 150),
       menuMotion = const FPopoverMenuMotion(),
       hapticFeedback = hapticFeedback.mediumImpact,
       super.inherit();
}

/// Motion-related properties for the submenu fade effect in [FPopoverMenu].
class FPopoverMenuMotion with Diagnosticable, _$FPopoverMenuMotionFunctions {
  /// A [FPopoverMenuMotion] with no motion effects.
  static const FPopoverMenuMotion none = .new(fade: 1.0);

  /// The fade applied to the parent menu when a submenu is active. Defaults to 0.4.
  @override
  final double fade;

  /// The fade duration. Defaults to 100ms.
  @override
  final Duration fadeDuration;

  /// The fade curve. Defaults to [Curves.linear].
  @override
  final Curve fadeCurve;

  /// Creates a [FPopoverMenuMotion].
  const FPopoverMenuMotion({
    this.fade = 0.4,
    this.fadeDuration = const Duration(milliseconds: 100),
    this.fadeCurve = Curves.linear,
  });
}

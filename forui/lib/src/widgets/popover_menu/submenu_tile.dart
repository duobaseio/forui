import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover_menu/submenu_trigger.dart';

/// A tile that opens a nested popover menu to the side on tap.
///
/// Used inside [FPopoverMenu.tiles] to create hierarchical menus. For desktop-oriented submenus, use [FSubmenuItem].
///
/// See:
/// * [FPopoverMenu] for the parent menu widget.
/// * [FSubmenuItem] for the item variant suited for desktop.
class FSubmenuTile extends StatefulWidget with FTileMixin {
  /// The popover control.
  ///
  /// Defaults to `const FPopoverControl.managed()`.
  final FPopoverControl control;

  /// The variant used to resolve the tile's style.
  ///
  /// Defaults to [FItemVariant.primary].
  final FItemVariant variant;

  /// The trigger tile's style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  final FItemStyleDelta style;

  /// Whether the trigger tile is enabled. Defaults to true.
  final bool? enabled;

  /// The semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// Whether the tile should be focused on initial build.
  final bool autofocus;

  /// The focus node used by the trigger tile.
  final FocusNode? focusNode;

  /// Called when the focus state of the trigger tile changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when the variant state of the trigger tile changes.
  final FTappableVariantChangeCallback? onVariantChange;

  /// Called when the trigger tile is long-pressed.
  final VoidCallback? onLongPress;

  /// Called when the trigger tile is double-tapped.
  final VoidCallback? onDoubleTap;

  /// Called when the trigger tile is secondary-pressed (right click).
  final VoidCallback? onSecondaryPress;

  /// Called when the trigger tile is secondary-long-pressed.
  final VoidCallback? onSecondaryLongPress;

  /// The keyboard shortcuts for the trigger tile.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The actions for the trigger tile.
  final Map<Type, Action<Intent>>? actions;

  /// The widget displayed before the title.
  final Widget? prefix;

  /// The title widget.
  final Widget title;

  /// The subtitle widget displayed below the title.
  final Widget? subtitle;

  /// The widget displayed after the title. Defaults to a chevron-right icon.
  final Widget? suffix;

  /// The submenu items.
  final List<FTileGroupMixin> menu;

  /// The submenu's popover style.
  ///
  /// To modify the current style:
  /// ```dart
  /// menuStyle: .delta(...)
  /// ```
  final FPopoverMenuStyleDelta menuStyle;

  /// The anchor point on the submenu used for positioning.
  ///
  /// Defaults to [AlignmentGeometry.topStart] on desktop platforms and [Alignment.bottomCenter] on touch platforms.
  final AlignmentGeometry? menuAnchor;

  /// The anchor point on the trigger tile used for positioning.
  ///
  /// Defaults to [AlignmentGeometry.topEnd] on desktop platforms and [Alignment.topCenter] on touch platforms.
  final AlignmentGeometry? childAnchor;

  /// The submenu's scroll controller.
  final ScrollController? submenuScrollController;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? submenuScrollCacheExtent;

  /// Whether the submenu should size itself to the intrinsic width of its children.
  final bool? submenuIntrinsicWidth;

  /// The submenu's drag start behavior.
  ///
  /// Defaults to [DragStartBehavior.start].
  final DragStartBehavior submenuDragStartBehavior;

  /// The spacing between the submenu and the trigger tile.
  ///
  /// Defaults to [FPortalSpacing.zero].
  final FPortalSpacing submenuSpacing;

  /// The submenu's overflow strategy.
  ///
  /// Defaults to [FPortalOverflow.flip].
  final FPortalOverflow submenuOverflow;

  /// {@macro forui.widgets.FPopover.arrow}
  final FPortalArrowAlignment? submenuArrow;

  /// The submenu's additional translation offset.
  ///
  /// Defaults to [Offset.zero].
  final Offset submenuOffset;

  /// {@macro forui.widgets.FPopover.hideRegion}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  final FPopoverHideRegion submenuHideRegion;

  /// The submenu's semantic label.
  final String? submenuSemanticsLabel;

  /// Whether the submenu should use the view's padding.
  ///
  /// Defaults to true.
  final bool submenuUseViewPadding;

  /// Whether the submenu should use the view's insets.
  ///
  /// Defaults to true.
  final bool submenuUseViewInsets;

  /// {@macro forui.foundation.FPortal.overlayLocation}
  ///
  /// Defaults to [OverlayChildLocation.nearestOverlay].
  final OverlayChildLocation submenuOverlayLocation;

  /// Whether the submenu should be auto-focused.
  final bool? submenuAutofocus;

  /// The submenu's focus node.
  final FocusScopeNode? submenuFocusNode;

  /// Called when the focus state of the submenu changes.
  final ValueChanged<bool>? submenuOnFocusChange;

  /// The submenu's traversal edge behavior.
  final TraversalEdgeBehavior? submenuTraversalEdgeBehavior;

  /// The submenu's max height. Defaults to infinity.
  final double submenuMaxHeight;

  /// The divider between submenu items.
  ///
  /// Defaults to [FItemDivider.full].
  final FItemDivider submenuDivider;

  /// Creates a [FSubmenuTile].
  const new({
    required this.title,
    required this.menu,
    this.control = const .managed(),
    this.variant = .primary,
    this.style = const .context(),
    this.enabled,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onVariantChange,
    this.onLongPress,
    this.onDoubleTap,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.shortcuts,
    this.actions,
    this.prefix,
    this.subtitle,
    this.suffix,
    this.menuStyle = const .context(),
    this.menuAnchor,
    this.childAnchor,
    this.submenuScrollController,
    this.submenuScrollCacheExtent,
    this.submenuIntrinsicWidth,
    this.submenuDragStartBehavior = .start,
    this.submenuSpacing = const .spacing(2),
    this.submenuOverflow = .flip,
    this.submenuArrow,
    this.submenuOffset = .zero,
    this.submenuHideRegion = .excludeChild,
    this.submenuSemanticsLabel,
    this.submenuUseViewPadding = true,
    this.submenuUseViewInsets = true,
    this.submenuOverlayLocation = .nearestOverlay,
    this.submenuAutofocus,
    this.submenuFocusNode,
    this.submenuOnFocusChange,
    this.submenuTraversalEdgeBehavior,
    this.submenuMaxHeight = .infinity,
    this.submenuDivider = .full,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('variant', variant))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onDoubleTap', onDoubleTap))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(DiagnosticsProperty('menuStyle', menuStyle))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('submenuScrollController', submenuScrollController))
      ..add(DiagnosticsProperty('submenuScrollCacheExtent', submenuScrollCacheExtent))
      ..add(FlagProperty('submenuIntrinsicWidth', value: submenuIntrinsicWidth, ifTrue: 'submenu intrinsic width'))
      ..add(EnumProperty('submenuDragStartBehavior', submenuDragStartBehavior))
      ..add(DiagnosticsProperty('submenuSpacing', submenuSpacing))
      ..add(ObjectFlagProperty.has('submenuOverflow', submenuOverflow))
      ..add(DiagnosticsProperty('submenuArrow', submenuArrow))
      ..add(DiagnosticsProperty('submenuOffset', submenuOffset))
      ..add(EnumProperty('submenuHideRegion', submenuHideRegion))
      ..add(StringProperty('submenuSemanticsLabel', submenuSemanticsLabel))
      ..add(FlagProperty('submenuUseViewPadding', value: submenuUseViewPadding, ifTrue: 'submenu using view padding'))
      ..add(FlagProperty('submenuUseViewInsets', value: submenuUseViewInsets, ifTrue: 'submenu using view insets'))
      ..add(EnumProperty('submenuOverlayLocation', submenuOverlayLocation))
      ..add(FlagProperty('submenuAutofocus', value: submenuAutofocus, ifTrue: 'submenu autofocus'))
      ..add(DiagnosticsProperty('submenuFocusNode', submenuFocusNode))
      ..add(ObjectFlagProperty.has('submenuOnFocusChange', submenuOnFocusChange))
      ..add(EnumProperty('submenuTraversalEdgeBehavior', submenuTraversalEdgeBehavior))
      ..add(DoubleProperty('submenuMaxHeight', submenuMaxHeight))
      ..add(EnumProperty('submenuDivider', submenuDivider));
  }

  @override
  State<FSubmenuTile> createState() => _FSubmenuTileState();
}

class _FSubmenuTileState extends State<FSubmenuTile> {
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode(debugLabel: 'FSubmenuTile');
  }

  @override
  void didUpdateWidget(covariant FSubmenuTile old) {
    super.didUpdateWidget(old);
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focusNode?.dispose();
      }

      _focusNode = widget.focusNode ?? FocusNode(debugLabel: 'FSubmenuTile');
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final desktop = context.platformVariant.desktop;
    return FPopoverMenu.tiles(
      control: widget.control,
      style: widget.menuStyle,
      scrollController: widget.submenuScrollController,
      scrollCacheExtent: widget.submenuScrollCacheExtent,
      intrinsicWidth: widget.submenuIntrinsicWidth ?? true,
      dragStartBehavior: widget.submenuDragStartBehavior,
      maxHeight: widget.submenuMaxHeight,
      divider: widget.submenuDivider,
      menuAnchor: widget.menuAnchor ?? (desktop ? .topStart : .bottomCenter),
      childAnchor: widget.childAnchor ?? (desktop ? .topEnd : .topCenter),
      spacing: widget.submenuSpacing,
      overflow: widget.submenuOverflow,
      arrow: widget.submenuArrow,
      offset: widget.submenuOffset,
      hideRegion: widget.submenuHideRegion,
      semanticsLabel: widget.submenuSemanticsLabel,
      useViewPadding: widget.submenuUseViewPadding,
      useViewInsets: widget.submenuUseViewInsets,
      overlayLocation: widget.submenuOverlayLocation,
      autofocus: widget.submenuAutofocus,
      focusNode: widget.submenuFocusNode,
      childFocusNode: _focusNode,
      onFocusChange: widget.submenuOnFocusChange,
      traversalEdgeBehavior: widget.submenuTraversalEdgeBehavior,
      menu: widget.menu,
      builder: (_, controller, _) => SubmenuTrigger(
        controller: controller,
        focusNode: _focusNode,
        builder: (context, shown, shortcuts, actions) => FTile(
          variant: widget.variant,
          style: widget.style,
          enabled: widget.enabled,
          selected: shown,
          semanticsLabel: widget.semanticsLabel,
          semanticsExpanded: shown,
          autofocus: widget.autofocus,
          focusNode: _focusNode,
          onFocusChange: widget.onFocusChange,
          onVariantChange: widget.onVariantChange,
          onLongPress: widget.onLongPress,
          onDoubleTap: widget.onDoubleTap,
          onSecondaryPress: widget.onSecondaryPress,
          onSecondaryLongPress: widget.onSecondaryLongPress,
          shortcuts: {...shortcuts, ...?widget.shortcuts},
          actions: {...actions, ...?widget.actions},
          prefix: widget.prefix,
          title: widget.title,
          subtitle: widget.subtitle,
          suffix: widget.suffix ?? context.theme.icons.chevronRight(context),
          onPress: () {},
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover_menu/popover_menu.dart';

/// An item that opens a nested popover menu.
///
/// Used inside [FPopoverMenu] to create hierarchical menus. For touch-oriented submenus, use [FSubmenuTile].
///
/// See:
/// * [FPopoverMenu] for the parent menu widget.
/// * [FSubmenuTile] for the tile variant suited for touch devices.
class FSubmenuItem extends StatelessWidget with FItemMixin {
  /// The popover control.
  ///
  /// Defaults to `const FPopoverControl.managed()`.
  final FPopoverControl control;

  /// The item's variant.
  ///
  /// Defaults to [FItemVariant.primary].
  final FItemVariant variant;

  /// The trigger item's style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  final FItemStyleDelta style;

  /// Whether the item is enabled. Defaults to true.
  final bool? enabled;

  /// The semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// Whether the item should be focused on initial build.
  final bool autofocus;

  /// The focus node used by the trigger item.
  final FocusNode? focusNode;

  /// Called when the focus state of the trigger item changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when the hover state of the trigger item changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the variant state of the trigger item changes.
  final FTappableVariantChangeCallback? onVariantChange;

  /// Called when the trigger item is long-pressed.
  final VoidCallback? onLongPress;

  /// Called when the trigger item is double-tapped.
  final VoidCallback? onDoubleTap;

  /// Called when the trigger item is secondary-pressed (right click).
  final VoidCallback? onSecondaryPress;

  /// Called when the trigger item is secondary-long-pressed.
  final VoidCallback? onSecondaryLongPress;

  /// The keyboard shortcuts for the trigger item.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The actions for the trigger item.
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
  final List<FItemGroupMixin> submenu;

  /// The submenu's popover style.
  ///
  /// To modify the current style:
  /// ```dart
  /// menuStyle: .delta(...)
  /// ```
  final FPopoverMenuStyleDelta submenuStyle;

  /// The anchor point on the submenu used for positioning.
  ///
  /// Defaults to [AlignmentGeometry.topStart] on desktop platforms and [Alignment.bottomCenter] on touch platforms.
  final AlignmentGeometry? submenuAnchor;

  /// The anchor point on the trigger item used for positioning.
  ///
  /// Defaults to [AlignmentGeometry.topEnd] on desktop platforms and [Alignment.topCenter] on touch platforms.
  final AlignmentGeometry? itemAnchor;

  /// The submenu's scroll controller.
  final ScrollController? submenuScrollController;

  /// The submenu's cache extent in logical pixels.
  final double? submenuCacheExtent;

  /// Whether the submenu should size itself to the intrinsic width of its children.
  final bool? submenuIntrinsicWidth;

  /// The submenu's drag start behavior.
  ///
  /// Defaults to [DragStartBehavior.start].
  final DragStartBehavior submenuDragStartBehavior;

  /// The spacing between the submenu and the trigger item.
  ///
  /// Defaults to [FPortalSpacing.zero].
  final FPortalSpacing submenuSpacing;

  /// The submenu's overflow strategy.
  ///
  /// Defaults to [FPortalOverflow.flip].
  final FPortalOverflow submenuOverflow;

  /// The submenu's additional translation offset.
  ///
  /// Defaults to [Offset.zero].
  final Offset submenuOffset;

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

  /// Whether submenus are shown when hovering over an item. Defaults to true on desktop platforms.
  final bool? hover;

  /// Creates a [FSubmenuItem].
  const FSubmenuItem({
    required this.title,
    required this.submenu,
    this.control = const .managed(motion: FPopoverMotion(exitDuration: .zero)),
    this.variant = .primary,
    this.style = const .context(),
    this.enabled,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
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
    this.submenuStyle = const .context(),
    this.submenuAnchor,
    this.itemAnchor,
    this.submenuScrollController,
    this.submenuCacheExtent,
    this.submenuIntrinsicWidth,
    this.submenuDragStartBehavior = .start,
    this.submenuSpacing = .zero,
    this.submenuOverflow = .flip,
    this.submenuOffset = .zero,
    this.submenuSemanticsLabel,
    this.submenuUseViewPadding = true,
    this.submenuUseViewInsets = true,
    this.submenuAutofocus,
    this.submenuFocusNode,
    this.submenuOnFocusChange,
    this.submenuTraversalEdgeBehavior,
    this.submenuMaxHeight = .infinity,
    this.submenuDivider = .full,
    this.hover,
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
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onVariantChange', onVariantChange))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onDoubleTap', onDoubleTap))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(DiagnosticsProperty('submenuStyle', submenuStyle))
      ..add(DiagnosticsProperty('submenuAnchor', submenuAnchor))
      ..add(DiagnosticsProperty('itemAnchor', itemAnchor))
      ..add(DiagnosticsProperty('submenuScrollController', submenuScrollController))
      ..add(DoubleProperty('submenuCacheExtent', submenuCacheExtent))
      ..add(FlagProperty('submenuIntrinsicWidth', value: submenuIntrinsicWidth, ifTrue: 'submenu intrinsic width'))
      ..add(EnumProperty('submenuDragStartBehavior', submenuDragStartBehavior))
      ..add(DiagnosticsProperty('submenuSpacing', submenuSpacing))
      ..add(ObjectFlagProperty.has('submenuOverflow', submenuOverflow))
      ..add(DiagnosticsProperty('submenuOffset', submenuOffset))
      ..add(StringProperty('submenuSemanticsLabel', submenuSemanticsLabel))
      ..add(FlagProperty('submenuUseViewPadding', value: submenuUseViewPadding, ifTrue: 'submenu using view padding'))
      ..add(FlagProperty('submenuUseViewInsets', value: submenuUseViewInsets, ifTrue: 'submenu using view insets'))
      ..add(FlagProperty('submenuAutofocus', value: submenuAutofocus, ifTrue: 'submenu autofocus'))
      ..add(DiagnosticsProperty('submenuFocusNode', submenuFocusNode))
      ..add(ObjectFlagProperty.has('submenuOnFocusChange', submenuOnFocusChange))
      ..add(EnumProperty('submenuTraversalEdgeBehavior', submenuTraversalEdgeBehavior))
      ..add(DoubleProperty('submenuMaxHeight', submenuMaxHeight))
      ..add(EnumProperty('submenuDivider', submenuDivider))
      ..add(FlagProperty('hover', value: hover, ifTrue: 'hover'));
  }

  @override
  Widget build(BuildContext context) {
    final desktop = context.platformVariant.desktop;
    return FPopoverMenu(
      control: control,
      style: submenuStyle,
      scrollController: submenuScrollController,
      cacheExtent: submenuCacheExtent,
      intrinsicWidth: submenuIntrinsicWidth ?? true,
      dragStartBehavior: submenuDragStartBehavior,
      maxHeight: submenuMaxHeight,
      divider: submenuDivider,
      menuAnchor: submenuAnchor ?? (desktop ? .topStart : .bottomCenter),
      childAnchor: itemAnchor ?? (desktop ? .topEnd : .topCenter),
      spacing: submenuSpacing,
      overflow: submenuOverflow,
      offset: submenuOffset,
      semanticsLabel: submenuSemanticsLabel,
      useViewPadding: submenuUseViewPadding,
      useViewInsets: submenuUseViewInsets,
      autofocus: submenuAutofocus,
      focusNode: submenuFocusNode,
      onFocusChange: submenuOnFocusChange,
      traversalEdgeBehavior: submenuTraversalEdgeBehavior,
      hover: hover,
      menu: submenu,
      builder: (context, controller, _) => _Trigger(
        controller: controller,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => FItem(
            variant: variant,
            style: style,
            enabled: enabled,
            selected: controller.status.isForwardOrCompleted,
            semanticsLabel: semanticsLabel,
            autofocus: autofocus,
            focusNode: focusNode,
            onFocusChange: onFocusChange,
            onHoverChange: onHoverChange,
            onVariantChange: onVariantChange,
            onLongPress: onLongPress,
            onDoubleTap: onDoubleTap,
            onSecondaryPress: onSecondaryPress,
            onSecondaryLongPress: onSecondaryLongPress,
            shortcuts: shortcuts,
            actions: actions,
            prefix: prefix,
            title: title,
            subtitle: subtitle,
            suffix: suffix ?? const Icon(FIcons.chevronRight),
            onPress: () {}, // This is necessary to enable the item.
          ),
        ),
      ),
    );
  }
}

class _Trigger extends StatefulWidget {
  final FPopoverController controller;
  final Widget child;

  const _Trigger({required this.controller, required this.child});

  @override
  State<_Trigger> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FPopoverController>('controller', controller));
  }
}

class _State extends State<_Trigger> {
  final Key _key = UniqueKey();
  PopoverMenuScope? _scope;
  int _monotonic = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final current = PopoverMenuScope.maybeOf(context);
    if (current?.active != _scope?.active) {
      _scope?.active.removeListener(_handleChange);
      _scope = current;
      _scope?.active.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    _scope?.active.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    if (_scope?.active case final active? when active.value != _key) {
      widget.controller.hide();
    }
  }

  @override
  Widget build(BuildContext context) => switch (_scope) {
    null => widget.child,
    final scope when scope.hover => FInheritedItemCallbacks(
      onHoverEnter: () async {
        final token = _monotonic;
        await Future.delayed(scope.style.motion.hoverEnterDuration);
        if (token == _monotonic && mounted) {
          scope.active.value = _key;
          unawaited(widget.controller.show());
        }
      },
      onHoverExit: () => _monotonic++,
      child: widget.child,
    ),
    final scope => FInheritedItemCallbacks(
      onPress: () {
        if (scope.active.value == _key) {
          scope.active.value = null;
          widget.controller.hide();
        } else {
          scope.active.value = _key;
          widget.controller.show();
        }
      },
      child: widget.child,
    ),
  };
}

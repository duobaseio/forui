import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover_menu/popover_menu.dart';

/// A tile that opens a nested popover menu to the side on tap.
///
/// Used inside [FPopoverMenu.tiles] to create hierarchical menus. For desktop-oriented submenus, use [FSubmenuItem].
///
/// See:
/// * [FPopoverMenu] for the parent menu widget.
/// * [FSubmenuItem] for the item variant suited for desktop.
class FSubmenuTile extends StatelessWidget with FTileMixin {
  /// The popover control.
  ///
  /// Defaults to `const FPopoverControl.managed()`.
  final FPopoverControl control;

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

  /// The submenu's cache extent in logical pixels.
  final double? submenuCacheExtent;

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

  /// Creates a [FSubmenuTile].
  const FSubmenuTile({
    required this.title,
    required this.menu,
    this.control = const .managed(motion: FPopoverMotion(exitDuration: .zero)),
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
    this.submenuCacheExtent,
    this.submenuIntrinsicWidth,
    this.submenuDragStartBehavior = .start,
    this.submenuSpacing = const .spacing(2),
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
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
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
      ..add(EnumProperty('submenuDivider', submenuDivider));
  }

  @override
  Widget build(BuildContext context) {
    final desktop = context.platformVariant.desktop;
    return FPopoverMenu.tiles(
      control: control,
      style: menuStyle,
      scrollController: submenuScrollController,
      cacheExtent: submenuCacheExtent,
      intrinsicWidth: submenuIntrinsicWidth ?? true,
      dragStartBehavior: submenuDragStartBehavior,
      maxHeight: submenuMaxHeight,
      divider: submenuDivider,
      menuAnchor: menuAnchor ?? (desktop ? .topStart : .bottomCenter),
      childAnchor: childAnchor ?? (desktop ? .topEnd : .topCenter),
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
      menu: menu,
      builder: (context, controller, _) => _Trigger(
        controller: controller,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => FTile(
            style: style,
            enabled: enabled,
            selected: controller.status.isForwardOrCompleted,
            semanticsLabel: semanticsLabel,
            autofocus: autofocus,
            focusNode: focusNode,
            onFocusChange: onFocusChange,
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
            onPress: () {},
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
  bool _hovered = false;

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
    final scope => FInheritedItemCallbacks(
      onHoverEnter: () async {
        _hovered = true;
        final token = _monotonic;
        await Future.delayed(scope.style.motion.hoverEnterDuration);
        if (token == _monotonic && mounted) {
          scope.active.value = _key;
          unawaited(widget.controller.show());
        }
      },
      onHoverExit: () {
        _hovered = false;
        _monotonic++;
      },
      onPress: () {
        if (_hovered) {
          return;
        }
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

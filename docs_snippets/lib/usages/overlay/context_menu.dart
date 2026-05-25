// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final contextMenu = FContextMenu(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topLeft,
  maxHeight: .infinity,
  intrinsicWidth: true,
  spacing: 0,
  overflow: .flip,
  useViewPadding: true,
  useViewInsets: true,
  offset: .zero,
  cutout: false,
  cutoutBuilder: FModalBarrier.defaultCutoutBuilder,
  // {@endcategory}
  // {@category "Tap Region""}
  groupId: null,
  hideRegion: .excludeChild,
  onTapHide: () {},
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  scrollCacheExtent: null,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: null,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Menu',
  traversalEdgeBehavior: null,
  barrierSemanticsLabel: null,
  barrierSemanticsDismissible: true,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(maxWidth: 250),
  longPress: null,
  secondaryPress: null,
  faded: null,
  divider: .full,
  menu: [
    .group(
      children: [
        .item(title: const Text('Edit'), onPress: () {}),
        .item(title: const Text('Delete'), onPress: () {}),
      ],
    ),
  ],
  menuBuilder: (context, controller, menu) => menu!,
  builder: (context, controller, child) => child!,
  child: const SizedBox.square(dimension: 200),
  // {@endcategory}
);

final contextMenuTiles = FContextMenu.tiles(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topLeft,
  maxHeight: .infinity,
  intrinsicWidth: true,
  spacing: 0,
  overflow: .flip,
  useViewPadding: true,
  useViewInsets: true,
  offset: .zero,
  cutout: false,
  cutoutBuilder: FModalBarrier.defaultCutoutBuilder,
  // {@endcategory}
  // {@category "Tap Region"}
  groupId: null,
  hideRegion: .excludeChild,
  onTapHide: () {},
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  scrollCacheExtent: null,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: null,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Menu',
  traversalEdgeBehavior: null,
  barrierSemanticsLabel: null,
  barrierSemanticsDismissible: true,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(maxWidth: 250),
  longPress: null,
  secondaryPress: null,
  faded: null,
  divider: .full,
  menu: [
    .group(
      children: [
        .tile(title: const Text('Edit'), onPress: () {}),
        .tile(title: const Text('Delete'), onPress: () {}),
      ],
    ),
  ],
  menuBuilder: (context, controller, menu) => menu!,
  builder: (context, controller, child) => child!,
  child: const SizedBox.square(dimension: 200),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the context menu's visibility.
final FPopoverControl lifted = .lifted(shown: false, onChange: (shown) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the context menu state internally.
final FPopoverControl managedInternal = .managed(initial: false, onChange: (shown) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the context menu's state.
final FPopoverControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: false),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();

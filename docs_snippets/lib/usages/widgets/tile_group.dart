// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tileGroup = FTileGroup(
  // {@category "Scroll"}
  scrollController: null,
  physics: const ClampingScrollPhysics(),
  cacheExtent: null,
  maxHeight: double.infinity,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Tile Group',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(dividerWidth: 1),
  enabled: true,
  divider: .indented,
  label: const Text('Label'),
  description: const Text('Description'),
  error: null,
  children: [
    .tile(title: const Text('Tile 1'), onPress: () {}),
    .tile(title: const Text('Tile 2'), onPress: () {}),
  ],
  // {@endcategory}
);

final tileGroupBuilder = FTileGroup.builder(
  // {@category "Scroll"}
  scrollController: null,
  physics: const ClampingScrollPhysics(),
  cacheExtent: null,
  maxHeight: double.infinity,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Tile Group',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(dividerWidth: 1),
  enabled: true,
  divider: .indented,
  label: const Text('Label'),
  description: const Text('Description'),
  error: null,
  tileBuilder: (context, index) => FTile(title: Text('Tile $index'), onPress: () {}),
  count: 10,
  // {@endcategory}
);

final tileGroupMerge = FTileGroup.merge(
  // {@category "Scroll"}
  scrollController: null,
  physics: const ClampingScrollPhysics(),
  cacheExtent: null,
  maxHeight: double.infinity,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Tile Group',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(dividerWidth: 1),
  enabled: true,
  divider: .full,
  label: const Text('Label'),
  description: const Text('Description'),
  error: null,
  children: [
    .group(
      children: [.tile(title: const Text('Group 1 Tile'), onPress: () {})],
    ),
    .group(
      children: [.tile(title: const Text('Group 2 Tile'), onPress: () {})],
    ),
  ],
  // {@endcategory}
);

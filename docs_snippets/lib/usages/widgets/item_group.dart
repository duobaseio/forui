// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final itemGroup = FItemGroup(
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item group',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(spacing: 4),
  enabled: true,
  divider: .none,
  children: [
    .item(title: const Text('Item 1'), onPress: () {}),
    .item(title: const Text('Item 2'), onPress: () {}),
  ],
  // {@endcategory}
);

final builder = FItemGroup.builder(
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item group',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(spacing: 4),
  enabled: true,
  divider: .none,
  itemBuilder: (context, index) => FItem(title: Text('Item $index'), onPress: () {}),
  count: 10,
  // {@endcategory}
);

final merge = FItemGroup.merge(
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item group',
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(spacing: 4),
  enabled: true,
  divider: .full,
  children: [
    .group(
      children: [.item(title: const Text('Group 1 Item'), onPress: () {})],
    ),
    .group(
      children: [.item(title: const Text('Group 2 Item'), onPress: () {})],
    ),
  ],
  // {@endcategory}
);

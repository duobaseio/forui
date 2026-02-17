// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final sidebar = FSidebar(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(headerPadding: .value(.fromLTRB(0, 16, 0, 0))),
  header: const Text('Header'),
  children: [
    FSidebarGroup(
      label: const Text('Navigation'),
      children: [
        FSidebarItem(icon: const Icon(FIcons.house), label: const Text('Home'), onPress: () {}),
        FSidebarItem(icon: const Icon(FIcons.settings), label: const Text('Settings'), onPress: () {}),
      ],
    ),
  ],
  footer: const Text('Footer'),
  // {@endcategory}
);

final sidebarBuilder = FSidebar.builder(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(headerPadding: .value(.fromLTRB(0, 16, 0, 0))),
  header: const Text('Header'),
  itemBuilder: (context, index) => FSidebarItem(label: Text('Item $index'), onPress: () {}),
  itemCount: 10,
  footer: const Text('Footer'),
  // {@endcategory}
);

final sidebarRaw = FSidebar.raw(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(headerPadding: .value(.fromLTRB(0, 16, 0, 0))),
  header: const Text('Header'),
  child: ListView(
    children: [FSidebarItem(label: const Text('Custom Item'), onPress: () {})],
  ),
  footer: const Text('Footer'),
  // {@endcategory}
);

final sidebarGroup = FSidebarGroup(
  // {@category "Callbacks"}
  onActionHoverChange: (hovered) {},
  onActionVariantChange: (previous, current) {},
  onActionPress: () {},
  onActionLongPress: () {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.symmetric(horizontal: 8))),
  label: const Text('Navigation'),
  action: const Icon(FIcons.plus),
  children: [
    FSidebarItem(label: const Text('Home'), onPress: () {}),
    FSidebarItem(label: const Text('Settings'), onPress: () {}),
  ],
  // {@endcategory}
);

final sidebarItem = FSidebarItem(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.symmetric(horizontal: 8))),
  selected: false,
  initiallyExpanded: false,
  icon: const Icon(FIcons.house),
  label: const Text('Home'),
  children: [
    FSidebarItem(label: const Text('Nested Item 1'), onPress: () {}),
    FSidebarItem(label: const Text('Nested Item 2'), onPress: () {}),
  ],
  // {@endcategory}
);

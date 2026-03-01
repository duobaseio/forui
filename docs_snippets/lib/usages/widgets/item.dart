// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final item = FItem(
  // {@category "Variants"}
  variants: const {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Item',
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onDoubleTap: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(margin: FVariants.all(EdgeInsets.zero)),
  enabled: true,
  selected: false,
  onPress: () {},
  title: const Text('Title'),
  prefix: const Icon(FIcons.user),
  subtitle: const Text('Subtitle'),
  details: const Text('Details'),
  suffix: const Icon(FIcons.chevronRight),
  // {@endcategory}
);

final raw = FItem.raw(
  // {@category "Variants"}
  variants: const {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Item',
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onDoubleTap: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(margin: FVariants.all(EdgeInsets.zero)),
  enabled: true,
  selected: false,
  onPress: () {},
  child: const Text('Content'),
  prefix: const Icon(FIcons.user),
  // {@endcategory}
);

// {@category "Variants" "Primary"}
/// The item's primary (base) variant.
final Set<FItemVariant> primary = {};

// {@category "Variants" "Destructive"}
/// The item's destructive variant.
final Set<FItemVariant> destructive = {.destructive};

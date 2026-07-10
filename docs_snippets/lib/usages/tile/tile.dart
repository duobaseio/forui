// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tile = FTile(
  // {@category "Variant"}
  variant: .primary,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tile',
  semanticsExpanded: null,
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
  style: const .delta(padding: .value(.zero)),
  enabled: true,
  selected: false,
  onPress: () {},
  title: const Text('Title'),
  subtitle: const Text('Subtitle'),
  details: const Text('Details'),
  prefix: const Icon(FLucideIcons.house),
  suffix: const Icon(FLucideIcons.chevronRight),
  // {@endcategory}
);

final tileRaw = FTile.raw(
  // {@category "Variant"}
  variant: .primary,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tile',
  semanticsExpanded: null,
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
  style: const .delta(padding: .value(.zero)),
  enabled: true,
  selected: false,
  onPress: () {},
  prefix: const Icon(FLucideIcons.house),
  child: const Text('Custom Content'),
  // {@endcategory}
);

// {@category "Variant" "Primary"}
/// The tile's primary (base) variant.
final Set<FItemVariant> primary = {};

// {@category "Variant" "Destructive"}
/// The tile's destructive variant.
final Set<FItemVariant> destructive = {.destructive};

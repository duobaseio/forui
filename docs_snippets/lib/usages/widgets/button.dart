// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final button = FButton(
  // {@category "Variants"}
  variants: const {},
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  selected: false,
  onPress: () {},
  child: const Text('Button'),
  // {@endcategory}
  // {@category "Content"}
  prefix: const Icon(FIcons.mail),
  suffix: null,
  mainAxisSize: .max,
  mainAxisAlignment: .center,
  crossAxisAlignment: .center,
  textBaseline: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
);

final icon = FButton.icon(
  // {@category "Variants"}
  variants: {.outline},
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  selected: false,
  onPress: () {},
  child: const Icon(FIcons.mail),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
);

final raw = FButton.raw(
  // {@category "Variants"}
  variants: const {},
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  selected: false,
  onPress: () {},
  child: const Text('Button'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
);

// {@category "Variants" "Primary"}
/// The button's primary (base) variant.
final Set<FButtonVariant> primary = {};

// {@category "Variants" "Secondary"}
/// The button's secondary variant.
final Set<FButtonVariant> secondary = {.secondary};

// {@category "Variants" "Destructive"}
/// The button's destructive variant.
final Set<FButtonVariant> destructive = {.destructive};

// {@category "Variants" "Outline"}
/// The button's outline variant.
final Set<FButtonVariant> outline = {.outline};

// {@category "Variants" "Ghost"}
/// The button's ghost variant.
final Set<FButtonVariant> ghost = {.ghost};

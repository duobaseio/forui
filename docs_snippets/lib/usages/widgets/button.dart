// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final button = FButton(
  // {@category "Variant"}
  variant: .primary,
  // {@endcategory}
  // {@category "Size"}
  size: .md,
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
  onDoubleTap: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .context(),
  selected: false,
  onPress: () {},
  child: const Text('Button'),
  // {@endcategory}
);

final icon = FButton.icon(
  // {@category "Variant"}
  variant: .outline,
  // {@endcategory}
  // {@category "Size"}
  size: .md,
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
  onDoubleTap: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .context(),
  selected: false,
  onPress: () {},
  child: const Icon(FIcons.mail),
  // {@endcategory}
);

final raw = FButton.raw(
  // {@category "Variant"}
  variant: .primary,
  // {@endcategory}
  // {@category "Size"}
  size: .md,
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
  onDoubleTap: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .context(),
  selected: false,
  onPress: () {},
  child: const Text('Button'),
  // {@endcategory}
);

// {@category "Variant" "Primary"}
/// The button's primary (base) variant.
const FButtonVariant primary = .primary;

// {@category "Variant" "Secondary"}
/// The button's secondary variant.
const FButtonVariant secondary = .secondary;

// {@category "Variant" "Destructive"}
/// The button's destructive variant.
const FButtonVariant destructive = .destructive;

// {@category "Variant" "Outline"}
/// The button's outline variant.
const FButtonVariant outline = .outline;

// {@category "Variant" "Ghost"}
/// The button's ghost variant.
const FButtonVariant ghost = .ghost;

// {@category "Size" "Medium"}
/// The button's medium (default) size.
const FButtonSizeVariant md = .md;

// {@category "Size" "Extra Small"}
/// The button's extra small size.
const FButtonSizeVariant xs = .xs;

// {@category "Size" "Small"}
/// The button's small size.
const FButtonSizeVariant sm = .sm;

// {@category "Size" "Large"}
/// The button's large size.
const FButtonSizeVariant lg = .lg;

// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final badge = FBadge(
  // {@category "Variants"}
  variants: {},
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  child: const Text('Badge'),
  // {@endcategory}
);

final raw = FBadge.raw(
  // {@category "Variants"}
  variants: {},
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  builder: (context, style) => const Text('Badge'),
  // {@endcategory}
);

// {@category "Variants" "Primary"}
/// The badge's primary (base) variant.
final Set<FBadgeVariant> primary = {};

// {@category "Variants" "Secondary"}
/// The badge's secondary variant.
final Set<FBadgeVariant> secondary = {.secondary};

// {@category "Variants" "Outline"}
/// The badge's outline variant.
final Set<FBadgeVariant> outline = {.outline};

// {@category "Variants" "Destructive"}
/// The badge's destructive variant.
final Set<FBadgeVariant> destructive = {.destructive};


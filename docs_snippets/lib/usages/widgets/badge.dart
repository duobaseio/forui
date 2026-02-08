// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final badge = FBadge(
  // {@category "Variant"}
  variant: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  child: const Text('Badge'),
  // {@endcategory}
);

final raw = FBadge.raw(
  // {@category "Variant"}
  variant: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .inherit(),
  builder: (context, style) => const Text('Badge'),
  // {@endcategory}
);

// {@category "Variant" "Primary"}
/// The badge's primary (base) variant.
const FBadgeVariant? primary = null;

// {@category "Variant" "Secondary"}
/// The badge's secondary variant.
const FBadgeVariant secondary = .secondary;

// {@category "Variant" "Outline"}
/// The badge's outline variant.
const FBadgeVariant outline = .outline;

// {@category "Variant" "Destructive"}
/// The badge's destructive variant.
const FBadgeVariant destructive = .destructive;

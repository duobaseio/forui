import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final FVariants<FTappableVariantConstraint, FTappableVariant, BoxDecoration, BoxDecorationDelta> delta =
    // {@snippet constructor}
    FVariants.from(
      // base (default if no variants match)
      const BoxDecoration(color: Colors.white, borderRadius: .all(.circular(8))),
      variants: {
        // NOT hovered - keeps border radius
        [.not(.hovered)]: const .delta(color: Colors.red),
        // hovered OR pressed - keeps border radius
        [.hovered, .pressed]: const .delta(color: Colors.grey),
        // disabled AND pressed - keeps border radius
        [.disabled.and(.pressed)]: const .delta(color: Colors.black26),
      },
    );
// {@endsnippet}

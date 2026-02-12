import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final FVariants<FTappableVariantConstraint, BoxDecoration, BoxDecorationDelta> decoration =
    // {@snippet constructor}
    FVariants(
      // base (default if no variants match)
      const BoxDecoration(color: Colors.white),
      variants: {
        // NOT hovered
        [.not(.hovered)]: const BoxDecoration(color: Colors.red),
        // hovered OR pressed
        [.hovered, .pressed]: const BoxDecoration(color: Colors.grey),
        // disabled AND pressed
        [.disabled.and(.pressed)]: const BoxDecoration(color: Colors.black26),
      },
    );
// {@endsnippet}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final accordion =
    // {@snippet constructor}
    FAccordion(
      style: .delta(
        titleTextStyle: FVariants.from(
          const TextStyle(fontSize: 18, fontWeight: .bold),
          variants: {
            [.hovered, .pressed]: const TextStyleDelta.delta(decoration: TextDecoration.underline),
            [.disabled]: const TextStyleDelta.delta(color: Colors.grey),
          },
        ),
      ),
      children: const [],
    );
// {@endsnippet}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final accordion =
    // {@snippet constructor}
    FAccordion(
      style: .delta(
        titleTextStyle: .value(
          FVariants.variants(
            const TextStyle(fontSize: 18, fontWeight: .bold),
            variants: {
              [.hovered, .pressed]: const .delta(decoration: .underline),
              [.disabled]: const .delta(color: Colors.grey),
            },
          ),
        ),
      ),
      children: const [],
    );
// {@endsnippet}

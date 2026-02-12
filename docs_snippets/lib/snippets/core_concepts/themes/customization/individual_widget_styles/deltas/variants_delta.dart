import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final accordion =
    // {@snippet constructor}
    FAccordion(
      style: .delta(
        titleTextStyle: .delta([
          // Change ONLY the base title color.
          .onBase(const .delta(color: Colors.red)),
          // Make hovered AND focused titles underlined, adds a new constraint
          // if it doesn't already exist.
          .on({.hovered.and(.focused)}, const .delta(decoration: .underline)),
          // Make all existing constraints containing hovered bold, does
          // nothing if none exist.
          .onMatching({.hovered}, const .delta(fontWeight: .bold)),
        ]),
      ),
      children: const [],
    );
// {@endsnippet}

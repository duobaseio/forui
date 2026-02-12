import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final radio =
    // {@snippet constructor}
    FRadio(
      style: .delta(
        borderColor: .apply([
          // Change ONLY the base border color.
          .onBase(Colors.blue),
          // Set the border color when selected, adds a new constraint
          // if it doesn't already exist.
          .on({.selected}, Colors.green),
          // Set the border color for all existing constraints containing
          // disabled, does nothing if none exist.
          .onMatching({.disabled}, Colors.grey),
        ]),
      ),
    );
// {@endsnippet}

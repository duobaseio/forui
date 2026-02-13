import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final radio =
    // {@snippet constructor}
    FRadio(
      style: .delta(
        borderColor: .delta([
          // Change ONLY the base border color.
          .base(Colors.blue),
          // Set the border color when selected, adds a new constraint
          // if it doesn't already exist.
          .exact([.selected], Colors.green),
          // Set the border color for all existing constraints containing
          // disabled, does nothing if none exist.
          .match([.disabled], Colors.grey),
        ]),
      ),
    );
// {@endsnippet}

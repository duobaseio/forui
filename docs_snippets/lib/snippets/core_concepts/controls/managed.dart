import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

late FPopoverController _externalController;

final internal =
    // {@snippet constructor}
    // FPopover manages its own state using an internal controller.
    FPopover(
      control: const .managed(initial: false, onChange: print),
      child: const Placeholder(),
      popoverBuilder: (_, _) => const Placeholder(),
    );
// {@endsnippet}

final external =
    // {@snippet constructor}
    // FPopover manages its own state using an external controller.
    FPopover(
      control: .managed(controller: _externalController),
      child: const Placeholder(),
      popoverBuilder: (_, _) => const Placeholder(),
    );
// {@endsnippet}

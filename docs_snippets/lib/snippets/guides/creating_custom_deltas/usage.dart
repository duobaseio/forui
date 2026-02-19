import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/guides/creating_custom_deltas/implement.dart';

final tooltip =
    // {@snippet constructor}
    FTooltip(
      style: const .delta(padding: MirrorDelta()),
      tipBuilder: (_, _) => const Text('Tooltip'),
      child: const Placeholder(),
    );
// {@endsnippet}

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
class MirrorDelta implements EdgeInsetsDelta {
  const MirrorDelta();

  @override
  EdgeInsets call(EdgeInsets? insets) {
    final resolved = insets ?? .zero;
    return .only(
      left: resolved.right,
      top: resolved.top,
      right: resolved.left,
      bottom: resolved.bottom,
    );
  }
}
// {@endsnippet}

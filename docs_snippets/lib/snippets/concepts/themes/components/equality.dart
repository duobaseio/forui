import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// {@snippet}
// Bad: a closure literal is never equal to another.
final bad = FDialogRouteStyle(
  barrierFilter: (_, v) => ImageFilter.blur(sigmaX: v * 5, sigmaY: v * 5),
);

// Good: a static function is canonical.
ImageFilter _blur(BuildContext context, double v) => ImageFilter.blur(sigmaX: v * 5, sigmaY: v * 5);

const good = FDialogRouteStyle(barrierFilter: _blur);
// {@endsnippet}

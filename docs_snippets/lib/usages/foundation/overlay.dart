// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final overlay = FOverlay(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Core"}
  overlay: const [Positioned(top: 42, left: 0, child: Text('Overlay content'))],
  overlayBuilder: (context, controller, childRenderBox, overlay) => overlay,
  builder: (context, controller, child) => child!,
  child: const Text('Child'),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the overlay visibility.
final FOverlayControl lifted = .lifted(shown: false, onChange: (shown) {});

// {@category "Control" "`.managed()` with initial"}
/// Manages overlay state internally with initial visibility.
final FOverlayControl internal = .managed(initial: false);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for overlay management.
// Don't create a controller inline. Store it in a State instead.
final FOverlayControl external = .managed(controller: OverlayPortalController());

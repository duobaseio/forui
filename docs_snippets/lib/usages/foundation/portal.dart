// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final portal = FPortal(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  constraints: const FPortalConstraints(),
  portalAnchor: .topCenter,
  childAnchor: .bottomCenter,
  spacing: .zero,
  overflow: .flip,
  offset: .zero,
  padding: .zero,
  useViewPadding: true,
  useViewInsets: true,
  // {@endcategory}
  // {@category "Core"}
  portalBuilder: (context, controller) => const Text('Portal content'),
  builder: (context, controller, child) => child!,
  child: const Text('Child'),
  barrier: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the portal visibility.
final FOverlayControl lifted = .lifted(shown: false, onChange: (shown) {});

// {@category "Control" "`.managed()` with initial"}
/// Manages portal state internally with initial visibility.
final FOverlayControl internal = .managed(initial: false);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for portal management.
// Don't create a controller inline. Store it in a State instead.
final FOverlayControl external = .managed(controller: OverlayPortalController());

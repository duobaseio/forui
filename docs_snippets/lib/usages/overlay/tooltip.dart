// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tooltip = FTooltip(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  tipAnchor: .bottomCenter,
  childAnchor: .topCenter,
  spacing: const .spacing(4),
  overflow: .flip,
  useViewPadding: true,
  useViewInsets: true,
  // {@endcategory}
  // {@category "Behavior"}
  hover: true,
  longPress: true,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.symmetric(horizontal: 14, vertical: 10))),
  tipBuilder: (context, controller) => const Text('Tooltip content'),
  builder: (context, controller, child) => child!,
  child: const Text('Hover me'),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the tooltip visibility.
final FTooltipControl lifted = .lifted(shown: false, onChange: (shown) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages tooltip state internally.
final FTooltipControl managedInternal = .managed(initial: false, onChange: (shown) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for tooltip management.
final FTooltipControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FTooltipController(vsync: vsync, shown: false),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();

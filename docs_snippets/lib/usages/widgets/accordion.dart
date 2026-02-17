// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const accordion = FAccordion(
  // {@category "Control"}
  control: .managed(min: 1, max: 2),
  // {@endcategory}
  // {@category "Core"}
  style: .delta(titlePadding: .value(.zero)),
  children: [FAccordionItem(title: Text('Title'), child: SizedBox())],
  // {@endcategory}
);

final accordionItem = FAccordionItem(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onVariantChange: (previous, current) {},
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(titlePadding: .value(.zero)),
  title: const Text('Title'),
  icon: const Icon(FIcons.chevronDown),
  initiallyExpanded: false,
  child: const Text('Content'),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the accordion items' expanded state.
final FAccordionControl lifted = .lifted(expanded: (index) => true, onChange: (index, expanded) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the expanded state of the accordion items internally.
final FAccordionControl internal = .managed(min: 1, max: 2, onChange: (items) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external `FAccordionController` to control the accordion items' expanded state.
final FAccordionControl external = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FAccordionController(min: 1, max: 2),
  onChange: (items) {},
);

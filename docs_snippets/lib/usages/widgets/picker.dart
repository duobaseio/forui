// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final picker = FPicker(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(spacing: 5),
  children: [
    FPickerWheel(children: [for (var i = 1; i <= 12; i++) Text('$i')]),
    const Text(':'),
    FPickerWheel(children: [for (var i = 0; i < 60; i++) Text('$i'.padLeft(2, '0'))]),
  ],
  debugLabel: '',
  // {@endcategory}
);

final pickerWheel = FPickerWheel(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Core"}
  loop: false,
  flex: 1,
  itemExtent: null,
  children: [for (var i = 1; i <= 12; i++) Text('$i')],
  // {@endcategory}
);

final pickerWheelBuilder = FPickerWheel.builder(
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Core"}
  flex: 1,
  itemExtent: null,
  builder: (context, index) => Text('$index'),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the picker's indexes.
final FPickerControl lifted = .lifted(
  indexes: [0, 0],
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOutCubic,
  onChange: (indexes) {},
);

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the picker state internally.
final FPickerControl managedInternal = .managed(initial: [0, 0], onChange: (indexes) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the picker's state.
final FPickerControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPickerController(indexes: [0, 0]),
  onChange: (indexes) {},
);

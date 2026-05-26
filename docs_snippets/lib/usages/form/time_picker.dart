// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const timePicker = FTimePicker(
  // {@category "Control"}
  control: .managed(),
  // {@endcategory}
  // {@category "Core"}
  style: .delta(padding: .value(.all(5))),
  hour24: false,
  hourInterval: 1,
  minuteInterval: 1,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the time picker value.
final FTimePickerControl lifted = .lifted(
  time: const FTime(9, 30),
  onChange: (time) {},
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOutCubic,
);

// {@category "Control" "`.managed()` with internal controller"}
/// Manages time picker state internally.
final FTimePickerControl managedInternal = .managed(initial: const FTime(9, 30), onChange: (time) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for time picker management.
final FTimePickerControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FTimePickerController(time: const FTime(9, 30)),
  onChange: (time) {},
);

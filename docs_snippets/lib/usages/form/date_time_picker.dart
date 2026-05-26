// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const dateTimePicker = FDateTimePicker(
  // {@category "Control"}
  control: .managed(),
  // {@endcategory}
  // {@category "Core"}
  style: .delta(padding: .value(.all(5))),
  hour24: false,
  dayInterval: 1,
  hourInterval: 1,
  minuteInterval: 1,
  dateBuilder: FDateTimePicker.defaultDateBuilder,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the date time picker value.
final FDateTimePickerControl lifted = .lifted(
  dateTime: DateTime(2026, 4, 8, 9, 30),
  onChange: (dateTime) {},
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOutCubic,
);

// {@category "Control" "`.managed()` with internal controller"}
/// Manages date time picker state internally.
final FDateTimePickerControl managedInternal = .managed(initial: DateTime(2026, 4, 8, 9, 30), onChange: (dateTime) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for date time picker management.
final FDateTimePickerControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: FDateTimePickerController(dateTime: DateTime(2026, 4, 8, 9, 30)),
  onChange: (dateTime) {},
);

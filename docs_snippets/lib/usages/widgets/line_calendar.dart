// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

final lineCalendar = FLineCalendar(
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Scroll"}
  initialScroll: .now(),
  initialScrollAlignment: .center,
  cacheExtent: null,
  keyboardDismissBehavior: .manual,
  physics: null,
  // {@endcategory}
  // {@category "Core"}
  style: const .delta(padding: .value(.zero)),
  start: .utc(1900),
  end: .utc(2100),
  today: .now(),
  builder: (context, data, child) => child!,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the line calendar's date.
final FLineCalendarControl lifted = .lifted(date: .now(), selectable: (date) => true, onChange: (date) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the line calendar state internally.
final FLineCalendarControl managedInternal = .managed(
  initial: .now(),
  selectable: (date) => true,
  toggleable: false,
  onChange: (date) {},
);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the line calendar's state.
final FLineCalendarControl managedExternal = .managed(
  // Don't create a controller inline. Store it in a State instead.
  controller: .date(initial: .now(), selectable: (date) => true, toggleable: false, truncateAndStripTimezone: true),
  onChange: (date) {},
);
